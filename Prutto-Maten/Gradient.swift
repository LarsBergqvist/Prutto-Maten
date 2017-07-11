import Foundation
import SpriteKit


class Gradient: SKScene {
    
    class func drawGradientImage(_ size: CGSize) -> UIImage {
        
        let bounds = CGRect(origin: CGPoint.zero, size: size)
        let opaque = false
        let scale: CGFloat = 0
        UIGraphicsBeginImageContextWithOptions(size, opaque, scale)
        let context = UIGraphicsGetCurrentContext()
        
        let topColour = UIColor(red:0.450, green:0.650, blue:0.900, alpha:1.000)
        let midColour = UIColor(red:0.610, green:0.852, blue:0.900, alpha:1.000)
        let bottomColour = UIColor(red:0.000, green:0.402, blue:0.900, alpha:1.000)
        
        let gradientColours: [CGColor] = [topColour.cgColor, midColour.cgColor, bottomColour.cgColor]
        
        let gradientLocations: [CGFloat] = [0.0, 0.5, 1.0]
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        
        let gradient = CGGradient(
            colorsSpace: colorSpace,
            colors: gradientColours as CFArray,
            locations: gradientLocations)
        
        let gradientLayer: CAGradientLayer = CAGradientLayer()
        gradientLayer.colors = gradientColours
        gradientLayer.locations = gradientLocations as [NSNumber]
        
        let topPoint = CGPoint(x: bounds.width/2, y: bounds.height)
        let bottomPoint = CGPoint(x: bounds.width/2, y: 0)
        
        context?.drawLinearGradient(gradient!, start: bottomPoint, end: topPoint, options: CGGradientDrawingOptions.drawsAfterEndLocation)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image!
    }
    
    class func getBackgroundSprite(_ frame:CGRect) -> SKSpriteNode {
        let imageSize = CGSize(width: frame.size.width, height: frame.size.height)
        let imageView = UIImageView(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: imageSize))
        
        let imageGradient = drawGradientImage(imageSize)
        imageView.image = imageGradient
        
        let gradBack = SKTexture(image: imageGradient)
        
        let background = SKSpriteNode(texture: gradBack)
        
        background.zPosition = 0
        background.position = CGPoint(x: frame.midX, y: frame.midY)
        
        return background
    }
    
    
}

    
