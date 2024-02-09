import SwiftUI
import SpriteKit

struct GameView: View {
    var scene: SKScene {
        let scene = SKScene(fileNamed: "GameScene")
        scene?.scaleMode = .fill
        return scene!
    }

    var body: some View {
        SpriteView(scene: scene).edgesIgnoringSafeArea(.all)
    }
}
