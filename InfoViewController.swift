//
//  InfoViewController.swift
//  MyCodeCamp
//
//  Created by docomo on 2017/03/10.
//  Copyright © 2017年 NAGAE TOSHIYUKI. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController ,UIPickerViewDelegate,UIPickerViewDataSource  {
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        aLabel.text = a
           self.view.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 0.9, alpha: 1.0)
        
        // Do any additional setup after loading the view.
    }

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
