//
//  HistoryAddVC.swift
//  iKeaDemo
//
//  Created by PoCheng Juan on 2018/9/3.
//  Copyright © 2018年 PoCheng Juan. All rights reserved.
//

import UIKit

protocol AddNewHistoryDelegate {
    func AddNewHistory( history:String)
}
class HistoryAddVC: UIViewController {

    
    @IBOutlet weak var NewHistoryField: UITextView!
    var TempHistory = [History_struct]()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        NewHistoryField.text = ""
        NewHistoryField.isEditable = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func Submitclick(_ sender: Any) {
        let notifycationName = Notification.Name("HistoryUpData")
        var cnt : Int = TempHistory.count
        var cnt_string : NSNumber
        var title_string : String = ""
        cnt = cnt + 1
        cnt_string = cnt as NSNumber
        title_string.append("(")
        title_string.append(cnt_string.stringValue)
        title_string.append(")")
        TempHistory.append( History_struct(Title: title_string, Detail: NewHistoryField.text))
        NotificationCenter.default.post(name: notifycationName, object: nil, userInfo: ["NewHistory" : self.TempHistory])
        self.navigationController?.popViewController(animated: true)
        

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
