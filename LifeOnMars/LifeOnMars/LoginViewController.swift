//
//  LoginViewController.swift
//  LifeOnMars
//
//  Created by apple on 2018/11/18.
//  Copyright © 2018年 nju. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController , UITextFieldDelegate{

    //MARK: Properties
    
    let launchGo = launchButton()
    let infoBar = loginInfo()
    let provinceTextField = UITextField()
    let provinceButton = UIButton()
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
    
    //MARK: UITextField Delegate
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        popupMenu()
        //disable textfield
        return false;
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
        self.view.addSubview(launchGo)
        
        //add register info bar
        let relativewidth = view.frame.width*2/3
        let relativeheight = relativewidth
        infoBar.frame = CGRect(x: 0, y: 0, width: relativewidth, height: relativeheight*2.0/3.0)
        loc.y = loc.y - relativeheight/2 - 43 - 40
        infoBar.center = loc
        self.view.addSubview(infoBar)
        
        //add province selector
        provinceTextField.borderStyle = .roundedRect
        provinceTextField.adjustsFontSizeToFitWidth = true
        provinceTextField.textAlignment = .left
        provinceTextField.contentVerticalAlignment = .center
        provinceTextField.delegate = self
        provinceTextField.frame = CGRect(x: 0, y: 0, width: relativewidth - 30, height: 40)
        provinceTextField.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.1)
        provinceTextField.textColor = UIColor.white
        provinceTextField.attributedPlaceholder = NSAttributedString.init(string:"provicne on Mars", attributes: [
            NSAttributedStringKey.foregroundColor:UIColor.gray])
//        print(imageMars.center)
//        print(view.center)
        loc = view.center
        loc.y = imageMars.center.y + imageMars.frame.height/2
        provinceTextField.center = loc
        self.view.addSubview(provinceTextField)
        
        
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

    func popupMenu()
    {
        print("time to popup")
    }
    

}

