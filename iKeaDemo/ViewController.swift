//
//  ViewController.swift
//  iKeaDemo
//
//  Created by PoCheng Juan on 2018/8/14.
//  Copyright © 2018年 PoCheng Juan. All rights reserved.
//
// /Users/mac/Documents/Xcode/helloDemo/iKeaDemo/iKeaDemo
import UIKit
import Speech

class ErrorData_Struct:NSObject {
    var Error_Type : String?
    var Error_Number : String?
    var Error_Msg : String?
    var Error_History : String?
    var Error_Solution : String?
    var Error_Note : String?
    var Error_Temp : String?
    var Error_Cell : [History_struct]?
    var Error_Solution_Cell : [Solution_struct]?
    
    init(Type:String,Number:String,Msg:String,History:String,Solution:String,Note:String,Temp:String,Cell_Clear:[History_struct],Solution_Clear:[Solution_struct]){
        self.Error_Type = Type
        self.Error_Number = Number
        self.Error_Msg = Msg
        self.Error_History = History
        self.Error_Solution = Solution
        self.Error_Note = Note
        self.Error_Temp = Temp
        //if Cell_Clear == true {
        //    self.Error_Cell = [History_struct].init()
        //}else{
        //}
        self.Error_Cell = Cell_Clear
        self.Error_Solution_Cell = Solution_Clear
    }
}
class ViewController: UIViewController ,SFSpeechRecognizerDelegate{

    let FullScreenSize = UIScreen.main.bounds.size
    var ErrorData_Main : ErrorData_Struct?
    var Mic_Icon:UIImageView?
    //var Mic_Button:UIButton?
    var Useed_Flag = 0
    var Data_Flag = 0
    @IBOutlet weak var GuideView: UILabel!
    @IBOutlet weak var NumField: UITextField!
    @IBOutlet weak var Mic_Button: UIButton!
    @IBOutlet weak var LogoutBtn: UIButton!
    
    private let speechRecognizer = SFSpeechRecognizer(locale: Locale.init(identifier: "zh_Hans_CN"))  //1

    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    private var recognitionTask: SFSpeechRecognitionTask?
    private let audioEngine = AVAudioEngine()
    
    @IBOutlet weak var MainMsg: UILabel!
    var ErrorNum : String = ""
    
    var ProgressView : UIProgressView?
    var ActivityIndicator:UIActivityIndicatorView!
    var ProgressTimer : Timer?
    var count = 0
    let complete = 30
    
