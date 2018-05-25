//
//  ViewController.swift
//  MyTimer
//
//  Created by 島田智貴 on 2018/02/08.
//  Copyright © 2018年 hakusan-labo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  // タイマーの変数
  var timer: Timer?
  // カウントの変数
  var count = 0
  // 設定値を扱うキー
  let settingKey = "timer_value"

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
    // インスタンス
    let settings = UserDefaults.standard
    // 初期値登録
    settings.register(defaults: [settingKey:10])
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  @IBOutlet weak var countDownLablel: UILabel!

  @IBAction func settingButtonAction(_ sender: Any) {
    if let nowTimer = timer {
      if nowTimer.isValid == true {
        nowTimer.invalidate()
      }
    }
    // 画面遷移
    performSegue(withIdentifier: "goSetting", sender: nil)
  }
  
  @IBAction func startButtonAction(_ sender: Any) {
    if let nowTimer = timer {
      if nowTimer.isValid == true {
        return
      }
    }
    
    timer = Timer.scheduledTimer(timeInterval: 1.0,
                                 target: self,
                                 selector: #selector(self.timerInterrupt(_:)),
                                 userInfo: nil,
                                 repeats: true)
  }
  
  @IBAction func stopButtonAction(_ sender: Any) {
    if let nowTimer = timer {
      if nowTimer.isValid == true {
        nowTimer.invalidate()
      }
    }
  }
  
  // 秒数更新
  func displayUpdate() -> Int {
    // インスタンス
    let settings = UserDefaults.standard
    let timerValue = settings.integer(forKey: settingKey)
    let remainCount = timerValue - count
    countDownLablel.text = "残り\(remainCount)秒"
    return remainCount
  }
  
  // 経過時間の処理
  @objc func timerInterrupt(_ timer:Timer) {
    // countに+1
    count += 1
    if displayUpdate() <= 0 {
      count = 0
      timer.invalidate()
      // ダイアログを表示
      let alertController = UIAlertController(title: "終了", message: "タイマー終了時間です", preferredStyle: .actionSheet)
      let defaultAction = UIAlertAction(title: "OK", style: .destructive, handler: nil)
      alertController.addAction(defaultAction)
      present(alertController, animated: true, completion: nil)
    }
  }
  
  // 画面切り替えのタイミングで処理を行う
  override func viewDidAppear(_ animated: Bool) {
    count = 0
    // タイマーの表示を更新する
    _ = displayUpdate()
  }
}

