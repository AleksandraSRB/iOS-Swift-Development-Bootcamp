//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation



class ViewController: UIViewController {

    let eggTimes = ["Soft": 3, "Medium": 4, "Hard": 7]
    var timer = Timer()
    var totalTime = 0
    var secondPassed = 0
  
    var playSound: AVAudioPlayer!
    
    @IBOutlet weak var progressBar: UIProgressView!
    
    @IBOutlet weak var headLine: UILabel!
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        
        
        timer.invalidate()
        
        let hardness = sender.currentTitle!
        totalTime = (eggTimes[hardness])!
        progressBar.progress = 0.0
        secondPassed = 0
        headLine.text = hardness
    

        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [self] (Timer) in
            if secondPassed <= totalTime {
                
                
                progressBar.progress = Float (secondPassed) / Float (totalTime)
                secondPassed += 1
                
            } else {
                Timer.invalidate()
                headLine.text = "DONE!"
              
                let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
                playSound = try! AVAudioPlayer(contentsOf: url!)
                
                playSound.play()
                
            }
        }
        
    }
    
}

    

