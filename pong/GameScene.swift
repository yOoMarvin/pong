//
//  GameScene.swift
//  pong
//
//  Created by Marvin Messenzehl on 09.02.17.
//  Copyright © 2017 Marvin Messenzehl. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var ball = SKSpriteNode()
    var enemy = SKSpriteNode()
    var main = SKSpriteNode()
    
    var topLabel = SKLabelNode()
    var btmLabel = SKLabelNode()
    
    var score = [Int]()
    
    
    
    override func didMove(to view: SKView) {
        
        startGame()
        
        topLabel = self.childNode(withName: "topLabel") as! SKLabelNode
        btmLabel = self.childNode(withName: "btmLabel") as! SKLabelNode
        
        ball = self.childNode(withName: "ball") as! SKSpriteNode
        enemy = self.childNode(withName: "enemy") as! SKSpriteNode
        main = self.childNode(withName: "main") as! SKSpriteNode
        
        ball.physicsBody?.applyImpulse(CGVector(dx: 20, dy: 20))
        
        //border for scene
        let border = SKPhysicsBody(edgeLoopFrom: self.frame)
        border.friction = 0
        border.restitution = 1
        self.physicsBody = border
        
    }
    
    
    
    
    func startGame() {
        score = [0,0]
        topLabel.text = "\(score[1])"
        btmLabel.text = "\(score[0])"
    }
    
    
    
    
    
    func addScore(playerWhoWon: SKSpriteNode) {
        
        ball.position = CGPoint(x:0, y:0)
        ball.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        
        if playerWhoWon == main {
            score[0] += 1
            ball.physicsBody?.applyImpulse(CGVector(dx: 20, dy: 20))
            
        } else if playerWhoWon == enemy {
            score[1] += 1
            ball.physicsBody?.applyImpulse(CGVector(dx: -20, dy: -20))
        }
        
        //new score values for labels
        topLabel.text = "\(score[1])"
        btmLabel.text = "\(score[0])"
    }
    
    
    
    
    //MARK : - react to user touches
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            let location = touch.location(in: self)
            
            main.run(SKAction.moveTo(x: location.x, duration: 0.2))
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            let location = touch.location(in: self)
            
            main.run(SKAction.moveTo(x: location.x, duration: 0.2))
        }
    }
    
    
    //MARK: - update function
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        enemy.run(SKAction.moveTo(x: ball.position.x, duration: 1.0))
        
        if ball.position.y <= main.position.y - 70 {
            addScore(playerWhoWon: enemy)
            
        }else if ball.position.y >= enemy.position.y + 70 {
            addScore(playerWhoWon: main)
        }
    }
}
