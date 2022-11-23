//
//  DetailViewController.swift
//  Parky
//
//  Created by Haoyuan Shi on 11/22/22.
//

import UIKit

class DetailViewController: UIViewController {
    
    let parkLabel = UILabel()
    let picImageView = UIImageView()
    let block = UIView()
    
    let parkAddress = UILabel()
    let parkOpen = UILabel()
    let ParkOpenTime = UILabel()
    let parkFee = UILabel()
    let parkOpenStatus = UILabel()
    
    
    let park: Park
    
    init(park: Park) {
        self.park = park
        //self.delegate = delegate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        picImageView.image = UIImage(systemName: "square.fill")
        //picImageView.contentMode = .scaleAspectFit
        picImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(picImageView)
        
        parkLabel.text = park.name
        parkLabel.font = UIFont(name: "Futura-bold", size: 20)
        parkLabel.textColor = .black
        parkLabel.textAlignment = .center
        parkLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(parkLabel)
        // Do any additional setup after loading the view.
        
        block.layer.backgroundColor = UIColor.white.cgColor
        block.layer.cornerRadius = 20
        block.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(block)
        
        parkAddress.font = UIFont(name: "Futura", size: 16)
        parkAddress.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(parkAddress)

        parkOpen.font = UIFont(name: "Futura", size: 16)
        parkOpen.textColor = .darkGray
        parkOpen.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(parkOpen)
        
        ParkOpenTime.font = UIFont(name: "Futura", size: 16)
        ParkOpenTime.textColor = .darkGray
        ParkOpenTime.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(ParkOpenTime)

        parkOpenStatus.font = UIFont(name: "Futura-bold", size: 16)
        parkOpenStatus.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(parkOpenStatus)
        
        parkFee.font = UIFont(name: "Futura", size: 16)
        parkFee.numberOfLines = 2
        parkFee.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(parkFee)
        
        configure(parkObject: park)
        setupConstraints()
    }
    
    func configure(parkObject: Park) {
        parkLabel.text = parkObject.name
        parkAddress.text = parkObject.address
        parkFee.text = "\(parkObject.hourlyRate)   \(parkObject.dailyRate)"
        
        
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
        
        
        coolDateFormatter.dateFormat = "hh:mm a"
        coolDateFormatter2.dateFormat = "hh:mm a"
        
        ParkOpenTime.text = "Available time: \(coolDateFormatter.string(from: timeStamp)) - \(coolDateFormatter2.string(from: timeStamp2))"
    
    }
    
    func setupConstraints() {
        
        NSLayoutConstraint.activate([
            block.widthAnchor.constraint(equalTo: view.widthAnchor),
            block.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.675),
            block.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            block.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
        
        NSLayoutConstraint.activate([
            parkLabel.widthAnchor.constraint(equalTo: view.widthAnchor),
            parkLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            parkLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 25)
        ])
        
        NSLayoutConstraint.activate([
            picImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            picImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            picImageView.widthAnchor.constraint(equalTo: view.widthAnchor),
            picImageView.heightAnchor.constraint(equalTo: view.widthAnchor)
        ])
        
        NSLayoutConstraint.activate([
            parkAddress.topAnchor.constraint(equalTo: parkLabel.bottomAnchor,constant: 5),
            parkAddress.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0)
        ])
        
        NSLayoutConstraint.activate([
            ParkOpenTime.topAnchor.constraint(equalTo: parkAddress.bottomAnchor,constant: 5),
            ParkOpenTime.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0)
        ])
        
        NSLayoutConstraint.activate([
            parkOpenStatus.topAnchor.constraint(equalTo: block.topAnchor,constant: 30),
            parkOpenStatus.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50)
        ])
        
        NSLayoutConstraint.activate([
            parkOpen.topAnchor.constraint(equalTo: block.topAnchor,constant: 30),
            parkOpen.leadingAnchor.constraint(equalTo: parkOpenStatus.trailingAnchor, constant: 10)
        ])
        
        NSLayoutConstraint.activate([
            parkFee.topAnchor.constraint(equalTo: parkOpen.topAnchor,constant: 30),
            parkFee.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50)
        ])
    
        
    }

}
