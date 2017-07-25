//
//  RoomScene.swift
//  Kesiiku
//
//  Created by mesuki on 2016/12/06.
//  Copyright © 2016年 mesuki. All rights reserved.
//

import SpriteKit

class RoomScene: SKScene {
    
    weak var presentingViewController: UIViewController?
    
    var movingNode: SKNode?
    //変数の家*･゜ﾟ･*:.｡..｡.:*･'(var*)'･*:.｡. .｡.:*･゜ﾟ･*＜ｲｴｲ
    var hajimetekitaFlag = true
    
    //ゲームを終わらせても覚えているノートを本棚から取り出す
    let userDefaults = UserDefaults.standard
    
    
    
    override func didMove(to view: SKView) {
        
        //背景画像のノードを作成する。
        let backNode = SKSpriteNode(imageNamed: "Room")
        backNode.zPosition = -1
        backNode.name = "Room"
        
        //背景画像のサイズをシーンのサイズと同じにする。
        backNode.size = self.frame.size
        
        //消しゴムのノードを作成する
        let kesigomuNode = SKSpriteNode(imageNamed: "kesigomu")
        kesigomuNode.zPosition = 1
        kesigomuNode.name = "kesigomu"
        
        //ガチャのノードを表示している。
        let gatyahonntaiNode = SKSpriteNode(imageNamed: "gatyahonntai")
        gatyahonntaiNode.zPosition = 2
        gatyahonntaiNode.name = "gatya"
        //お布団のノードを作成する
        let oftonnNode = SKSpriteNode(imageNamed: "oftonn")
        oftonnNode.zPosition = 3
        oftonnNode.name = "oftonn"
        
        //ゴミ箱のノードを作成する
        let gomibakoNode = SKSpriteNode(imageNamed: "gomibako")
        gomibakoNode.zPosition = 3
        gomibakoNode.name = "gomibako"
        
        self.room = backNode
        
        
        //ノードをシーンに追加する。
        self.addChild(backNode)
        self.addChild(kesigomuNode)
        self.addChild(oftonnNode)
        self.addChild(gomibakoNode)
        self.addChild(gatyahonntaiNode)
        //背景画像の位置をシーンの中央にする。
        backNode.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        kesigomuNode.position = CGPoint(x: 150, y: 250)
        gomibakoNode.position = CGPoint(x: 100, y: 200)
        oftonnNode.position = CGPoint(x: 150, y: 150)
        gatyahonntaiNode.position = CGPoint(x: 100, y: 150)
        

        if hajimetekitaFlag == true {
            // 部屋を選択するビューを表示する
            if let roomSelectView = UINib(nibName: "RoomSelectView", bundle: Bundle.main).instantiate(withOwner: view, options: nil).first as? RoomSelectView {
                let width = self.view!.bounds.size.width - 10*2
                let height = self.view!.bounds.size.height - 50*2
                
                roomSelectView.frame = CGRect(x:10, y: 50, width: width, height: height)
                roomSelectView.presentingViewController = self.presentingViewController
                roomSelectView.scene = self
                view.addSubview(roomSelectView)
            }
        } else {
            // 表示しない
            
            // 保存したのを、取り出してる
            let otokonokonoheyaFlag = userDefaults.bool(forKey: "部屋")
            self.部屋の切り替え(gender: otokonokonoheyaFlag)
            
        }
    }
    
    private var room : SKSpriteNode?
    
    func 部屋の切り替え(gender: Bool) {
        
        print("kesigomu")
        
        if gender == false {
            if let room = self.room {
                print("abc")
               room.texture = SKTexture(imageNamed:"heya")
            }
        } else {
        
            if let room = self.room {
                print("def")
                room.texture = SKTexture(imageNamed:"Room")
            }
        }
        //保存してる。
        userDefaults.set(gender, forKey: "部屋")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            
            let location = touch.location(in: self)
            
            // どのnodeが触られたかを検出
            let node = self.atPoint(location)
           
            print("■\(node)")
            
           //nodeの名前を取り出してる
            if let name = node.name {
                
                if name != "Room" && name != "kesigomu" {
                    // 覚えておく
                    movingNode = node
                }
                if name == "kesigomu" {
                    // タッチを検出したときにDannmakuSceneを呼び出す
                    let scene = DanmakuScene(size: self.scene!.size)
                    //scene.scaleMode = .aspectFill
                    scene.anchorPoint = CGPoint(x: 0.5, y: 0.5)
                    
                    scene.presentingViewController = self.presentingViewController
                    self.view!.presentScene(scene)

                    print("r")
                }
                if name == "gatya" {
                    // タッチを検出したときにGatyaSceneを呼び出す
                    let scene = GatyaScene(size: self.scene!.size)
                    //scene.scaleMode = .aspectFill
                    scene.anchorPoint = CGPoint(x: 0.5, y: 0.5)
                    
                    self.view!.presentScene(scene)
                    
                    print("r")
                }
                if name == "oftonn" {
                    print("キターーー")
                    let scene = ButurisentouScene(size: self.scene!.size)
                    scene.anchorPoint = CGPoint(x: 0.5, y: 0.5)
                    
                    scene.presentingViewController = self.presentingViewController
                    self.view!.presentScene(scene)
                }
            }
        }
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            if let node = self.movingNode {
                let position = touch.location(in: self)
                node.position = position

                
                
            }
        }
        
        
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.movingNode = nil
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
       self.movingNode = nil
    }

  
    
    
}

