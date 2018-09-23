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
    var Photo : String?
    init(history:String,solution:String,photo:String){
        self.History = history
        self.Solution = solution
        self.Photo = photo
    }
}

class HistoryDetailVC: UIViewController ,URLSessionDelegate,URLSessionDownloadDelegate{

    let FullScreenSize = UIScreen.main.bounds.size

    var OutPutString : outputstring?
    @IBOutlet weak var SegmentedControl: UISegmentedControl!
    @IBOutlet weak var HistoryDetailField: UITextView!
    @IBOutlet weak var LoadImageAct: UIActivityIndicatorView!
    
    var OutputImageStr : [String]?
    var imageArray = [UIImage]()
    var image = [UIImage]()
    var RequestCnt : Int = 0
    var DownloadCont : Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = #colorLiteral(red: 0.7490196078, green: 0.7450980392, blue: 0.7490196078, alpha: 1)
        self.HistoryDetailField.backgroundColor = #colorLiteral(red: 0.7490196078, green: 0.7450980392, blue: 0.7490196078, alpha: 1)
        self.HistoryDetailField.isEditable = false
        self.HistoryDetailField.text = ""
        
        
        let image = UIBarButtonItem(title: "Image", style: .plain, target: self, action: #selector(LoadImage))
        self.navigationItem.rightBarButtonItem = image
        
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
    /************************************************************************************************/
    /*      Function: prepare                                                                       */
    /*      Argument: for segue: UIStoryboardSegue, sender: Any?                                    */
    /*      Return:                                                                                 */
    /*      Note:                                                                                   */
    /*                                                                                              */
    /*                                                                                              */
    /************************************************************************************************/
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "image" {
            let controller = segue.destination as! LoadImageVC
            controller.imageArray = imageArray
        }
    }
    /************************************************************************************************/
    /*      Function: LoadImage                                                                     */
    /*      Argument:                                                                               */
    /*      Return:                                                                                 */
    /*      Note:                                                                                   */
    /*                                                                                              */
    /*                                                                                              */
    /************************************************************************************************/
    @objc func LoadImage() {
        if imageArray.isEmpty == true {
            LoadImageAct.startAnimating()
            OutputImageStr = GetOutputImageStr(str: (OutPutString?.Photo)!)
            GetOutputImage(str: OutputImageStr!)
        }else
        {
            self.performSegue(withIdentifier: "image", sender: imageArray)
        }
    }
    
    /************************************************************************************************/
    /*      Function: GetOutputImageStr                                                             */
    /*      Argument: str                                                                           */
    /*      Return:   [String]                                                                      */
    /*      Note:                                                                                   */
    /*                                                                                              */
    /*                                                                                              */
    /************************************************************************************************/
    func GetOutputImageStr(str:String)->[String] {
        var out : [String] = [""]
        var str_temp : String?
        var startIndex = str.index(str.index(of: "@")!, offsetBy: 1)
        
        var endIndex = str.endIndex
        str_temp = str[startIndex..<endIndex]
        repeat{
            startIndex = (str_temp?.startIndex)!
            endIndex = (str_temp?.index(of: "@"))!
            if out[0] == "" {
                out[0] = str_temp![startIndex..<endIndex]
            }else {
                out.append(str_temp![startIndex..<endIndex])
            }
            str_temp = str_temp![str_temp?.index(after: endIndex)..<str_temp?.endIndex]
        }while (str_temp?.contains("@"))!
        out.append(str_temp![startIndex..<endIndex])
        return out
    }
    /************************************************************************************************/
    /*      Function: GetOuputImageStr                                                              */
    /*      Argument: [String]                                                                      */
    /*      Return:   [UIImage]                                                                     */
    /*      Note:                                                                                   */
    /*                                                                                              */
    /*                                                                                              */
    /************************************************************************************************/
    //func GetOutputImage(str:[String])->[UIImage]{
    func GetOutputImage(str:[String]){
        let urlStr : String = "http://114.35.249.80/TelDemo_php/Image/"
        let sessionWithConfigure = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionWithConfigure, delegate: self, delegateQueue: OperationQueue.main)
        
        for i in 0...((str.count)-1) {
            let url1 : URL = URL(string: urlStr + (str[i]))!
            let dataTask = session.downloadTask(with: url1)
            dataTask.resume()
        }
        RequestCnt = (str.count)-1
    }

    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        let data = (try? Data(contentsOf: URL(fileURLWithPath: location.path)))
        imageArray.append(UIImage(data:data!)!)
        print(location)
        if DownloadCont == RequestCnt {
            self.performSegue(withIdentifier: "image", sender: imageArray)
            LoadImageAct.stopAnimating()
        }
        DownloadCont = DownloadCont + 1

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
