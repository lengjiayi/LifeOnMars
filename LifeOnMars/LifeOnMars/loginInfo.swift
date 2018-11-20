//
//  loginInfo.swift
//  LifeOnMars
//
//  Created by apple on 2018/11/19.
//  Copyright © 2018年 nju. All rights reserved.
//

import UIKit

class loginInfo: UIView , UITextFieldDelegate{

    //MARK: Properties
    
    var usrname = ""
    enum Sex{
        case Male
        case Female
    }
    var gender:Sex = .Male

    //UIComponents
    
    let nameTextField = UITextField()
    let genderMaleButton = UIButton()
    let genderFemaleButton = UIButton()

    //numeric
    let bgAlpha:CGFloat = 0.1
    var constrain:CGFloat = 0
    var rowheight:CGFloat = 0
    let lightblue = UIColor(red: 0.1, green: 0.2, blue: 0.8, alpha: 1.0)
    override var frame: CGRect{
        didSet{
            fixLayout()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(red: 255, green: 255, blue: 255, alpha: 0.0);
        loadComponent()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        backgroundColor = UIColor(red: 255, green: 255, blue: 255, alpha: 0.0);
        loadComponent()
    }

    override func draw(_ rect: CGRect) {
        
        //draw border
        let g = UIGraphicsGetCurrentContext()!
        g.setStrokeColor(red: 255, green: 255, blue: 255, alpha: 0.0)
        g.setShouldAntialias(true)
        let border = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
        let borderPath = UIBezierPath(roundedRect: border, cornerRadius: 10)
        borderPath.lineWidth = 3
        UIColor(red: 255, green: 255, blue: 255, alpha: bgAlpha).setFill()
        UIColor.white.setStroke()
        borderPath.fill()
        borderPath.stroke()
        
        //draw seperate line
        g.move(to: CGPoint(x: 10, y: frame.height/2))
        g.addLine(to: CGPoint(x: frame.width - 10, y: frame.height/2))
        g.strokePath()
    }
    
    //MARK: TextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.restorationIdentifier! == "TFN"
        {
            print("TFN")
            usrname = nameTextField.text ?? ""
            if(usrname.isEmpty){
                return false
            }
            nameTextField.resignFirstResponder()
            return true
        }
        return false
    }
    
    //MARK: Private Method
    @objc private func femaleIsClicked(){
        gender = .Male
        genderFemaleButton.backgroundColor = lightblue
        genderMaleButton.backgroundColor = UIColor.white
        genderFemaleButton.isSelected = true
        genderMaleButton.isSelected = false
    }
    
    @objc private func maleIsClicked(){
        gender = .Male
        genderFemaleButton.backgroundColor = UIColor.white
        genderMaleButton.backgroundColor = lightblue
        genderFemaleButton.isSelected = false
        genderMaleButton.isSelected = true
    }
    
    
    private func loadComponent(){
        
        //nameTextField
        
        nameTextField.borderStyle = .roundedRect
        nameTextField.adjustsFontSizeToFitWidth = true
        nameTextField.textAlignment = .left
        nameTextField.contentVerticalAlignment = .center
        nameTextField.returnKeyType = .done
        nameTextField.clearButtonMode = .whileEditing
        nameTextField.placeholder = "Your name"
        nameTextField.delegate = self
        nameTextField.restorationIdentifier = "TFN"
        self.addSubview(nameTextField)

        //gender selector
        
        genderMaleButton.addTarget(self, action: #selector(maleIsClicked), for: .touchUpInside)
        genderMaleButton.setTitleColor(UIColor.black, for: .normal)
        genderMaleButton.setTitleColor(UIColor.lightGray, for: .selected)
        genderMaleButton.setTitle("Male", for: .normal)
        genderMaleButton.layer.cornerRadius = 10
        genderMaleButton.isEnabled = true
        genderMaleButton.backgroundColor = lightblue
        genderMaleButton.setTitleShadowColor(UIColor.darkGray, for: .selected)
        genderMaleButton.isSelected = true
        self.addSubview(genderMaleButton)
        
        genderFemaleButton.addTarget(self, action: #selector(femaleIsClicked), for: .touchUpInside)
        genderFemaleButton.setTitleColor(UIColor.black, for: .normal)
        genderFemaleButton.setTitleColor(UIColor.lightGray, for: .selected)
        genderFemaleButton.setTitle("Female", for: .normal)
        genderFemaleButton.layer.cornerRadius = 10
        genderFemaleButton.isEnabled = true
        genderFemaleButton.backgroundColor = UIColor.white
        genderFemaleButton.setTitleShadowColor(UIColor.darkGray, for: .selected)
        genderFemaleButton.isSelected = false
        self.addSubview(genderFemaleButton)
        
 
        fixLayout()
    }
    
    private func fixLayout(){
        var loc = CGPoint(x: frame.width/2.0, y: frame.height/2.0)
        constrain = 20
        rowheight = (frame.height - 30 - 2*constrain)/2.0
        nameTextField.frame = CGRect(x: 0, y: 0, width: frame.width-30, height: 40)
        loc.y -= constrain + 20
        nameTextField.center = loc
        
        genderFemaleButton.frame = CGRect(x: 0, y: 0, width: frame.width/3, height: 40)
        genderMaleButton.frame = CGRect(x: 0, y: 0, width: frame.width/3, height: 40)
        loc.y = frame.height/2 + constrain + 20
        loc.x -= constrain + frame.width/6
        genderMaleButton.center = loc
        loc.x = frame.width - loc.x
        genderFemaleButton.center = loc

        
    }
}
