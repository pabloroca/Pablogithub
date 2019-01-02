//
//  AppDelegate.swift
//  Pablogithub
//
//  Created by Pablo Roca on 26/12/2018.
//  Copyright © 2018 PR2Studio. All rights reserved.
//

import UIKit

// Sample color palette

extension UIColor {
    @nonobjc class var pr2ColorMain: UIColor {
        return UIColor(red: 84.0 / 255.0, green: 76.0 / 255.0, blue: 99.0 / 255.0, alpha: 1.0)
    }

    @nonobjc class var pr2White: UIColor {
        return UIColor(red: 255.0 / 255.0, green: 255.0 / 255.0, blue: 255.0 / 255.0, alpha: 1.0)
    }

    @nonobjc class var pr2ColorBlue: UIColor {
        return UIColor(red: 0.0 / 255.0, green: 0.0 / 255.0, blue: 255.0 / 255.0, alpha: 1.0)
    }

    @nonobjc class var pr2ColorRed: UIColor {
        return UIColor(red: 255.0 / 255.0, green: 0.0 / 255.0, blue: 0.0 / 255.0, alpha: 1.0)
    }

    @nonobjc class var pr2ColorLightGrey: UIColor {
        return UIColor(red: 226.0 / 255.0, green: 226.0 / 255.0, blue: 226.0 / 255.0, alpha: 1.0)
    }

    @nonobjc class var pr2ColorOrange: UIColor {
        return UIColor(red: 255.0 / 255.0, green: 98.0 / 255.0, blue: 0.0 / 255.0, alpha: 1.0)
    }

}

// Sample text styles

extension UIFont {
    
    class func pr2FontBig() -> UIFont {
        return UIFont.boldSystemFont(ofSize: 18)
    }

    class func pr2FontHeader() -> UIFont {
        return UIFont.boldSystemFont(ofSize: 15)
    }
    
    class func skyFontTitle() -> UIFont {
        return UIFont.systemFont(ofSize: 16)
    }

    class func pr2FontSubtitle() -> UIFont {
        return UIFont.systemFont(ofSize: 12)
    }

    class func pr2FontBottomLeft() -> UIFont {
        return UIFont.systemFont(ofSize: 10)
    }
    
}
