//
//  ViewController.swift
//  stroopstory
//
//  Created by Jeremiah Leary on 2/23/22.
//

import UIKit

class ViewController: UIViewController {
    var timer = Timer()
    var timeLeft = 59
    var instructions = "Does the top word match the color of the bottom word?"
    var score = 0
    
    let colors = [
        "red",
        "blue",
        "yellow",
        "green",
        "purple",
        "orange"
    ]
    
    let colorToUi = [
        "red" : UIColor.red,
        "blue" : UIColor.blue,
        "yellow" : UIColor.yellow,
        "green" : UIColor.green,
        "purple" : UIColor.purple,
        "orange" : UIColor.orange
    ]
    
    @IBOutlet weak var instructionsLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    
    func updateScore(scoreToAdd:Int) {
        score += scoreToAdd
        scoreLabel.text = "\(score)"
    }
    
    func startTimer(){
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.updateTimer), userInfo: nil, repeats: true)
    }
    
    // helper function to decrease timer time
    @objc func updateTimer(){
        if timeLeft >= 0 {
            timerLabel.text = "\(timeLeft)"
            timeLeft -= 1
        } else {
            timer.invalidate()
            timeLeft = 59
            startButton.isHidden = false
            instructionsLabel.isHidden = false
        }
    }
    
    @IBOutlet weak var colorLabel: UILabel!
    @IBOutlet weak var meaningLabel: UILabel!
    
    func changeColorLabel() {
        let randomNumber = Int.random(in: 0...colors.count - 1)
        colorLabel.text = colors[randomNumber]
    }
    
    func changeMeaningLabel() {
        let randomNumber = Int.random(in: 0...colors.count - 1)
        meaningLabel.text = colors[randomNumber]
        let randomNumber2 = Int.random(in: 0...colors.count - 1)
        meaningLabel.textColor = colorToUi[colors[randomNumber2]]
    }
    
    @IBOutlet weak var startButton: UIButton!
    @IBAction func startButtonTapped(_ sender: Any) {
        startButton.isHidden = true
        instructionsLabel.isHidden = true
        timerLabel.text = "1:00"
        startTimer()
        score = 0
        scoreLabel.text = "\(score)"
        changeColorLabel()
        changeMeaningLabel()
    }
    
    @IBOutlet weak var noButton: UIButton!
    @IBOutlet weak var yesButton: UIButton!
    
    
    @IBAction func yesButtonTapped(_ sender: Any) {
//     text name matches color of second element
        if meaningLabel.textColor == colorToUi[colorLabel.text!] {
            updateScore(scoreToAdd: 10)
        } else {
            updateScore(scoreToAdd: -10)
        }
        changeColorLabel()
        changeMeaningLabel()
    }
    
    @IBAction func noButtonTapped(_ sender: Any) {
        if meaningLabel.textColor != colorToUi[colorLabel.text!] {
            updateScore(scoreToAdd: 10)
        } else {
            updateScore(scoreToAdd: -10)
        }
        changeColorLabel()
        changeMeaningLabel()
    }
    
    
    @IBAction func restartButtonTapped(_ sender: Any) {
        timer.invalidate()
        timeLeft = 59
        startButton.isHidden = false
        instructionsLabel.isHidden = false
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        instructionsLabel.text = instructions
        // Do any additional setup after loading the view.
    }


}

