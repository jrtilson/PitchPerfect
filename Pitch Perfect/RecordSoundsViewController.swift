//
//  RecordSoundsViewController.swift
//  Pitch Perfect
//
//  Created by Jeff Tilson on 2015-09-27.
//  Copyright © 2015 Jeff Tilson. All rights reserved.
//

import UIKit
import AVFoundation

//TODO: Rename
class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {

    // MARK: - Outlets
    @IBOutlet weak var labelRecording: UILabel!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var recordButton: UIButton!

    // MARK: - Global Variables
    var audioRecorder:AVAudioRecorder!
    var recordedAudio: RecordedAudio!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    // MARK: - UIViewController
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        stopButton.hidden = true
        labelRecording.text  = "tap to record"
        recordButton.enabled = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "stopRecording") {
            let playSoundsVC: PlaySoundsViewController = segue.destinationViewController as! PlaySoundsViewController
            let data = sender as! RecordedAudio
            playSoundsVC.receivedAudio = data
        }
    }
    
    // MARK: - Actions
    @IBAction func recordAudio(sender: UIButton) {
        // TODO: Record some audio!
        print("recordAudio called")
        stopButton.hidden = false
        recordButton.enabled = false
        labelRecording.text = "recording"
        
        // Get a path that we can write to
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
        
        // Build the filename of the recording
        let recordingName = "my_audio.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = NSURL.fileURLWithPathComponents(pathArray)
        print(filePath)
        
        // Set up audio session
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord)
        
        // Set up the recorder
        try! audioRecorder = AVAudioRecorder(URL: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.meteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }
    
    // MARK: - Actions
    @IBAction func stopRecording(sender: UIButton) {
        print("stopRecording called")
        
        // Stop the recording
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
    }
    
    // MARK: - AVAudioRecorderDelegate
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder, successfully flag: Bool) {
        if (flag) {
            // Save the audio
            self.recordedAudio = RecordedAudio(title: recorder.url.lastPathComponent!, filePathUrl: recorder.url)
    
            // TODO: Segue to the play sounds view controller
            self.performSegueWithIdentifier("stopRecording", sender: recordedAudio)
        } else {
            // Failed, print error and reset buttons
            print("Recording was not successful")
            recordButton.enabled = true
            stopButton.hidden = true
        }
    }
}

