//
//  KeyboardCasing.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-07-04.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This enum lists the various shift states a keyboard can use.
 */
public enum KeyboardCasing: String, Codable, Identifiable {
    
    /**
     `.auto` is a transient state, that means that it should
     automatically be replaced by another case.
     */
    case auto
    
    /**
     `.capsLocked` is an uppercased state that should not be
     automatically adjusted when typing.
     */
    case capsLocked
    
    /**
     `.lowercased` should follow the `autocapitalization` of
     the text document proxy.
     */
    case lowercased
    
    /**
     `.uppercased` should follow the `autocapitalization` of
     the text document proxy.
     */
    case uppercased
}

public extension KeyboardCasing {
    
    /**
     The casing's unique identifier.
     */
    var id: String { rawValue }
    
    /**
     Whether or not the casing represents a lowercased case.
     */
    var isLowercased: Bool {
        switch self {
        case .auto: return false
        case .capsLocked: return false
        case .lowercased: return true
        case .uppercased: return false
        }
    }
    
    /**
     Whether or not the casing represents an uppercased case.
     */
    var isUppercased: Bool {
        switch self {
        case .auto: return false
        case .capsLocked: return true
        case .lowercased: return false
        case .uppercased: return true
        }
    }
}
