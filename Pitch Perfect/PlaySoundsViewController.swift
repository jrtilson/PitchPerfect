//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by Jeff Tilson on 2015-09-29.
//  Copyright © 2015 Jeff Tilson. All rights reserved.
//

import UIKit
import AVFoundation
import MediaPlayer

class PlaySoundsViewController: UIViewController {

    // MARK: - Global Variables
    var audioPlayer: AVAudioPlayer!
    var receivedAudio: RecordedAudio!
    var audioEngine:AVAudioEngine!
    var audioFile:AVAudioFile!
    
    // MARK: - UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up audio engine and audio file for pitch shifting
        audioEngine = AVAudioEngine()
        audioFile = try! AVAudioFile(forReading: self.receivedAudio.filePathUrl)
    
        // Set up audio player for rate modification
        audioPlayer = try! AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl)
        audioPlayer.enableRate = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Actions
    @IBAction func playSlowAudio(sender: UIButton) {
        playAudioWithVariableRate(0.5)
    }

    @IBAction func playFastAudio(sender: UIButton) {
        playAudioWithVariableRate(2.0)
    }

    @IBAction func playChipmunkAudio(sender: UIButton) {
        playAudioWithVariablePitch(1000)
    }
    
    @IBAction func playVaderAudio(sender: UIButton) {
        playAudioWithVariablePitch(-1000)
    }

    @IBAction func stopAudio(sender: UIButton) {
        resetAllAudio()
    }
    
    // MARK: - Helpers
    func playAudioWithVariableRate(rate: Float) {
        resetAllAudio()
        audioPlayer.rate = rate
        audioPlayer.play()
    }
    
    func playAudioWithVariablePitch(pitch: Float){
        resetAllAudio()
        
        let audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        let changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        try! audioEngine.start()
        
        audioPlayerNode.play()
    }
    
    func resetAllAudio() {
        // Stop and reset all audio
        audioPlayer.currentTime = 0.0
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
    }
}
