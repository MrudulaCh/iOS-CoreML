//
//  ViewController.swift
//  CoreMLProject
//
//  Created by Mrudula on 3/15/19.
//  Copyright © 2019 Mrudula. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let cars = Cars()
    
    @IBOutlet var stackView: UIStackView!
    @IBOutlet var model: UISegmentedControl!
    @IBOutlet var upgrades: UISegmentedControl!
    @IBOutlet var mileageLabel: UILabel!
    @IBOutlet var mileage: UISlider!
    @IBOutlet var condition: UISegmentedControl!
    @IBOutlet var valuation: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        stackView.setCustomSpacing(30, after: model)
        stackView.setCustomSpacing(30, after: upgrades)
        stackView.setCustomSpacing(30, after: mileage)
        stackView.setCustomSpacing(60, after: condition)
        
        calculateValue(self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func calculateValue(_ sender: Any) {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 0
        let formattedMileage = formatter.string(for: mileage.value) ?? "0"
        mileageLabel.text = "Mileage \(formattedMileage) Miles"
        
        if let prediction = try? cars.prediction(
            model:Double(model.selectedSegmentIndex),
            premium: Double(upgrades.selectedSegmentIndex),
            mileage: Double(mileage.value),
            condition: Double(condition.selectedSegmentIndex)) {
            let newValuation = max(2000, prediction.price)
            formatter.numberStyle = .currency
            valuation.text = formatter.string(for: newValuation)
        } else {
            valuation.text = "Error!"
        }
    }
    
}

