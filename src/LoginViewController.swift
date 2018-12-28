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
    let tipsTextField = UITextField()
    
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
        //disable textfield from being edited
        return false;
    }
    
    //MARK: Setup UIComponent
    func setUpUI(){
        let bgimage = UIImage(named: "LoginBG")
        var loc = view.center
        var imgwidth = loc.x * 2
        var imgheight = imgwidth / (bgimage?.size.width)!  * (bgimage?.size.height)!
        imageMars.frame = CGRect(x: 0, y: 0, width: imgwidth, height: imgheight)
        imageMars.image = bgimage
        loc.y +=  view.center.y - imgheight/2
        imageMars.center = loc
        //add launch button
        launchGo.frame = CGRect(x: 0, y: 0, width: 64, height: 86)
        loc = imageMars.center
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
        
        //add tipsTextField
        tipsTextField.borderStyle = .roundedRect
        tipsTextField.adjustsFontSizeToFitWidth = true
        tipsTextField.textAlignment = .left
        tipsTextField.contentVerticalAlignment = .center
        tipsTextField.delegate = self
        tipsTextField.frame = CGRect(x: 0, y: 0, width: relativewidth - 30, height: 40)
        tipsTextField.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.1)
        tipsTextField.textColor = UIColor.white
        tipsTextField.attributedPlaceholder = NSAttributedString.init(string:"设置您在火星上的身份", attributes: [
            NSAttributedStringKey.foregroundColor:UIColor.gray])
//        print(imageMars.center)
//        print(view.center)
        loc = view.center
        loc.y = view.frame.height - tipsTextField.frame.height
        tipsTextField.center = loc
        self.view.addSubview(tipsTextField)
        
        
    }

    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showProvinceTableView"{
            let nextView = segue.destination as! provinceTableViewController
            nextView.female = infoBar.gender
            nextView.usrname = infoBar.usrname
        }
    }
    
    //MARK: Actions
    @objc func rocketGo()
    {
        if (infoBar.nameTextField.text?.isEmpty)!{
            tipsTextField.text = "请填写昵称"
            return
        }
        launchGo.isSelected = true
        let top = CGPoint(x: view.center.x, y: -43)
        UIView.animate(withDuration: 1.0, animations: {
            () -> Void in
            self.launchGo.center = top
        })
        
        //jump to next view after 1.0s
        perform(#selector(tonextview), with: self, afterDelay: 1.0)

    }
    
    @objc func tonextview(){
//        let sb = UIStoryboard(name: "Main", bundle:nil)
//        let provinceview = sb.instantiateViewController(withIdentifier: "provinceTable") as! provinceTableViewController
//        self.present(provinceview, animated: true, completion: nil)
        self.performSegue(withIdentifier: "showProvinceTableView", sender: "parameters")
    }

    

}

