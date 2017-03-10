//
//  Info1ViewController.swift
//  MyCodeCamp
//
//  Created by docomo on 2017/03/09.
//  Copyright © 2017年 NAGAE TOSHIYUKI. All rights reserved.
//

import UIKit

class Info1ViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource   {
    
    var a = ""
    var b = ""
    @IBOutlet weak var aLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        aLabel.text = a
        
        self.view.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 0.9, alpha: 1.0)

        // Do any additional setup after loading the view.
    }
    
    
    @IBOutlet weak var testLabel: UILabel!
    
    let dataList = [["17年","18年","19年"],["1月","2月","3月","4月","5月","6月","7月","8月","9月","10月","11月","12月"],["1日","2日","3日","4日","5日","6日","7日","8日","9日","10日","11日","12日","13日","14日","15日","16日","17日","18日","19日","20日","21日","22日","23日","24日","25日","26日","27日","28日","29日","30日","31日"]]
    
    //コンポーネントの個数を返すメソッド
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return dataList.count
    }
    
    //コンポーネントに含まれるデータの個数を返すメソッド
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dataList[component].count
    }
    
    //データを返すメソッド
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return dataList[component][row]
    }
    
    var data1 = ""
    var data2 = ""
    var data3 = ""
    
    //データ選択時の呼び出しメソッド
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        //コンポーネントごとに現在選択されているデータを取得する。
        
        data1 = self.pickerView(pickerView, titleForRow: pickerView.selectedRow(inComponent: 0), forComponent: 0)!
        data2 = self.pickerView(pickerView, titleForRow: pickerView.selectedRow(inComponent: 1), forComponent: 1)!
        data3 = self.pickerView(pickerView, titleForRow: pickerView.selectedRow(inComponent: 2), forComponent: 2)!
    }



    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    @IBAction func AriButton(_ sender: Any) {
//        performSegue(withIdentifier: "GoInfo2",sender: nil)
//    }
    
    /// Segueで遷移する際のメソッド
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)  {
        if segue.identifier == "GoInfo2" { //SecondViewControllerに遷移する場合
            // SecondViewControllerをインスタンス化
            let info1Vc = segue.destination as! Info2ViewController
            // 値を渡す
            info1Vc.a = self.a
            info1Vc.data1 = self.data1
            info1Vc.data2 = self.data2
            info1Vc.data3 = self.data3
            
            
        }else {
            // どちらでもない遷移
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

}
