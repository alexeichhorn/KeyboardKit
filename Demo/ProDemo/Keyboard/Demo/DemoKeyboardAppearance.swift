//
//  DemoKeyboardAppearance.swift
//  Keyboard
//
//  Created by Daniel Saidi on 2021-10-06.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import KeyboardKitPro
import SwiftUI

/**
 This demo-specific appearance inherits the standard one and
 can be used to easily customize the demo keyboard.

 This appearance is registered by ``KeyboardViewController``
 to show you how to register a custom appearance then use it
 to customize how the keyboard looks.
 */
class DemoKeyboardAppearance: StandardKeyboardAppearance {
    
    override func actionCalloutStyle() -> ActionCalloutStyle {
        let style = super.actionCalloutStyle()
        // style.callout.backgroundColor = .red
        return style
    }
    
    override func buttonImage(for action: KeyboardAction) -> Image? {
        super.buttonImage(for: action)
    }
    
    override func buttonStyle(
        for action: KeyboardAction,
        isPressed: Bool) -> KeyboardButtonStyle {
        let style = super.buttonStyle(for: action, isPressed: isPressed)
        // style.cornerRadius = 10
        return style
    }
    
    override func buttonText(for action: KeyboardAction) -> String? {
        super.buttonText(for: action)
    }
    
    override func inputCalloutStyle() -> InputCalloutStyle {
        let style = super.inputCalloutStyle()
        // style.callout.backgroundColor = .red
        return style
    }
}
