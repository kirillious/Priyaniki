//
//  ViewController.swift
//  Pryaniky
//
//  Created by Kirill on 29.01.2021.
//

import UIKit
import SwiftyJSON
import Kingfisher

class ViewController: UIViewController {
    
    let url = "https://pryaniky.com/static/json/sample.json"
    var swiftyJSON = ParsingOfData()
    var priynikiData: JSON = []
    var rightIndex = 0
     
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.myFunction))
        
        hzLabel.isUserInteractionEnabled = true
        hzLabel.addGestureRecognizer(tap)
        hzLabel.addGestureRecognizer(setGesture())
        
        pictureImage.isUserInteractionEnabled = true
        pictureImage.addGestureRecognizer(tap)
        pictureImage.addGestureRecognizer(setGesture())
        
        hzLable2.isUserInteractionEnabled = true
        hzLable2.addGestureRecognizer(tap)
        hzLable2.addGestureRecognizer(setGesture())
        
        pictureText.isUserInteractionEnabled = true
        pictureText.addGestureRecognizer(tap)
        pictureText.addGestureRecognizer(setGesture())
        
        selectorLabel.isUserInteractionEnabled = true
        selectorLabel.addGestureRecognizer(tap)
        selectorLabel.addGestureRecognizer(setGesture())
 
        swiftyJSON.delegate = self
        swiftyJSON.urlRequest(urlString: url)
    }
    
    
    //MARK: - LogicOFReturningPath
    
    @objc func myFunction(sender:UITapGestureRecognizer) {
        
        if sender.view?.tag == 1 {
            print(priynikiData["data"][0])
        }
        
        if sender.view?.tag == 2 {
            print(priynikiData["data"][1])
        }
        
        if sender.view?.tag == 3 {
            print(priynikiData["data"][2]["data"]["variants"][rightIndex])
        }
    }
    
    
    func setGesture() -> UITapGestureRecognizer {
        
        var myRecognizer = UITapGestureRecognizer()
        
        myRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.myFunction))
        return myRecognizer
    }
    
    //MARK: - Defining of labels
    

    @IBOutlet weak var hzLabel: UILabel!
    
    
    @IBOutlet weak var hzLable2: UILabel!
    
    
    @IBOutlet weak var selectorLabel: UILabel!
    
    @IBOutlet weak var pictureImage: UIImageView!
    
    
    @IBOutlet weak var pictureText: UILabel!
    
    
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    
    
    //MARK: - Choice of variants logic
    
    @IBAction func choiceOfVariantsControl(_ sender: UISegmentedControl) {
        rightIndex = segmentControl.selectedSegmentIndex
        DispatchQueue.main.async {self.selectorLabel.text = self.priynikiData["data"][2]["data"]["variants"][self.rightIndex]["text"].stringValue}
    }
    
}





//MARK: - SwiftyJSONDelegate


extension ViewController: SwiftyJSONDelegate {
    func updateLabels(for priyanikData: JSON) {
        priynikiData = priyanikData
        print(priynikiData)
        DispatchQueue.main.sync {
            self.hzLabel.text = priyanikData["data"][0]["data"]["text"].stringValue
            self.hzLable2.text = priyanikData["data"][0]["data"]["text"].stringValue
            self.pictureText.text = priyanikData["data"][1]["data"]["text"].stringValue
            self.pictureImage.kf.setImage(with: URL(string: priyanikData["data"][1]["data"]["url"].stringValue))
            self.selectorLabel.text = self.priynikiData["data"][2]["data"]["variants"][self.rightIndex]["text"].stringValue
        }
    }
    
    
}
    
