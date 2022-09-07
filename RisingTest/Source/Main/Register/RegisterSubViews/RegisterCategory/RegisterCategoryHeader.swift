//
//  RegisterCategoryHeader.swift
//  RisingTest
//
//  Created by 김태윤 on 2022/08/25.
//

import UIKit

class RegisterCategoryHeader: UITableViewHeaderFooterView {
    @IBOutlet weak var stackView: UIStackView!
    static let identifier = "RegisterCategoryHeader"
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    func setStack(_ datas: [String]){
            stackView.subviews.forEach { view in
                view.removeFromSuperview()
            }
        if datas.count == 1 {
            stackView.addArrangedSubview({
                let label = UILabel()
                label.text = datas[0]
                let font = UIFont(name: "System", size: 12)
                
                label.textColor = .gray
                label.font = font
                label.font = .systemFont(ofSize: 14, weight: .bold)
                return label
            }())
        }else{
            let labels = datas.map { data -> UILabel in
                let label = UILabel()
                label.text = data
                let font = UIFont(name: "System", size: 12)
                label.font = font
                label.font = .systemFont(ofSize: 14, weight: .bold)
                return label
            }
            labels.last?.textColor = .red
            labels.forEach { label in
                stackView.addArrangedSubview(label)
                stackView.addArrangedSubview({
                    let imageView = UIImageView(image: UIImage(systemName: "chevron.right"))
                    imageView.tintColor = .gray
                    return imageView
                }())
            }
            let view = stackView.subviews[stackView.subviews.count - 1]
            view.isHidden = true
            stackView.removeArrangedSubview(view)
        }
        stackView.addArrangedSubview(UIView())
    }
}
