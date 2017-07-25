//
//  DanmakuScene.swift
//  Kesiiku
//
//  Created by mesuki on H29/01/24.
//  Copyright © 平成29年 mesuki. All rights reserved.
//

import SpriteKit

class DanmakuScene: SKScene
    , SKPhysicsContactDelegate
{
    
    weak var presentingViewController: UIViewController?
    var kesigomuNode: SKNode?
    var x: CGFloat = 0
    var y: CGFloat = 0
    var osareteruflag = false
    var osareterunode: SKNode?
    var butukkataCount: Int = 0
    var isSparking:Bool = false
    var hp: Int = 100
    var gauge: GaugeNode?
    var teki5: SKNode?
    var 右に行く = true
    // 一番初めにシーンを用意している
    override func didMove(to view: SKView) {
        
        // 重力を0に設定
        self.physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        self.physicsWorld.contactDelegate = self
        // 背景画像のノードを作成する
        
        //消しゴムのノードを作成する        
        let kesigomuNode = SKSpriteNode(imageNamed: "kesigomu")
        kesigomuNode.zPosition = 1
        kesigomuNode.name = "kesigomu"
        //消しゴムノードに体を与える
        let kesigomuBody = SKPhysicsBody(rectangleOf: kesigomuNode.size)
        kesigomuBody.contactTestBitMask = 0x1<<0
        kesigomuBody.isDynamic = false
        kesigomuNode.physicsBody = kesigomuBody
        
        let teki5Node = SKSpriteNode(imageNamed: "teki5")
        kesigomuNode.zPosition = 1
        kesigomuNode.name = "teki5"
        
                
        //矢印のノードを作成する
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
        //ノードをシーンに追加する
        self.addChild(kesigomuNode)
        self.addChild(ueNode)
        self.addChild(sitaNode)
        self.addChild(migiNode)
        self.addChild(hidariNode)
        self.addChild(teki5Node)
        self.addChild(gauge)
        
        //座標指定
        kesigomuNode.position = CGPoint(x: 0, y: 0)
        ueNode.position = CGPoint(x: 85, y: -180)
        sitaNode.position = CGPoint(x: 85, y: -230)
        migiNode.position = CGPoint(x: 105, y: -210)
        hidariNode.position = CGPoint(x: 60, y: -210)
        teki5Node.position = CGPoint(x: 0, y: 250)
        // 作ったノードを世界    全体スコープの変数に保存している。
        self.kesigomuNode = kesigomuNode
        self.gauge = gauge
        self.teki5 = teki5Node
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            
            // タッチされた位置
            let location = touch.location(in: self)
            
            // どのnodeが触られたかを検出
            let node = self.atPoint(location)
            
            print("■\(node.name)")
            
            osareterunode = node
            
            if let name = node.name
                , let kesigomuNode = self.kesigomuNode {
                
                if name == "ue" {
                        osareteruflag = true
                    //y = y + 10
                    //kesigomuNode.position = CGPoint(x: x, y: y)
                } else if name == "sita" {
                     //y = y - 10
                    osareteruflag = true
                    //kesigomuNode.position = CGPoint(x: x, y: y)
                } else if name == "migi" {
                    // x = x + 10
                    osareteruflag = true
                    //kesigomuNode.position = CGPoint(x: x, y: y)
                } else if name == "hidari" {
                     //x = x - 10
                    osareteruflag = true
                    //kesigomuNode.position = CGPoint(x: x, y: y)
                }
                
            }
        }
    }
//離した時呼ばれる。
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
         osareteruflag = false
    }

    var counter = 0
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        if let teki5Node = self.teki5 {
            if 右に行く {
                if teki5Node.position.x < 150 {
                    teki5Node.position.x += 1 
                }
                else {
                    右に行く = false
                }
            } else {
                if teki5Node.position.x > -150 {
                    teki5Node.position.x -= 1
                }
                else{
                    右に行く = true
                }
            }
            
            if counter % 20 == 0 {
                self.danmaku(point: teki5Node.position)
                counter = 1
            } else {
                counter += 1
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
            }
        }
    }
    
    func danmaku(point: CGPoint) {
        
        let p = CGPoint(x: point.x + CGFloat(arc4random_uniform(10)), y: point.y + CGFloat(arc4random_uniform(10)))
        
        for i in 0..<30 {
            let node = SKSpriteNode(imageNamed: "tekidannmaku")
            
            node.position = point
            node.speed = 0.4
            let pr = node.size.width/2
            
            let body = SKPhysicsBody(circleOfRadius: pr)
            body.contactTestBitMask = 0x1<<1
            body.categoryBitMask    = 0x1<<0
            body.collisionBitMask   = 0x1<<1
            node.physicsBody = body
            
            let r  = self.size.height
            
           var x  = r * CGFloat(cos( Double(i) * (2 * M_PI ) / 30.0))
            var y  = r * CGFloat(sin( Double(i) * (2 * M_PI ) / 30.0))
            
           // if x < 0 { x = x * -1 }
//            if y < 0 { y = y * -1 }
            
            let sequence = SKAction.sequence(
                [
                    SKAction.repeat(SKAction.moveBy(x: p.x+x, y: p.y+y, duration: 1), count: 10)
                    , SKAction.wait(forDuration: 30.0/60.0)
                    , SKAction.removeFromParent()
                ]
            )
            
            node.run(sequence)
            
            
            self.addChild(node)
        }
    }
    
    //弾幕にぶつかった時呼ばれる
    func didBegin(_ contact: SKPhysicsContact){
        print("ぶつかった")
        if let emitternode = SKEmitterNode(fileNamed: "SparkParticle.sks")
            , let bombnode = SKEmitterNode(fileNamed: "sparkeParticle.sks")
            , let kesigomuNode = self.kesigomuNode
        {
            if self.isSparking == false {
                butukkataCount = butukkataCount+1
                print("ぶつかった回数: \(self.butukkataCount) , HP: \(hp)")
                
                //ここで爆発音を鳴らしてる。↓
                let action = SKAction.playSoundFileNamed("bomb2-5.mp3", waitForCompletion: true)
                self.run(action)
                
                
                hp = hp-10
                //　ゲージを取り出してる。
                if let gauge = self.gauge {
                    gauge.ダメージ(d: 10)
                }
            
                //ここで爆発を出している。↓
                emitternode.particlePosition = kesigomuNode.position
                emitternode.zPosition = 2
                self.addChild(emitternode)
                self.isSparking = true
                self.run(SKAction.wait(forDuration: 2), completion: {
                    emitternode.removeFromParent()
                    self.isSparking = false
                    
                })
                if hp == 0 {
                    bombnode.particlePosition = kesigomuNode.position
                    bombnode.zPosition = 2
                    self.addChild(bombnode)
                    self.isSparking = true
                    self.run(SKAction.wait(forDuration: 2), completion: {
                        bombnode.removeFromParent()
                        self.isSparking = false
                    })
                    //こいつが消しゴムを消している↓
                    kesigomuNode.removeFromParent()
                    //「敗北(T^T)」の文字のノードを作っている
                    let gameoverlabel = SKLabelNode(text: "敗北(T^T)")
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
    }
   
    
    
    
}



