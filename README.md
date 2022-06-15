# 구현 목표
AVAudioPlayer를 이용하여 오디오 파일을 재생, 일시 정지 및 정지하는 방법과 볼륨을 조정하는 방법 그리고 녹음할 수 있다.   


여기서 만들 앱은 기본적으로 '재생 모드'와 '녹음 모드'를 스위치로 전환할 수 있는 앱이다. 재생 모드에서는 재생, 일시 정지,
정지를 할 수 있으며 음악이 재생되는 동안 재생 정도가 프로그레스 뷰(Progress View)와 시간으로 표시됩니다.   
또한 볼륨 조절도 가능합니다. 녹음 모드에서는 녹음을 할 수 있고 녹음이 되는 시간도 표시할 수 있습니다. 녹음이 종료되면 녹음 파일을 재생,
일시 정지, 정지할 수 있다. 그리고 이 두가지 모드를 스위치로 전환하여 반복적으로 사용할 수 있다.


### 12장 코드

```
 audioRecorder.delegate = self
        
        slVolume.value = 1.0
        audioPlayer.volume = slVolume.value
        lblEndTime.text = convertNSTimeInterval2String(0)
        lblCurrentTime.text = convertNSTimeInterval2String(0)
        setPlayButtons(false, pause: false, stop: false)
```

AudioRecorder의 델리게이트(Deligate)를 self로 설정합니다.     
볼륨 슬라이더 값을 1.0으로 설정합니다.    
audioPlayer의 볼륨도 슬라이더 값과 동일한 1.0으로 설정합니다.
[play], [Pause], [stop] 버튼을 비활성화로 설정합니다.     


```
 @IBAction func swRecordMode(_ sender: UISwitch) {
        if sender.isOn {
            audioPlayer.stop()
            audioPlayer.currentTime = 0
            lblRecordTime!.text = convertNSTimeInterval2String(0)
            isRecordMode = true
            btnRecord.isEnabled = true
            lblRecordTime.isEnabled = true
        } else {
            isRecordMode = false
            btnRecord.isEnabled = false
            lblRecordTime.isEnabled = false
            lblRecordTime.text = convertNSTimeInterval2String(0)
        }
        selectAudioFile()
        if !isRecordMode {
            initPlay()
        } else {
            initRecord()
        }
    }
```

스위치가 [on]이 되었을 땐 '녹음 모드' 이므로 오디오 재생을 중지, isRecordMode의 값을 참(true)으로 설정, [Record] 버튼과 녹음 시간을 활성화로 설정한다.    
스위치가 [on]이 아닐 땐 '재생 모드' 이므로 isRecord의 값을 거짓(false)으로 설정하고, [Record] 버튼과 녹음 시간을 비활설화하며, 녹음 시간은 0으로 초기화한다.    
selectionAudioFile 함수를 호출하여 오디오 파일을 선택하고, 모드에 따라 초기화할 함수를 호출합니다.    


