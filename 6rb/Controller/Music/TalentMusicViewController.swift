//
//  TalentMusicViewController.swift
//  6rb
//
//  Created by PCH-37 on 2019/9/11.
//  Copyright © 2019 6rb. All rights reserved.
//

import UIKit
import AVFoundation

class TalentMusicViewController: UIViewController {

    var session: AVAudioSession?
    var engine: AVAudioEngine?
    var isInput: Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
        createSession()
    }
    

    func configureView() {
        
    }
    
    func createSession() {
        
        session = AVAudioSession.sharedInstance()
        let startSessionError : NSError?
        
        do {
            try session?.setPreferredSampleRate(44100)                                //-- Try to set a spcific SampleRate.
            try session?.setCategory(.playAndRecord)               //-- Set a recording category.
            try session?.overrideOutputAudioPort(.speaker)    //-- Active loud speaker mic.
        } catch let err as NSError {
            startSessionError = err
            print("An error on starting session: \(startSessionError)")
        }
    }
    
    //-- Add audio input.
    func startAudioInput() {
        
        engine = AVAudioEngine()                                    //-- Get AVaudioEngine object.
        let input =  engine?.inputNode                             //-- Init mic input.
        let mixer = engine?.mainMixerNode                           //-- mainMixerNode have to be called for it works.
        let inputFormat = input?.inputFormat(forBus: 0)               //-- Get the correct format.
        let startEngineError : NSError?
        
        engine?.connect(input!, to: mixer!, format: inputFormat)    //-- To test if I hear me.
        
        do {
            try engine?.start()                                     //-- Start Engine Vroooooouuum !! :).
            isInput = true                                          //-- Set isInput to True.
        } catch let err as NSError {
            startEngineError = err
            print("Starting engine failed \(startEngineError)")
            isInput = false                                         //-- starting engine failed : set isInput to false.
        }
        
        //-- Get the buffer on every sound received in the input.
        input?.installTap(onBus: 0, bufferSize: 4096, format: inputFormat) {
            (buffer : AVAudioPCMBuffer!, when : AVAudioTime!) in
            
            print("aaa")
//            let floatChannelData = buffer.floatChannelData          //-- Get the low sound values for filter them.
//            let memory = floatChannelData.memory                    //-- Get memory.
//            let memoryValue = memory[Int(buffer.frameLength) - 1]   //-- Get value.
//
//            //-- If the value is too low -> return.
//            if fabs(memoryValue) < 0.0005 {
//                return
//            }
//
//            print("Buffer \(buffer)")                               //-- We can send or record the buffer here.
        }
    }
    
    //-- Stop audio input.
    func stopAudioInput() {
        engine?.stop()      //-- Stop the engine.
        isInput = false     //-- isInput to false.
    }

    @IBAction func openMic(_ sender: Any) {
        isInput = isInput == nil ? false : isInput  //-- Set false if isInput value is nil.
        
        //-- Check statement for isInput.
        if !isInput! {
            startAudioInput()
//            audioInput.setTitle("Stop audio input", forState: .Normal)
        } else {
            stopAudioInput()
//            audioInput.setTitle("Start audio input", forState: .Normal)
        }
    }
}

extension TalentMusicViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
}

extension TalentMusicViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 15
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SongTableViewCell", for: indexPath) as! SongTableViewCell
        return cell
    }
}
