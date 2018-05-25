//
//  SettingViewController.swift
//  MyTimer
//
//  Created by 島田智貴 on 2018/02/08.
//  Copyright © 2018年 hakusan-labo. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
  let settingArray : [Int] = [10,20,30,40,50,60]
  let settingKey = "timer_value"
  
    override func viewDidLoad() {
        super.viewDidLoad()
      
      timerSettingPicker.delegate = self
      timerSettingPicker.dataSource = self
      
      let settings = UserDefaults.standard
      let timerValue = settings.integer(forKey: settingKey)
      
      for row in 0..<settingArray.count {
        if settingArray[row] == timerValue {
          timerSettingPicker.selectRow(row, inComponent: 0, animated: true)
        }
      }

        // Do any additional setup after loading the view.
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

  @IBOutlet weak var timerSettingPicker: UIPickerView!
  
  @IBAction func decisionButtonAction(_ sender: Any) {
    // 前画面に戻る
    _ = navigationController?.popViewController(animated: true)
  }
  
  // UIPickerViewの設定
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
  }
  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return settingArray.count
  }
  
  // UIPickerViewの表示する内容を設定
  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    return String(settingArray[row])
  }
  
  // picker選択時に実行
  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    let settings = UserDefaults.standard
    settings.setValue(settingArray[row], forKey: settingKey)
    settings.synchronize()
  }
}
