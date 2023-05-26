//
//  GestureButtonDefaults.swift
//  SwiftUIKit
//
//  Created by Daniel Saidi on 2022-11-24.
//  Copyright © 2022 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This struct can be used to configure default values for the
 ``GestureButton`` and ``ScrollViewGestureButton`` views.
 */
@available(iOS 14.0, macOS 11.0, watchOS 8.0, *)
public struct GestureButtonDefaults {

    /// The max time between two taps for them to count as a double tap, by default `0.2`.
    public static var doubleTapTimeout = 0.2

    /// The time it takes for a press to count as a long press, by default `1.0`.
    public static var longPressDelay = 1.0

    /// The time it takes for a press to count as a repeat trigger, by default `1.0`.
    public static var repeatDelay = 1.0
}
