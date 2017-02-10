//
//  PlayViewController.swift
//  khoi
//
//  Created by Prashant Sah on 2/6/17.
//  Copyright © 2017 Prashant Sah. All rights reserved.
//

import UIKit
import AVFoundation
class ViewController: UIViewController {
    @IBOutlet weak var vol: UISlider!
    @IBOutlet weak var pausebutton: UIButton!
    @IBOutlet weak var playbutton: UIButton!
    var player: AVAudioPlayer = AVAudioPlayer()
    var audioUrl: NSURL!
    var passedaudio	: PassedAudio!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        do
        {
            let audio = Bundle.main.path(forResource: "song", ofType: "mp3")!
            audioUrl = NSURL(fileURLWithPath: audio)
            try player=AVAudioPlayer(contentsOf: audioUrl as URL)
        }
        catch{
            print("khoi!!")
        }
    }
    
    //    let khoi=Bundle.main.path(forResource: "song", ofType: "mp3")!
    //    var audiourl = NSURL(fileURLWithPath: khoi)
    
    @IBAction func volume(_ sender: UISlider) {
        player.volume=sender.value
    }
    @IBAction func play(_ sender: UIButton) {
        player.play()
        pausebutton.isHidden=false
        playbutton.isHidden=true
        print(vol.value)
    }
    @IBAction func stop(_ sender: UIButton) {
        player.currentTime=0
        player.stop()
        playbutton.isHidden=false
        pausebutton.isHidden=true
    }
    @IBAction func pause(_ sender: UIButton) {
        player.pause()
        playbutton.isHidden=false
        pausebutton.isHidden=true
    }
    @IBAction func replay(_ sender: UIButton) {
        player.currentTime=0
        player.play()
        playbutton.isHidden=true
        pausebutton.isHidden=false
        player.volume=vol.value
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier=="passaudio"){
            let modplayvc:ModifiedPlayViewController=segue.destination as! ModifiedPlayViewController
            let data=sender as! PassedAudio
            modplayvc.ReceivedAudio=data
        }
    }
    
    @IBAction func modify(_ sender: UIButton) {
        passedaudio=PassedAudio()
        passedaudio.filePathUrl=audioUrl
        self.performSegue(withIdentifier: "passaudio", sender: passedaudio)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

