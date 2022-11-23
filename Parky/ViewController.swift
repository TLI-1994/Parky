//
//  ViewController.swift
//  Parky
//
//  Created by 李天骄 on 11/17/22.
//

import UIKit

class ViewController: UIViewController {
    
    let parkTableView = UITableView()
    
    var parkData: [Park] = []
    var shownParkData: [Park] = []
    
    let parkReuseIdentifier = "parkReuseIdentifier"

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //title = "Parky"
        view.backgroundColor = .white
        
        parkTableView.translatesAutoresizingMaskIntoConstraints = false
        parkTableView.delegate = self
        parkTableView.dataSource = self
        parkTableView.register(ParkTableViewCell.self, forCellReuseIdentifier: parkReuseIdentifier)
        view.addSubview(parkTableView)
        
        createDummyData()
        setupConstraints()
        
    }
    
    func createDummyData() {
        NetworkManager.getAllParks { parks in
            self.parkData = parks
            self.shownParkData = self.parkData
            self.parkTableView.reloadData()
        }
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            parkTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            parkTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            parkTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            parkTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

}

extension ViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shownParkData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: parkReuseIdentifier, for: indexPath) as! ParkTableViewCell
        let parkObject = shownParkData[indexPath.row]
        cell.configure(parkObject: parkObject)
        return cell
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigationController?.pushViewController(DetailViewController(park: shownParkData[indexPath.row]), animated: true)
    }
    
}
