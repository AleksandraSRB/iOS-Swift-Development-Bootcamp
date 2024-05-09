//
//  ViewController.swift
//  BMI Calculator
//
//  Created by Angela Yu on 21/08/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit

class CalculateViewController: UIViewController {
    
    var calculatorBrain = CalculatorBrain()
    
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var heightSlider: UISlider!
    @IBOutlet weak var weightSlider: UISlider!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func hightSliderChanged(_ sender: UISlider) {
        let hight = String(format: "%.2f", sender.value)
        heightLabel.text = "\(hight)m"

    }
    
    
    @IBAction func weightSliderChanged(_ sender: UISlider) {
        let weight = String(format: "%.0f", sender.value)
        weightLabel.text = "\(weight)Kg"

    }
    
    @IBAction func calculatePressed(_ sender: UIButton) {
       let height = heightSlider.value
       let weight = weightSlider.value
        
        calculatorBrain.calculateBMI (height: height, weight: weight)
        
        // Procedura za prikaz novog ekrana
                                                        // self.CalculateViewController
        self.performSegue(withIdentifier: "goToResult", sender: self)
    
    }
    
    // Prepare for performing Segue by using segue.destination
    // Pass the selected object to the new view controller.
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToResult" {
            let destinationVC = segue.destination as! ResultViewController
            destinationVC.bmiValue = calculatorBrain.getBMIValue()
            destinationVC.advice = calculatorBrain.getAdvice()
            destinationVC.color = calculatorBrain.getColor()
        }
    }
}
