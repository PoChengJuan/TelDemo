//
//  myNavigationController.swift
//  iKeaDemo
//
//  Created by PoCheng Juan on 2018/8/31.
//  Copyright © 2018年 PoCheng Juan. All rights reserved.
//

import UIKit

class myNavigationController: UINavigationController {

    var Detail_str : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(Detail_str)
        let VC_2 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SecondVC") as! SecondVC
        performSegue(withIdentifier: "NaviToHome", sender: Detail_str)
        
        self.navigationController?.pushViewController(VC_2, animated: true)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "NaviToHome" {
            let controller = segue.destination as! SecondVC
            controller.Detail_str = Detail_str
        }
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
