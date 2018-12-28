//
//  mainViewController.swift
//  LifeOnMars
//
//  Created by apple on 2018/11/26.
//  Copyright © 2018年 nju. All rights reserved.
//

import UIKit
import AVKit

class mainViewController: UIViewController ,UITextFieldDelegate{

    //Tools
    let translator = MarsTranslator()
    let audio = audioHandler()
    var audioPlayer = AVAudioPlayer()
    
    //UIComponents
    let bgimageView = UIImageView()
    let alienImageView = UIImageView()
    let receiveLogView = bubbleLogView()
    let wave = waveMask()
    let inputTextField = UITextField()
    let audioWave = AudioWaveView()
    
    //Properties
    let margin:CGFloat = 40
    var msgToSend:String = ""
    var myInfo = usrInfoStruct(usrname: "", gender: .Male, province: "")
    var friendInfo = usrInfoStruct(usrname: "", gender: .Male, province: "")
    var mymsg:Bool = true

    //Bt relates
    var centerManager:btCenter? = nil
    var commonManager:btCommon? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //init background image
        view.backgroundColor = UIColor(red: 9/255.0, green: 10/255.0, blue: 14/255.0, alpha: 1.0)
        let bgimage = UIImage(named: "mainBG")
        var loc = view.center
        var imgwidth = loc.x * 2
        var imgheight = imgwidth / (bgimage?.size.width)!  * (bgimage?.size.height)!
        bgimageView.frame = CGRect(x: 0, y: 0, width: imgwidth, height: imgheight)
        bgimageView.image = bgimage
        loc.y +=  view.center.y - imgheight/2
        bgimageView.center = loc
        view.addSubview(bgimageView)
        
        view.addSubview(wave)
        //init audio wave
        audioWave.frame = CGRect(x: 0, y: 0, width: view.frame.width - 30, height: view.frame.height / 8)
        loc = view.center
        loc.y = audioWave.frame.height
        audioWave.center = loc
        view.addSubview(audioWave)
        audioWave.start()
        
        //init alien image
        loc = bgimageView.center
        let alienimage = UIImage(named: "alien")
        imgwidth = imgwidth / 2
        imgheight = imgwidth / (alienimage?.size.width)! * (alienimage?.size.height)!
        alienImageView.frame = CGRect(x: 0, y: 0, width: imgwidth, height: imgheight)
        alienImageView.image = alienimage
        loc.y -= imgheight - 100
        alienImageView.center = loc
        //add gesture rg
        let singleTapGesture = UITapGestureRecognizer(target: self, action: #selector(sendMsg))
        alienImageView.addGestureRecognizer(singleTapGesture)
        alienImageView.isUserInteractionEnabled = true
        view.addSubview(alienImageView)


        reStartWave()
        view.addSubview(receiveLogView)
        
        //init input TextField
        inputTextField.textColor = UIColor.lightGray
        inputTextField.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.2)
        inputTextField.borderStyle = .roundedRect
        inputTextField.adjustsFontSizeToFitWidth = true
        inputTextField.textAlignment = .left
        inputTextField.contentVerticalAlignment = .center
        inputTextField.returnKeyType = .done
        inputTextField.clearButtonMode = .always
        inputTextField.placeholder = "Hi there ~"
        inputTextField.delegate = self
        inputTextField.frame = CGRect(x: 0, y: 0, width: view.frame.width - margin*2, height: (view.frame.width - margin*2)/5)
        loc.x = view.center.x
        loc.y = view.frame.height - 50 - margin
        inputTextField.center = loc
        view.addSubview(inputTextField)
        /*
        //for debug
        debugButton.frame = CGRect(x: view.frame.height - 50, y: view.frame.width - 50, width: 20, height: 20)
        debugButton.backgroundColor = UIColor.white
        debugButton.addTarget(self, action: #selector(debugAction), for: .touchUpInside)
        view.addSubview(debugButton)
 */
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: TextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        msgToSend = inputTextField.text ?? ""
        inputTextField.resignFirstResponder()
        return true
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    //MARK: Actions
    @objc func debugAction(){
        WaveAnimation()
    }

