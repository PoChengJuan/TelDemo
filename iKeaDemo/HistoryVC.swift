//
//  HistoryVC.swift
//  iKeaDemo
//
//  Created by PoCheng Juan on 2018/8/31.
//  Copyright © 2018年 PoCheng Juan. All rights reserved.
//

import UIKit

class History_struct:NSObject {
    var History_title : String?
    var History_detail : String?
    
    init(Title:String,Detail:String){
        self.History_title = Title
        self.History_detail = Detail
    }
}
class HistoryVC: UIViewController , UITableViewDataSource , UITableViewDelegate{

    @IBOutlet weak var HistoryNavItem: UINavigationItem!
    var History_str : String?
    var History_main = [History_struct]()
    var HistoryDetailSender : String?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let search = UISearchController(searchResultsController: nil)
        let addBtn = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addBtnFunc))
        //HistoryNavItem.title = "back"
        self.navigationItem.searchController = search
        self.navigationItem.rightBarButtonItem = addBtn
        //self.navigationItem.leftBarButtonItem
        History_main = StringToModel(str: History_str!)
        print(History_main)

    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.History_main.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle(rawValue: 3)!, reuseIdentifier: "Cell")
        let HistoryTitle = History_main[indexPath.item]
        cell.textLabel?.text = HistoryTitle.History_title
        cell.detailTextLabel?.text = HistoryTitle.History_detail
        return cell
    }
     
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        HistoryDetailSender = History_main[indexPath.item].History_detail!
        tableView.deselectRow(at: indexPath, animated: true)
        self.performSegue(withIdentifier: "HistoryDetailString", sender: HistoryDetailSender)
    }
    func addBtnFunc(){
        print("press add btn")
        let HisAdd_VC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HistoryAddVC") as! HistoryAddVC

        self.navigationController?.pushViewController(HisAdd_VC, animated: true)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "HistoryDetailString" {
            let controller = segue.destination as! HistoryDetailVC
            controller.HistoryDetail_str = HistoryDetailSender
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    func StringToModel(str: String) -> [History_struct]{
        var Main_Data = [History_struct]()
        var temp = History_struct(Title: "", Detail: "")
        var str_temp : String = str[str.index(str.startIndex, offsetBy: 12)..<str.endIndex]
        var title_start = str_temp.startIndex
        var title_end = str_temp.endIndex
        var title : String
        var detail_start = str_temp.startIndex
        var detail_end = str_temp.endIndex
        var detail : String
        var End_Flg : Int = 0
        
        //str_temp = str[str.index(str.startIndex, offsetBy: 12)..<str.endIndex]
        
        repeat{
            title_start = str_temp.startIndex
            title_end = str_temp.index(str_temp.index(of: ")")!, offsetBy: 1)
            title = str_temp[title_start..<title_end]
            str_temp = str_temp[title_end..<str_temp.endIndex]
            detail_start = str_temp.startIndex
            if str_temp.index(of: "(") != nil {
                detail_end = str_temp.index(of: "(")!
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
        
        
        /*var str_temp : String?
        var End_Flg : Int = 0
        var
        var temp = History_struct(Title: "", Detail: "")
        var title_start = str.index(str.startIndex, offsetBy: 12)
        var title_end = str.index(str.index(of:")")!,offsetBy: 1)
        var title : String = str[title_start..<title_end]
        str_temp = str[title_end..<str.endIndex]
        var detail_start = str_temp?.startIndex
        var detail_end = str_temp?.index(of: "(")
        var detail : String = str_temp![detail_start..<detail_end]
        //var test = [History_struct]()
        //for()
        History_main = [History_struct(Title: title, Detail: detail)]
        repeat{
            str_temp = str_temp?[detail_end..<str_temp?.endIndex]
            title_start = (str_temp?.startIndex)!
            title_end = (str_temp?.index((str_temp?.index(of: ")"))!, offsetBy: 1))!
            title = str_temp![title_start..<title_end]
            str_temp = str_temp?[title_end..<str_temp?.endIndex]
            detail_start = str_temp?.startIndex
            if str_temp?.index(of: "(") != nil {
                detail_end = str_temp?.index(of: "(")
            }else{
                detail_end = str_temp?.endIndex
                End_Flg = 1
            }
            //detail_end = str_temp?.index(of: "(")
            detail = str_temp![detail_start..<detail_end]
            temp = History_struct(Title: title, Detail: detail)
            History_main.append(temp)
        }while End_Flg != 1
        return History_main*/

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
