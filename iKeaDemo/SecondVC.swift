//
//  SecondVC.swift
//  iKeaDemo
//
//  Created by PoCheng Juan on 2018/8/15.
//  Copyright © 2018年 PoCheng Juan. All rights reserved.
//

import UIKit

class SecondVC: UIViewController {

    
    var Detail_str : String?
    var OutputString : String?
    @IBOutlet weak var Detail_Field: UITextView!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let OutputStart = Detail_str?.index((Detail_str?.startIndex)!, offsetBy: 10)
        //let OutputEnd = Detail_str?.index(before: (Detail_str?.endIndex)!)
        let OutputEnd = Detail_str?.endIndex
        OutputString = Detail_str?[OutputStart..<OutputEnd]
        Detail_Field.text = OutputString
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func exitClick(_ sender: Any) {
        dismiss(animated: true, completion: nil)
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
