//
//  MainViewController.swift
//  SummerCampNews
//
//  Created by VERTEX22 on 2019/08/11.
//  Copyright © 2019 N-project. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class MainViewController: ButtonBarPagerTabStripViewController {
    
   // URLの文字列(Yahoo!, NHK, 週間文春)
    let urlList: [String] = ["https://news.yahoo.co.jp/pickup/domestic/rss.xml",
         "https://www.nhk.or.jp/rss/news/cat0.xml",
         "http://shukan.bunshun.jp/list/feed/rss"]
    
    // タブの名前の表示
    var itemInfo: [IndicatorInfo] =  ["Yahoo!", "NHK", "週間文春"]
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
    }
 
    
     // 管理されるViewControllerを返す処理
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        
         // 返すviewcontrollerの配列を作成
        var childViewControllers: [UIViewController] = []
        
        // 同じNewsViewControllerだけど、urlやタブ名が異なるものをつくる
        for i in 0 ..< urlList.count {
            
            // viewcontrollerのインスタンス化
            let VC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "News") as! NewsViewController
            
             // urlListのURLを一つづつVCにあるurlに入れる(
             VC.url = urlList[i]
             VC.itemInfo = itemInfo[i]
            
            // 配列にappendする
            childViewControllers.append(VC)
        }
        // VCを返す
        return childViewControllers
        
        
    }

}

