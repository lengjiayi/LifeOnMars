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
    var myInfo = usrInfoStruct(usrname: "", gender: .Male, province: "")
    var friendInfo = usrInfoStruct(usrname: "bot", gender: .Male, province: "Arabia Terra"){
        didSet{
            self.friendInfoView.udpateInfo(self.friendInfo)
        }
    }
    //UIComponents
    let bgimageView = UIImageView()
    let alienImageView = UIImageView()
    let hits = hitsView()
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
        let singleTapGesture = UITapGestureRecognizer(target: self, action: #selector(jumptonext))
        alienImageView.addGestureRecognizer(singleTapGesture)
        alienImageView.isUserInteractionEnabled = true
        view.addSubview(alienImageView)
        hits.frame = CGRect(x: alienImageView.center.x + imgwidth/2, y: alienImageView.center.y - 20, width: 100, height: 30)
        view.addSubview(hits)
        //init friend info
        loc.y = imgheight * 3
        loc.x = view.center.x + imgwidth * 0.75
        friendInfoView.frame = CGRect(x: 0, y: 0, width: 3 * imgwidth, height: 2 * imgheight)
        friendInfoView.center = loc
        friendInfoView.udpateInfo(self.friendInfo)
        view.addSubview(friendInfoView)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showMainView"{
            let nextView = segue.destination as! mainViewController
            nextView.myInfo = self.myInfo
            nextView.friendInfo = self.friendInfo
            
        }
    }
    
    //Mark Private Methods
    @objc private func jumptonext()
    {
        self.performSegue(withIdentifier: "showMainView", sender: "parameters")
    }
    

}
