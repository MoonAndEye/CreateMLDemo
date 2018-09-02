//
//  ViewController.swift
//  HouseValuePrediction
//
//  Created by Moon on 2018/9/2.
//  Copyright © 2018 Moon. All rights reserved.
//

import UIKit
import CoreML

class ViewController: UIViewController {

    @IBOutlet weak var averageRoomTextField: UITextField!
    @IBOutlet weak var lstatTextField: UITextField!
    @IBOutlet weak var ptRationTextField: UITextField!
    
    @IBOutlet weak var houseValueLabel: UILabel!
    
    var houseMediumValue: Double! {
        didSet {
            
            let trimValue = Int(houseMediumValue ?? 0)
            
            houseValueLabel.text = "USD $:\(trimValue)"
        }
    }
    
    // 如果是正式專案,建議把 Model 抽出變成一個 class
    let mlModel = HousePricer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let prediction = try? mlModel.prediction(input: HousePricerInput(RM: 5.5, LSTAT: 10.0, PTRATIO: 20.0))
        
        print(prediction?.MEDV)
        
    }

    @IBAction func calculateButtonTapped(_ sender: Any) {
        
        guard let roomAveragePerHouseText = averageRoomTextField.text,
            let roomAveragePerHouse = Double(roomAveragePerHouseText),
        let lstatText = lstatTextField.text,
            let lstat = Double(lstatText),
        let ptRatioText = ptRationTextField.text,
            let ptRatio = Double(ptRatioText) else { return }
        
        let prediction = try? mlModel.prediction(input: HousePricerInput(RM: roomAveragePerHouse, LSTAT: lstat, PTRATIO: ptRatio))
        
        if let mediumValue = prediction?.MEDV {
            houseMediumValue = mediumValue
        }
        else {
            print("預測 model 出問題")
        }
        
    }
    
    @IBAction func viewDidTap(_ sender: Any) {
        self.view.endEditing(true)
    }
}

