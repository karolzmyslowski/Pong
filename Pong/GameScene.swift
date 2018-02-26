//
//  GameScene.swift
//  Pong
//
//  Created by Karol Zmyslowski on 26.02.2018.
//  Copyright © 2018 Karol Zmyslowski. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var ball = SKSpriteNode()
    var enemy = SKSpriteNode()
    var main = SKSpriteNode()
    var score = [Int]()
    
    var topLabel = SKLabelNode()
    var botLabel = SKLabelNode()
    override func didMove(to view: SKView) {
        startGame()
        
        ball = self.childNode(withName: "ball") as! SKSpriteNode
        enemy = self.childNode(withName: "enemy") as! SKSpriteNode
        main = self.childNode(withName: "main") as! SKSpriteNode
        topLabel = self.childNode(withName: "toplabel") as! SKLabelNode
        botLabel = self.childNode(withName: "botlabel") as! SKLabelNode
        
        ball.physicsBody?.applyImpulse(CGVector(dx: 20, dy: 20))
        let border = SKPhysicsBody(edgeLoopFrom: self.frame)
        border.friction = 0
        border.restitution = 1
        
        self.physicsBody = border
    }
    
    func startGame() {
        score = [0,0]
        topLabel.text = "\(score[1])"
        botLabel.text = "\(score[0])"
    }
    
    func addScore(playerWhoWon: SKSpriteNode) {
        ball.position = CGPoint(x: 0, y: 0)
        ball.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        if playerWhoWon == main {
            score[0] += 1
            ball.physicsBody?.applyImpulse(CGVector(dx: 20, dy: 20))

        } else if playerWhoWon == enemy {
            score[1] += 1
            ball.physicsBody?.applyImpulse(CGVector(dx: -20, dy: -20))

        }
        topLabel.text = "\(score[1])"
        botLabel.text = "\(score[0])"
    }
    
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
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        enemy.run(SKAction.moveTo(x: ball.position.x, duration: 1))
        
        if ball.position.y <= main.position.y - 10 {
            addScore(playerWhoWon: enemy)
        } else if ball.position.y >= enemy.position.y + 10 {
            addScore(playerWhoWon: main)
        }

        
    }
    
}





