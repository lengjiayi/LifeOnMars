//
//  friendInfoBar.swift
//  LifeOnMars
//
//  Created by apple on 2018/11/23.
//  Copyright © 2018年 nju. All rights reserved.
//

import UIKit

class friendInfoBar: UIView {

    //UIComponents
    let friendNameLabel = UILabel()
    let friendProvinceLabel = UILabel()
    let friendGenderLabel = UILabel()
    
    
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
        let bgAlpha:CGFloat = 0.2
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
        g.move(to: CGPoint(x: 10, y: frame.height/3))
        g.addLine(to: CGPoint(x: frame.width - 10, y: frame.height/3))
        g.move(to: CGPoint(x: 10, y: frame.height*2/3))
        g.addLine(to: CGPoint(x: frame.width - 10, y: frame.height*2/3))
        g.strokePath()
    }
    //MARK: Public Methods
    func updateInfo(_ info:usrInfoStruct){
        friendNameLabel.text = info.usrname
        switch info.gender {

        case .Male:
            friendGenderLabel.text = "男"
        case .Female:
            friendGenderLabel.text = "女"
        case .Special:
            friendGenderLabel.text = "海绵宝宝"
        }
        friendProvinceLabel.text = info.province
    }
    
    //MARK: Private Methods
    private func loadComponent(){
        
        friendNameLabel.textColor = UIColor.green
        friendNameLabel.textAlignment = .center
        friendNameLabel.text = "对方昵称"
        addSubview(friendNameLabel)
        
        friendGenderLabel.textColor = UIColor.black
        friendGenderLabel.textAlignment = .center
        friendGenderLabel.text = "男"
        addSubview(friendGenderLabel)
        
        friendProvinceLabel.textColor = UIColor.black
        friendProvinceLabel.textAlignment = .center
        friendProvinceLabel.text = "来自哪个省份"
        addSubview(friendProvinceLabel)
    }
    
    private func fixLayout(){
        var loc = center
        loc.y = frame.height / 6
        friendNameLabel.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height/3)
        friendNameLabel.center = loc
        loc.y = center.y
        friendGenderLabel.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height/3)
        friendGenderLabel.center = loc
        loc.y = frame.height * 5 / 6
        friendProvinceLabel.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height/3)
        friendProvinceLabel.center = loc
    }
    
}
