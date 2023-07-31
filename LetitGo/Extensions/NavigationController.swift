//
//  NavigationController.swift
//  LetitGo
//
//  Created by Амир Кайдаров on 7/30/23.
//

import SwiftUI

extension UINavigationController {
    
    override open func viewDidLoad() {
        
        super.viewDidLoad()
        
        let gradient = CAGradientLayer()
        
        gradient.frame = self.view.bounds
        gradient.colors = [UIColor(Color.purple).cgColor,
                           UIColor(Color.blue).cgColor]
        gradient.startPoint = CGPoint(x: 0.0, y: 0.4)
        gradient.endPoint = CGPoint(x: 1.0, y: 0.5)
        
        let standard = UINavigationBarAppearance()
        standard.backgroundImage = gradient.toImage()
        standard.titleTextAttributes = [.foregroundColor: UIColor.white]

        let compact = UINavigationBarAppearance()
        compact.backgroundImage = gradient.toImage()
        compact.titleTextAttributes = [.foregroundColor: UIColor.white]

        let scrollEdge = UINavigationBarAppearance()
        scrollEdge.backgroundImage = gradient.toImage()
        scrollEdge.titleTextAttributes = [.foregroundColor: UIColor.white]

        self.navigationBar.standardAppearance = standard
        self.navigationBar.compactAppearance = compact
        self.navigationBar.scrollEdgeAppearance = scrollEdge
        
    }
    
}

extension CALayer {

    func toImage() -> UIImage {
        UIGraphicsBeginImageContext(self.frame.size)
        self.render(in: UIGraphicsGetCurrentContext()!)
        let outputImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return outputImage!
    }
    
}
