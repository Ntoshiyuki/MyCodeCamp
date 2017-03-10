//
//  AirApiViewController.swift
//  MyCodeCamp
//
//  Created by docomo on 2017/03/10.
//  Copyright © 2017年 NAGAE TOSHIYUKI. All rights reserved.
//


import UIKit
import SafariServices

class AirApiViewController: UIViewController, UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate, SFSafariViewControllerDelegate{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //Search Barのdelegate通知先
        searchText.delegate = self
        //入力のヒントをプレースホルダへ設定
        searchText.placeholder = "行きたい国の名前を入力してください"
        //Table Viewのdatasourceを設定
        tableView.dataSource = self
        //Table Viewのdelegateを設定
        tableView.delegate = self
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var searchText: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    //航空券のリスト(タプル配列)
    var AirList : [(id:String, title:String, link:String)] = []
 
    //
    
    //サーチボタンクリックじ
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        //キーボード閉じる
        view.endEditing(true)
        //デバックエリアに出力
        print(searchBar.text)
        
        if let searchWord = searchBar.text{
            //入力されていたら、航空券を検索
            searchAir(keyword : searchWord)
        }
        
    }
    
    func searchAir(keyword : String){
        //航空券の検索キーワードをURLエンコードする
        let keyword_eocode = keyword.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        //URLオブジェクトの生成
        
        //"http://api.calil.jp/library?appkey=cda25df58f9fb03b6ee549ff1693aa19&format=json&pref=\(keyword_eocode!)&max=10&order=r"
        
        //https://webservice.recruit.co.jp/ab-road/tour/v1/?key=8dd0e17904d54982&format=json&dept=TYO&keyword=\(keyword_eocode!)&max=10&order=r
        
        //http://webservice.recruit.co.jp/ab-road-air/ticket/v1/?city=SFO&key=[APIキー]
        //
        let URL = Foundation.URL(string:"http://webservice.recruit.co.jp/ab-road-air/ticket/v1/?city=NYC&key=8dd0e17904d54982&format=json&keyword=\(keyword_eocode!)&max=10&order=r")
        
        
        //cda25df58f9fb03b6ee549ff1693aa19
        print(URL)
        
        //リクエストオブジェクトの生成
        let req = URLRequest(url: URL!)
        
        
        //セッションの接続をカスタマイズ
        //タイムアウト値、キャッシュポリシーなどが指定できる。今回は、デフォルト値を使用
        let configuration = URLSessionConfiguration.default
        
        //セッション情報を取り出し
        let session = URLSession(configuration: configuration, delegate: nil, delegateQueue: OperationQueue.main)
        
        //リクエストをタスクとして登録
        let task = session.dataTask(with: req, completionHandler: {
            (data, response, error) in
            //do try catch　エラーハンドリング
            do{
                //受け取ったJsonデータを解析して格納
                let json = try JSONSerialization.jsonObject(with: data!) as! [String:Any]
                //                let tmp1 = json["results"] as! [String:Any]
                //print (tmp1)
                
                //let tmp2 = tmp1["ticket"] as! [String:Any]
                //print("count = \(tmp2["title"])")
                //if let tmp3 = tmp2["urls"] as? NSString{
                
                //航空券のリストを初期化
                self.AirList.removeAll()
                
                if let tmp1 = json["results"] as? [String:Any]{
                    print("^^")
                    if let tmp2Array = tmp1["ticket"] as? NSArray{
                        for i in 0..<tmp2Array.count {
                            if let tmp2 = tmp2Array[i] as? NSDictionary{
                                guard let id = tmp2["id"] as? String else{
                                    continue
                                    //print(id)
                                }
                                guard let title = tmp2["title"] as? String else{
                                    continue
                                    //print(title)
                                }
                                if let tmp3 = tmp2["urls"] as? NSDictionary{
                                    //                                    print(tmp3["pc"])
                                    guard let link = tmp3["pc"] as? String else{
                                        continue
                                    }
                                    //                                    let link2:String = link.description
                                    //                                    let link = tmp3["pc"]
                                }
                                //                                let link = tmp3["pc"]
                                //                                let link2:String = link.description
                                
                                let Air = (id, title, String(describing: link))
                                self.AirList.append(Air)
                                print("----------------")
                                print("AirList[\(i)] = \(self.AirList[i])")
                                //Table Viewを更新する
                                self.tableView.reloadData()
                                
                            }
                        }
                    }
                }
            }catch{
                //エラー処理
                print("エラーが出たよ")
            }
        })
        //ダウンロード開始
        task.resume()
        
        
    }
    //Cellの総数を返すdatsourceメソッド、必ず記述する必要がある
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //お菓子リストの総数
        return AirList.count
    }
    
    //Cellに値を設定するdatasourceメソッド。必ず記述する必要があります。
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //今回表示を行う、cellオブジェクト(1行)を取得する
        let cell = tableView.dequeueReusableCell(withIdentifier: "apiCell", for: indexPath)
        
        //お菓子のタイトルを設定
        cell.textLabel?.text = AirList[indexPath.row].title
        
        //        //お菓子画像のURLを取り出す
        //        let url = URL(string: okashiList[indexPath.row].image)
        //
        //        //URLから画像を取得
        //        if let image_data = try? Data(contentsOf: url!){
        //            //正常に取得できた場合は、UIImageでオブジェクトを生成して、cellにお菓子画像を設定
        //            cell.imageView?.image = UIImage(data: image_data)
        
        //設定済みのcellオブジェクトを画面に反映
        return cell
    }
    //Cellが選択された際に呼び出されるdelegateメソッド
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //ハイライト解除
        tableView.deselectRow(at: indexPath, animated: true)
        
        //URLをString → URL型に変換
        let urlToLink = URL(string: AirList[indexPath.row].link)
        
        //SFSafariViewを開く
        let safariViewController = SFSafariViewController(url: urlToLink!)
        
        //delegateの通知先が自分自身
        safariViewController.delegate = self
        
        //SafariViewが開かれる
        present(safariViewController, animated: true, completion: nil)
    }
    //SafariViewが閉じられた時に呼ばれるdelegateメソッド
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        
        //SafariViewを閉じる
        dismiss(animated: true, completion: nil)
        
    }
}
/*
 // MARK: - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 // Get the new view controller using segue.destinationViewController.
 // Pass the selected object to the new view controller.
 }
 */


