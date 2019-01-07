//
//  connectionViewController.swift
//  LifeOnMars
//
//  Created by apple on 2018/11/23.
//  Copyright © 2018年 nju. All rights reserved.
//

import UIKit

class connectionViewController: UIViewController {

    //MARK: Usrinfo
    var myInfo = usrInfoStruct(usrname: "", gender: .Male, province: "")
    var friendInfo = usrInfoStruct(usrname: "default", gender: .Male, province: "Arabia Terra"){
        didSet{
            self.friendInfoView.updateInfo(self.friendInfo)
        }
    }
    //MARK: UIComponents
    let bgimageView = UIImageView()
    let alienImageView = UIImageView()
    let hits = hitsView()
    let friendInfoView = friendInfoBar()
    let nextNeightborButton = UIButton()


    //MARK: Bt relates
    var centerManager:btCenter? = nil
    var commonManager:btCommon? = nil
    var index:Int = -1
    
    //MARK:Other Properties
    let provinceName = ["Solis Lacus",
                        "Arabia Terra",
                        "Olympus Mons",
                        "Valles Marineris",
                        "Cydonia",
                        "Planum Austrlate",
                        ]
    
    //MARK: Initialization
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
        friendInfoView.updateInfo(self.friendInfo)
        view.addSubview(friendInfoView)
        
        //init next button
        loc.x = view.center.x
        loc.y = view.frame.height - imgwidth * 0.75
        nextNeightborButton.frame = CGRect(x: 0, y: 0, width: 1.5 * imgwidth, height: imgwidth * 0.75)
        nextNeightborButton.center = loc
        nextNeightborButton.addTarget(self, action: #selector(switchFriInfo), for: .touchUpInside)
        nextNeightborButton.setTitle("下一位", for: .normal)
        nextNeightborButton.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.3)
        nextNeightborButton.setTitleColor(UIColor.black, for: .normal)
        view.addSubview(nextNeightborButton)
        
        //init bluetoothTools
        var info:String = myInfo.usrname
        switch myInfo.gender {
        case .Male:
            info += "1"
        case .Female:
            info += "2"
        case .Special:
            info += "0"
        }
        info += String(provinceName.firstIndex(of: myInfo.province)!)
        centerManager = btCenter(frame: self.view.frame)
        commonManager = btCommon(frame: self.view.frame, info: info)
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
            nextView.centerManager = self.centerManager
            nextView.commonManager = self.commonManager
            nextView.commonManager?.father = nextView
        }
    }
    
    //Mark Private Methods
    @objc private func jumptonext()
    {
        /*for test
        if index<0 {
            return
        }
        centerManager!.link(index: index)
        */
        self.performSegue(withIdentifier: "showMainView", sender: "parameters")
    }
    
    @objc private func switchFriInfo()
    {
        if centerManager!.infos.count == 0 {
            return
        }
        index = index+1
        index = index % centerManager!.infos.count
        friendInfo.usrname = "新用户"
        let curinfo = centerManager!.infos[index]
        let intinfo = Int.init(String(curinfo.suffix(2)))
        let start = curinfo.index((curinfo.startIndex), offsetBy: 3)
        let end = curinfo.index((curinfo.endIndex), offsetBy: -2)
        friendInfo.usrname = String(curinfo[start..<end])
        friendInfo.province = provinceName[intinfo! % 10]
        switch intinfo! / 10{
            case 0: friendInfo.gender = .Special
            case 1: friendInfo.gender = .Male
            case 2: friendInfo.gender = .Female
            default: fatalError("wrong msg")
        }
        self.friendInfoView.updateInfo(self.friendInfo)
    }
}