    override func viewDidLoad() {
        super.viewDidLoad()
/**************************************** View ****************************************/
        self.view.backgroundColor = #colorLiteral(red: 0.7490196078, green: 0.7450980392, blue: 0.7490196078, alpha: 1)
        NumField.delegate = self
/*************************************** Object ***************************************/
        //self.Mic_Button = UIButton(frame: CGRect(x: (FullScreenSize.width/2)-45, y:480, width: 90, height: 90))
        //self.Mic_Button?.setImage(UIImage(named: "Mic_icon_01.png"), for: UIControlState.normal)
        self.Mic_Button?.layer.cornerRadius = 45
        self.Mic_Button?.clipsToBounds = true
        //self.view.addSubview(Mic_Button!)
        self.Mic_Button?.addTarget(self , action: #selector(MicTappDown(sender:)) , for: UIControlEvents.touchDown)
        self.Mic_Button?.addTarget(self, action: #selector(MicTappUp(sender:)), for: UIControlEvents.touchUpInside)
        
        //self.LogoutBtn?.imageView?.contentMode = .scaleToFill
        //self.LogoutBtn?.imageView?.bounds.size.width = 52
        //self.LogoutBtn?.imageView?.bounds.size.height = 53
        self.NumField.isEnabled = true
        self.NumField.keyboardType = UIKeyboardType.numberPad
        //AuthStatus
        Mic_Button?.isEnabled = false
        speechRecognizer?.delegate = self

        SFSpeechRecognizer.requestAuthorization { (authStatus) in  //4
            
            var isButtonEnabled = false
            
            switch authStatus {  //5
            case .authorized:
                isButtonEnabled = true
                
            case .denied:
                isButtonEnabled = false
                print("User denied access to speech recognition")
                
            case .restricted:
                isButtonEnabled = false
                print("Speech recognition restricted on this device")
                
            case .notDetermined:
                isButtonEnabled = false
                print("Speech recognition not yet authorized")
            }
            
            OperationQueue.main.addOperation() {
                self.Mic_Button?.isEnabled = isButtonEnabled
            }
        }
/*************************************** ProgressView ***************************************/
        

        // 建立一個 UIActivityIndicatorView
        ActivityIndicator = UIActivityIndicatorView(
            activityIndicatorStyle:.whiteLarge)
        
        // 環狀進度條的顏色
        ActivityIndicator.color = UIColor.black
        
        // 底色
        ActivityIndicator.backgroundColor = UIColor.clear
        
        // 設置位置並放入畫面中
        ActivityIndicator.center = CGPoint(
            x: FullScreenSize.width * 0.5,
            y: FullScreenSize.height * 0.4)
        self.view.addSubview(ActivityIndicator);
/********************************************************************************************/
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        if NumField.text != "" {
            ErrorDataClear()
            StartProcess()
        }
    }
    @IBAction func ErrorButton(_ sender: Any) {
        MainMsg.text = "Error"
        DebugShow(x: "Error")
    }
    @IBAction func AlarmButton(_ sender: Any) {
        MainMsg.text = "Alarm"
        DebugShow(x: "Alarm")
    }
    @IBAction func MsgButton(_ sender: Any) {
        MainMsg.text = "Message"
        DebugShow(x: "Message")
    }
    
    @IBAction func MicTappDown(sender:UIButton) {
        //print("Say something")
        /*
        if audioEngine.isRunning {
            audioEngine.stop()
            recognitionRequest?.endAudio()
            Mic_Button?.isEnabled = false
            //Mic_Button?.setTitle("Start Recording", for: .normal)
        } else {
        */
            ErrorDataClear()
            StartRecording()
            //microphoneButton.setTitle("Stop Recording", for: .normal)
        //}
    }
    
    @IBAction func MicTappUp(sender:UIButton) {
        StartProcess()
        //print("Stop talking")
        
        
    }
    func StartProcess() {
        Mic_Button?.isEnabled = false
        self.Useed_Flag = 0
        self.Data_Flag = 0
        if audioEngine.isRunning {
            audioEngine.stop()
            recognitionRequest?.endAudio()
        }
        self.ErrorData_Main?.Error_Number = self.NumField.text
        ErrorNum = ""
        if MainMsg.text == "Error" {
            ErrorData_Main?.Error_Type = "E"
            //print(ErrorNum)
        } else if MainMsg.text == "Alarm" {
            ErrorData_Main?.Error_Type = "A"
            //print("A" + ErrorNum)
        } else if MainMsg.text == "Message" {
            ErrorData_Main?.Error_Type = "M"
            
        }
        //ErrorData_Main?.Error_Number = "4041"
        //print(ErrorNum)
        /*************************************************/
        //let postString = "error_type="+ErrorNum+"&error_num="+NumField.text!
        
        let postString = "error_type="+(ErrorData_Main?.Error_Type)!+"&error_num="+(ErrorData_Main?.Error_Number)!
        print(postString)
        //let postString : String = "error_type=E&error_num=4041"
        
        SendPost(err: postString)
        /*************************************************/
        //sleep(1)
        // 分別重設兩個進度條
        self.ProgressView?.progress = 0
        self.ActivityIndicator.startAnimating()
        
        // 建立一個 Timer
        //self.Timer = Timer.
        self.ProgressTimer = Timer.scheduledTimer(
            timeInterval: 0.2,
            target: self,
            selector:
            #selector(ViewController.showProgress),
            userInfo: ["test":"for userInfo test"],
            repeats: true)
        while((Data_Flag == 0)){print("1")}
        /*************************************************/
        if Useed_Flag == 1 {
            while(ErrorData_Main?.Error_Temp?.elementsEqual(""))!{}
            let sb = UIStoryboard(name: "Main", bundle:nil)
            let vc = sb.instantiateViewController(withIdentifier: "myNavigationController") as! myNavigationController
            performSegue(withIdentifier: "DetailTextShow", sender: ErrorData_Main)
            self.present(vc, animated: true, completion: nil)
        }
        NumField.text = ""
    }
    @objc func SendPost( err:String) {
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
            //if( self.OutputString.contains("Msg") )
            if( self.ErrorData_Main?.Error_Temp?.contains("Msg"))!
            {
                self.Useed_Flag = 1
            }else if( self.ErrorData_Main?.Error_Temp?.contains("NotUsed"))!{
                self.Useed_Flag = 0
            }
            self.Data_Flag = 1
            
        }
        task.resume()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailTextShow" {
            let controller = segue.destination as! myNavigationController
            controller.ErrorData_Main = ErrorData_Main!
        }
    }

