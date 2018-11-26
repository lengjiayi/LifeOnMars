//
//  waveMask.swift
//  LifeOnMars
//
//  Created by apple on 2018/11/26.
//  Copyright © 2018年 nju. All rights reserved.
//

import UIKit

class waveMask: UIView {

    var curRadius:CGFloat = 100{
        didSet{
            setNeedsDisplay()
        }
    }
    let thick:CGFloat = 30
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(red: 255, green: 255, blue: 255, alpha: 0.0);
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        backgroundColor = UIColor(red: 255, green: 255, blue: 255, alpha: 0.0);
    }
    
    override func draw(_ rect: CGRect) {
        let g = UIGraphicsGetCurrentContext()!
        let components:[CGFloat] = [0.0, 0.3, 1.0, 0.3,
                                    1.0, 0.0, 0.2, 0.0]
        let locations:[CGFloat] = [0.0, 1.0]
        let gradient = CGGradient(colorSpace: CGColorSpaceCreateDeviceRGB(), colorComponents: components, locations: locations, count: locations.count)!
        let circleCenter = CGPoint(x: center.x, y: frame.height)
        g.drawRadialGradient(gradient, startCenter: circleCenter, startRadius: curRadius, endCenter: circleCenter, endRadius: curRadius + thick, options: .drawsAfterEndLocation)
        /* draw border
        let borderPath = UIBezierPath()
        borderPath.move(to: CGPoint(x: center.x - curRadius, y: frame.height))
        borderPath.addArc(withCenter: CGPoint(x: center.x, y: frame.height), radius: curRadius, startAngle: CGFloat(Double.pi), endAngle: CGFloat(Double.pi)*2, clockwise: true)
        borderPath.addLine(to: CGPoint(x: borderPath.currentPoint.x + thick, y: borderPath.currentPoint.y))
        borderPath.addArc(withCenter: CGPoint(x: center.x, y: frame.height), radius: curRadius + thick, startAngle: 0, endAngle: CGFloat(Double.pi), clockwise: false)
        borderPath.addLine(to: CGPoint(x: center.x - curRadius, y: frame.height))
        
        UIColor.white.setStroke()
        borderPath.fill()
 */
    }

}
