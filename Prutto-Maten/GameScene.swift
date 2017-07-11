//
//  GameScene.swift
//  MaxFart
//
//  Created by Lars Bergqvist on 2015-09-07.
//  Copyright (c) 2015 Lars Bergqvist. All rights reserved.
//

import SpriteKit
import AVFoundation

class GameScene: SKScene, AVAudioPlayerDelegate {
    let pointsLabel = SKLabelNode(fontNamed:"Chalkduster")
    var points = 0
    var sprite = SKSpriteNode(imageNamed:"Poop")
    
    override func didMove(to view: SKView) {
        /* Setup your scene here */
        self.addChild(Gradient.getBackgroundSprite(self.frame))

        pointsLabel.fontSize = 100
        pointsLabel.position = CGPoint(x:self.frame.midX, y:self.frame.midY-250)
        pointsLabel.zPosition = 5
        self.addChild(pointsLabel)
        
        
        sprite = SKSpriteNode(imageNamed:"Poop")
        sprite.zPosition = 10
        setSpriteTexture("Poop")
        sprite.physicsBody = SKPhysicsBody( circleOfRadius: 100)
        sprite.physicsBody?.allowsRotation = false
        sprite.physicsBody?.isDynamic = true
        sprite.physicsBody?.mass = 1
        sprite.physicsBody?.friction = 1
        
        self.physicsWorld.gravity = CGVector(dx: 0, dy: -9.8)
        let physicsBody = SKPhysicsBody(edgeLoopFrom: CGRect(x: 0, y: self.frame.height/2-100, width: self.frame.width,height: self.frame.height/2))
        self.physicsBody = physicsBody
        self.name = "edge"
        
        sprite.xScale = 1.0
        sprite.yScale = 1.0
        sprite.position = CGPoint(x:self.frame.midX, y:self.frame.midY)
        self.addChild(sprite)
        
        updatePointsLabel()
        
    }
    
    var hasPressed = false
    
    func setSpriteTexture(_ textureName:String) {
        sprite.texture? = SKTexture(imageNamed: textureName)
    }
    
    var nextSound:UInt32 = 1

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        /* Called when a touch begins */
        
        for touch in (touches ) {
            let location = touch.location(in: self)
            
            if (sprite.frame.contains(location)) {
                hasPressed = true
                
            }
        }
        
    }
    
    func animateSprite() -> Void {
        let impSize = 800*soundlengths[Int(nextSound)]
        sprite.physicsBody?.applyImpulse(CGVector(dx: 0, dy: CGFloat(impSize)))
    }
    
    
    
    let sounds = ["f1","f3","f4","f5","f6","f7","f8","f9","f10","f11","f12"]
    let soundlengths = [1,3,1,2,1,1,1,3,1,2,2]
    
    var beepPlayer = AVAudioPlayer()
    
    var avPlayer = AVAudioPlayer()
    
    func playMySound(){
        let s = sounds[Int(nextSound)]
        let url = URL(fileURLWithPath: Bundle.main.path(forResource: s, ofType: "wav")!)
        
        do {
            avPlayer = try AVAudioPlayer(contentsOf: url)
            avPlayer.prepareToPlay()
            avPlayer.play()
            avPlayer.delegate = self
        }
        catch _ {
            
        }
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        setSpriteTexture("Poop")
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {

    }
    
    func updatePointsLabel() -> Void {
        pointsLabel.text = "\(points)"
    }
    
    func increaseValue() -> Void {
        points += 1
        updatePointsLabel()
    }
    
    override func update(_ currentTime: TimeInterval) {
        /* Called before each frame is rendered */
        if (hasPressed){
            nextSound = arc4random_uniform(UInt32(sounds.count))
            increaseValue()
            playMySound()
            animateSprite()
            setSpriteTexture("Poop2")
            hasPressed = false
        }

    }
}
