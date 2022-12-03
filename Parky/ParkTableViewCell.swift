//
//  ParkTableViewCell.swift
//  Parky
//
//  Created by Haoyuan Shi on 11/22/22.
//

import UIKit
import SnapKit

class ParkTableViewCell: UITableViewCell {
    
    let parkImageView = UIImageView()
    let parkLabel = UILabel()
    let parkAddress = UILabel()
    let untilLabel = UILabel()
    let parkFee = UILabel()
    let isOpenLabel = UILabel()
    
    let stackView = UIStackView()
    let openUntilStackView = UIStackView()
    
    var parkImageDic: [Int: Int] = [:]
    
    let parkLike = UIButton()
    var isLiked:Bool = false
    var likeDic:[Bool:String] = [:]
    var parkID:Int?
    
    weak var delegate: ChangeIsLikeDelegate?
    
    init(delegate: ChangeIsLikeDelegate) {
        self.delegate = delegate
        super.init(style: UITableViewCell.CellStyle.default, reuseIdentifier: nil)
    }
        
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        
        backgroundColor = .clear // very important
        layer.masksToBounds = false
        layer.shadowOpacity = 0.05
        layer.shadowRadius = 4
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowColor = UIColor.black.cgColor
        
        // add corner radius on `contentView`
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 15
        
        for i in 1..<22 {
            parkImageDic[i] = i
        }
        
        likeDic[true] = "suit.heart.fill"
        likeDic[false] = "suit.heart"
        
        setupViews()
        setupConstraints()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: -2.5, right: 10))
    }
    
    func setupViews() {
        
        parkImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(parkImageView)
        
        parkLabel.textAlignment = .left
        parkLabel.font = UIFont(name: "Futura-bold", size: 18)
        parkLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(parkLabel)
        
        parkAddress.font = UIFont(name: "Futura", size: 14)
        parkAddress.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(parkAddress)
        
        untilLabel.font = UIFont(name: "Futura", size: 14)
        untilLabel.textColor = .darkGray
        untilLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(untilLabel)
        
        isOpenLabel.font = UIFont(name: "Futura-bold", size: 14)
        isOpenLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(isOpenLabel)
        
        openUntilStackView.translatesAutoresizingMaskIntoConstraints = false
        openUntilStackView.addArrangedSubview(isOpenLabel)
        openUntilStackView.addArrangedSubview(untilLabel)
        openUntilStackView.spacing = 5
        openUntilStackView.alignment = .leading
        openUntilStackView.axis = .horizontal
        
        parkFee.font = UIFont(name: "Futura", size: 10)
        parkFee.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(parkFee)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .leading
        stackView.distribution = .equalSpacing
        stackView.axis = .vertical
        
        stackView.addArrangedSubview(parkLabel)
        stackView.addArrangedSubview(parkAddress)
        stackView.addArrangedSubview(parkFee)
        stackView.addArrangedSubview(openUntilStackView)
        contentView.addSubview(stackView)
        
        parkLike.setImage(UIImage(systemName: "suit.heart"), for: .normal)
        parkLike.tintColor = .systemRed
        parkLike.addTarget(self, action: #selector(toggleLikeButton), for: .touchUpInside)
        parkLike.setTitleColor(.black, for: .normal)
        parkLike.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(parkLike)
        
        
    }
    
    func setupConstraints() {
        let padding: CGFloat = 20.0
        
        parkImageView.snp.makeConstraints { make in
            make.height.width.equalTo(contentView.snp.height)
            make.leading.equalTo(contentView)
            make.centerY.equalToSuperview()
        }
        
        stackView.snp.makeConstraints { make in
            make.leading.equalTo(parkImageView.snp.trailing).offset(padding)
            make.top.equalTo(contentView).offset(padding)
            make.bottom.equalTo(contentView).offset(-padding)
            make.trailing.equalTo(contentView).offset(-padding)
            make.height.equalTo(100)
        }
        
        parkLike.snp.makeConstraints {  make in
            make.top.equalTo(contentView.safeAreaLayoutGuide).offset(10)
            make.trailing.equalTo(contentView).offset(-10)
        }
        
    }
    
    func configure(parkObject: Park, isLiked: Bool) {
        parkID = parkObject.id
        parkImageView.image = UIImage(named: String(parkImageDic[parkObject.id]!))
        parkLabel.text = parkObject.name
        parkAddress.text = parkObject.address
        parkFee.text = "\(parkObject.hourlyRate) \(parkObject.dailyRate)"
        parkLike.setImage(UIImage(systemName: likeDic[isLiked]!), for: .normal)
        
        let tpr = OpenHourProcessor(openTime: parkObject.openHours).process()
        
        if tpr.start == "12:00 AM" && tpr.end == "11:59 PM" {
            isOpenLabel.text = "Open"
            isOpenLabel.textColor = UIColor(red: 0, green: 0.6, blue: 0.36, alpha: 1)
            untilLabel.text = "all day"
        } else {
            if tpr.isOpen {
                untilLabel.text = "until \(tpr.end)"
                isOpenLabel.text = "Open"
                isOpenLabel.textColor = UIColor(red: 0, green: 0.6, blue: 0.36, alpha: 1)
            } else  {
                untilLabel.text = "until \(tpr.start)"
                isOpenLabel.text = "Close"
                isOpenLabel.textColor = .red
            }
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ParkTableViewCell: LikeDelegate {
    @objc func toggleLikeButton() {
        isLiked.toggle()
        parkLike.setImage(UIImage(systemName: likeDic[isLiked]!), for: .normal)
        if let unwrapParkID = parkID {
            delegate?.ChangeIsLike(row: unwrapParkID - 1)
        }
    }
}

protocol ChangeIsLikeDelegate: UIViewController {
    func ChangeIsLike(row: Int)
}
