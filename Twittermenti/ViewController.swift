//
//  ViewController.swift
//  Twittermenti
//
//  Created by Angela Yu on 17/07/2019.
//  Copyright © 2019 London App Brewery. All rights reserved.
//

import UIKit
import SwifteriOS
import CoreML



class ViewController: UIViewController {
    
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var sentimentLabel: UILabel!
    
    let sentimentClassifier = MyTwitClassifier_1()

    let swifter = Swifter(consumerKey: "rZfsfylmrVZB1CzYgYLEmRq5g", consumerSecret: "RWpgL2zpFiQWDXYDhH4buwC1Y0OGgxLLE6pmdBB5876NFT3TZz")
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
            // pasamos el metodo de prediccion que viene de mytwitclassifier
      let prediction =   try! sentimentClassifier.prediction(text: "@Apple is terrible")
        
        //lo pasamos a string
         print(prediction.label)
        
        //para buscar los twit desde swifter
        swifter.searchTweet(using: "@Apple", lang: "en", count: 100, tweetMode: .extended) { (results,metadata) in
            //print(results)
        } failure: { error in
            print("error api\(error)")
        }

        
        
    }

    @IBAction func predictPressed(_ sender: Any) {
    
    
    }
    
}

