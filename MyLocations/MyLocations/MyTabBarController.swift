//
//  MyTabBarController.swift
//  MyLocations
//
//  Created by Hector Enrique Gomez Morales on 2/11/15.
//  Copyright (c) 2015 Hector Enrique Gomez Morales. All rights reserved.
//

import UIKit

class MyTabBarController: UITabBarController {
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    override func childViewControllerForStatusBarStyle() -> UIViewController? {
        return nil
    }
}