//
//  ViewController.swift
//  Audio
//
//  Created by 203a05 on 2022/05/20.
//

import UIKit
import AVFoundation

class ViewController: UIViewController,AVAudioPlayerDelegate {
    var audioplayer : AVAudioPlayer!
    var audioFile : URL!
    let MAX_VOLUME : Float = 10.0
    var progressTimer : Timer!
    let timePlayerSelector:Selector = #selector(ViewController.updatePlayTime)
    

    @IBOutlet var pvProgress: UIProgressView!
    @IBOutlet var lblCurrentTime: UILabel!
    @IBOutlet var lblEndTime: UILabel!
    @IBOutlet var btnPlay: UIButton!
    @IBOutlet var btnPause: UIButton!
    @IBOutlet var btnStop: UIButton!
    @IBOutlet var slVolume: UISlider!
    
    @IBOutlet var btnRecord: UIButton!
    @IBOutlet var lblRecordTime: UILabel!
    
    var audioRecorder : AVAudioRecorder
    var isRecordMode = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        selectAudioFile()
        if !isRecordMode{
        initpaly()
            btnRecord.isEnabled = false
            lblRecordTime.isEnabled = false
        } else {
            initRecord()
        }
    
    func selectAudioFile(){
        if !isRecordMode{ audioFile = Bundle.main.url(forResource: "너의 모든 순간", withExtension: "mp3")
        }
        
        else {
            let documenDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            audioFile = documenDirectory.appendingPathComponent("recordFile.m4a")
            
        }
    }
    
    func initRecord() {
        
    }
    
    func initpaly() {
        
        do {audioplayer = try AVAudioPlayer(contentsOf: audioFile)
        }
        
        catch let error as NSError {print("Error-initplay : \(error)")
        }
    
        slVolume.maximumValue = MAX_VOLUME
        slVolume.value = 1.0
        pvProgress.progress = 0
        
        audioplayer.delegate = self
        audioplayer.prepareToPlay()
        audioplayer.volume = slVolume.value
        
        lblEndTime.text = convertNSTimeInterval2String(audioplayer.duration)
        lblCurrentTime.text = convertNSTimeInterval2String(0)
        
        setPlayButtons(play: true, pause: false, stop: false)    }
    
    func setPlayButtons(play:Bool, pause:Bool, stop:Bool){
        
        btnPlay.isEnabled = play
        btnPause.isEnabled = pause
        btnStop.isEnabled = stop   }
    
    func convertNSTimeInterval2String(_ time:TimeInterval) -> String {
        let min = Int(time/60)
        let sec = Int(time.truncatingRemainder(dividingBy: 60))
        let strTime = String(format: "%02d:%02d", min,sec)
        return strTime
    }
    
    
        func btnPlayAudio(_ sender: UIButton) {
        audioplayer.play()
        setPlayButtons(play: false, pause: true, stop: true)
        progressTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: timePlayerSelector, userInfo: nil, repeats: true)
            }
        func updatePlayTime(){
        lblCurrentTime.text = convertNSTimeInterval2String(audioplayer.currentTime)
        pvProgress.progress = Float(audioplayer.currentTime/audioplayer.duration)
    }
    
        func btnPauseAudio(_ sender: UIButton) {
        audioplayer.pause()
        setPlayButtons(play: true, pause: false, stop: true)
    }
    
        func btnStopAudio(_ sender: UIButton) {
        audioplayer.stop()
        audioplayer.currentTime = 0
        lblCurrentTime.text = convertNSTimeInterval2String(0)
        setPlayButtons(play: true, pause: false, stop: false)
        progressTimer.invalidate()
    }
    
        func slChangeVolume(_ sender: UISlider) {
        audioplayer.volume = slVolume.value
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        progressTimer.invalidate()
        setPlayButtons(play: true, pause: false, stop: false)
    }
    
        func swRecordMode(_ sender: UISwitch) {
    }
    
        func btnRecord(_ sender: UIButton) {
    }
    
    
}

}
