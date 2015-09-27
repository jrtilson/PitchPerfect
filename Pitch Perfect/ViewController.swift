//
//  ViewController.swift
//  Pitch Perfect
//
//  Created by Jeff Tilson on 2015-09-27.
//  Copyright © 2015 Jeff Tilson. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var labelRecording: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func recordAudio(sender: UIButton) {
        // TODO: Record some audio!
        print("recordAudio called")
        
        
            labelRecording.hidden = false
    }
    
    @IBAction func stopRecording(sender: UIButton) {
        print("stopRecording called")
        
        labelRecording.hidden = true
    }
}

