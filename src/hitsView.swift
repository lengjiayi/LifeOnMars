//
//  hitsView.swift
//  LifeOnMars
//
//  Created by apple on 2018/11/27.
//  Copyright © 2018年 nju. All rights reserved.
//

import UIKit

class hitsView: UIView {

    //MARK: UIComponent
    let logText = UILabel()
    
    //MARK: Properties
    let angleWidth:CGFloat = 10
    
    override var frame: CGRect{
        didSet{
            fixLayout()
        }
    }
    
    //init UI
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.0)
        logText.adjustsFontSizeToFitWidth = true
        logText.textColor = UIColor.green
        logText.text = "点我~"
        addSubview(logText)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.0)
        logText.adjustsFontSizeToFitWidth = true
        logText.textColor = UIColor.green
        logText.text = "点我~"
        addSubview(logText)
    }
    
    override func draw(_ rect: CGRect) {
        // Drawing code
        let borderPath = UIBezierPath()
        borderPath.move(to: CGPoint(x: 0, y: frame.height))
        borderPath.addLine(to: CGPoint(x: frame.width - 10, y: frame.height))
        borderPath.addArc(withCenter: CGPoint(x: frame.width - 10, y: frame.height-10), radius: 10, startAngle: CGFloat(Double.pi)/2, endAngle: 0.0, clockwise: false)
        borderPath.addLine(to: CGPoint(x: frame.width, y: 10))
        borderPath.addArc(withCenter: CGPoint(x: frame.width - 10, y: 10), radius: 10, startAngle: 0.0, endAngle: -CGFloat(Double.pi)/2, clockwise: false)
        borderPath.addLine(to: CGPoint(x: angleWidth + 10, y: 0))
        borderPath.addArc(withCenter: CGPoint(x: angleWidth + 10, y: 10), radius: 10, startAngle: CGFloat(Double.pi)*3/2, endAngle: CGFloat(Double.pi), clockwise: false)
        borderPath.addLine(to: CGPoint(x: angleWidth, y: frame.height - 7))
        borderPath.close()
        borderPath.lineWidth = 1
        UIColor(red: 255, green: 255, blue: 255, alpha: 0.2).setFill()
        UIColor.lightGray.setStroke()
        borderPath.fill()
        borderPath.stroke()
        
    }
    private func fixLayout(){
        logText.frame = CGRect(x: angleWidth + 10, y: 0, width: frame.width - angleWidth - 20, height: frame.height)
    }
}
