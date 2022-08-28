//
//  UI_Components.swift
//  WeekThree
//
//  Created by 김태윤 on 2022/07/27.
//

import UIKit
// 네비게이션 바 라벨 아이템
class LabelBarButtonItem:UIBarButtonItem{
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    convenience init(text:String){
        self.init(text: text,fontName: "System",fontSize: 21,color: .black)
    }
    init(text:String,fontName:String,fontSize:Int,color: UIColor){
        super.init()
        let fSize:CGFloat = CGFloat(fontSize)
        self.customView = {
            let label = UILabel()
            label.text = text
            label.font = UIFont(name:fontName,size: fSize)
            label.textColor = color
            label.font = UIFont.boldSystemFont(ofSize: fSize)
            return label
        }()
    }
}
// 네비게이션 바 버튼 아이템
class BarButtonItem: UIBarButtonItem{
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    convenience init(text:String,imageName:String,action: UIAction?){
        self.init(text: text,fontName: "System",fontSize: 21,color: .black,imageName:imageName,action: action)
    }
    init(text:String,fontName:String, fontSize:Int, color: UIColor,imageName:String,action: UIAction?){
        super.init()
        let fSize:CGFloat = CGFloat(fontSize)
        self.customView = {
            let button = UIButton()
            button.setTitle(text, for: .normal)
            button.backgroundColor = .orange
            button.titleLabel?.font = UIFont(name: fontName, size: fSize)
            button.titleLabel!.font = UIFont.boldSystemFont(ofSize: fSize)
            button.setTitleColor(color, for: .normal)
            button.tintColor = color
            button.setImage(UIImage(systemName: imageName,withConfiguration:
                                        UIImage.SymbolConfiguration(scale: .small)), for: .normal)
            button.semanticContentAttribute = .forceRightToLeft
            button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
            button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
            if #available(iOS 14.0, *) {
                if let ac = action{
                    button.addAction(ac, for: .touchDown)
                }
            } else {
                // Fallback on earlier versions
            }
            return button
        }()
    }
}
class RectangularDashedView: UIView {
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
        }
    }
    @IBInspectable var dashWidth: CGFloat = 0
    @IBInspectable var dashColor: UIColor = .clear
    @IBInspectable var dashLength: CGFloat = 0
    @IBInspectable var betweenDashesSpace: CGFloat = 0
    
    var dashBorder: CAShapeLayer?
    override func layoutSubviews() {
        super.layoutSubviews()
        dashBorder?.removeFromSuperlayer()
        let dashBorder = CAShapeLayer()
        dashBorder.lineWidth = dashWidth
        dashBorder.strokeColor = dashColor.cgColor
        dashBorder.lineDashPattern = [dashLength, betweenDashesSpace] as [NSNumber]
        dashBorder.frame = bounds
        dashBorder.fillColor = nil
        if cornerRadius > 0 {
            dashBorder.path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath
        } else {
            dashBorder.path = UIBezierPath(rect: bounds).cgPath
        }
        layer.addSublayer(dashBorder)
        self.dashBorder = dashBorder
    }
}
protocol SliderDelegate{
    func numberOfPages(count: Int)
    func currentPage(index: Int)
}
//MARK: --  이미지 슬라이더 뷰 구현
class UIImgSliderView: UIView,SliderDelegate{
    var data: [String] = ["안녕하세요!!","반갑습니다!!","잘 부탁 드림!!"]
    var imgSliderManager: ImgSliderManager?
    var sliderCollection: UICollectionView!
    var sliderPageControl: UIPageControl!
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        imgSliderManager = ImgSliderManager(data: self.data, updater: self)
        self.sliderCollection = UICollectionView(frame: .zero, collectionViewLayout: ImgSliderManager.createSliderCompositionalLayout())
        self.sliderCollection.register(UINib(nibName: "ImgSliderCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ImgSliderCollectionViewCell")
        self.sliderCollection.dataSource = imgSliderManager
        self.sliderCollection.delegate = imgSliderManager
        self.sliderCollection.collectionViewLayout = ImgSliderManager.createSliderCompositionalLayout()
        //Page Controller
        self.sliderPageControl = UIPageControl()
        self.sliderPageControl.pageIndicatorTintColor = .systemGray5
        self.sliderPageControl.currentPageIndicatorTintColor = UIColor.orange
        self.sliderPageControl.numberOfPages = (self.imgSliderManager?.data.count)!
        self.sliderPageControl.currentPage = self.imgSliderManager!.nowIdx
        self.layout()
    }
    private func layout(){
        self.sliderPageControl.translatesAutoresizingMaskIntoConstraints = false
        self.sliderCollection.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(sliderCollection)
        self.addSubview(sliderPageControl)
        NSLayoutConstraint.activate([
            self.sliderCollection.topAnchor.constraint(equalTo: self.topAnchor),
            self.sliderCollection.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.sliderCollection.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.sliderCollection.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.sliderPageControl.bottomAnchor.constraint(equalTo: self.bottomAnchor,constant: -5),
            self.sliderPageControl.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }
    func setData(data:[String]){
        self.data = data
        self.imgSliderManager?.setData(data: self.data)
    }
    func numberOfPages(count: Int){
        self.sliderPageControl.numberOfPages = count
    }
    func currentPage(index: Int){
        self.sliderPageControl.currentPage = index
    }
}

//MARK: -- 스트레치 테이블 헤더 뷰 구현
final class StretchyTableHeaderView: UIView{
    public let ImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    private var imageViewHeight = NSLayoutConstraint()
    private var imageViewBottom = NSLayoutConstraint()
    private var WrapperView: UIView = {
        let uiview = UIView()
        uiview.contentMode = .scaleToFill
        return uiview
    }()
    private var wrapperViewHeight = NSLayoutConstraint()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createViews()
        setViewsConstraints()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func createViews(){
        self.addSubview(WrapperView)
        WrapperView.addSubview(ImageView)
    }
    private func setViewsConstraints(){
        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalTo:WrapperView.widthAnchor),
            centerXAnchor.constraint(equalTo: WrapperView.centerXAnchor),
            heightAnchor.constraint(equalTo: WrapperView.heightAnchor)
        ])
        WrapperView.translatesAutoresizingMaskIntoConstraints = false
        
