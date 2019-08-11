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
    // XMLファイルに解析をかけた情報
    var elements = NSMutableDictionary()
    // XMLファイルのタグ情報
    var element: String = ""
    // XMLの<title>タグで囲まれた情報を入れる
    var titleString: String = ""
    // XMLの<link>タグで囲まれた情報を入れる
    var linkString: String = ""
    
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
        
        // tabelViewのサイズを確定
        tableView.frame = CGRect(x: 0, y: 50, width: self.view.frame.width, height: self.view.frame.width - 50)
        
        // tableViewをViewに追加
        self.view.addSubview(tableView)
    
     // 最初にニュースリストのtabaleViewを表示させるため、最初はtoolBarもwebViewも隠しておく
     webView.isHidden = true
     toolBar.isHidden = true
        
        
       // navigationDelegate(Webページの画面遷移を監視するプロトコル)
        webView.navigationDelegate = self
        
      // perseUrl関数を呼び出す
        perseUrl()
    
    }
    
    
    // URLが読まれるたびに呼ばれる関数を定義
    func perseUrl() {
        
        /* url型に変換 URL(string: String型の定数名など )
                         ^^^^^^^                   */
        let urlToSend: URL = URL(string: url)!
        
        // parserに解析対象のurlを格納
        parser = XMLParser(contentsOf: urlToSend)!
        
        // 記事情報を初期化
        articles = []
        
        // parserの接続
        parser.delegate = self
        
        // 解析(パース)の実行
        parser.parse()
        
        // tableViewをリロード
        tableView.reloadData()
    }
    
    
    // 解析中に要素の開始だタグがあったときに呼ばれる関数
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        
        // 自分で定義したelementに引数elementNameで入ってきたタグ名を代入する
        element = elementName
        
        // タグにitemがあるとき
        if element == "item" {
            
            // 初期化
            elements = [:]
            titleString = ""
            linkString = ""
        }
        
    }
    
    // 開始タグと終了タグに囲まれているcharacterを見つけたときに呼ばれる関数
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        
        if element == "title" {
            // ()内のstringはこの関数の引数のstringのこと。この場合、タイトル名が入っている。
            titleString.append(string)
            
        } else if element == "link" {
            // ()内のstringはこの関数の引数のstringのこと。この場合、リンク名が入っている。
            linkString.append(string)
        }
        
    }
    
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
        if elementName == "item" {
            
            // titleString,linkStringが空でないなら
            if titleString != "" {
                // elementsに"title"、"Link"というキー値を付与しながらtitleString,linkStringをセット
                elements.setObject(titleString, forKey: "title" as NSCopying)
            }
            
            if linkString != "" {
                elements.setObject(linkString, forKey: "link" as NSCopying)
            }
            
            // articlesの中にelementsを入れる
            articles.append(elements)
            
            
        }
        
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
        
        cell.textLabel?.text = (articles[indexPath.row] as AnyObject).value(forKey: "title") as? String
        // セルのテキストサイズとフォント
        cell.textLabel?.textColor = UIColor.black
        
        // セルのサブタイトル(記事urlを表示)の設定
        // セルのフォントサイズと色
        cell.detailTextLabel?.font = UIFont.systemFont(ofSize: 13)
        cell.detailTextLabel?.text = (articles[indexPath.row] as AnyObject).value(forKey: "link") as? String
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
