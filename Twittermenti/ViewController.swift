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
import SwiftyJSON



class ViewController: UIViewController {
    
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var sentimentLabel: UILabel!
    
    let sentimentClassifier = MyTwitClassifier_1()

    let swifter = Swifter(consumerKey: "rZfsfylmrVZB1CzYgYLEmRq5g", consumerSecret: "RWpgL2zpFiQWDXYDhH4buwC1Y0OGgxLLE6pmdBB5876NFT3TZz")
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        


        //para buscar los twit desde swifter
        swifter.searchTweet(using: "#ukraine", lang: "en", count: 100, tweetMode: .extended) { (results,metadata) in
            
            
            var tweets = [MyTwitClassifier_1Input]()
            
            // un for para cargar todos los tweest en un []
            for i in 0..<100 {
                
                if let tweet = results[i]["full_text"].string {
                    
                    //esta let para cambiar el type de tweet ya que el input tiene que ser un inpuy y no un string
                    let tweetForClassifier = MyTwitClassifier_1Input(text: tweet)
                    
                    tweets.append(tweetForClassifier)
                    }
                
            }
            
            do {
                
              let predictions =  try self.sentimentClassifier.predictions(inputs: tweets)
                
                
               var sentimentalScore = 0
                
                
                for pred in predictions {
                    
                    let setiment = pred.label
                    
                    if setiment == "pos"{
                    
                        sentimentalScore += 1
                    
                    }else if setiment == "neg"{
                    
                        sentimentalScore -= 1
                    
                    }
                    
                            }
                            
                print(sentimentalScore)
                
            
            }catch {
                print("error\(error)")
            }
            
            
            
            
            
        } failure: { error in
            print("error api\(error)")
        }

        
        
    }

    @IBAction func predictPressed(_ sender: Any) {
    
    
    }
    
}

