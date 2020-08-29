//
//  ViewController.swift
//  Protocol And Delegate
//
//  Created by Vu Nguyen on 12/25/17.
//  Copyright © 2017 Vu Nguyen. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, ReceiveDelegate {
    
    var data:String = ""
    @IBOutlet weak var firstLabel: UILabel!
    @IBOutlet weak var firstTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        firstLabel.text = data
    }
    @IBAction func changeColor(_ sender: Any) {
        view.backgroundColor = UIColor.blue
    }
    
    @IBAction func clickFirstButton(_ sender: Any) {
        performSegue(withIdentifier: "toSecondView", sender: self)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toSecondView" {
            let secondVC = segue.destination as! SecondViewController
            secondVC.data = firstTextField.text!
            secondVC.delegate = self
        }
    }
    
    func dataReceive(data: String) {
        firstLabel.text = data
    }
}

