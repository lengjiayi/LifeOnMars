//
//  LoginViewController.swift
//  LifeOnMars
//
//  Created by apple on 2018/11/18.
//  Copyright © 2018年 nju. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    //MARK: Properties
    let launchGo = launchButton()
    let infoBar = loginInfo()
    @IBOutlet weak var imageMars: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()

        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Setup UIComponent
    func setUpUI(){
        //add launch button
        launchGo.frame = CGRect(x: 0, y: 0, width: 64, height: 86)
        var loc = imageMars.center
        loc.y -= 70
        loc.x = view.center.x
        launchGo.center = loc
        launchGo.addTarget(self, action: #selector(rocketGo), for: .touchUpInside)
        view.addSubview(launchGo)
        
        //add register info bar
        let relativewidth = view.frame.width*2/3
        let relativeheight = relativewidth
        infoBar.frame = CGRect(x: 0, y: 0, width: relativewidth, height: relativeheight)
        loc.y = loc.y - relativeheight/2 - 43 - 10
        infoBar.center = loc
        view.addSubview(infoBar)
        
    }
    
    //MARK: Actions
    @objc func rocketGo()
    {
        launchGo.isSelected = true
        let top = CGPoint(x: view.center.x, y: -43)
        UIView.animate(withDuration: 1.0, animations: {
            () -> Void in
            self.launchGo.center = top
        })
    }
    

}

