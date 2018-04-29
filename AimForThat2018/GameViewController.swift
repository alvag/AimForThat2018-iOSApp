//
//  ViewController.swift
//  AimForThat2018
//
//  Created by Max on 26/04/18.
//  Copyright © 2018 Max Alva. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    var currentValue: Int = 0
    @IBOutlet weak var slider: UISlider!
    var targetValue: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startNewRound()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func showAlert() {
        let message = """
                El valor del slider es \(self.currentValue)
                El valor del objetivo es \(self.targetValue)
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
    }
}

