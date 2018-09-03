//
//  HistoryAddVC.swift
//  iKeaDemo
//
//  Created by 阮柏程 on 2018/9/3.
//  Copyright © 2018年 PoCheng Juan. All rights reserved.
//

import UIKit

class HistoryAddVC: UIViewController {

    @IBOutlet weak var NewHistoryField: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        NewHistoryField.text = ""
    }

    @IBAction func Submitclick(_ sender: Any) {
        PostToSubmit(str: NewHistoryField.text)
    }
    
    func PostToSubmit(str:String){
        print(str)
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
