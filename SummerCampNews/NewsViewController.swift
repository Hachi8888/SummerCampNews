//
//  NewsViewController.swift
//  SummerCampNews
//
//  Created by VERTEX22 on 2019/08/11.
//  Copyright © 2019 N-project. All rights reserved.
//

import UIKit
import XLPagerTabStrip

// webkiviewを使う
import WebKit

class NewsViewController: UIViewController ,IndicatorInfoProvider, UITableViewDataSource, UITableViewDelegate, WKNavigationDelegate, XMLParserDelegate {
    
    // tableViewのインスタンスを取得
    var tableView: UITableView =
    UITableView()
    
    
    // XMLparserのインスタンスを取得
    var parser = XMLParser()
    
    //  取得するNewsを全て格納する配列
    var articles: [Any] = []
    
    // 紐付けを行う
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var toolBar: UIToolbar!
    
    // urlを受けとる
    var url: String = ""

    // itemInfo(タブの名前)を受け取る
    var itemInfo: IndicatorInfo = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        // デリゲートとの接続
        tableView.delegate = self
        tableView.dataSource = self
        
        // parserの接続
        parser.delegate = self
        
        // tabelViewのサイズを確定
        tableView.frame = CGRect(x: 0, y: 50, width: self.view.frame.width, height: self.view.frame.width - 50)
        
        // tableViewをViewに追加
        self.view.addSubview(tableView)
    
     // 最初にニュースリストのtabaleViewを表示させるため、最初はtoolBarもwebViewも隠しておく
     webView.isHidden = true
     toolBar.isHidden = true
        
        
       // navigationDelegate(Webページの画面遷移を監視するプロトコル)
        webView.navigationDelegate = self
    
    }
    
    // URLが読まれるたびに呼ばれる関数を定義
    func perseUrl() {
        
        // url型に変換
        let urlToSend: URL = URL(string: url)!
        
        // parserに解析対象のurlを格納
        parser = XMLParser(contentsOf: urlToSend)!
        
        // 記事情報を初期化
        articles = []
        
        // 解析(パース)の実行
        parser.parse()
        
        // tableViewをリロード
        tableView.reloadData()
    }
    
    
    // tableViewのセルの高さ
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    // tableViewのセルの数をarticlesの数に合わす
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")
        
        // セルの設定
        // セルの色
        cell.backgroundColor = #colorLiteral(red: 1, green: 0.814948995, blue: 0.8542565316, alpha: 1)
        
        // セルのフォント
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        
        // セルのテキストサイズとフォント
        cell.textLabel?.textColor = UIColor.black
        
        // セルのサブタイトル(記事urlを表示)の設定
        // セルのフォントサイズと色
        cell.detailTextLabel?.font = UIFont.systemFont(ofSize: 13)
        cell.detailTextLabel?.textColor = UIColor.gray
        
        
        // セルをタップしたときの処理
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            // あとで書く
            
        }
        
        
        
        return cell
    }
    
    
    
    // ウェブページの読み込みが完了したときの処理
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
    
        // tableViewを隠す
        tableView.isHidden = true
        // toolBarを出す
        toolBar.isHidden = false
        // webViweを出す
        webView.isHidden = false
        
    }
    
    
    // キャンセルボタンを押したとき
    @IBAction func cansel(_ sender: Any) {
      
        // tableViewを出す
        tableView.isHidden = false
        // toolBarを隠す
        toolBar.isHidden = true
        // webViweを隠す
        webView.isHidden = true
    
    }
    
    // 戻るボタンを押したとき
    @IBAction func backPage(_ sender: Any) {
        webView.goBack()
    }
    
    // 進むボタンを押したとき
    @IBAction func NextPage(_ sender: Any) {
        webView.goForward()
    }
    
    // リロードを押したとき
    @IBAction func refreshPage(_ sender: Any) {
        webView.reload()
    }
    
    
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        
        return itemInfo
    }



}
