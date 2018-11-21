//
//  provinceTableViewCell.swift
//  LifeOnMars
//
//  Created by apple on 2018/11/20.
//  Copyright © 2018年 nju. All rights reserved.
//

import UIKit

class provinceTableViewCell: UITableViewCell {

    @IBOutlet weak var provinceLabel: UILabel!
    @IBOutlet weak var InfoLabel: UILabel!
    @IBOutlet weak var selectButton: UIButton!
    
    var showing = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    //MARK: Actions
    func prepareInfo(info : String) -> CGFloat
    {
        self.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.0)
        //init provinceLabel
        provinceLabel.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.0)
        //init InfoLabel
        InfoLabel.textColor = UIColor.white
        InfoLabel.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.0)
        InfoLabel.frame = CGRect(x: 0, y: 0, width: frame.width - 120, height:0)
        InfoLabel.text = info
        InfoLabel.font = UIFont.systemFont(ofSize: 15.0)
        InfoLabel.numberOfLines = 0
        InfoLabel.lineBreakMode = .byCharWrapping
        
        //reSize InfoLabel
        let size = info.boundingRect(with: CGSize(width: InfoLabel.frame.width, height: 8000), options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: InfoLabel.font], context: nil)
        var autoRect = InfoLabel.frame
        autoRect.size.height = size.height
        InfoLabel.frame = autoRect
        
        var loc = provinceLabel.center
        loc.y += 22 + 8 + InfoLabel.frame.height/2
        loc.x = 40 + InfoLabel.frame.width/2
        InfoLabel.center = loc
        
        //reset selectButton
        selectButton.frame = CGRect(x: 0, y: 0, width: 80, height: 60)
        loc.x = 40 + InfoLabel.frame.width + selectButton.frame.width/2
        selectButton.center = loc
        return InfoLabel.frame.height+16
    }
}
