//
//  myNavigationController.swift
//  iKeaDemo
//
//  Created by PoCheng Juan on 2018/8/31.
//  Copyright © 2018年 PoCheng Juan. All rights reserved.
//

import UIKit

class myNavigationController: UINavigationController {

    //var Detail_str : ErrorData_Struct
    var ErrorData_Main : ErrorData_Struct?
    override func viewDidLoad() {
        super.viewDidLoad()
        //print(Detail_str)
        let VC_2 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SecondVC") as! SecondVC
        performSegue(withIdentifier: "NaviToHome", sender: ErrorData_Main)
        
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
            controller.ErrorData_Main = ErrorData_Main
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
