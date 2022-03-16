//
//  TabBarViewController.swift
//  AlboMapLocation
//
//  Created by Hiram Castro on 16/03/22.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    private var viewModel: TabBarVM?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .systemBackground
        
        if #available(iOS 13, *) {
            let tabBarAppearance = UITabBarAppearance()
            let tabBarItemAppearance = UITabBarItemAppearance()

            tabBarItemAppearance.normal.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.red]
            tabBarItemAppearance.selected.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.blue]

            tabBarAppearance.stackedLayoutAppearance = tabBarItemAppearance

            tabBar.standardAppearance = tabBarAppearance
            tabBar.scrollEdgeAppearance = tabBarAppearance
        } else {
            // set padding between tabbar item title and image
            UITabBarItem.appearance().titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 4)
            UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.gray], for: .normal)
            UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.blue], for: .selected)
        }
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    func setupControllers() {
        let nav1 = UINavigationController(rootViewController: makeMapController())
        let nav2 = UINavigationController(rootViewController: makeListController())

        nav1.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "mappin.and.ellipse"), tag: 1)
        nav2.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "list.dash"), tag: 2)

        viewControllers = [nav1, nav2]
    }
    
    func makeViewModel(withKmRadius km:Int) {
        self.viewModel = TabBarVM()
        self.viewModel?.setKmSearchLocation(km: km)
    }
    
    private func makeMapController() -> UIViewController {
        let viewmodel = MapViewModel()
        viewmodel.setKmInRange(km: self.viewModel?.getKmSearchLocation() ?? 0)
        let mapController = MapVC(viewModel: viewmodel)
        return mapController
    }
    
    private func makeListController() -> UIViewController {
        let listVC = ListVC()
        return listVC
    }

}
