//
//  ModifiedPlayViewController.swift
//  khoi
//
//  Created by Prashant Sah on 2/9/17.
//  Copyright © 2017 Prashant Sah. All rights reserved.
//

import UIKit
import AVFoundation

class ModifiedPlayViewController: UIViewController {
    var player = AVAudioPlayer()
    var audioengine=AVAudioEngine()
    var ReceivedAudio = PassedAudio()
    var audiofile = AVAudioFile()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        do
        {
            try player=AVAudioPlayer(contentsOf: ReceivedAudio.filePathUrl as URL)
            player.enableRate=true
            audioengine = AVAudioEngine()
        }
        catch{
            //
        }
        // Do any additional setup after loading the view.
    }
    
    @IBAction func slowplay(_ sender: UIButton) {
        player.rate=0.5
        player.play()
        
    }
    
    @IBAction func fastplay(_ sender: UIButton) {
        player.rate=1.5
        player.play()
        
    }
    
    @IBAction func chipmunkplay(_ sender: UIButton) {
        playAudioWithVariablePitch(pitch: 1000)
        
        
    }
    func playAudioWithVariablePitch(pitch:Float)
    {
        do{
            audiofile=try AVAudioFile(forReading: ReceivedAudio.filePathUrl as URL)
        }
        catch{
            //
        }
        let audioPlayerNode = AVAudioPlayerNode()
        player.stop()
        audioengine.stop()
        audioengine.reset()
        
        
        audioengine.attach(audioPlayerNode)
        
        let changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch=pitch
        audioengine.attach(changePitchEffect)
        
        audioengine.connect(audioPlayerNode,to:changePitchEffect, format:nil)
        audioengine.connect(changePitchEffect, to:audioengine.outputNode, format:nil)
        
        audioPlayerNode.scheduleFile(audiofile, at: nil, completionHandler: nil)
        print(audioengine.isRunning)
        print (audioPlayerNode.isPlaying)
        audioengine.prepare()
        try? audioengine.start()
        
        audioPlayerNode.play()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
