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
    //var TempHistory = [History_struct]()
    var ErrorData_Main : ErrorData_Struct?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = #colorLiteral(red: 0.7490196078, green: 0.7450980392, blue: 0.7490196078, alpha: 1)

        NewHistoryField.text = ""
        NewHistoryField.isEditable = true
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func Submitclick(_ sender: Any) {
        let notifycationName = Notification.Name("HistoryUpData")
        var cnt : Int = (ErrorData_Main?.Error_Cell!.count)!
        var cnt_string : NSNumber
        var title_string : String = ""
        
        if NewHistoryField.text != "" {
            if ErrorData_Main?.Error_Cell![0].History_title == "" {
                cnt = 1
                cnt_string = cnt as NSNumber
                title_string.append("(")
                title_string.append(cnt_string.stringValue)
                title_string.append(")")
                ErrorData_Main?.Error_Cell![0].History_title = title_string
                ErrorData_Main?.Error_Cell![0].History_detail = NewHistoryField.text
            }else {
                cnt = cnt + 1
                cnt_string = cnt as NSNumber
                title_string.append("(")
                title_string.append(cnt_string.stringValue)
                title_string.append(")")
                ErrorData_Main?.Error_Cell?.append(History_struct(Title: title_string, Detail: NewHistoryField.text))
            }
            NotificationCenter.default.post(name: notifycationName, object: nil, userInfo: ["NewHistory" : self.ErrorData_Main?.Error_Cell as Any])
            self.navigationController?.popViewController(animated: true)
            
            SendPostAddHisotyr(err: MakePostString(data: ErrorData_Main!))

        }
        
    }

    func MakePostString(data:ErrorData_Struct) -> String{
        var outputstr : String = ""
        var history : String?
        var solution : String?
        if data.Error_History?.contains("@") == true {
            let historystart = data.Error_History?.index((data.Error_History?.index(of: "@"))!, offsetBy: 0)
            let historyend = data.Error_History?.endIndex
            history = data.Error_History?[historystart..<historyend]
        
            let solutionstart = data.Error_Solution?.index((data.Error_Solution?.index(of: "@"))!, offsetBy: 0)
            let solutionend = data.Error_Solution?.endIndex
            solution = data.Error_Solution?[solutionstart..<solutionend]
        }else {
            history = ""
            solution = ""
        }
        
        outputstr.append("errorType=")
        outputstr.append(data.Error_Type!)
        outputstr.append("&")
        outputstr.append("errorNum=")
        outputstr.append(data.Error_Number!)
        outputstr.append("&")
        outputstr.append("errorHistory=")
        outputstr.append(history!)
        outputstr.append("@")
        outputstr.append(data.Error_Cell![(data.Error_Cell?.count)!-1].History_title!)
        outputstr.append(data.Error_Cell![(data.Error_Cell?.count)!-1].History_detail!)
        outputstr.append("&")
        outputstr.append("errorSolution=")
        outputstr.append(solution!)
        print(outputstr)
        return outputstr
    }
/************************************************************************************************/
/*      Function: SendPostAddHisotyr                                                            */
/*      Argument: str : String                                                                  */
/*      Return: None                                                                            */
/*      Note:                                                                                   */
/*                                                                                              */
/*                                                                                              */
/************************************************************************************************/
    @objc func SendPostAddHisotyr( err:String)  {
        let url = URL(string: "http://114.35.249.80/TelDemo_php/signUp.php")!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        request.httpBody = err.data(using: .utf8)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {                                                 // check for fundamental networking error
                print("error=\(String(describing: error))")
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(String(describing: response))")
            }
            
            var  responseString = String(data: data, encoding: .utf8)
            //Wait response
            while responseString != responseString{
                responseString = String(data: data, encoding: .utf8)
            }
            
            print("responseString = \(String(describing: responseString))")
            //print(responseString as Any)
            self.ErrorData_Main?.Error_Temp?.append(responseString!)

        }
        task.resume()
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
