//
//  HistoryDetailVC.swift
//  iKeaDemo
//
//  Created by PoCheng Juan on 2018/9/3.
//  Copyright © 2018年 PoCheng Juan. All rights reserved.
//

import UIKit
class outputstring {
    var History : String?
    var Solution : String?
    
    init(history:String,solution:String){
        self.History = history
        self.Solution = solution
    }
}

class HistoryDetailVC: UIViewController {

    var OutPutString : outputstring?
    @IBOutlet weak var SegmentedControl: UISegmentedControl!
    @IBOutlet weak var HistoryDetailField: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = #colorLiteral(red: 0.7490196078, green: 0.7450980392, blue: 0.7490196078, alpha: 1)
        self.HistoryDetailField.backgroundColor = #colorLiteral(red: 0.7490196078, green: 0.7450980392, blue: 0.7490196078, alpha: 1)
        self.HistoryDetailField.isEditable = false
        self.HistoryDetailField.text = ""
        
        self.SegmentedControl.addTarget(self, action: #selector(onCheng), for: .valueChanged)
        HistoryDetailField.text = OutPutString?.History
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @objc func onCheng(sender: UISegmentedControl){
        if sender.selectedSegmentIndex == 0 {
            HistoryDetailField.text = OutPutString?.History
        }else {
            HistoryDetailField.text = OutPutString?.Solution
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
