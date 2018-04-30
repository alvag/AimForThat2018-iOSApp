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
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startNewRound()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        let points = (difference > 0) ? 100 - difference : 1000
        self.score += points
        
        let message = """
                Has marcado \(points) puntos
        """
        let alert = UIAlertController(title: "Resultado", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Genial", style: .default, handler: nil)
        
        alert.addAction(action)
        present(alert, animated: true)
        startNewRound()
    }
    
    @IBAction func sliderMoved(_ sender: UISlider) {
//        self.currentValue = Int(sender.value)
        self.currentValue = lroundf(sender.value) // redondea al enterior inferior
    }
    
    func startNewRound() {
        self.targetValue = 1 + Int(arc4random_uniform(100))
        self.currentValue = 50
        self.slider.value = Float(self.currentValue)
        self.round += 1
        updateLabels()
    }
    
    func updateLabels() {
        self.targetLabel.text = "\(self.targetValue)"
        self.scoreLabel.text = "\(self.score)"
        self.roundLabel.text = "\(self.round)"
    }
}

