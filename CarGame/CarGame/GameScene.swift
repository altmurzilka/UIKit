//
//  GameScene.swift
//  CarGame
//
//  Created by Алтын on 10/12/20.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var leftCar = SKSpriteNode()
    var rightCar = SKSpriteNode()
    
    var canMove = false
    var leftToMoveLeft = true
    var rightToMovRight = true
    
    var leftCarAtRight = false
    var righttCarAtLeft = false
    var centerPoint : CGFloat!
    
    let leftCarMinimumX : CGFloat = -200
    let leftCarMaximumX : CGFloat = -100
    
    let rightCarMinimumX : CGFloat = 100
    let rightCarMaximumX : CGFloat = 280
    
    override func didMove(to view: SKView) {
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        setUp()
        Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(GameScene.createRoadStrip), userInfo: nil, repeats: true)
    }
    
    override func update(_ currentTime: TimeInterval) {
        if canMove {
            move(leftSide: leftToMoveLeft)
            moveRightCar(rightSide: rightToMovRight)
        }
        showRoadStrip()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let touchLocation = touch.location(in: self)
            if (touchLocation.x > centerPoint) {
                if righttCarAtLeft {
                    righttCarAtLeft = false
                    rightToMovRight = true
                } else {
                    righttCarAtLeft = true
                    rightToMovRight = false
                }
            } else {
                if leftCarAtRight {
                    leftCarAtRight = false
                    leftToMoveLeft = true
                } else {
                    leftCarAtRight = true
                    leftToMoveLeft = false
                }
            }
            canMove = true
        }
    }
    
    func setUp() {
        leftCar = self.childNode(withName: "leftCar") as! SKSpriteNode
        rightCar = self.childNode(withName: "rightCar") as! SKSpriteNode
        centerPoint = self.frame.size.width / self.frame.size.height
    }
    
    @objc func createRoadStrip() {
        let leftRoadStrip = SKShapeNode(rectOf: CGSize(width: 10, height: 40))
        leftRoadStrip.strokeColor = SKColor.white
        leftRoadStrip.fillColor = SKColor.white
        leftRoadStrip.alpha = 0.4
        leftRoadStrip.name = "leftRoadStrip"
        leftRoadStrip.zPosition = 10
        leftRoadStrip.position.x = -187.5
        leftRoadStrip.position.y = 700
        addChild(leftRoadStrip)
        
        let rightRoadStrip = SKShapeNode(rectOf: CGSize(width: 10, height: 40))
        rightRoadStrip.strokeColor = SKColor.white
        rightRoadStrip.fillColor = SKColor.white
        rightRoadStrip.alpha = 0.4
        rightRoadStrip.name = "rightRoadStrip"
        rightRoadStrip.zPosition = 10
        rightRoadStrip.position.x = 187.5
        rightRoadStrip.position.y = 700
        addChild(rightRoadStrip)
    }
    
    func showRoadStrip() {
        enumerateChildNodes(withName: "leftRoadStrip") { (roadStrip, stop) in
            let strip = roadStrip as! SKShapeNode
            strip.position.y -= 30
        }
        
        enumerateChildNodes(withName: "rightRoadStrip") { (roadStrip, stop) in
            let strip = roadStrip as! SKShapeNode
            strip.position.y -= 30
        }
    }
    
    func removeItems() {
        for child in children {
            if child.position.y < -self.size.height - 100 {
                child.removeFromParent()
            }
        }
    }
    
    func move(leftSide: Bool) {
        if leftSide {
            leftCar.position.x -= 20
            if leftCar.position.x < leftCarMinimumX {
                leftCar.position.x = leftCarMinimumX
            }
        } else {
            leftCar.position.x += 20
            if leftCar.position.x > leftCarMaximumX {
                leftCar.position.x = leftCarMaximumX
            }
        }
    }
    
    func moveRightCar(rightSide: Bool) {
        if rightSide {
            rightCar.position.x += 20
            if rightCar.position.x > rightCarMaximumX {
                rightCar.position.x = rightCarMaximumX
            }
        } else {
            rightCar.position.x -= 20
            if rightCar.position.x < rightCarMinimumX {
                rightCar.position.x = rightCarMinimumX
            }
        }
    }
    
    func leftTraffic() {
        let leftTrafficItem : SKSpriteNode!
        let randomNumber = Helper().randomBetweenTwoNumbers(firstNumber: 1, secondNumber: 8)
        switch Int(randomNumber) {
        case 1...4:
            leftTrafficItem = SKSpriteNode(imageNamed: "redCar")
            leftTrafficItem.name = "redCar"
            break
        case 5...8:
            leftTrafficItem = SKSpriteNode(imageNamed: "blueCar")
            leftTrafficItem.name = "blueCar"
            break
        default:
            leftTrafficItem = SKSpriteNode(imageNamed: "redCar")
            leftTrafficItem.name = "redCar"
        }
    }
}
