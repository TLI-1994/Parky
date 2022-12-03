//
//  MapViewController.swift
//  Parky
//
//  Created by 李天骄 on 11/21/22.
//

import MapKit

class MapViewController: UIViewController {
    class MapButton: UIButton {
        init(systemName: String) {
            super.init(frame: .zero)
            self.contentHorizontalAlignment = .fill
            self.contentVerticalAlignment = .fill
            self.setImage(UIImage(systemName: systemName), for: .normal)
            self.imageView?.contentMode = .scaleAspectFit
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
    
    
    let mapView = MKMapView()
    let manager: CLLocationManager = CLLocationManager()
    let centerButton = MapButton(systemName: "location.fill")
    var parkingLots: [Park] = []
    var parkingLotAnnotations: [ParkingLotAnnotation] = []
    
    var regionHasBeenCentered = false
    
    init(parkingLots: [Park]) {
        self.parkingLots = parkingLots
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.delegate = self
        view.addSubview(mapView)
        
        centerButton.translatesAutoresizingMaskIntoConstraints = false
        centerButton.addTarget(self, action: #selector(centerOnUser), for: .touchUpInside)
        mapView.addSubview(centerButton)
        
        mapView.addAnnotations(createAnnotations(parkingLots: parkingLots))
        
        setupConstraints()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }
    
    @objc func centerOnUser() {
        if let location = manager.location {
            mapView.setCenter(location.coordinate, animated: true)
        }
    }
    
    func createAnnotations(parkingLots: [Park]) -> [ParkingLotAnnotation] {
        return parkingLots.map { parkingLot in
            ParkingLotAnnotation(parkingLot: parkingLot)
        }
    }

    func setupConstraints() {
        mapView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
        
        centerButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.trailing.equalTo(view).offset(-20)
            make.width.height.equalTo(view.snp.width).multipliedBy(0.1)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MapViewController: CLLocationManagerDelegate {
    
    // center on user at beginning
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            if !regionHasBeenCentered {
                let span: MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
                let userLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
                let region: MKCoordinateRegion = MKCoordinateRegion(center: userLocation, span: span)
                
                mapView.setCenter(location.coordinate, animated: true)
                mapView.setRegion(region, animated: true)
                regionHasBeenCentered = true
            }
        }
        mapView.showsUserLocation = true
    }
}

extension MapViewController: MKMapViewDelegate {
    
    // region cannot be too small
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        if mapView.region.span.latitudeDelta <= 0.005 && mapView.region.span.longitudeDelta <= 0.005 {
            let minimumSpan = MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
             let minimumRegion = MKCoordinateRegion(center: mapView.centerCoordinate, span: minimumSpan)
             mapView.setRegion(minimumRegion, animated: true)
        }
    }
    
}

class ParkingLotAnnotation: NSObject, MKAnnotation {
    var title: String?
    var coordinate: CLLocationCoordinate2D
    var info: String

    init(parkingLot: Park) {
        self.title = parkingLot.name
        self.coordinate = CLLocationCoordinate2D(latitude: Double(parkingLot.latitude)!, longitude: Double(parkingLot.longitude)!)
        self.info = parkingLot.note
    }
    
}
