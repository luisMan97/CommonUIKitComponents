//
//  Workspace.swift
//  CommonUIKitComponents
//
//  Created by Jorge Luis Rivera Ladino on 27/11/22.
//

import UIKit

public enum Workspace {
    
    public static var mainScreenSize: CGSize {
        UIScreen.main.bounds.size
    }
    
    public static var mainScreenWidth: CGFloat {
        Workspace.mainScreenSize.width
    }
    
    public static var mainScreenHeight: CGFloat {
        Workspace.mainScreenSize.height
    }
    
    public static func isIphoneX() -> Bool {
        Workspace.isIphone() && UIScreen.main.bounds.size.height == 812.0
    }
    
    public static func isIphoneXOrBigger() -> Bool {
        Workspace.isIphone() && UIScreen.main.bounds.size.height >= 812.0
    }
    
    public static func isIphone() -> Bool {
        UIDevice.current.userInterfaceIdiom == .phone
    }
    
    public static func isIphone5() -> Bool {
        isIphone() && mainScreenHeight == 568.0
    }
    
    public static func isIphonePlus() -> Bool {
        isIphone() && mainScreenHeight == 736.0
    }
    
}
