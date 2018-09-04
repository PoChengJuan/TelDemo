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

    //var HistoryDetail_str : String?
    var ErrorData_Main : ErrorData_Struct?
    var OutPutString : outputstring?
    @IBOutlet weak var HistoryDetailField: UITextView!
    @IBOutlet weak var SolutionField: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = #colorLiteral(red: 0.7490196078, green: 0.7450980392, blue: 0.7490196078, alpha: 1)
        self.HistoryDetailField.backgroundColor = #colorLiteral(red: 0.7490196078, green: 0.7450980392, blue: 0.7490196078, alpha: 1)
        self.HistoryDetailField.isEditable = false
        self.HistoryDetailField.text = ""
        self.SolutionField.backgroundColor = #colorLiteral(red: 0.7490196078, green: 0.7450980392, blue: 0.7490196078, alpha: 1)
        self.SolutionField.isEditable = false
        self.SolutionField.text = ""
        //print(self.HistoryDetail_str)
        //HistoryDetailField.text = HistoryDetail_str
        //HistoryDetailField.text = ErrorData_Main?.Error_Cell![0].History_detail
        HistoryDetailField.text = OutPutString?.History
        SolutionField.text = OutPutString?.Solution
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
