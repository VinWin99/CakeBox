//
//  SupportLogic.swift
//  CakeBox
//
//  Created by Krish Kalai on 5/21/19.
//  Copyright © 2019 Vineet Ramisetty, Krish Kalai. All rights reserved.
//

import Foundation
import UIKit

class SupportLogic {
    static let logicInstance:SupportLogic = SupportLogic()
    
    private init() { }
    
    /**
     * Get an UIImageView composing an UIImage with
     * dimentions retaining the aspect ratio of the
     * original image.
     - Parameters:
     * imageName: The image to contain.
     * boundingDimension: A CGFloat of a size to bind the UIImageView.
     *                    This will always be bounded to the portrait width
     - Returns:
     * An UIImage with the correct dimensions and the correct aspect ratio.
     */
    func getImageView(image: UIImage,
                      origin: CGPoint,
                      boundingDimension: CGFloat) -> UIImageView {
        let imageView = UIImageView(image: image)
        
        // img.h / img.w = view.h / view.w -> view.h = img.h * view.w / view.h
        let height = image.size.height * boundingDimension / image.size.width
        imageView.frame = CGRect(origin: origin,
                                 size: CGSize(width: boundingDimension,
                                              height: height))
        return imageView
    }
}
