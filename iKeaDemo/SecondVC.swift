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
    var DetailOutput : String?
    var HistoryOutput : String?
    @IBOutlet weak var Detail_Field: UITextView!
    let History :String = "History"
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let OutputStart = Detail_str?.index((Detail_str?.startIndex)!, offsetBy: 7)
        let OutputEnd = Detail_str?.index(of: "@")
        //let OutputEnd = Detail_str?.indexof
        //let OutputEnd = Detail_str?.endIndex
        DetailOutput = Detail_str?[OutputStart..<OutputEnd]
        Detail_Field.text = DetailOutput
        HistoryOutput = Detail_str?[OutputEnd..<Detail_str?.endIndex]
    }

    
    @IBAction func HistoryClick(_ sender: Any) {
        //let His_VC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HistoryVC") as! HistoryVC

        //performSegue(withIdentifier: "HistoryString", sender: HistoryOutput)
        //self.navigationController?.pushViewController(His_VC, animated: true)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "HistoryString" {
            let controller = segue.destination as! HistoryVC
            controller.History_str = HistoryOutput
        }
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
