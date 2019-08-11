//
//  NewsViewController.swift
//  SummerCampNews
//
//  Created by VERTEX22 on 2019/08/11.
//  Copyright © 2019 N-project. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class NewsViewController: UIViewController ,IndicatorInfoProvider {
    
    // urlを受けとる
    var url: String = ""

    // itemInfo(タブの名前)を受け取る
    var itemInfo: IndicatorInfo = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        
        return itemInfo
    }



}
