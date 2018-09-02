//
//  ViewController.swift
//  SpamDetector
//
//  Created by Moon on 2018/9/2.
//  Copyright © 2018 Moon. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var inputTextView: UITextView!
    
    let model = SpamDetector()
    
    var isSpam: Bool! {
        didSet {
            showUIAfterDecting(isSpam)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func showUIAfterDecting(_ result: Bool) {
        
        if (result) {
            self.view.backgroundColor = .green
            self.resultLabel.text = "正常郵件"
        }
        else {
            self.view.backgroundColor = .red
            self.resultLabel.text = "垃圾郵件"
        }
        
    }

    @IBAction func detectorSpamTapped(_ sender: Any) {
        
        guard let inputText = inputTextView.text else { return }
    
        let prediction = try? model.prediction(input: SpamDetectorInput(text: inputText))
        
        if prediction?.label == "ham" {
            isSpam = false
        }
        else if prediction?.label == "spam" {
            isSpam = true
        }
        else {
            print("Something wrong")
        }
    }
    
}

