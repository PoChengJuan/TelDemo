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

    var imageArray = [UIImage]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.CollectionImage.showsHorizontalScrollIndicator = false

        self.ErrorImageView.contentMode = .scaleAspectFit
        self.MyScrollView.delegate = self

        ErrorImageView.image = imageArray[0]
    }

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //return (OutputImage?.count)!
        return (imageArray.count)
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
