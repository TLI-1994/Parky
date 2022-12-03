//
//  ViewController.swift
//  Parky
//
//  Created by 李天骄 on 11/17/22.
//

import UIKit
import SnapKit
import MapKit

class ViewController: UIViewController {
    let mapButton = UIButton()
    var parkingLots: [ParkingLot] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        mapButton.translatesAutoresizingMaskIntoConstraints = false
        mapButton.setTitle("push map", for: .normal)
        mapButton.backgroundColor = .systemBlue
        mapButton.layer.cornerRadius = 10
        mapButton.addTarget(self, action: #selector(pushMap), for: .touchUpInside)
        view.addSubview(mapButton)
        
        fetchParkingLots()
        
        setupConstraints()
    }
    
    func fetchParkingLots() {
        NetworkManagerForMap.getAllParkingLots { parkingLots in
            print("received \(parkingLots.count) parks")
            self.parkingLots = parkingLots
        }
    }
    
    var mapView: MapViewController?
    @objc func pushMap() {
        if let mapView {
            navigationController?.pushViewController(mapView, animated: true)
        } else {
            mapView = MapViewController(parkingLots: self.parkingLots)
            pushMap()
        }
    }
    
    func setupConstraints() {
        mapButton.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.4)
            make.centerX.centerY.equalToSuperview()
        }
    }

}

