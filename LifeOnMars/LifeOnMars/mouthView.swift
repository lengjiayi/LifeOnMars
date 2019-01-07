//
//  mouthView.swift
//  LifeOnMars
//
//  Created by apple on 2019/1/7.
//  Copyright © 2019 nju. All rights reserved.
//

import UIKit
enum mouthState{
    //when not talking, this mouth show a sweet smile
    case slience
    //when talking, this mouth starts moving
    case talk
}
class mouthView: UIView {
    var state:mouthState = .slience
    let outlook:UIImageView = UIImageView();
    var imgSet:[UIImage?] = []
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    override init(frame: CGRect) {
        super.init(frame:frame)
        /*
         mouth1 is the sweet smile
         mouth2 to mouth6 is 5 different shapes of mouth
         all shapes are selected from SouthPark charactor Cartman:)
         */
        imgSet = [
            UIImage(named: "mouth1"),
            UIImage(named: "mouth2"),
            UIImage(named: "mouth3"),
            UIImage(named: "mouth4"),
            UIImage(named: "mouth5"),
            UIImage(named: "mouth6"),
        ]
        outlook.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
        outlook.image = imgSet[0]
        addSubview(outlook)
        //A timer animate the talking mouth by changing the shape each 0.2 seconds
        _ = Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(handleTimer), userInfo: nil, repeats: true)
//        backgroundColor = UIColor.white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func handleTimer()
    {
        //if in slience mode, mouth don't talk and show a sweet smile
        if(state == .slience)
        {
            outlook.image = imgSet[0]
            return
        }
        // if talking, select a not-close shape randomly
        let index:Int = Int(arc4random()%5 + 1)
        outlook.image = imgSet[index]
    }
}
