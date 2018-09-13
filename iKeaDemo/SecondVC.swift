//
//  SecondVC.swift
//  iKeaDemo
//
//  Created by PoCheng Juan on 2018/8/15.
//  Copyright © 2018年 PoCheng Juan. All rights reserved.
//

import UIKit

class SecondVC: UIViewController {

    
    var ErrorData_Main : ErrorData_Struct?
    @IBOutlet weak var Detail_Field: UITextView!
    let History :String = "History"
    
/************************************************************************************************/
/*      Function: HistoryUpData                                                                 */
/*      Argument: noti:Notification                                                             */
/*      Return:                                                                                 */
/*      Note:                                                                                   */
/*                                                                                              */
/*                                                                                              */
/************************************************************************************************/
    @objc func HistoryUpData(noti:Notification) {
        ErrorData_Main?.Error_Cell = (noti.userInfo!["NewHistory"] as! [History_struct])
        //self.HistoryTable.reloadData()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let notifycationName = Notification.Name("HistoryUpData")
        NotificationCenter.default.addObserver(self, selector: #selector(HistoryUpData(noti:)), name: notifycationName, object: nil)
        
        let exitBtn = UIBarButtonItem(title: "Exit", style: .plain , target: self, action: #selector(ExitBtnFunc))
        let historyBtn = UIBarButtonItem(title: "History", style: .plain , target: self, action: #selector(HistoryBtnFunc) )
        self.navigationItem.leftBarButtonItem = exitBtn
        self.navigationItem.rightBarButtonItem = historyBtn
        
        self.Detail_Field.backgroundColor = #colorLiteral(red: 0.7490196078, green: 0.7450980392, blue: 0.7490196078, alpha: 1)
        self.view.backgroundColor = #colorLiteral(red: 0.7490196078, green: 0.7450980392, blue: 0.7490196078, alpha: 1)
        var str_temp : String?
        var OutputStart = ErrorData_Main?.Error_Temp?.index( (ErrorData_Main?.Error_Temp?.startIndex)!, offsetBy: 7)
        var OutputEnd = ErrorData_Main?.Error_Temp?.index(of: "#")
        ErrorData_Main?.Error_Msg = ErrorData_Main?.Error_Temp?[OutputStart..<OutputEnd]       //"Msg<BR>#History<BR>#Solution<BR>#Photo<BR>"
        Detail_Field.text = ErrorData_Main?.Error_Msg                                          //"Msg<BR>
        
        str_temp = ErrorData_Main?.Error_Temp?[(ErrorData_Main?.Error_Temp?.index(after: OutputEnd!))..<(ErrorData_Main?.Error_Temp?.endIndex)]                             //History<BR>#Solution<BR>#Photo<BR>"
        OutputStart = str_temp?.startIndex
        OutputEnd = str_temp?.index(of: "#")
        ErrorData_Main?.Error_History = str_temp?[OutputStart..<OutputEnd]                      //"History<BR>"
        
        str_temp = str_temp?[str_temp?.index(after: OutputEnd!)..<str_temp?.endIndex]           //"Solution<BR>#Photo<BR>"
        OutputStart = str_temp?.startIndex
        OutputEnd = str_temp?.index(of: "#")
        ErrorData_Main?.Error_Solution = str_temp?[OutputStart..<OutputEnd]                     //"Solution<BR>"
        
        str_temp = str_temp?[str_temp?.index(after: OutputEnd!)..<str_temp?.endIndex]           //"Photo<BR>"
        ErrorData_Main?.Error_Photo = str_temp                                                  //"Photo<BR>"
    }

    

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @objc func HistoryBtnFunc () {
        self.performSegue(withIdentifier: "HistoryString", sender: ErrorData_Main)
    }
    @objc func ExitBtnFunc () {
        dismiss(animated: true, completion: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "HistoryString" {
            let controller = segue.destination as! HistoryVC
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
