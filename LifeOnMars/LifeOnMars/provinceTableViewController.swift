//
//  provinceTableViewController.swift
//  LifeOnMars
//
//  Created by apple on 2018/11/20.
//  Copyright © 2018年 nju. All rights reserved.
//

import UIKit

class provinceTableViewController: UITableViewController {

    //MARK: Parameters from login view
    var usrname : String = ""
    var female : loginInfo.Sex = .Male
    var pname : String = ""

    //MARK: Province names
    var provinceName = [String]()
    var provinceInfo:NSMutableDictionary?
    var selected:[Bool] = [false, false, false, false, false, false]               //current selected cell
    var infoheight : [CGFloat] = [0,0,0,0,0,0]        //height of info string
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //load province detail info
        if let path = Bundle.main.path(forResource: "provinceInfo", ofType: "plist"){
            provinceInfo = NSMutableDictionary.init(contentsOfFile: path)!
        }
        else{
            print("cannot find plistfile")
        }

        //set background image
        let imgback=UIImage(named:"infoviewbg")
        
        let imgbackV=UIImageView(image: imgback)
        
        self.tableView.backgroundView=imgbackV
//        tableView.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.0)
        loadProvinces()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {

        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return provinceName.count
    }

    //init cells
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "provinceCell", for: indexPath) as? provinceTableViewCell else {
            fatalError("The dequeued cell is not an instance of provinceTableViewCell.")
        }
        // Configure the cell...
        let pname = provinceName[indexPath.row]
        cell.provinceLabel.text = pname
        
        let info = provinceInfo![pname]!
        infoheight[indexPath.row] = cell.prepareInfo(info: info as! String)
        cell.father = self
        return cell
    }
    
    //change cell height
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        var height:CGFloat = 44
        if(selected[indexPath.row]){
            height += infoheight[indexPath.row]
        }
//        print(height)
        return height
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selected[indexPath.row] = !selected[indexPath.row]
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showConnectView"{
            let nextView = segue.destination as! connectionViewController
            nextView.myInfo.usrname = self.usrname
            nextView.myInfo.gender = self.female
            nextView.myInfo.province = pname

        }
    }
    //MARK: Actions
    func jumptonext()
    {
//        print(pname)
        self.performSegue(withIdentifier: "showConnectView", sender: "parameters")
    }
    
    //MARK: Private Method
    private func loadProvinces(){
        provinceName = ["Solis Lacus",
                   "Arabia Terra",
                   "Olympus Mons",
                   "Valles Marineris",
                   "Cydonia",
                   "Planum Austrlate",
        ]
    }

}
