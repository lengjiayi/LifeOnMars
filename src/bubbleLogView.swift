//
//  bubbleLogView.swift
//  LifeOnMars
//
//  Created by apple on 2018/11/26.
//  Copyright © 2018年 nju. All rights reserved.
//

import UIKit

class bubbleLogView: UIView {
    
    //MARK: UIComponent
    let logText = UILabel()
    
    //MARK: Properties
    let angleHeight:CGFloat = 15
    
    override var frame: CGRect{
        didSet{
            fixLayout()
        }
    }
    
    //init UI
    override init(frame: CGRect) {
        super.init(frame: frame)
        logText.adjustsFontSizeToFitWidth = true
        logText.textColor = UIColor.white
        logText.text = "收到消息：balabala"
        addSubview(logText)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        logText.adjustsFontSizeToFitWidth = true
        logText.textColor = UIColor.white
        logText.text = "收到消息：balabala"
        addSubview(logText)
    }
    
    override func draw(_ rect: CGRect) {
        // Drawing code
        let borderPath = UIBezierPath()
        borderPath.move(to: CGPoint(x: 10, y: 0))
        borderPath.addLine(to: CGPoint(x: frame.width - 10, y: 0))
        borderPath.addArc(withCenter: CGPoint(x: frame.width - 10, y: 10), radius: 10, startAngle: -CGFloat(M_PI)/2, endAngle: 0, clockwise: true)
        borderPath.addLine(to: CGPoint(x: frame.width, y: frame.height - 10 - angleHeight))
        borderPath.addArc(withCenter: CGPoint(x: frame.width - 10, y: frame.height - 10 - angleHeight), radius: 10, startAngle: 0, endAngle: CGFloat(M_PI)/2, clockwise: true)
        borderPath.addLine(to: CGPoint(x: frame.width / 2, y: borderPath.currentPoint.y))
        borderPath.addLine(to: CGPoint(x: borderPath.currentPoint.x-5, y: borderPath.currentPoint.y + angleHeight))
        borderPath.addLine(to: CGPoint(x: borderPath.currentPoint.x-10, y: borderPath.currentPoint.y - angleHeight))
        borderPath.addLine(to: CGPoint(x: 10, y: borderPath.currentPoint.y))
        borderPath.addArc(withCenter: CGPoint(x: 10, y: borderPath.currentPoint.y - 10), radius: 10, startAngle: CGFloat(M_PI)/2, endAngle: CGFloat(M_PI), clockwise: true)
        borderPath.addLine(to: CGPoint(x: 0, y: 10))
        borderPath.addArc(withCenter: CGPoint(x: 10, y: 10), radius: 10, startAngle: CGFloat(M_PI), endAngle: CGFloat(M_PI)*3/2, clockwise: true)
        borderPath.lineWidth = 1
        UIColor(red: 255, green: 255, blue: 255, alpha: 0.2).setFill()
        UIColor.lightGray.setStroke()
        borderPath.fill()
        borderPath.stroke()
        
    }
    
    //Private Methods
    private func fixLayout(){
        var loc = CGPoint(x: frame.width/2, y: frame.height/2)
        loc.y -= angleHeight / 2
        logText.frame = CGRect(x: 0, y: 0, width: frame.width - 20, height: frame.height - 20 - angleHeight)
        logText.center = loc
    }

}
