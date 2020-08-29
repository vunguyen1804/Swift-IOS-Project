//
//  SecondViewController.swift
//  Protocol And Delegate
//
//  Created by Vu Nguyen on 12/25/17.
//  Copyright © 2017 Vu Nguyen. All rights reserved.
//

import UIKit
protocol ReceiveDelegate{
    func dataReceive (data : String)
}

class SecondViewController: UIViewController {
    
    var data:String = ""
    var delegate : ReceiveDelegate?
    

    @IBOutlet weak var secondTextField: UITextField!
    @IBOutlet weak var secondLabel: UILabel!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        secondLabel.text  = data
        
    }
    @IBAction func changeToRed(_ sender: Any) {
        view.backgroundColor = UIColor.red
    }
    
    @IBAction func clickSecondButton(_ sender: Any) {
        // when user clicks this button, method dataReceive will be called, dismiss this view.
        delegate?.dataReceive(data: secondTextField.text!)
        dismiss(animated: true, completion: nil)
        
    }
}
