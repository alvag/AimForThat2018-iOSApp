//
//  ViewController.swift
//  AimForThat2018
//
//  Created by Max on 26/04/18.
//  Copyright © 2018 Max Alva. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    var score: Int = 0
    var round: Int = 0
    var currentValue: Int = 0
    var targetValue: Int = 0
    var time: Int = 0
    var timer: Timer?
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startNewRound()
        setupSlider()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupSlider() {
        let thumbImageNormal = UIImage(named: "SliderThumb-Normal")
        let thumbImageHighlighted = UIImage(named: "SliderThumb-Highlighted")
        let trackLeftImage = UIImage(named: "SliderTrackLeft")
        let trackRightImage = #imageLiteral(resourceName: "SliderTrackRight")
        
        self.slider.setThumbImage(thumbImageNormal, for: .normal)
        self.slider.setThumbImage(thumbImageHighlighted, for: .highlighted)
        
        let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        
        let trackLeftResizable = trackLeftImage?.resizableImage(withCapInsets: insets)
        let trackRightResizable = trackRightImage.resizableImage(withCapInsets: insets)
        
        self.slider.setMinimumTrackImage(trackLeftResizable, for: .normal)
        self.slider.setMaximumTrackImage(trackRightResizable, for: .normal)

    }

    @IBAction func showAlert() {
        /*var difference: Int = 0
        
        if (self.currentValue > self.targetValue) {
            difference = self.currentValue - self.targetValue
        } else {
            difference + self.targetValue - self.currentValue
        }*/
        
        /*var difference: Int = self.currentValue - self.targetValue
        if (difference < 0) difference *= -1*/
        
        let difference: Int = abs(self.currentValue - self.targetValue)
        var points = 100 - difference
        
        let title: String
        
        switch difference {
        case 0:
            title = "Puntuación perfecta!!!"
            points = Int(10 * points)
        case 1...5:
            title = "Casi perfecto"
            points = Int(1.5 * Float(points))
        case 6...12:
            title = "Te ha faltado poco..."
            points = Int(1.2 * Float(points))
        default:
            title = "Has ido lejos..."
        }
        
        self.score += points
        let message = "Has marcado \(points) puntos"

        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK!", style: .default, handler: {
            action in self.startNewRound()
        })
        
        alert.addAction(action)
        present(alert, animated: true)
//        startNewRound()
    }
    
    @IBAction func sliderMoved(_ sender: UISlider) {
//        self.currentValue = Int(sender.value)
        self.currentValue = lroundf(sender.value) // redondea al enterior inferior
    }
    
    func startNewRound() {
        self.time = 15
        self.targetValue = 1 + Int(arc4random_uniform(100))
        self.currentValue = 50
        self.slider.value = Float(self.currentValue)
        self.round += 1
        
        if (self.timer != nil ) {
            self.timer?.invalidate()
        }
        
        self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(tick), userInfo: nil, repeats: true)
        
        
        updateLabels()
    }
    
    func updateLabels() {
        self.targetLabel.text = "\(self.targetValue)"
        self.scoreLabel.text = "\(self.score)"
        self.roundLabel.text = "\(self.round)"
        self.timeLabel.text = "\(self.time)"
    }
    
    @IBAction func startNewGame() {
        self.resetGame()
    }
    
    func resetGame() {
        self.score = 0
        self.round = 0
        self.startNewRound()
    }
    
    @objc func tick() {
        self.time -= 1
        self.timeLabel.text = "\(self.time)"
        if (self.time <= 0) {
            self.resetGame()
        }
    }
    
}

