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
    let refreshControl = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //title = "Parky"
        view.backgroundColor = .white
        
        parkTableView.translatesAutoresizingMaskIntoConstraints = false
        parkTableView.delegate = self
        parkTableView.dataSource = self
        parkTableView.register(ParkTableViewCell.self, forCellReuseIdentifier: parkReuseIdentifier)
        parkTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        view.addSubview(parkTableView)
        
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        
        if #available(iOS 10.0, *) {
            parkTableView.refreshControl = refreshControl
        } else {
            parkTableView.addSubview(refreshControl)
        }
        
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
    
    @objc func refreshData() {

        NetworkManager.getAllParks { parks in
            self.parkData = parks
            self.shownParkData = self.parkData
            self.parkTableView.reloadData()
            self.refreshControl.endRefreshing()
        }
    }
    
    func setupConstraints() {
        
        parkTableView.snp.makeConstraints { make in
            make.top.bottom.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalTo(view)
        }
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
        let cell = parkTableView.cellForRow(at: indexPath) as! ParkTableViewCell
        present(DetailViewController(park: shownParkData[indexPath.row], delegate: cell), animated: true, completion: nil)
        
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // this will turn on `masksToBounds` just before showing the cell
        cell.contentView.layer.masksToBounds = true
        let radius = cell.contentView.layer.cornerRadius
        cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: radius).cgPath
    }
    
    
    
}
