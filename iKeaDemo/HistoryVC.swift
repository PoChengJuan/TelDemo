//
//  HistoryVC.swift
//  iKeaDemo
//
//  Created by PoCheng Juan on 2018/8/31.
//  Copyright © 2018年 PoCheng Juan. All rights reserved.
//

import UIKit

class History_struct {
    var History_title : String?
    var History_detail : String?
    
    init(Title:String,Detail:String){
        self.History_title = Title
        self.History_detail = Detail
    }
    func reset(){
        self.History_title = ""
        self.History_detail = ""
    }
}
class Solution_struct {
    var Solution_title : String?
    var Solution_detail : String?
    
    init(Title:String,Detail:String)
    {
        self.Solution_title = Title
        self.Solution_detail = Detail
    }
}
class HistoryVC: UIViewController , UITableViewDataSource , UITableViewDelegate{
    
    

    @IBOutlet weak var HistoryNavItem: UINavigationItem!
    var OutPutString = outputstring.init(history: "", solution: "", photo: "")
    var ErrorData_Main : ErrorData_Struct?
    //var search = UISearchController(searchResultsController: nil)
    @IBOutlet weak var HistoryTable: UITableView!
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
        self.HistoryTable.reloadData()
    }
/************************************************************************************************/
/*      Function: viewDidLoad                                                                   */
/*      Argument: None                                                                          */
/*      Return:                                                                                 */
/*      Note:                                                                                   */
/*                                                                                              */
/*                                                                                              */
/************************************************************************************************/
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let notifycationName = Notification.Name("HistoryUpData")
        NotificationCenter.default.addObserver(self, selector: #selector(HistoryUpData(noti:)), name: notifycationName, object: nil)
        if (ErrorData_Main?.User_Permisstion)! >= Mid_LV {
            let addBtn = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(AddBtnFunc))
            self.navigationItem.rightBarButtonItem = addBtn
        }
        
        if (ErrorData_Main?.Error_Cell![0].History_title == ""){
            if ErrorData_Main?.Error_History?.contains("@") == true{
                ErrorData_Main?.Error_Cell = StringToModel(str: (ErrorData_Main?.Error_History)!)
            }
            
        }
        if(ErrorData_Main?.Error_Solution_Cell![0].Solution_title == ""){
            if ErrorData_Main?.Error_Solution?.contains("@") == true {
                ErrorData_Main?.Error_Solution_Cell = GetSolution(str: (ErrorData_Main?.Error_Solution)!)
            }
        }
        //self.navigationItem.searchController = search
        //self.navigationItem.hidesSearchBarWhenScrolling = false
    }
/************************************************************************************************/
/*      Function: numberOfSecti                                                                 */
/*      Argument: in tableView: UITableView                                                     */
/*      Return:                                                                                 */
/*      Note:                                                                                   */
/*                                                                                              */
/*                                                                                              */
/************************************************************************************************/
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
/************************************************************************************************/
/*      Function: tableView - numberOfRowsInSection                                             */
/*      Argument:                                                                               */
/*      Return:                                                                                 */
/*      Note:                                                                                   */
/*                                                                                              */
/*                                                                                              */
/************************************************************************************************/
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.ErrorData_Main?.Error_Cell![0].History_title != "" {
            return (self.ErrorData_Main?.Error_Cell?.count)!
        }else {
            return 0
        }
        
    }
/************************************************************************************************/
/*      Function: tableView - numberOfRowsInSection                                             */
/*      Argument:                                                                               */
/*      Return:                                                                                 */
/*      Note:                                                                                   */
/*                                                                                              */
/*                                                                                              */
/************************************************************************************************/
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle(rawValue: 3)!, reuseIdentifier: "Cell")
        let HistoryTitle = ErrorData_Main?.Error_Cell![indexPath.item]
        cell.textLabel?.text = HistoryTitle?.History_title
        cell.detailTextLabel?.text = HistoryTitle?.History_detail
        return cell
    }
/************************************************************************************************/
/*      Function: tableView - didSelectRowAt                                                    */
/*      Argument:                                                                               */
/*      Return:                                                                                 */
/*      Note:                                                                                   */
/*                                                                                              */
/*                                                                                              */
/************************************************************************************************/
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var limit = ErrorData_Main?.Error_Solution_Cell?.count
        OutPutString = outputstring.init(history: "", solution: "", photo: "")
        limit = limit! - 1
        if ErrorData_Main?.Error_Solution_Cell?.count != 0 {
            if let limit = limit {
                for i in 0...limit
                {
                    if ErrorData_Main?.Error_Cell![indexPath.item].History_title == ErrorData_Main?.Error_Solution_Cell![i].Solution_title{
                        //print(ErrorData_Main?.Error_Cell![indexPath.item].History_title)
                        //print(ErrorData_Main?.Error_Solution_Cell![i].Solution_title)
                        OutPutString.Solution = ErrorData_Main?.Error_Solution_Cell![i].Solution_detail
                    }
                }
            }
        }
        //HistoryDetailSender = ErrorData_Main?.Error_Cell![indexPath.item].History_detail!
        if OutPutString.Solution == "" {
            OutPutString.Solution = "None"
        }
        OutPutString.History = ErrorData_Main?.Error_Cell![indexPath.item].History_detail!
        if ErrorData_Main?.Error_Photo != "" {
            OutPutString.Photo = ErrorData_Main?.Error_Photo
        }
        tableView.deselectRow(at: indexPath, animated: true)
        self.performSegue(withIdentifier: "HistoryDetailString", sender: OutPutString)
    }
