//
//  ViewController.swift
//  Banner
//
//  Created by Peiyun on 2023/1/6.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var myCollectionView: UICollectionView!
    //圖片名稱
    let images = ["1","2","3","4","1"]
    
    
    //collectionView的方法
    func numberOfSections(in collectionView: UICollectionView) -> Int {
            return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MyCollectionViewCell
        cell.myImageView.image = UIImage(named: images[indexPath.row])
        return cell
    }
    
    //UICollectionViewDelegateFlowLayout的方法
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //每個cell的大小都跟整個collection view一樣大
        return collectionView.bounds.size
        
    }
    
    //左右間隔
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    //上下間隔
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        myCollectionView.delegate = self
        myCollectionView.dataSource = self
        //自動輪播動畫，設定加入一秒切換
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(changeBanner), userInfo: nil, repeats: true)
    }
    
    //用來記錄目前的banner播放到第幾個cell
    var imageIndex = 0
    
    //輪播動畫
    @objc func changeBanner(){
        var indexPath:IndexPath
        imageIndex += 1
        if imageIndex < images.count{
            //如果播放的cell小於總數量，則顯示下一張
            indexPath = IndexPath(item: imageIndex, section: 0)
            //加入自動輪播動畫時要做的事
            myCollectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
        }else{
            //如果播放的cell等於總數量，沒有下一張圖時，則先選到第一張，再馬上呼叫自己
            imageIndex = 0
            indexPath = IndexPath(item: imageIndex, section: 0)
            //加入自動輪播動畫時要做的事
            myCollectionView.selectItem(at: indexPath, animated: false, scrollPosition: .centeredHorizontally)
            changeBanner()
            
        }
        
    }


}

