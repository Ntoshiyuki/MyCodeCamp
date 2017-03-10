//
//  DepViewController.swift
//  MyCodeCamp
//
//  Created by docomo on 2017/03/09.
//  Copyright © 2017年 NAGAE TOSHIYUKI. All rights reserved.
//

import UIKit

class DepViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    let Japan = ["成田空港", "羽田空港", "関西空港","中部国際空港","福岡空港"]
    let Thailand = ["ドンムアン空港", "スワンナプーム空港", "チェンマイ空港"]
//    let America = ["マッカラン空港","ロサンゼルス空港","ジョンFケネディ空港","サンフランシスコ空港"]
    
    
    //セクションのタイトル
    let mySections = ["日本","タイ"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //セクションの数を返す.
    func numberOfSections(in tableView: UITableView) -> Int {
        return mySections.count
    }
    
    //セクションのタイトルを返す.
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return mySections[section] as String
    }
    
    //Table Viewのセルの数を指定
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return Japan.count
        } else if section == 1 {
            return Thailand.count
        }
        else {
            return 0
        }
    }
    
    
    /// セルに値を設定するデータソースメソッド（必須）
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // セルを取得する
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "DepCell", for: indexPath as IndexPath)
        
        // セルに表示する値を設定する
        if indexPath.section == 0 {
            cell.textLabel!.text = Japan[indexPath.row]
        } else if indexPath.section == 1 {
            cell.textLabel!.text = Thailand[indexPath.row]
        } else {
            
        }
        
        //        cell.textLabel!.text = fruits[indexPath.row]
        //
        return cell
    }
    
    var a = ""
    @IBAction func NextButton(_ sender: Any) {
        performSegue(withIdentifier: "Goinfo1",sender: nil)
        print(a)
    }
    
    /// Segueで遷移する際のメソッド
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)  {
        if segue.identifier == "Goinfo1" { //SecondViewControllerに遷移する場合
            // SecondViewControllerをインスタンス化
            let DepVc = segue.destination as! Info1ViewController
            // 値を渡す
            DepVc.a = self.a
        }else {
            // どちらでもない遷移
        }
    }
    
    
    /// セルが選択された時に呼ばれるデリゲートメソッド
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            print("Section:\(indexPath.section) Row:\(indexPath.row) Value:\(Japan[indexPath.row])")
            a = Japan[indexPath.row]
        } else if indexPath.section == 1{
            print("Section:\(indexPath.section) Row:\(indexPath.row) Value:\(Thailand[indexPath.row])")
            a = Thailand[indexPath.row]
        }
    
    }
}
