//
//  GameViewController.swift
//  Kesiiku
//
//  Created by mesuki on 2016/11/01.
//  Copyright © 2016年 mesuki. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            
            //if let scene = SKScene(fileNamed: "DanmakuScene") as? DanmakuScene {
            if let scene = SKScene(fileNamed: "GameScene") as? GameScene {
            //if let scene = SKScene(fileNamed: "presentingViewController") as? ButurisentouScene {

                // Set the scale mode to scale to fit the window
                //scene.scaleMode = .aspectFill
                
                scene.presentingViewController = self
                
                // Present the scene
                view.presentScene(scene)
            }
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