        WrapperView.widthAnchor.constraint(equalTo: ImageView.widthAnchor).isActive = true
        wrapperViewHeight = WrapperView.heightAnchor.constraint(equalTo: self.heightAnchor)
        wrapperViewHeight.isActive = true
        
        ImageView.translatesAutoresizingMaskIntoConstraints = false
        imageViewBottom = ImageView.bottomAnchor.constraint(equalTo: WrapperView.bottomAnchor)
        imageViewBottom.isActive = true
        imageViewHeight = ImageView.heightAnchor.constraint(equalTo: WrapperView.heightAnchor)
        imageViewHeight.isActive = true
    }
    /// Notify view of scroll change from container
    // -> Wrapper 뷰에게 스크롤이 바뀐 것을 알려준다.
    public func scrollViewDidScroll(scrollView: UIScrollView){
        self.wrapperViewHeight.constant = scrollView.contentInset.top
        let offsetY = -(scrollView.contentOffset.y + scrollView.contentInset.top)
        self.WrapperView.clipsToBounds = offsetY <= 0
        // 아래에서 위로 스크롤시 부드럽게 스크롤 하는 constant
        //print("\(offsetY >= 0 ? 30 : -(offsetY / 2)), offset: \(-offsetY)")
        // offset이 작아지면? bottomConstant가 늘어난다
        self.imageViewBottom.constant = offsetY >= 0 ? 0 : -(offsetY / 2)
        // 위에서 아래로 스크롤시 크기를 늘리는 constant
        self.imageViewHeight.constant = max(offsetY + scrollView.contentInset.top, scrollView.contentInset.top)
        
        //let headerWrapperHeight = HeaderWrapper.frame.height // label + spacer (102)
        
    }
}

final class StretchableView: UIView{
    public let ImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        createViews()
        setViewsConstraints()
    }
    convenience init(frame: CGRect,imageName: String){
        self.init(frame: frame)
        self.ImageView.image = UIImage(named: imageName)
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    private func createViews(){
        self.ImageView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(ImageView)
    }
    private func setViewsConstraints(){
        
        NSLayoutConstraint.activate([
            self.ImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.ImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.ImageView.topAnchor.constraint(equalTo: self.topAnchor),
            self.ImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}

//MARK: -- 수평 슬라이더 뷰 구현
class HorizontalScrollView: UIView{
    var data: [String] = ["안녕하세요!!","반갑습니다!!","잘 부탁 드림!!"]
    var horizontalScrollViewManager: HorizontalScrollViewManager?
    var sliderCollection: UICollectionView!
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        horizontalScrollViewManager = HorizontalScrollViewManager(data: self.data)
        self.sliderCollection = UICollectionView(frame: .zero, collectionViewLayout: HorizontalScrollViewManager.createSliderCompositionalLayout())
        self.sliderCollection.register(UINib(nibName: "HorizontalScrollViewCell", bundle: nil), forCellWithReuseIdentifier: "HorizontalScrollViewCell")
        self.sliderCollection.dataSource = horizontalScrollViewManager
        self.sliderCollection.delegate = horizontalScrollViewManager
        self.sliderCollection.collectionViewLayout = HorizontalScrollViewManager.createSliderCompositionalLayout()
        self.layout()
    }
    private func layout(){
        self.sliderCollection.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(sliderCollection)
        NSLayoutConstraint.activate([
            self.sliderCollection.topAnchor.constraint(equalTo: self.topAnchor),
            self.sliderCollection.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.sliderCollection.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.sliderCollection.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }
    func setData(data:[String]){
        self.data = data
        horizontalScrollViewManager?.setData(data:data)
    }
}

