//
//  FruitClassifierViewController.swift
//  ImageClassifier
//
//  Created by Moon on 2018/9/4.
//  Copyright © 2018 Moon. All rights reserved.
//

import UIKit

class FruitClassifierViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var itemLabel: UILabel!
    
    let mlModel = FruitClassifier()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    func judgeKaneshiro(image: UIImage) {
        imageView.image = image
        
        // buffer size 只能調 299 x 299
        if let buffer = image.buffer(with: CGSize(width: 299, height: 299)),
            let prediction = try? mlModel.prediction(image: buffer) {
            let result = prediction.classLabel
            
            guard let confidence = prediction.classLabelProbs[result] else { return }
            
            let confidenceString = String(format: "%.2f", confidence)
            var target: String?
            if result == "Banana" {
                target = "是香蕉"
                itemLabel.textColor = .green
            }
            else
            {
                target = "是蘋果"
                itemLabel.textColor = .red
            }
            
            guard let unwrapTarget = target else { return }
            
            itemLabel.text = "分析結果: 這張照片\(unwrapTarget),信心: \(confidenceString)"
        }
            
        
    }
    
    @IBAction func importFromGalleryTapped(_ sender: Any) {
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        
        let sampleVC = storyBoard.instantiateViewController(withIdentifier: "SampleVC") as! SampleGalleryViewController // 範例才用 as!
        
        let imageNameArray: [String] = ["banana_1", "banana_2", "banana_3", "apple_1", "apple_2", "apple_3"]
        
        sampleVC.imageNameArray = imageNameArray
        self.navigationController?.pushViewController(sampleVC, animated: true)
        
    }
    
}
