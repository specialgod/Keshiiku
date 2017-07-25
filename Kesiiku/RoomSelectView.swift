//
//  RoomSelectView.swift
//  Kesiiku
//
//  Created by mesuki on 2016/12/13.
//  Copyright © 2016年 mesuki. All rights reserved.
//

import UIKit

class RoomSelectView: UIView {
    
    weak var presentingViewController: UIViewController?

    weak var scene: RoomScene?

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    @IBAction func 男の子の部屋押された(_ sender: UIButton) {
        print("これで、いいですか？")
        
        if let s = scene {
            s.部屋の切り替え(gender: true)
        }
        
        
        if let vc = presentingViewController {
            let alert = UIAlertController(title: "こっちでいいですか？",message:nil,preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .default, handler: {
                // ボタンが押された時の処理を書く（クロージャ実装）
                action -> Void in
                print("OK")
                // RoomSelectview自体を消す
                self.removeFromSuperview()
            })
            // キャンセルボタン
            let cancelAction = UIAlertAction(title: "キャンセル", style: .cancel, handler: {
                // ボタンが押された時の処理を書く（クロージャ実装）
                action -> Void in
                print("Cancel")
            })
            
            // ③ UIAlertControllerにActionを追加
            alert.addAction(cancelAction)
            alert.addAction(defaultAction)
            
            // ④ Alertを表示
            vc.present(alert, animated: true, completion: nil)
        }
    }
    
    
    
    @IBAction func 女の子の部屋押された(_ sender: UIButton) {
        print("これで、いいですか？")
        
        if let s = scene {
            s.部屋の切り替え(gender: false)
        }
        
        if let vc = presentingViewController {
            let alert = UIAlertController(title: "こっちでいいですか？",message:nil,preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .default, handler: {
                // ボタンが押された時の処理を書く（クロージャ実装）
                action -> Void in
                print("OK")
                
                // RoomSelectview自体を消す
                self.removeFromSuperview()
            })
            // キャンセルボタン
            let cancelAction = UIAlertAction(title: "キャンセル", style: .cancel, handler: {
                // ボタンが押された時の処理を書く（クロージャ実装）
                action -> Void in
                print("Cancel")
            })
            
            // ③ UIAlertControllerにActionを追加
            alert.addAction(cancelAction)
            alert.addAction(defaultAction)
            
            // ④ Alertを表示
            vc.present(alert, animated: true, completion: nil)
        }
    }
        
    
    
}
