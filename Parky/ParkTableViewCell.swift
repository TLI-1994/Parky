//
//  ParkTableViewCell.swift
//  Parky
//
//  Created by Haoyuan Shi on 11/22/22.
//

import UIKit

class ParkTableViewCell: UITableViewCell {
    
    let parkImageView = UIImageView()
    let parkLabel = UILabel()
    let parkAddress = UILabel()
    let parkOpen = UILabel()
    let parkFee = UILabel()
    let parkOpenStatus = UILabel()
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setupViews()
        setupConstraints()
    }
    
    func setupViews() {
        
        parkImageView.image = UIImage(systemName: "car.fill")
        parkImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(parkImageView)
        
        parkLabel.textAlignment = .left
        parkLabel.font = UIFont(name: "Futura-bold", size: 12)
        parkLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(parkLabel)
        
        parkAddress.font = UIFont(name: "Futura", size: 10)
        parkAddress.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(parkAddress)

        parkOpen.font = UIFont(name: "Futura", size: 10)
        parkOpen.textColor = .darkGray
        parkOpen.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(parkOpen)

        parkOpenStatus.font = UIFont(name: "Futura-bold", size: 10)
        parkOpenStatus.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(parkOpenStatus)
        
        parkFee.font = UIFont(name: "Futura", size: 10)
        parkFee.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(parkFee)
        

    }
    
    func setupConstraints() {
        
        NSLayoutConstraint.activate([
            parkImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 10),
            parkImageView.heightAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.15),
            parkImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.15),
            parkImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            parkImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
        

        NSLayoutConstraint.activate([
            parkLabel.leadingAnchor.constraint(equalTo: parkImageView.trailingAnchor,constant: 10),
            parkLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            parkAddress.leadingAnchor.constraint(equalTo: parkImageView.trailingAnchor,constant: 10),
            parkAddress.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 0)
        ])
        
        NSLayoutConstraint.activate([
            parkOpen.leadingAnchor.constraint(equalTo: parkOpenStatus.trailingAnchor,constant: 5),
            parkOpen.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 20)
        ])
        
        NSLayoutConstraint.activate([
            parkFee.leadingAnchor.constraint(equalTo: parkOpen.trailingAnchor,constant: 10),
            parkFee.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 20)
        ])
    
        NSLayoutConstraint.activate([
            parkOpenStatus.leadingAnchor.constraint(equalTo: parkImageView.trailingAnchor,constant: 10),
            parkOpenStatus.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 20)
        ])
        
    }
    
    func configure(parkObject: Park) {
        parkLabel.text = parkObject.name
        parkAddress.text = parkObject.address
        parkFee.text = "\(parkObject.hourlyRate) \(parkObject.dailyRate)"
        
        
        let openTime = parkObject.openHours
        let start = openTime.startIndex
        let end = openTime.endIndex
        let index = openTime.index(start, offsetBy: 7)
        let startT = openTime[start..<index]
        let endT = openTime[index..<end]
        
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mma"
        dateFormatter.timeZone = TimeZone(abbreviation: "EST")
        let timeStamp = dateFormatter.date(from: String(startT))!

        let coolDateFormatter = DateFormatter()
        coolDateFormatter.dateFormat = "HH:mm"
        let coolDateString = coolDateFormatter.string(from: timeStamp)
        
        let dateFormatter2 = DateFormatter()
        dateFormatter2.dateFormat = "'- 'hh:mma"
        dateFormatter2.timeZone = TimeZone(abbreviation: "EST")
        let timeStamp2 = dateFormatter2.date(from: String(endT))!

        let coolDateFormatter2 = DateFormatter()
        coolDateFormatter2.dateFormat = "HH:mm"
        let coolDateString2 = coolDateFormatter2.string(from: timeStamp2)
        
        let coolDateFormatter3 = DateFormatter()
        coolDateFormatter3.dateFormat = "HH:mm"
        let currT = coolDateFormatter3.string(from: Date())
        
        
        if (coolDateString <= currT && currT <= coolDateString2) {
            coolDateFormatter2.dateFormat = "hh:mm a"
            let coolDateString2 = coolDateFormatter2.string(from: timeStamp2)
            parkOpen.text = "until \(coolDateString2)"
            parkOpenStatus.text = "Open"
            parkOpenStatus.textColor = UIColor(red: 0, green: 0.6, blue: 0.36, alpha: 1)
        } else {
            coolDateFormatter.dateFormat = "hh:mm a"
            let coolDateString = coolDateFormatter.string(from: timeStamp)
            parkOpen.text = "until \(coolDateString)"
            parkOpenStatus.text = "Close"
            parkOpenStatus.textColor = .red
        }
    
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

