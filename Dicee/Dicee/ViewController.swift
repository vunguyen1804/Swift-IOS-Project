//
//  ViewController.swift
//  Dicee
//
//  Created by Vu Nguyen on 12/23/17.
//  Copyright © 2017 Vu Nguyen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var leftDice: UIImageView!
    @IBOutlet weak var rightDice: UIImageView!
    
    var randLeft: Int = 0
    var randRight: Int = 0
    
    var dices: Array = ["dice1", "dice2", "dice3", "dice4", "dice5", "dice6"]
    override func viewDidLoad() {
        super.viewDidLoad()
        updateDiceImages()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func rollButtonPresses(_ sender: UIButton) {
        updateDiceImages()
    }
    
    func updateDiceImages (){
        randLeft = Int(arc4random_uniform(6))
        randRight = Int(arc4random_uniform(6))
        leftDice.image = UIImage(named: dices[randLeft])
        rightDice.image = UIImage(named: dices[randRight])
    }
    
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        updateDiceImages()
    }
}

