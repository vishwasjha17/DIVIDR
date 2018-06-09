//
//  GameScene.swift
//  pushme
//
//  Created by vishwas jha on 09/06/18.
//  Copyright © 2018 vishwas jha. All rights reserved.
//

import SpriteKit


class GameScene: SKScene, SKPhysicsContactDelegate {
    
 
    var player:SKSpriteNode!
    var player2:SKSpriteNode!
    
    
    var initialplayerposition:CGPoint!
    
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first
        {
            let maximumPossibleForce = touch.maximumPossibleForce
            let force = touch.force
            let normalisedForce = force/maximumPossibleForce
            player.position.x = (self.size.width / 2) - normalisedForce * (self.size.width/2 - 25)
            player2.position.x = (self.size.width / 2) + normalisedForce * (self.size.width/2 - 25)
            
        }
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        resetPlayerPosition()
        
    }
    
    func resetPlayerPosition()
    {player.position = initialplayerposition
        player2.position = initialplayerposition
        
        
        
    }
    
    
    
    
    override func didMove(to view: SKView)
      {
         self.physicsWorld.gravity = CGVector(dx: 0, dy: 0)
         physicsWorld.contactDelegate = self
        
        addPlayer()
    
        addRow(type: RowType.twoS)
        
       }
    
    
    func addRandomRow ()
    {
        
        let randomNumber = Int(arc4random_uniform(6))
        
        switch randomNumber {
        case 0:
            addRow(type: RowType(rawValue: 0)!)
         break
        case 1:
            addRow(type: RowType(rawValue: 1)!)
            break
        case 2:
            addRow(type: RowType(rawValue: 2)!)
            break
        case 3:
            addRow(type: RowType(rawValue: 3)!)
            break
        case 4:
            addRow(type: RowType(rawValue: 4)!)
            break
        case 5:
            addRow(type: RowType(rawValue: 5)!)
            break
            
        default:
            break
        }
        
    }
    
    
    
    var lastUpdateTimeInterval = TimeInterval()
    var lastYieldTimeInterval = TimeInterval()
    
    func updateWithtimesinceLastUpdate(timeSinceLastUpdate:CFTimeInterval)
    {
        lastYieldTimeInterval += timeSinceLastUpdate
        if lastYieldTimeInterval > 0.6
        {
            lastYieldTimeInterval = 0
            addRandomRow()
        }
        
        
        
    }
    
    
    
    
    override func update(_ currentTime: TimeInterval) {
       
        var timeSinceLastUpdate = currentTime - lastUpdateTimeInterval
        lastUpdateTimeInterval = currentTime
        if timeSinceLastUpdate > 1
        {
            timeSinceLastUpdate = 1/60
            lastUpdateTimeInterval = currentTime
        }
        
        
        updateWithtimesinceLastUpdate(timeSinceLastUpdate: timeSinceLastUpdate)
        
        
        // Called before each frame is rendered
    }
    
    
    
    func didBegin(_ contact: SKPhysicsContact) {
        if contact.bodyA.node?.name == "PLAYER"
        {
            
            print("GAME OVER")
        }
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
}
