//
//  mainViewController.swift
//  LifeOnMars
//
//  Created by apple on 2018/11/26.
//  Copyright © 2018年 nju. All rights reserved.
//

import UIKit

class mainViewController: UIViewController {

    //UIComponents
    let bgimageView = UIImageView()
    let alienImageView = UIImageView()
    let receiveLogView = bubbleLogView()
    let wave = waveMask()
    
    //debug
    let debugButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //init background image
        view.backgroundColor = UIColor.black
        let bgimage = UIImage(named: "mainBG")
        var loc = view.center
        var imgwidth = loc.x * 2
        var imgheight = imgwidth / (bgimage?.size.width)!  * (bgimage?.size.height)!
        bgimageView.frame = CGRect(x: 0, y: 0, width: imgwidth, height: imgheight)
        bgimageView.image = bgimage
        loc.y +=  view.center.y - imgheight/2
        bgimageView.center = loc
        view.addSubview(bgimageView)
        wave.frame = bgimageView.frame
        wave.center = bgimageView.center
        view.addSubview(wave)
        
        //init alien image
        let alienimage = UIImage(named: "alien")
        imgwidth = imgwidth / 2
        imgheight = imgwidth / (alienimage?.size.width)! * (alienimage?.size.height)!
        alienImageView.frame = CGRect(x: 0, y: 0, width: imgwidth, height: imgheight)
        alienImageView.image = alienimage
        loc.y -= imgheight - 100
        alienImageView.center = loc
        view.addSubview(alienImageView)

        //init receive view
        loc.y -= imgheight/2 + 10 + 50
        receiveLogView.frame = CGRect(x: 0, y: 0, width: imgwidth * 1.5, height: 100)
        receiveLogView.center = loc
        view.addSubview(receiveLogView)
        
        //for debug
        debugButton.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        debugButton.backgroundColor = UIColor.white
        debugButton.center = view.center
        debugButton.addTarget(self, action: #selector(debugAction), for: .touchUpInside)
        view.addSubview(debugButton)
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
    
    //Actions
    @objc func debugAction(){
/*
        UIView.animate(withDuration: 1.0, animations: {
            () -> Void in
            self.wave.curRadius += 1
        })
 */
        for i in 1...50{
            perform(#selector(increase), with: self, afterDelay: 0.01)
        }
    }
    @objc func increase(){
        wave.curRadius += 1
    }
    func hideLogView(){
        receiveLogView.isHidden = true
    }
}
