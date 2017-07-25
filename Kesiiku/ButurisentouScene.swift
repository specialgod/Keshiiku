//
//  ButurisentouScene.swift
//  Kesiiku
//
//  Created by mesuki on 2017/05/16.
//  Copyright © 2017年 mesuki. All rights reserved.
//

import SpriteKit

class ButurisentouScene: SKScene {
    
    
    //変数・関数の家=(:3 三 )=
    weak var presentingViewController: UIViewController?
    var kesigomuNode: SKNode?
    var osareteruflag = false
    var osareterunode: SKNode?
    var x: CGFloat = 0
    var y: CGFloat = 0
    var hp: Int = 100
    var gauge: GaugeNode?
    var kyori: CGFloat?
    var isSparking:Bool = false
    

    // ① 鉛筆ノードのための変数を作る
    var enpituNode: SKNode?
    
    // 同じ方向に進む回数を数えるための変数
    var susumuKaisu: Int = 0
    
    // 進む方向を保存しておくための変数
    var susumuMuki: Int = 0
    
    //スタートした時に鉛筆と消しゴムが呼ばれる
    override func didMove(to view: SKView) {
    print("呼ばれた")
        //消しゴムのノードを作成
        let kesigomuNode = SKSpriteNode(imageNamed: "kesigomu")
        kesigomuNode.zPosition = 1
        kesigomuNode.name = "kesigomu"
        //消しゴムノードに体を与える
        let kesigomuBody = SKPhysicsBody(rectangleOf: kesigomuNode.size)
        kesigomuBody.contactTestBitMask = 0x1<<0
        kesigomuBody.isDynamic = false
        kesigomuNode.physicsBody = kesigomuBody
        //矢印のノードを作成
        let ueNode = SKSpriteNode(imageNamed: "kesigomu")
        ueNode.zPosition = 1
        ueNode.name = "ue"
        
        let sitaNode = SKSpriteNode(imageNamed: "kesigomu")
        sitaNode.zPosition = 1
        sitaNode.name = "sita"
        
        let migiNode = SKSpriteNode(imageNamed: "kesigomu")
        migiNode.zPosition = 1
        migiNode.name = "migi"
        
        let hidariNode = SKSpriteNode(imageNamed: "kesigomu")
        hidariNode.zPosition = 1
        hidariNode.name = "hidari"
        //ゲージノードを作るところ。
        let gauge = GaugeNode()
        gauge.初期値設定(hp: 100)
        gauge.position = CGPoint(x: -10, y: -260)
        gauge.zPosition = 2
        //世界全体スコープの変数に保存
        self.gauge = gauge
        // 作ったノードを世界全体スコープの変数に保存している。
        self.kesigomuNode = kesigomuNode
        //こうげきボタンのノードを作成
        let kougekibotanNode = SKSpriteNode(imageNamed: "kougekibotan")
        kougekibotanNode.zPosition = 1
        kougekibotanNode.name = "kougekibotan"
        //座標指定
        kesigomuNode.position = CGPoint(x: 0, y: 0)
        ueNode.position = CGPoint(x: 85, y: -180)
        sitaNode.position = CGPoint(x: 85, y: -230)
        migiNode.position = CGPoint(x: 105, y: -210)
        hidariNode.position = CGPoint(x: 60, y: -210)
        kougekibotanNode.position = CGPoint(x: -90, y:-210)
        //鉛筆のノードを表示
        let enpituNode = SKSpriteNode(imageNamed: "enpitu")
        enpituNode.zPosition = 1
        enpituNode.name = "enpitu"

        //ノードをシーンに追加する
        self.addChild(enpituNode)
        self.addChild(kesigomuNode)
        self.addChild(ueNode)
        self.addChild(sitaNode)
        self.addChild(migiNode)
        self.addChild(hidariNode)
        self.addChild(kougekibotanNode)
        self.addChild(gauge)
        //座標指定
        enpituNode.position = CGPoint(x: 0, y: 0)
        
        // ② 変数の家に鉛筆ノードを保存
        self.enpituNode = enpituNode
    }
    
