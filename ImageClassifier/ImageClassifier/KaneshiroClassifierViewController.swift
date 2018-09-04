//
//  KaneshiroClassifierViewController.swift
//  ImageClassifier
//
//  Created by Moon on 2018/9/4.
//  Copyright © 2018 Moon. All rights reserved.
//

import UIKit

class KaneshiroClassifierViewController: UIViewController {

    @IBOutlet weak var itemLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    let mlModel = KaneshiroOrNot()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func judgeKaneshiro(image: UIImage) {
        imageView.image = image
        
        // buffer size 只能調 299 x 299
        if let buffer = image.buffer(with: CGSize(width: 299, height: 299)),
            let prediction = try? mlModel.prediction(image: buffer) {
            
            print(prediction)
            
            let kaneshiroOrNot = prediction.classLabel
            guard let confidence = prediction.classLabelProbs[kaneshiroOrNot] else { return }
            let confidenceString = String(format: "%.2f", confidence)
            var target: String?
            if kaneshiroOrNot == "kaneshiro" {
                target = "是金城武"
                itemLabel.textColor = .green
            }
            else
            {
                target = "不是金城武"
                itemLabel.textColor = .red
            }

            guard let unwrapTarget = target else { return }

            itemLabel.text = "分析結果: 這張照片\(unwrapTarget),信心: \(confidenceString)"
        }
    }
    
    @IBAction func importFromGalleryTapped(_ sender: Any) {
    
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        
        let sampleVC = storyBoard.instantiateViewController(withIdentifier: "SampleVC") as! SampleGalleryViewController // 範例才用 as!
        
        let imageNameArray: [String] = ["kaneshiro_1", "kaneshiro_2", "kaneshiro_3", "kaneshiro_4", "kaneshiro_5", "Andy_1", "Jay_1", "Jacky_1", "JackyWu_1", "Koo_1"]
        
        sampleVC.imageNameArray = imageNameArray
        self.navigationController?.pushViewController(sampleVC, animated: true)
        
    }
    
}
