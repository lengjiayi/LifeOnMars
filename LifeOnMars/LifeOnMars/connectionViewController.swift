//
//  connectionViewController.swift
//  LifeOnMars
//
//  Created by apple on 2018/11/23.
//  Copyright © 2018年 nju. All rights reserved.
//

import UIKit

class connectionViewController: UIViewController {

    //usrinfo
    var usrname : String = ""
    var gender : loginInfo.Sex = .Male
    var province : String = ""
    
    //UIComponents
    let bgimageView = UIImageView()
    let alienImageView = UIImageView()
    let friendInfoView = friendInfoBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //init background image
        view.backgroundColor = UIColor.black
        let bgimage = UIImage(named: "connectbg")
        var loc = view.center
        var imgwidth = loc.x * 2
        var imgheight = imgwidth / (bgimage?.size.width)!  * (bgimage?.size.height)!
        bgimageView.frame = CGRect(x: 0, y: 0, width: imgwidth, height: imgheight)
        bgimageView.image = bgimage
        loc.y +=  view.center.y - imgheight/2
        bgimageView.center = loc
        view.addSubview(bgimageView)
        
        //init alien image
        let alienimage = UIImage(named: "alien")
        imgwidth = imgwidth / 5
        imgheight = imgwidth / (alienimage?.size.width)!  * (alienimage?.size.height)!
        alienImageView.frame = CGRect(x: 0, y: 0, width: imgwidth, height: imgheight)
        alienImageView.image = alienimage
        loc.x -= imgwidth * 1.5
        loc.y += imgheight / 2
        alienImageView.center = loc
        view.addSubview(alienImageView)

        //init friend info
        loc.y -= imgheight * 1.25 + 10
        loc.x = view.center.x + imgwidth * 0.75
        friendInfoView.frame = CGRect(x: 0, y: 0, width: 3 * imgwidth, height: 2 * imgheight)
        friendInfoView.center = loc
        view.addSubview(friendInfoView)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