    // 画面を更新した時に呼ばれる
    override func update(_ currentTime: TimeInterval) {
        
        // 鉛筆と消しゴムの距離を計算する
        var x1: CGFloat = 0  // 鉛筆のx
        var y1: CGFloat = 0  // 鉛筆のy
        var x2: CGFloat = 0  // 消しゴムのx
        var y2: CGFloat = 0  //　消しゴムのy
        
        
        
        // ③ 変数の家の鉛筆ノード用変数から中身を取り出す
        if let enpituNode = self.enpituNode {
            
            if susumuKaisu == 0 {
                // 方向転換する
                let random = arc4random_uniform(8)
                self.susumuMuki = Int(random)
                susumuKaisu = 50
                
                //鉛筆の位置を教えてあげる
                x1 = enpituNode.position.x
                y1 = enpituNode.position.y
            } else {
                // 同じ方向に進む
                if self.susumuMuki == 0 {
                    // 上
                    enpituNode.position.y += 1
                } else if self.susumuMuki == 1 {
                    // 右上
                    enpituNode.position.y += 1
                    enpituNode.position.x += 1
                } else if self.susumuMuki == 2 {
                    // 右
                    enpituNode.position.x += 1
                } else if self.susumuMuki == 3 {
                    // 右下
                    enpituNode.position.x += 1
                    enpituNode.position.y += -1
                } else if self.susumuMuki == 4 {
                    // 下
                    enpituNode.position.y += -1
                } else if self.susumuMuki == 5 {
                    // 左下
                    enpituNode.position.x += -1
                    enpituNode.position.y += -1
                } else if self.susumuMuki == 6 {
                    // 左
                    enpituNode.position.x += -1
                } else if self.susumuMuki == 7 {
                    // 左上
                    enpituNode.position.y += 1
                    enpituNode.position.x += -1
                }
                
                susumuKaisu = susumuKaisu - 1
                
                // 画面外に出ていた場合には、強制的に方向転換
                if enpituNode.position.x > 150 {
                    enpituNode.position.x = 150
                    susumuKaisu = 0
                } else if enpituNode.position.x < -150 {
                    enpituNode.position.x = -150
                    susumuKaisu = 0
                } else if enpituNode.position.y < -270 {
                    enpituNode.position.y = -270
                    susumuKaisu = 0
                } else if enpituNode.position.y > 270 {
                    enpituNode.position.y = 270
                    susumuKaisu = 0
                }
                //鉛筆の位置を教えてあげる
                x1 = enpituNode.position.x
                y1 = enpituNode.position.y
            }
        }
        
        // 消しゴムのノードを変数から取り出す
        if let kesigomuNode = self.kesigomuNode
            , let osareterunode = self.osareterunode
            , let name = osareterunode.name
        {
            if osareteruflag == true {
                
                // 押されているNodeがueなら
                // 変数yを1増やす
                if name == "ue" {
                    if  y < 270{
                        y = y + 2.5
                    }
                }
                    // 押されているNodeがsitaなら
                    // 変数yを1減らす
                else if name == "sita" {
                    if  y > -270{
                        y = y - 2.5
                    }
                    print("今のy: \(y)")
                }
                    // 押されているNodeがmigiなら
                    // 変数xを1増やす
                else if name == "migi" {
                    if  x < 150 {
                        x = x + 2.5
                    }
                }
                    // 押されているNodeがhidariなら
                    // 変数xを1減らす
                else if name == "hidari" {
                    if  x > -150 {
                        x = x - 2.5
                    }
                    
                }
                
                // 消しゴムノードの位置（position）を更新
                kesigomuNode.position = CGPoint(x: x, y: y)
                
                print("position: \(kesigomuNode.position)")
                //消しゴムの位置を教えてあげてる
                x2 = kesigomuNode.position.x
                y2 = kesigomuNode.position.y
            } else {
                x2 = kesigomuNode.position.x
                y2 = kesigomuNode.position.y
            }
        }
        
        //鉛筆と消しゴムの距離を計算する。
        let kyori = sqrt(pow(x1-x2, 2)+pow(y1-y2, 2))
//        print("距離: \(kyori)")
        self.kyori = kyori
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
        
            // タッチされた位置
            let location = touch.location(in: self)
            
            // どのnodeが触られたかを検出
            let node = self.atPoint(location)
            
            print("■\(node.name)")
            
            osareterunode = node
        
            
            if let name = node.name {
                if name == "ue" {
                    osareteruflag = true
                    print("■ 通った！\(node.name)")
                } else if name == "sita" {
                    osareteruflag = true
                    print("■ 通った！\(node.name)")
                } else if name == "migi" {
                    osareteruflag = true
                    print("■ 通った！\(node.name)")
                } else if name == "hidari" {
                    osareteruflag = true
                    print("■ 通った！\(node.name)")
                }
                if name == "kougekibotan" {
                    print("■ 攻撃！\(node.name)")
                    if let kyori = self.kyori {
                        if 100 > kyori {
                            if let emitternode = SKEmitterNode(fileNamed: "SparkParticle.sks")
                                , let enpituNode = self.enpituNode
                            {
                                if self.isSparking == false {
                                    hp = hp-10
                                    //　ゲージを取り出してる。
                                    if let gauge = self.gauge {
                                        gauge.ダメージ(d: 10)
                                    }
                                    //ここで爆発を出している。
                                    emitternode.particlePosition = enpituNode.position
                                    emitternode.zPosition = 2
                                    self.addChild(emitternode)
                                    self.isSparking = true
                                    self.run(SKAction.wait(forDuration: 2), completion: {
                                        emitternode.removeFromParent()
                                        self.isSparking = false
                                        
                                    })
                                    print("■ 攻撃成功！ \(kyori)")
                                    if hp == 0 {
                                        //こいつが鉛筆を消している↓
                                        enpituNode.removeFromParent()
                                        //「敗北(T^T)」の文字のノードを作っている
                                        let gameoverlabel = SKLabelNode(text: "勝利！(^^)")
                                        gameoverlabel.fontSize = 50
                                        gameoverlabel.fontColor = UIColor.red
                                        self.addChild(gameoverlabel)
                                        
                                        // 3秒後に処理
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                                            //ここでRoomを呼び出している
                                            let scene = RoomScene(size: self.scene!.size)
                                            scene.hajimetekitaFlag = false
                                            scene.scaleMode = .aspectFill
                                            scene.presentingViewController = self.presentingViewController
                                            self.view!.presentScene(scene)
                                        }
                                    }

                                }
                            }
                        }else{
                            print("■ 攻撃失敗orz \(kyori)")
                        }
                    }
                }
            }
        }
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        osareteruflag = false
    }

}