    func receiveMsg(data: String){
        mymsg = false
        msgToSend = data
        audioWave.flat = !audioWave.flat
        WaveAnimation()
        perform(#selector(playaudio), with: self, afterDelay: 0.5)
    }
    
    //MARK: Private Methods
    
    @objc private func sendMsg(){
        mymsg = true
        audioWave.flat = !audioWave.flat
        WaveAnimation()
        perform(#selector(playaudio), with: self, afterDelay: 0.5)
        centerManager!.send(data: msgToSend)
    }
    
    @objc private func playaudio(){
        if msgToSend.isEmpty{
            return
        }
        var hex: [Int]
        if(mymsg){
            hex = translator.stringToHex(msg: msgToSend, province: myInfo.province)
        }else {
            hex = translator.stringToHex(msg: msgToSend, province: friendInfo.province)
        }
        var tmpgender = myInfo.gender
        if !mymsg {
            tmpgender = friendInfo.gender
        }
        let (str, hexArray) = translator.hexToFile(msg: hex, gender: tmpgender)
        receiveLogView.logText.text = str
        if !mymsg {
            receiveLogView.logText.text = friendInfo.usrname + ": " + msgToSend
        }
        let (duration,tmpdata) = audio.mergeWav(hexArray)
        if tmpdata != nil{
            audioPlayer = try! AVAudioPlayer(data: tmpdata!)
            audioPlayer.prepareToPlay()
            audioPlayer.play()
            perform(#selector(silence), with: self, afterDelay: duration)
            inputTextField.text = ""
        }else{
            print("return nil")
        }
        /*
        if let path = Bundle.main.path(forResource: "wavs", ofType: nil){
            let fileManager = FileManager.default
            if fileManager.fileExists(atPath: path+"/merge.wav"){
                print("success!")
                do{
                    audioPlayer = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: path+"/merge.wav"))
                } catch _ {
                    fatalError("something goes wrong")
                }
                audioPlayer.prepareToPlay()
                audioPlayer.play()
                print(audioPlayer.isPlaying)
                
            }
            else{
                fatalError("merge fail")
            }
        }
        else{
            fatalError("folder not found")
        }
 */
    }
    
    private func reStartWave(){
        let initwidth:CGFloat = view.frame.width/3*2
        let initheight:CGFloat = initwidth/2
        receiveLogView.frame = CGRect(x: view.frame.width/2 - initwidth/2, y: alienImageView.center.y - alienImageView.frame.height/2 - initheight, width: initwidth, height: initheight)
        receiveLogView.alpha = 0.0
        
        wave.frame = CGRect(x: 0, y: 0, width: 60 , height: 30)
        var loc = view.center
        loc.y = view.frame.height - wave.frame.height/2
        wave.center = loc
        wave.alpha = 0.0
    }
    
    private func Disapear(){
        UIView.animate(withDuration: 0.3, animations: {
            () -> Void in
            self.receiveLogView.alpha = 0.0
        })
    }
    
    private func WaveAnimation(){
        reStartWave()
        WaveAnimate1()
        perform(#selector(WaveAnimate2), with: self, afterDelay: 0.3)
        perform(#selector(WaveAnimate3), with: self, afterDelay: 0.5)
    }
    
    private func WaveAnimate1(){
        UIView.animate(withDuration: 0.3, animations: {
            () -> Void in
            self.wave.alpha = 1.0
        })
    }
    
    @objc private func WaveAnimate2(){
        let dstframe = CGRect(x: -view.frame.width/2, y: view.frame.height - view.frame.width, width: view.frame.width*2, height: view.frame.width)
        UIView.animate(withDuration: 0.7, animations: {
            () -> Void in
            self.wave.frame = dstframe
            self.wave.alpha = 0.0
        })
    }
    
    @objc private func WaveAnimate3(){

        UIView.animate(withDuration: 0.5, animations: {
            () -> Void in
        self.receiveLogView.alpha = 1.0
        })

    }

    @objc private func silence(){
        self.audioWave.flat = true
        Disapear()
    }
}
