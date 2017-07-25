//
//  GatyaScene.swift
//  Kesiiku
//
//  Created by mesuki on 2017/04/11.
//  Copyright © 2017年 mesuki. All rights reserved.
//

import SpriteKit

class GatyaScene: SKScene {
    //\(^o^)/＜オワタ
    private var counter: Int = 0
    
    
    
    
    
    //ガチャのノードを表示
    override func didMove(to view: SKView) {
        let gatyaNode = SKSpriteNode(imageNamed: "gatya")
        gatyaNode.zPosition = 2
        gatyaNode.name = "gatya1"
        
        let gatya2Node = SKSpriteNode(imageNamed: "gatya2")
        gatya2Node.zPosition = 2
        gatya2Node.name = "gatya2"
        
        let gatya3Node = SKSpriteNode(imageNamed: "gatya3")
        gatya3Node.zPosition = 1
        gatya3Node.name = "gatya3"
        
        let gatya4Node = SKSpriteNode(imageNamed: "gatya4")
        gatya4Node.zPosition = 1
        gatya4Node.name = "gatya4"
        
        let gatya6Node = SKSpriteNode(imageNamed: "gatya6")
        gatya6Node.zPosition = 2
        gatya6Node.name = "gatya6"

        
        //ノードをシーンに追加する。
        self.addChild(gatyaNode)
        self.addChild(gatya2Node)
        self.addChild(gatya3Node)
        self.addChild(gatya4Node)
        self.addChild(gatya6Node)
        //座標指定
        gatyaNode.position = CGPoint(x: 0, y: -80)
        gatya2Node.position = CGPoint(x: -67.5, y: -165)
        gatya3Node.position = CGPoint(x: 0, y: 65)
        gatya4Node.position = CGPoint(x: 0, y: -110)
        gatya6Node.position = CGPoint(x: 0, y: 140)
        
        

    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        for touch in touches {
            let location = touch.location(in: self)
            
            // どのnodeが触られたかを検出
            let node = self.atPoint(location)
            
            print("■\(node)")
            
            //nodeの名前を取り出してる
            if let name = node.name {
                if name == "gatya1" {
                    print("押されたお〜")
                    //let action = SKAction.rotate(toAngle: CGFloat(M_PI_2), duration: 1.0)
                    let action = SKAction.rotate(byAngle: -CGFloat(M_PI * 2), duration: 1.0)
                    node.run(action)
                    
                    // 一回目のタップなら（＝counterが０なら）
                    if counter == 0 {
                        counter = counter + 1
                                //玉のノードを表示する
                        let tamaNode = SKSpriteNode(imageNamed: "tama")
                        tamaNode.zPosition = 3
                        tamaNode.name = "tama"
                        //玉のノードをシーンに追加する。
                        self.addChild(tamaNode)
                        //玉の座標指定
                        tamaNode.position = CGPoint(x: -67.5, y: -165)
                        //↓ここで小さくしている。
                        let syukusyouaction = SKAction.scale(to: 0.1, duration: 0)
                        tamaNode.run(syukusyouaction)
                        //↓ここで大きくしている。
                        let kakudaiaction = SKAction.scale(by: 5.0, duration: 1)
                        tamaNode.run(kakudaiaction)
                        
                    }
                }
                
                
                if name == "tama" {
                    print("押されたyo!")
                    let scene = KeihinScene(size: self.scene!.size)
                    //scene.scaleMode = .aspectFill
                    scene.anchorPoint = CGPoint(x: 0.5, y: 0.5)
                    
                    self.view!.presentScene(scene)
                    
                }
            }
        }
    }
}




























































































































































