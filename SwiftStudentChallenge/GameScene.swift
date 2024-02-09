import SpriteKit
import GameplayKit

struct Bar {
    let color: UIColor
    let speed: TimeInterval
    let points: Int
}

class GameScene: SKScene {
    var spawnTimer: Timer?
    var meters : Int = 0 {
        didSet {
            updateValue(to: meters)
        }
    }
    let metersLabel = SKLabelNode(text: "M")
    let valueLabel = SKLabelNode(text: "0")
    var lastUpdateTime: TimeInterval = 0
    
    let bars = [
        Bar(color: .red, speed: 0.7, points: 5),
        Bar(color: .orange, speed: 0.8, points: 10),
        Bar(color: .yellow, speed: 0.9, points: 15)
    ]
    
    override func didMove(to view: SKView) {
        metersLabel.position = CGPoint(x: 670, y: 1270)
        metersLabel.fontName = "AppleSDGothicNeo-Bold"
        metersLabel.fontSize = 50
        addChild(metersLabel)
        
        valueLabel.position = CGPoint(x: 600, y: 1270)
        valueLabel.fontName = "AppleSDGothicNeo-Bold"
        valueLabel.fontSize = 50
        addChild(valueLabel)
        
        Spawner()
        updateValue(to: meters)
    }
    
    func updateValue(to newValue: Int) {
        valueLabel.text = "\(newValue)"
        valueLabel.position.x = metersLabel.position.x - metersLabel.frame.size.width / 2 - valueLabel.frame.size.width / 2
    }
    
    override func update(_ currentTime: TimeInterval) {
        if lastUpdateTime == 0 {
            lastUpdateTime = currentTime
        }
        
        if currentTime - lastUpdateTime > 2 {
            meters += 1
            lastUpdateTime = currentTime
        }
    }
    
    func showMessage(_ message: String, at position: CGPoint) {
        let label = SKLabelNode(text: message)
        label.fontName = "AppleSDGothicNeo-Bold"
        label.fontSize = 65
        label.position = position
        label.zRotation = CGFloat.random(in: 0..<(20 * CGFloat.pi / 180))
        label.setScale(0)
        
        addChild(label)
        

        let scaleAction = SKAction.scale(to: 1, duration: 0.3)
        let fadeOutAction = SKAction.fadeOut(withDuration: 0.5)
        let removeAction = SKAction.removeFromParent()
        let sequence = SKAction.sequence([scaleAction, fadeOutAction, removeAction])
        label.run(sequence)
    }
    
    func removeSpriteWithAnimation(sprite: SKSpriteNode) {
        let scaleAction = SKAction.scale(to: 0, duration: 0.1)
        let removeAction = SKAction.removeFromParent()
        let sequence = SKAction.sequence([scaleAction, removeAction])
        sprite.run(sequence)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)

            let nodesAtPoint = nodes(at: location)
            var spriteTouched = false
            for node in nodesAtPoint {
                if let sprite = node as? SKSpriteNode, abs(sprite.position.y - location.y) <= 25 {
                    removeSpriteWithAnimation(sprite: sprite)
                    if let points = sprite.userData?["points"] as? Int {
                        addMeters(points)
                    }
                    let messages = ["Great!", "Perfect!", "Awesome!"]
                    let message = messages.randomElement()!
                    showMessage(message, at: sprite.position)
                    spriteTouched = true
                }
            }
            if !spriteTouched {
                showMessage("Keep Going!", at: location)
            }
        }
    }
    
    func addMeters(_ points: Int) {
        if meters < 500 {
            meters += points
        }
    }
    func Spawner() {
        let interval = Double.random(in: 0.5...1.0)
        spawnTimer = Timer.scheduledTimer(timeInterval: interval, target: self, selector: #selector(instantiateBar), userInfo: nil, repeats: false)
    }

    @objc func instantiateBar() {
        let selectedBar = bars.randomElement()!

        let bar = SKShapeNode(rectOf: CGSize(width: 650, height: 100), cornerRadius: 20)
        bar.fillColor = selectedBar.color
        let texture = SKView().texture(from: bar)
        let sprite = SKSpriteNode(texture: texture)
        sprite.userData = NSMutableDictionary()
        sprite.userData?["points"] = selectedBar.points
        sprite.position = CGPoint(x: self.size.width / 2, y: self.size.height + sprite.size.height / 2)
        
        let emojiLabel = SKLabelNode(text: "🥁")
        emojiLabel.fontSize = 80
        emojiLabel.position = CGPoint.zero
        emojiLabel.position.y -= 25
        sprite.addChild(emojiLabel)
        let endY = sprite.size.height + 150
        let moveAction1 = SKAction.moveTo(y: endY, duration: selectedBar.speed)
        moveAction1.timingMode = .linear
        let moveAction2 = SKAction.moveTo(y: -sprite.size.height / 2, duration: 0.2)
        moveAction2.timingMode = .easeOut
        let removeAction = SKAction.removeFromParent()

        let scaleAction = SKAction.scale(to: 0, duration: 1.0)
        let runBlockAction = SKAction.run {
            sprite.run(scaleAction)
        }

        let sequence = SKAction.sequence([moveAction1, runBlockAction, moveAction2, removeAction])
        sprite.run(sequence)

        self.addChild(sprite)

        spawnTimer?.invalidate()
        Spawner()
    }
}
