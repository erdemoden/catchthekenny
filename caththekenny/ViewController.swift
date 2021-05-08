//
//  ViewController.swift
//  caththekenny
//
//  Created by erdem öden on 23.09.2020.
//  Copyright © 2020 erdem öden. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var score = 0
    var timer = Timer()
    var hidetimer = Timer()
    var counter = 0
    var kennyarray = [UIImageView]()
    var highscore = 0;
    @IBOutlet weak var timelabel: UILabel!
    @IBOutlet weak var scorelabel: UILabel!
    @IBOutlet weak var highscorelabel: UILabel!
    @IBOutlet weak var kenny1: UIImageView!
    @IBOutlet weak var kenny2: UIImageView!
    @IBOutlet weak var kenny3: UIImageView!
    @IBOutlet weak var kenny4: UIImageView!
    @IBOutlet weak var kenny5: UIImageView!
    @IBOutlet weak var kenny6: UIImageView!
    @IBOutlet weak var kenny7: UIImageView!
    @IBOutlet weak var kenny8: UIImageView!
    @IBOutlet weak var kenny9: UIImageView!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let storedhighscore = UserDefaults.standard.object(forKey: "highscore")
        if storedhighscore == nil{
            highscore = 0;
            highscorelabel.text = "HighScore : \(highscore)"
        }
        if let newscore = storedhighscore as? Int{
            highscore = newscore
            highscorelabel.text = "HighScore : \(highscore)"
        }
        kenny1.isUserInteractionEnabled = true
        kenny2.isUserInteractionEnabled = true
        kenny3.isUserInteractionEnabled = true
        kenny4.isUserInteractionEnabled = true
        kenny5.isUserInteractionEnabled = true
        kenny6.isUserInteractionEnabled = true
        kenny7.isUserInteractionEnabled = true
        kenny8.isUserInteractionEnabled = true
        kenny9.isUserInteractionEnabled = true
        scorelabel.text = "Score: \(score)"
        let recognizer1 = UITapGestureRecognizer(target: self, action: #selector(increasescore))
        let recognizer2 = UITapGestureRecognizer(target: self, action: #selector(increasescore))
        let recognizer3 = UITapGestureRecognizer(target: self, action: #selector(increasescore))
        let recognizer4 = UITapGestureRecognizer(target: self, action: #selector(increasescore))
        let recognizer5 = UITapGestureRecognizer(target: self, action: #selector(increasescore))
        let recognizer6 = UITapGestureRecognizer(target: self, action: #selector(increasescore))
        let recognizer7 = UITapGestureRecognizer(target: self, action: #selector(increasescore))
        let recognizer8 = UITapGestureRecognizer(target: self, action: #selector(increasescore))
        let recognizer9 = UITapGestureRecognizer(target: self, action: #selector(increasescore))
        kenny1.addGestureRecognizer(recognizer1)
        kenny2.addGestureRecognizer(recognizer2)
        kenny3.addGestureRecognizer(recognizer3)
        kenny4.addGestureRecognizer(recognizer4)
        kenny5.addGestureRecognizer(recognizer5)
        kenny6.addGestureRecognizer(recognizer6)
        kenny7.addGestureRecognizer(recognizer7)
        kenny8.addGestureRecognizer(recognizer8)
        kenny9.addGestureRecognizer(recognizer9)
        kennyarray = [kenny1,kenny2,kenny3,kenny4,kenny5,kenny6,kenny7,kenny8,kenny9]
        counter = 10
        timelabel.text="\(counter)"
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countdown), userInfo: nil, repeats: true)
        hidetimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(hidekenny), userInfo: nil, repeats: true)
        // Do any additional setup after loading the view.
        hidekenny()
    }
    @objc func increasescore(){
        score+=1
        scorelabel.text = "Score: \(score)"
    }
    @objc func countdown(){
        counter-=1
        timelabel.text = String(counter)
        if counter == 0{
            timer.invalidate()
            hidetimer.invalidate()
            for kenny in kennyarray{
                       kenny.isHidden=true
                   }
            if self.score > self.highscore{
                self.highscore = self.score;
                highscorelabel.text = "HighScore : \(highscore)"
                UserDefaults.standard.set(self.highscore, forKey: "highscore")
            }
            //alert
            let alert = UIAlertController(title: "Time's up", message: "Do you want to play again", preferredStyle: UIAlertController.Style.alert)
            let okbutton = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel,handler: nil)
            let replaybutton = UIAlertAction(title: "Replay", style: UIAlertAction.Style.default) { (UIAlertAction) in
                self.score = 0
                self.scorelabel.text = "Score \(self.score)"
                self.counter = 10
                self.timelabel.text = String(self.counter)
                self; self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.countdown), userInfo: nil, repeats: true)
                self; self.hidetimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.hidekenny), userInfo: nil, repeats: true)
            }
            alert.addAction(okbutton)
            alert.addAction(replaybutton)
            self.present(alert,animated: true,completion: nil)
        }
    }
    @objc func hidekenny(){
        for kenny in kennyarray{
            kenny.isHidden=true
        }
       let random =  Int(arc4random_uniform(UInt32(kennyarray.count - 1)))
        kennyarray[random].isHidden = false
    }

}

