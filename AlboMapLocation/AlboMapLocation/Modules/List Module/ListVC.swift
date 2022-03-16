//
//  ListVC.swift
//  AlboMapLocation
//
//  Created by Hiram Castro on 16/03/22.
//

import UIKit

class ListVC: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configView()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    private func configView() {
        self.view.backgroundColor = .lightGray
    }
    
}

extension ListVC {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Helper.shared.airportsLocations.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        
        let airportLocation = Helper.shared.airportsLocations[indexPath.row]
        
        cell.textLabel?.text = airportLocation.name ?? ""
        
        return cell
    }
    
}
