//
//  CalculatorBrain.swift
//  BMI Calculator
//
//  Created by Aleksandra Sobot on 28.2.22..
//  Copyright © 2022 Angela Yu. All rights reserved.
//

import UIKit

struct CalculatorBrain {
    
    var bmi: BMI?

    func getBMIValue() -> String {
        let bmi1DecimalPlace = String (format: "%.1f", bmi?.value ?? 0.0)
        return bmi1DecimalPlace
    }
    
  
    func getAdvice() -> String {
        return bmi?.advice ?? "No advice"
    }
    
    func getColor() -> UIColor {
        return bmi?.color ?? UIColor {_ in return #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)}
    }
    
    
    
    mutating func calculateBMI(height: Float, weight: Float ) {
        let bmiValue = weight / pow(height, 2)
        if bmiValue < 18.5{
            bmi = BMI(value: bmiValue, advice: "Eat more pies!", color: UIColor {_ in return #colorLiteral(red: 0.1982856989, green: 0.7698788047, blue: 0.9613167644, alpha: 1)})
        } else if bmiValue < 24.9 {
            bmi = BMI(value: bmiValue, advice: "Fit as a fiddle!", color: UIColor {_ in return #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)})
        } else {
            bmi = BMI(value: bmiValue, advice: "Eat less pies!", color: UIColor {_ in return #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)})
        }
    

    }
 
  
}
