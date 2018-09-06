//
//  LoginVC.swift
//  iKeaDemo
//
//  Created by PoCheng Juan on 2018/8/21.
//  Copyright © 2018年 PoCheng Juan. All rights reserved.
//

import UIKit
//import MySQL

class LoginVC: UIViewController {

    
    @IBOutlet weak var NameField: UITextField!
    @IBOutlet weak var PwField: UITextField!
    var Login : Bool?
    var Data_Flag = 0
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.PwField.isSecureTextEntry = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func EnterClick(_ sender: Any) {
        var outputstring : String? = ""
        outputstring?.append("ID=")
        outputstring?.append(NameField.text!)
        outputstring?.append("&PW=")
        outputstring?.append(PwField.text!)
        self.Data_Flag = 0
        LoginProc(str:outputstring!)
        while((Data_Flag == 0)){print("1")}
        if Login == true {
            print("Login OK!!")
            //let VC = UIStoryboard(name: "main", bundle: nil).instantiateViewController(withIdentifier: "ViewController") as! ViewController
            let sb = UIStoryboard(name: "Main", bundle:nil)
            let VC = sb.instantiateViewController(withIdentifier: "MainVC") as! ViewController
            present(VC, animated: true, completion: nil)
        }else {
            print("Login Fail")
        }
    }
    
    
    func LoginProc(str:String){
        
        let url = URL(string: "http://114.35.249.80/TelDemo_php/signUp.php")!
        var request = URLRequest(url: url)
        let LoginOK : String = "Login OK"
        //var LoginStatus : Bool?
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        request.httpBody = str.data(using: .utf8)
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
            //self.ErrorData_Main?.Error_Temp?.append(responseString!)
            if (responseString?.contains(LoginOK))! {
                //return true
                self.Login = true
            }else {
                self.Login = false
            }
            self.Data_Flag = 1
        }
        task.resume()

    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
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
