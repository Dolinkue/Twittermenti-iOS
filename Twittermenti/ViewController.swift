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
    
    let tweetCount = 100
    
    override func viewDidLoad() {
        super.viewDidLoad()
        


        
        
    }

    @IBAction func predictPressed(_ sender: Any) {
        
        // cuando el usuario preciona el boton ejecuta el codigo
        
       fetchTweets()
    
    
        
        
    }
    
    func fetchTweets () {
        
        if let searchText = textField.text {
            
            //para buscar los twit desde swifter
            swifter.searchTweet(using: searchText, lang: "en", count: tweetCount, tweetMode: .extended) { (results,metadata) in
                
                
                var tweets = [MyTwitClassifier_1Input]()
                
                // un for para cargar todos los tweest en un []
                for i in 0..<self.tweetCount {
                    
                    if let tweet = results[i]["full_text"].string {
                        
                        //esta let para cambiar el type de tweet ya que el input tiene que ser un inpuy y no un string
                        let tweetForClassifier = MyTwitClassifier_1Input(text: tweet)
                        
                        tweets.append(tweetForClassifier)
                        }
                    
                }
                
                self.makePrediction(with: tweets)
                
                
                
                
                
            } failure: { error in
                print("error api\(error)")
            }
        }
    }
    
    func makePrediction (with tweets: [MyTwitClassifier_1Input]) {
        
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
                        
            updateUI(with: sentimentalScore)
            
        
        }catch {
            print("error\(error)")
        }
    
    }
    
    func updateUI (with sentimentalScore: Int ) {
        
        if sentimentalScore > 20 {
            self.sentimentLabel.text = "😁"
        }else if sentimentalScore > 10 {
            self.sentimentLabel.text = "🙂"
        } else if sentimentalScore > 0 {
            self.sentimentLabel.text = "🙃"
        } else if sentimentalScore == 0 {
            self.sentimentLabel.text = "🥸"
        }else if sentimentalScore > -10 {
            self.sentimentLabel.text = "😕"
        }else {
            self.sentimentLabel.text = "😩"
        }
    }
    
}