    @objc func showProgress(sender: Timer) {
        
        // 以一個計數器模擬背景處理的動作
        count += 5
        
        // 每次都為進度條增加進度
        ProgressView?.progress =
            Float(count) / Float(complete)
        
        // 進度完成時
        //if count >= complete {
        if self.ErrorData_Main?.Error_Temp == self.ErrorData_Main?.Error_Temp{
        // 示範 userInfo 傳入的參數
        //var info =
        //    sender.userInfo as?
        //        Dictionary<String, AnyObject>
        //print(info?["test"])
        
        // 重設計數器及 NSTimer 供下次按下按鈕測試
            count = 0
            ProgressTimer?.invalidate()
            ProgressTimer = nil
        
        // 隱藏環狀進度條
            ActivityIndicator.stopAnimating()
        
        // 將按鈕功能啟動
        //myButton.enabled = true
            Mic_Button?.isEnabled = true
        //self.ReceiveField.text = output
        }
        if count >= complete {
        // 示範 userInfo 傳入的參數
            //var info =
                //sender.userInfo as?
                //   Dictionary<String, AnyObject>
            //print(info?["test"])
        
            // 重設計數器及 NSTimer 供下次按下按鈕測試
            count = 0
            ProgressTimer?.invalidate()
            ProgressTimer = nil
            
            // 隱藏環狀進度條
            ActivityIndicator.stopAnimating()
        
            // 將按鈕功能啟動
            //myButton.enabled = true
            Mic_Button?.isEnabled = true
        }
        
    }
    @objc func ErrorDataClear() {
        //self.ErrorData_Main = ErrorData_Struct(Type: "", Number: "", Msg: "", History: "", Solution: "", Note: "", Temp: "",Cell_Clear: true)
        self.ErrorData_Main = ErrorData_Struct(Type: "", Number: "", Msg: "", History: "", Solution: "", Note: "", Temp: "", Cell_Clear: [History_struct.init(Title: "", Detail: "")], Solution_Clear: [Solution_struct.init(Title: "", Detail: "")])
    }
    func StartRecording(){
        NumField.text = ""
        if recognitionTask != nil {
            recognitionTask?.cancel()
            recognitionTask = nil
        }
        
        let AudioSession = AVAudioSession.sharedInstance()
        do {
            try AudioSession.setCategory(AVAudioSessionCategoryRecord)
            try AudioSession.setMode(AVAudioSessionModeMeasurement)
            try AudioSession.setActive(true, with: .notifyOthersOnDeactivation)
        } catch {
            print( "audioSession properties weren't set because of an error." )
        }
        
        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        
        guard let InputNode = audioEngine.inputNode else {
            fatalError("Audio engine has no input node")
        }  //4

        guard let recognitionRequest = recognitionRequest else {
            fatalError("Unable to create an SFSpeechAudioBufferRecognitionRequest object")
        } //5
        
        recognitionRequest.shouldReportPartialResults = true
        
        recognitionTask = speechRecognizer?.recognitionTask(with: recognitionRequest, resultHandler: { (result, error) in  //7
            var isFinal = false  //8
            
            if result != nil {
                self.NumField.text = result?.bestTranscription.formattedString
                self.ErrorData_Main?.Error_Number = self.NumField.text
                isFinal = (result?.isFinal)!
            }
            
            if error != nil || isFinal {  //10
                self.audioEngine.stop()
                InputNode.removeTap(onBus: 0)
                
                self.recognitionRequest = nil
                self.recognitionTask = nil
                
                self.Mic_Button?.isEnabled = true
            }
        })
        
        let recordingFormat = InputNode.outputFormat(forBus: 0)  //11
        InputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer, when) in
            self.recognitionRequest?.append(buffer)
        }
        
        audioEngine.prepare()  //12
        
        do {
            try audioEngine.start()
        } catch {
            print("audioEngine couldn't start because of an error.")
        }
        
        GuideView.text = "listening..."
        
        
    }
    
    func speechRecognizer(_ speechRecognizer: SFSpeechRecognizer, availabilityDidChange available: Bool) {
        if available {
            Mic_Button?.isEnabled = true
        } else {
            Mic_Button?.isEnabled = false
        }
    }
    
    func DebugShow(x:String){
        print(x)
    }

    @IBAction func LogoutButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}



extension UIViewController : UITextFieldDelegate {
    
    func textfild()
    {
        print("testdelegate")
    }

}

