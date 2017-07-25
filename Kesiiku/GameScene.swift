//
//  GameScene.swift
//  Kesiiku
//
//  Created by mesuki on 2016/11/01.
//  Copyright © 2016年 mesuki. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    weak var presentingViewController: UIViewController?
    
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    
    private var tamago : SKSpriteNode?
    
    private var counter: Int = 0
    
    
    
    override func didMove(to view: SKView) {
        
        let background = SKSpriteNode(imageNamed: "tamago")
        let tamago = SKSpriteNode(imageNamed: "tamago")
        //let bird = SKSpriteNode(imageNamed: "tamago")
        
        self.addChild(tamago)
        //self.addChild(tamago)
        //self.addChild(tamago)
        
        self.tamago = tamago
        
        
        // BGMを、登録して再生
        let audioNode = SKAudioNode(fileNamed: ".mp3")
        self.addChild(audioNode)
        
        background.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        tamago .position =  CGPoint(x: self.frame.width/12, y: self.frame.height/14)
        //bird.position = CGPoint(x: self.frame.width*2/3, y: self.frame.height*3/5)
        
        
        // Get label node from scene and store it for use later
       // self.label = self.childNode(withName: "//helloLabel") as? SKLabelNode
        //if let label = self.label {
          //  label.alpha = 0.0
            //label.run(SKAction.fadeIn(withDuration: 2.0))
        //}
        
        // Create shape node to use during mouse interaction
        let w = (self.size.width + self.size.height) * 0.05
        self.spinnyNode = SKShapeNode.init(rectOf: CGSize.init(width: w, height: w), cornerRadius: w * 0.3)
        
        if let spinnyNode = self.spinnyNode {
            spinnyNode.lineWidth = 2.5
            
            spinnyNode.run(SKAction.repeatForever(SKAction.rotate(byAngle: CGFloat(M_PI), duration: 1)))
            spinnyNode.run(SKAction.sequence([SKAction.wait(forDuration: 0.5),
                                              SKAction.fadeOut(withDuration: 0.5),
                                              SKAction.removeFromParent()]))
        }
    }
    
    
    func touchDown(atPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.green
            self.addChild(n)
        }
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.blue
            self.addChild(n)
        }
    }
    
    func touchUp(atPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.red
            self.addChild(n)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        counter = counter + 1
        print ("クリックされた数:　\(counter)")
    
        if let tamago = self.tamago {
            tamago.run(SKAction.init(named: "Pulse")!, withKey: "fadeInOut")
        }
        
        if counter == 5 {
            if let tamago = self.tamago {
                tamago.texture = SKTexture(imageNamed:"tamago2")
            }
        }
        
        if counter == 10 {
            if let tamago = self.tamago {
                tamago.texture = SKTexture(imageNamed:"tamago3")
                
                
            }
        }
        
        if counter == 15 {
            if let tamago = self.tamago {
                tamago.texture = SKTexture(imageNamed:"tamago4")
            }
        }
       
    
        if counter == 20 {
            if let tamago = self.tamago {
                tamago.texture = SKTexture(imageNamed:"tamago5")
                
                // 5になった時BGM（ラッパの音）を、鳴らす　これ↓
                 let action = SKAction.playSoundFileNamed("trumpet1.mp3", waitForCompletion: true)
                 self.run(action)
                
            }
        }

        if counter == 21 {
            if let tamago = self.tamago {
                tamago.texture = SKTexture(imageNamed:"kesigomu")
            }
            
            // タッチを検出したときにRoomSceneを呼び出す
            let scene = RoomScene(size: self.scene!.size)
            scene.scaleMode = .aspectFill
            scene.presentingViewController = self.presentingViewController
            self.view!.presentScene(scene)
            
        }
        
        
        
       // if let label = self.label {
        //    label.run(SKAction.init(named: "Pulse")!, withKey: "fadeInOut")
        //}
        
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}

