/************************************************************************************************/
/*      Function: AddBtnFunc                                                                    */
/*      Argument:                                                                               */
/*      Return:                                                                                 */
/*      Note:                                                                                   */
/*                                                                                              */
/*                                                                                              */
/************************************************************************************************/
    @objc func AddBtnFunc() {
        self.performSegue(withIdentifier: "TempHistory", sender: ErrorData_Main)
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
        if segue.identifier == "HistoryDetailString" {
            let controller = segue.destination as! HistoryDetailVC
            controller.OutPutString = OutPutString
        }
        if segue.identifier == "TempHistory" {
            let controller1 = segue.destination as! HistoryAddVC
            controller1.ErrorData_Main = ErrorData_Main
        }
    }

/************************************************************************************************/
/*      Function: StringToModel                                                                 */
/*      Argument: str : String                                                                  */
/*      Return: [History_struct]                                                                */
/*      Note:                                                                                   */
/*                                                                                              */
/*                                                                                              */
 /***********************************************************************************************/
    func StringToModel(str: String) -> [History_struct]{
        //let key : String = "@#"
        var Main_Data = [History_struct]()
        var temp = History_struct(Title: "", Detail: "")
        var str_temp : String = str[str.index(str.startIndex, offsetBy: 11)..<str.endIndex]
        var title_start = str_temp.startIndex
        var title_end = str_temp.endIndex
        var title : String
        var detail_start = str_temp.startIndex
        var detail_end = str_temp.endIndex
        var detail : String
        var End_Flg : Int = 0
        
        repeat{
            //title_start = str_temp.startIndex
            if str_temp.index(of: "@") != nil {
                title_start = str_temp.index(after: str_temp.index(of: "@")!)
            }else{
                title_start = str_temp.index(str_temp.startIndex, offsetBy: 0)
            }
            title_end = str_temp.index(str_temp.index(of: ")")!, offsetBy: 1)
            title = str_temp[title_start..<title_end]
            str_temp = str_temp[title_end..<str_temp.endIndex]
            detail_start = str_temp.startIndex
            if str_temp.index(of: "@") != nil {
                //detail_end = str_temp.index(before: key.startIndex)
                //detail_end = str_temp.index(str_temp.index(of: "@")!, offsetBy: 1)
                //detail_end = str_temp.index(before: str_temp.index(of: "@")!)
                detail_end = str_temp.index(of: "@")!
            }else{
                detail_end = str_temp.endIndex
                End_Flg = 1
            }
            detail = str_temp[detail_start..<detail_end]
            str_temp = str_temp[detail_end..<str_temp.endIndex]
            temp = History_struct(Title: title, Detail: detail)
            Main_Data.append(temp)
        }while End_Flg != 1
        return Main_Data
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
/************************************************************************************************/
/*      Function: StringToModel                                                                 */
/*      Argument: str : String                                                                  */
/*      Return: [History_struct]                                                                */
/*      Note:                                                                                   */
/*                                                                                              */
/*                                                                                              */
/************************************************************************************************/
    func GetSolution(str:String)-> [Solution_struct] {
        var solution = [Solution_struct]()
        var temp = Solution_struct(Title: "", Detail: "")
        var str_temp : String = str[str.index(str.startIndex, offsetBy: 12)..<str.endIndex]
        var title_start = str_temp.startIndex
        var title_end = str_temp.endIndex
        var title : String
        var detail_start = str_temp.startIndex
        var detail_end = str_temp.endIndex
        var detail : String
        var End_Flg : Int = 0
        
        if str_temp == "" {
            return solution
        }
        repeat{
            //title_start = str_temp.startIndex
            if str_temp.index(of: "@") != nil {
                title_start = str_temp.index(after: str_temp.index(of: "@")!)
            }else{
                title_start = str_temp.index(str_temp.startIndex, offsetBy: 0)
            }
            title_end = str_temp.index(str_temp.index(of: ")")!, offsetBy: 1)
            title = str_temp[title_start..<title_end]
            str_temp = str_temp[title_end..<str_temp.endIndex]
            detail_start = str_temp.startIndex
            if str_temp.index(of: "@") != nil {
                //detail_end = str_temp.index(before: key.startIndex)
                //detail_end = str_temp.index(str_temp.index(of: "@")!, offsetBy: 1)
                detail_end = str_temp.index(of: "@")!
            }else{
                detail_end = str_temp.endIndex
                End_Flg = 1
            }
            detail = str_temp[detail_start..<detail_end]
            str_temp = str_temp[detail_end..<str_temp.endIndex]
            temp = Solution_struct(Title: title, Detail: detail)
            solution.append(temp)
        }while End_Flg != 1
        //return Main_Data
        
        return solution
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
