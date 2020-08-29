//
//  ViewController.swift
//  Xylophone
//
//  Created by Angela Yu on 27/01/2016.
//  Copyright © 2016 London App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController{
    var audioPlayer: AVAudioPlayer!
    var notes = ["note1", "note2", "note3", "note4", "note5", "note6", "note7"]

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func notePressed(_ sender: UIButton) {
        playANote(noteNumber: sender.tag)
    }
    
    func playANote(noteNumber: Int){
        let soundSource = Bundle.main.url(forResource: notes[noteNumber - 1], withExtension: "wav")
        do{
            audioPlayer = try AVAudioPlayer(contentsOf: soundSource!)
        }catch{
            print(error)
        }
        audioPlayer.play()
    }
}

