//
//  launchButton.swift
//  LifeOnMars
//
//  Created by apple on 2018/11/18.
//  Copyright © 2018年 nju. All rights reserved.
//

import UIKit

@IBDesignable class launchButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setBackgroundImage(UIImage(named: "rocketSilent"), for: .normal)
        setBackgroundImage(UIImage(named: "rocketPrepare"), for: .highlighted)
        setBackgroundImage(UIImage(named: "rocketGo"), for: .selected)
        setBackgroundImage(UIImage(named: "rocketGo"), for: [.highlighted, .selected])
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setBackgroundImage(UIImage(named: "rocketSilent"), for: .normal)
        setBackgroundImage(UIImage(named: "rocketPrepare"), for: .highlighted)
        setBackgroundImage(UIImage(named: "rocketGo"), for: .selected)
        setBackgroundImage(UIImage(named: "rocketGo"), for: [.highlighted, .selected])

        
    }
    

    
}
