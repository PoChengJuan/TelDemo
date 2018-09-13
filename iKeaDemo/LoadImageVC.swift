//
//  LoadImageVC.swift
//  iKeaDemo
//
//  Created by PoCheng Juan on 2018/9/7.
//  Copyright © 2018年 PoCheng Juan. All rights reserved.
//

import UIKit

fileprivate let cellid = "Cell"
class LoadImageVC: UIViewController ,UICollectionViewDataSource ,UICollectionViewDelegate ,UICollectionViewDataSourcePrefetching,UIScrollViewDelegate{

    

    

    @IBOutlet weak var CollectionImage: UICollectionView!
    @IBOutlet weak var ErrorImageView: UIImageView!
    @IBOutlet weak var MyScrollView: UIScrollView!
    var imageStr : String?
    var OutputImage : [String]?
    var imageArray = [UIImage]()
    let urlStr : String = "http://114.35.249.80/TelDemo_php/Image/"
    var data : NSData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.CollectionImage.showsHorizontalScrollIndicator = false

        self.ErrorImageView.contentMode = .scaleAspectFit
        self.MyScrollView.delegate = self
        OutputImage = GetOuputImage(str:imageStr!)

        for i in 0...((OutputImage?.count)!-1) {
            let url1 : URL = URL(string: urlStr + (OutputImage?[i])!)!
            data = NSData(contentsOf: url1)
            imageArray.append(UIImage(data: data! as Data)!)
        }
        ErrorImageView.image = imageArray[0]
    }

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (OutputImage?.count)!
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print("cellForItemAt",indexPath.item)
        let Cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! MyCollectionViewCell

        Cell.imageView.image = imageArray[indexPath.item]
        return Cell
    }
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        //print("prefetchItemAt")
    }
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        //print("didEndDisplaying",indexPath.item)
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        //print("willDisplay",indexPath.item)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("didSelectItemAt",indexPath.item)
        ErrorImageView.contentMode = .scaleAspectFit
        ErrorImageView.image = imageArray[indexPath.item]
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return ErrorImageView
    }
    /************************************************************************************************/
    /*      Function: GetOuputImage                                                                 */
    /*      Argument:                                                                               */
    /*      Return:                                                                                 */
    /*      Note:                                                                                   */
    /*                                                                                              */
    /*                                                                                              */
    /************************************************************************************************/
    func GetOuputImage(str:String)->[String] {
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
