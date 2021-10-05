//
//  AutocompleteToolbarItemBackgroundStyle.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-10-06.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 This style can be applied behind `AutocompleteToolbar` item
 views to control the color corner radius etc.
 
 You can modify the `.standard` style instance to change the
 standard, global style.
 */
public struct AutocompleteToolbarItemBackgroundStyle {
    
    /**
     Create an autocomplete toolbar item style.
     
     - Parameters:
       - color: The background color to use, by default `.white.opacity(0.5)`.
       - cornerRadius: The corner radius to use, by default `4`.
     */
    public init(
        color: Color = .white.opacity(0.5),
        cornerRadius: CGFloat = 4) {
        self.color = color
        self.cornerRadius = cornerRadius
    }
    
    /**
     The background color to use.
     */
    public let color: Color
    
    /**
     The corner radius to use.
     */
    public let cornerRadius: CGFloat
}

public extension AutocompleteToolbarItemBackgroundStyle {
    
    /**
     This standard style aims to mimic the native iOS style.
     */
    static var standard = AutocompleteToolbarItemBackgroundStyle()
}

extension AutocompleteToolbarItemBackgroundStyle {
    
    /**
     This internal style is only used in previews.
     */
    static var preview1 = AutocompleteToolbarItemBackgroundStyle(
        color: .purple.opacity(0.3),
        cornerRadius: 20)
    
    /**
     This internal style is only used in previews.
     */
    static var preview2 = AutocompleteToolbarItemBackgroundStyle(
        color: .orange.opacity(0.8),
        cornerRadius: 10)
}
