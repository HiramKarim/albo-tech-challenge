//
//  SearchLocationsVC.swift
//  AlboMapLocation
//
//  Created by Hiram Castro on 13/03/22.
//

import UIKit
import CoreLocation

final class SearchLocationsVC: UIViewController {
    
    private let locationManager = CLLocationManager()
    
    private let titleText: UILabel = {
        return UILabel.makeLabel(for: .title, withText: "AIRPORT", withTextColor: .white, andTextsize: 50)
    }()
    
    private let subTitleText: UILabel = {
        return UILabel.makeLabel(for: .title, withText: "finder", withTextColor: .white, andTextsize: 30)
    }()
    
    private let kmRadiusText:UILabel = {
        return UILabel.makeLabel(for: .title, withText: "0km", withTextColor: .darkGray, andTextsize: 50)
    }()
    
    private let searchButton:UIButton = {
        let button = UIButton()
        button.setTitle("SEARCH", for: .normal)
        button.layer.cornerRadius = 5
        button.backgroundColor = .blue
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let slider:UISlider = {
        let slider = UISlider()
        slider.minimumValue = 0
        slider.maximumValue = 100
        slider.value = 0
        slider.translatesAutoresizingMaskIntoConstraints = false
        return slider
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configView()
    }
    
    private func configView() {
        self.view.backgroundColor = .lightGray
        
        self.view.addSubview(titleText)
        self.view.addSubview(subTitleText)
        self.view.addSubview(kmRadiusText)
        self.view.addSubview(slider)
        self.view.addSubview(searchButton)
        
        slider.addTarget(self, action: #selector(sliderChangedValue(_:)), for: .valueChanged)
        searchButton.addTarget(self, action: #selector(searchAirpotsButtonPressed), for: .touchUpInside)
        
        validateSearchButtonStatus(withSelectedKm: 0)
        
        NSLayoutConstraint.activate([
            titleText.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0),
            titleText.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20),
            
            subTitleText.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0),
            subTitleText.topAnchor.constraint(equalTo: titleText.bottomAnchor, constant: 10),
            
            kmRadiusText.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0),
            kmRadiusText.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 0),
            
            slider.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0),
            slider.topAnchor.constraint(equalTo: kmRadiusText.bottomAnchor, constant: 10),
            slider.widthAnchor.constraint(equalToConstant: self.view.frame.width * 0.90),
            slider.heightAnchor.constraint(equalToConstant: 30),
            
            searchButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -70),
            searchButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0),
            searchButton.widthAnchor.constraint(equalToConstant: self.view.frame.width * 0.70),
            searchButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    @objc private func sliderChangedValue(_ sender: UISlider) {
        DispatchQueue.main.async {
            self.kmRadiusText.text = "\(String(Int(sender.value)))km"
            self.validateSearchButtonStatus(withSelectedKm: Int(sender.value))
        }
    }
    
    @objc private func searchAirpotsButtonPressed() {
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(MapVC(), animated: true)
        }
    }
    
    private func validateSearchButtonStatus(withSelectedKm km:Int) {
        if km > 0 {
            searchButton.alpha = 1
            searchButton.isEnabled = true
        } else {
            searchButton.alpha = 0.5
            searchButton.isEnabled = false
        }
    }
    
}
