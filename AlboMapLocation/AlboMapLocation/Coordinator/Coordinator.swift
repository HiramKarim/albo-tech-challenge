//
//  Coordinator.swift
//  AlboMapLocation
//
//  Created by Hiram Castro on 16/03/22.
//

import UIKit

protocol Coordinator {
    var parentCoordinator: Coordinator? { get set }
    var children:[Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    
    func start()
}

class AppCoordinator: Coordinator {
    var parentCoordinator: Coordinator?
    var children: [Coordinator] = []
    var navigationController: UINavigationController
    
    init(navCon: UINavigationController) {
        self.navigationController = navCon
    }
    
    func start() {
        goToSearchLocationVC()
    }
    
    func goToSearchLocationVC() {
        let searchController = SearchLocationsVC()
        searchController.makeViewModel(withCoordinator: self)
        self.navigationController.pushViewController(searchController, animated: true)
    }
    
    func goToTabController(withKmRadius km:Int) {
        let tabVC = TabBarViewController()
        tabVC.makeViewModel(withKmRadius: km)
        tabVC.setupControllers()
        self.navigationController.pushViewController(tabVC, animated: true)
    }
    
    func goToMapVC(withKm km:Int) {
        let viewmodel = MapViewModel()
        viewmodel.setKmInRange(km: km)
        let mapController = MapVC(viewModel: viewmodel)
        self.navigationController.pushViewController(mapController, animated: true)
    }
    
    func goToDetails() {
        
    }
}
