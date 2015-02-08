//
//  UIImage+Resize.swift
//  MyLocations
//
//  Created by Hector Enrique Gomez Morales on 2/7/15.
//  Copyright (c) 2015 Hector Enrique Gomez Morales. All rights reserved.
//

import UIKit

extension UIImage {
    func resizeImageWithBounds(bounds: CGSize) -> UIImage {
        let horizontalRatio = bounds.width / size.width
        let verticalRatio = bounds.height / size.height
        let ratio = min(horizontalRatio, verticalRatio)
        let newSize = CGSize(width: size.width * ratio, height: size.height * ratio)
        
        UIGraphicsBeginImageContextWithOptions(newSize, true, 0)
        drawInRect(CGRect(origin: CGPoint.zeroPoint, size: newSize))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
}
