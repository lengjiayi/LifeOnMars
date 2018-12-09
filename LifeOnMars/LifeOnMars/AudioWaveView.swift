//
//  AudioWaveView.swift
//  LifeOnMars
//
//  Created by apple on 2018/11/30.
//  Copyright © 2018 nju. All rights reserved.
//

import UIKit

class AudioWaveView: UIView {

    
    private lazy var waveLayer1: CAShapeLayer = CAShapeLayer()
    private lazy var waveLayer2: CAShapeLayer = CAShapeLayer()
    private lazy var waveLayer3: CAShapeLayer = CAShapeLayer()
    private lazy var borderLayer: CAShapeLayer = CAShapeLayer()
    let timer:Timer? = nil
    let margin:CGFloat = 10
    var Wrate:CGFloat = 0.0
    var flat:Bool = true{
        didSet{
            if flat{
                Wrate = 1.0
            }else{
                Wrate = 0.0
            }
        }
    }
    
    //析构函数
    deinit {
        stop()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initShape(waveLayer1)
        initShape(waveLayer2)
        initShape(waveLayer3)
        initShape(self.borderLayer)
        initializerWaveLayer()
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        initializerWaveLayer()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initializerWaveLayer()
    {
        self.layer.addSublayer(waveLayer1)
        self.layer.addSublayer(waveLayer2)
        self.layer.addSublayer(waveLayer3)
        self.layer.addSublayer(borderLayer)
    }
    private func initShape(_ layer: CAShapeLayer)
    {
        layer.frame = self.bounds
        layer.backgroundColor = UIColor.clear.cgColor
        layer.lineWidth = 2
        layer.fillColor = UIColor.clear.cgColor
        layer.strokeStart = 0
        layer.strokeEnd = 1
    }
    public func start()
    {
        initShape(self.waveLayer1)
        initShape(self.waveLayer2)
        initShape(self.waveLayer3)
        initShape(self.borderLayer)
        let timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(handleTimer), userInfo: nil, repeats: true)
        RunLoop.current.add(timer, forMode: .commonModes)
    }
    
    
    @objc private func handleTimer()
    {
        if !flat && Wrate < 1.0{
            Wrate += 0.2
            if Wrate > 1.0{
                Wrate = 1.0
            }
        }
        if flat && Wrate > 0{
            Wrate -= 0.2
            if(Wrate < 0){
                Wrate = 0
            }
        }
        let path1 = UIBezierPath()
        let path2 = UIBezierPath()
        let path3 = UIBezierPath()
        path1.move(to: CGPoint(x: margin, y: frame.height/2))
        path2.move(to: CGPoint(x: margin, y: frame.height/2))
        path3.move(to: CGPoint(x: margin, y: frame.height/2))
        waveLayer1.strokeColor = getRandomColor().cgColor
        waveLayer2.strokeColor = getRandomColor().cgColor
        waveLayer3.strokeColor = getRandomColor().cgColor
        var h1:CGFloat = 0
        var h2:CGFloat = 0
        var h3:CGFloat = 0
        let dx:CGFloat = (frame.width - 2*margin) / 30
        for _ in 1...30{
            h1 = (CGFloat(Int(arc4random()%100)+1) - 50)*Wrate
            h2 = (CGFloat(Int(arc4random()%50)+1) - 25)*Wrate
            h3 = (CGFloat(Int(arc4random()%20)+1) - 10)*Wrate
            h1 = h1 / 100 * (frame.height - margin * 2) + frame.height/2
            h2 = h2 / 100 * (frame.height - margin * 2) + frame.height/2
            h3 = h3 / 100 * (frame.height - margin * 2) + frame.height/2
            path1.addLine(to: CGPoint(x: path1.currentPoint.x + dx, y: h1))
            path2.addLine(to: CGPoint(x: path2.currentPoint.x + dx, y: h2))
            path3.addLine(to: CGPoint(x: path3.currentPoint.x + dx, y: h3))
        }
        waveLayer1.path = path1.cgPath
        waveLayer2.path = path2.cgPath
        waveLayer3.path = path3.cgPath
        //draw border
        borderLayer.strokeColor = getRandomColor().cgColor
        let border = UIBezierPath()
        border.move(to: CGPoint(x: margin, y: 0))
        border.addLine(to: CGPoint(x: frame.width-margin, y: 0))
        border.addArc(withCenter: CGPoint(x: frame.width-margin, y: margin), radius: margin, startAngle: CGFloat(Double.pi)*3/2, endAngle: CGFloat(Double.pi)*2, clockwise: true)
        border.addLine(to: CGPoint(x: frame.width, y: frame.height - margin))
        border.addArc(withCenter: CGPoint(x: frame.width-margin, y: frame.height - margin), radius: margin, startAngle: 0, endAngle: CGFloat(Double.pi)/2, clockwise: true)
        border.addLine(to: CGPoint(x: margin, y: frame.height))
        border.addArc(withCenter: CGPoint(x: margin, y: frame.height - margin), radius: margin, startAngle: CGFloat(Double.pi)/2, endAngle: CGFloat(Double.pi), clockwise: true)
        border.addLine(to: CGPoint(x: 0, y: margin))
        border.addArc(withCenter: CGPoint(x: margin, y: margin), radius: margin, startAngle: CGFloat(Double.pi), endAngle: CGFloat(Double.pi)*3/2, clockwise: true)
        borderLayer.path = border.cgPath
        
    }
    
    func getRandomColor() -> UIColor {
        return UIColor(red:   CGFloat(arc4random()) / CGFloat(UInt32.max),
                       green: CGFloat(arc4random()) / CGFloat(UInt32.max),
                       blue:  CGFloat(arc4random()) / CGFloat(UInt32.max),
                       alpha: 1.0)
    }
    
    public func stop()
    {
        
    }
    
}
