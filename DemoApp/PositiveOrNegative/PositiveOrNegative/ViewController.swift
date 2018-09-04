//
//  ViewController.swift
//  PositiveOrNegative
//
//  Created by Moon on 2018/9/3.
//  Copyright © 2018 Moon. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var inputTextView: UITextView!
    
    let model = SentimentClassifer()
    
    var isPositive: Bool! {
        didSet {
            if isPositive {
                self.view.backgroundColor = .green
            }
            else
            {
                self.view.backgroundColor = .red
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func judgeButtonTapped(_ sender: Any) {
        
        guard let text = inputTextView.text else { return }
        
        let prediction = try? model.prediction(text: text)
        
        if prediction?.label == "positive" {
            isPositive = true
        }
        else if prediction?.label == "negative" {
            isPositive = false
        }
        else {
            print("Something wrong")
        }
        
    }
    
}

