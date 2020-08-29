//
//  ViewController.swift
//  War
//
//  Created by Vu Nguyen on 12/22/17.
//  Copyright © 2017 Vu Nguyen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let cardNames =  [ "card2", "card3", "card4", "card5", "card6", "card7", "card8", "card9", "card10", "jack", "king", "queen", "ace"]
    
    @IBOutlet weak var rightImage: UIImageView!
    @IBOutlet weak var rightScore: UILabel!
    var right: Int = 0
    
    @IBOutlet weak var leftScore: UILabel!
    @IBOutlet weak var leftImage: UIImageView!
    var left:Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func dealButton(_ sender: Any) {
        //generating 2 new cards and changing left and right image :
        let randLeft = Int(arc4random_uniform(13))
        leftImage.image = UIImage(named: cardNames[randLeft])
        let randRight = Int(arc4random_uniform(13))
        rightImage.image = UIImage(named: cardNames[randRight])
        
        //Comparing score:
        if (randLeft > randRight){
            left += 1
            leftScore.text = String(left)
        }else{
            right += 1
            rightScore.text = String(right)
        }
    }
}

