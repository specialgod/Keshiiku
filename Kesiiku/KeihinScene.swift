//
//  KeihinScene.swift
//  Kesiiku
//
//  Created by mesuki on 2017/05/02.
//  Copyright © 2017年 mesuki. All rights reserved.
//

import SpriteKit

class KeihinScene: SKScene {
    
    
    
    
    //変数の家(√・∇・√)＜楽しいよ！
    
    
    // ディドゥムーブトゥビュー↓
    override func didMove(to view: SKView) {
        // 景品のノードを表示
        var keihinnNode = SKSpriteNode(imageNamed: "keihinn1")
        keihinnNode.zPosition = 1
        keihinnNode.name = "keihinn1"
        
        // ランダムに数字を得る
        let random = arc4random_uniform(5)
        
        
        // ランダムになるようにしてる。
        if random == 0 {
            // 何もしない
        } else if random == 1 {
            keihinnNode = SKSpriteNode(imageNamed: "keihinn2")
            keihinnNode.zPosition = 1
            keihinnNode.name = "keihinn2"

        } else if random == 2{
            keihinnNode = SKSpriteNode(imageNamed: "keihinn3")
            keihinnNode.zPosition = 1
            keihinnNode.name = "keihinn3"
            
        } else if random == 3{
            keihinnNode = SKSpriteNode(imageNamed: "keihinn4")
            keihinnNode.zPosition = 1
            keihinnNode.name = "keihinn4"

        } else if random == 4{
            keihinnNode = SKSpriteNode(imageNamed: "keihinn5")
            keihinnNode.zPosition = 1
            keihinnNode.name = "keihinn5"
        }
        
        // 表示
        self.addChild(keihinnNode)
        
        
        if let emitternode = SKEmitterNode(fileNamed: "KeihinParticle.sks"){
            //ここで爆発を出している。↓
            emitternode.particlePosition = keihinnNode.position
            emitternode.zPosition = 2
            //パーティクルを追加している。
            self.addChild(emitternode)
            //2秒後にパーティクルを削除している。
            self.run(SKAction.wait(forDuration: 2), completion: {
                emitternode.removeFromParent()
            })
            // 3秒後に処理
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                //ここでRoomを呼び出している
                let scene = RoomScene(size: self.scene!.size)
                scene.hajimetekitaFlag = false
                scene.scaleMode = .aspectFill
                self.view!.presentScene(scene)
            }

        }
    }
}
