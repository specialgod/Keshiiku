//
//  GaugeNode.swift
//  Kesiiku
//
//  Created by mesuki on H29/02/28.
//  Copyright © 平成29年 mesuki. All rights reserved.
//

import SpriteKit

class GaugeNode: SKCropNode {
    
    // 変数
    var 初期値 = 0
    
    var hp = 0
    
    
    override init() {
        super.init()
        
        let gaugeNode = SKSpriteNode(imageNamed: "gauge")
        gaugeNode.anchorPoint = CGPoint(x: 0, y: 0)
        
        let maskNode = SKSpriteNode(color: SKColor.black, size: gaugeNode.size)
        maskNode.anchorPoint = CGPoint(x: 0, y: 0)
        self.maskNode = maskNode
        
        self.addChild(gaugeNode)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    func 初期値設定(hp: Int) {
        self.maskNode?.xScale = 1
        self.初期値 = hp
        self.hp = hp
    }
    
    func ダメージ(d: Int) {
        // 100 - 30 = 70
        self.hp = self.hp - d
        
        // 70 ÷ 100 = 0.7
        self.maskNode?.xScale = CGFloat(self.hp) / CGFloat(self.初期値)
    }
    
    
}
