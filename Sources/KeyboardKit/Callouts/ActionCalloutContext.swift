//
//  ActionCalloutContext.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-01-06.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 This context can be used to handle callouts that show a set
 of alternate actions for a certain keyboard action.
 
 The context will automatically dismiss itself when the user
 ends the callout gesture or drags too far down.
  
 You can inherit this class and override any open properties
 and functions to customize the standard behavior.
 
 KeyboardKit automatically creates an instance of this class
 and binds it to the ``KeyboardInputViewController``.
 */
open class ActionCalloutContext: ObservableObject {
    
    
    // MARK: - Initialization
    
    /**
     Create a new context instance,
     
     - Parameters:
       - actionHandler: The action handler to use when tapping buttons.
       - actionProvider: The action provider to use for resolving callout actions.
     */
    public init(
        actionHandler: KeyboardActionHandler,
        actionProvider: CalloutActionProvider) {
        self.actionHandler = actionHandler
        self.actionProvider = actionProvider
    }
    
    
    // MARK: - Dependencies
    
    public let actionHandler: KeyboardActionHandler
    public let actionProvider: CalloutActionProvider
    
    
    // MARK: - Shared
    
    /**
     The shared context is resolved by returning the context
     of ``KeyboardInputViewController/shared``.
     */
    static var shared: ActionCalloutContext? {
        #if os(iOS)
        KeyboardInputViewController.shared.actionCalloutContext
        #else
        nil
        #endif
    }
    
    
    // MARK: - Properties
    
    public static let coordinateSpace = "com.keyboardkit.coordinate.ActionCallout"
    
    /**
     Whether or not the context has a selected action.
     */
    public var hasSelectedAction: Bool { selectedAction != nil }
    
    /**
     Whether or not the context has any current actions.
     */
    public var isActive: Bool { !actions.isEmpty }
    
    /**
     Whether or not the action callout alignment is leading.
     */
    public var isLeading: Bool { !isTrailing }
    
    /**
     Whether or not the action callout alignment is trailing.
     */
    public var isTrailing: Bool { alignment == .trailing }
    
    /**
     The currently selected callout action, which updates as
     the user swipes left and right.
     */
    public var selectedAction: KeyboardAction? {
        isIndexValid(selectedIndex) ? actions[selectedIndex] : nil
    }
    
    
    // MARK: - Published Properties
    
    /**
     The action that are currently active for the context.
     */
    @Published public private(set) var actions: [KeyboardAction] = []
    
    /**
     The callout bubble alignment.
     */
    @Published public private(set) var alignment: HorizontalAlignment = .leading
    
    /**
     The frame of the currently pressed keyboard button.
     */
    @Published public private(set) var buttonFrame: CGRect = .zero
    
    /**
     The currently selected action index.
     */
    @Published public private(set) var selectedIndex: Int = -1


    // MARK: - Functions
    
    /**
     Handle the end of the drag gesture, which should commit
     the selected action and reset the context.
     */
    open func endDragGesture() {
        handleSelectedAction()
        reset()
    }
    
    /**
     Handle the selected action, if any. By default, it will
     be handled by the context's action handler.
     */
    open func handleSelectedAction() {
        guard let action = selectedAction else { return }
        actionHandler.handle(.tap, on: action, at: nil)
    }
    
    /**
     Reset the context, which will reset all state and cause
     any callouts to dismiss.
     */
    open func reset() {
        actions = []
        selectedIndex = -1
        buttonFrame = .zero
    }
    
    /**
     Trigger a haptic feedback for selection change. You can
     override this to change or disable the haptic feedback.
     */
    open func triggerHapticFeedbackForSelectionChange() {
        HapticFeedback.selectionChanged.trigger()
    }
    
    /**
     Update the input actions for a certain keyboard action.
     */
    open func updateInputs(for action: KeyboardAction?, in geo: GeometryProxy, alignment: HorizontalAlignment? = nil) {
        guard let action = action else { return reset() }
        let actions = actionProvider.calloutActions(for: action)
        self.buttonFrame = geo.frame(in: .named(Self.coordinateSpace))
        self.alignment = alignment ?? getAlignment(for: geo)
        self.actions = isLeading ? actions : actions.reversed()
        self.selectedIndex = startIndex
        guard isActive else { return }
        triggerHapticFeedbackForSelectionChange()
    }
    
    
    #if os(iOS) || os(macOS) || os(watchOS)
    /**
     Update the selected input action when a drag gesture is
     changed by a drag gesture.
     */
    open func updateSelection(with dragValue: DragGesture.Value?) {
        guard let value = dragValue, buttonFrame != .zero else { return }
        if shouldReset(for: value) { return reset() }
        guard shouldUpdateSelection(with: value) else { return }
        let translation = value.translation.width
        let standardStyle = ActionCalloutStyle.standard
        let maxButtonSize = standardStyle.maxButtonSize
        let buttonSize = buttonFrame.size.limited(to: maxButtonSize)
        let indexWidth = 0.9 * buttonSize.width
        let offset = Int(abs(translation) / indexWidth)
        let index = isLeading ? offset : actions.count - offset - 1
        let currentIndex = self.selectedIndex
        let newIndex = isIndexValid(index) ? index : startIndex
        if currentIndex != newIndex { triggerHapticFeedbackForSelectionChange() }
        self.selectedIndex = newIndex
    }
    #endif
}


// MARK: - Public functionality

public extension ActionCalloutContext {
    
    static var disabled: ActionCalloutContext {
        ActionCalloutContext(
            actionHandler: PreviewKeyboardActionHandler(),
            actionProvider: DisabledCalloutActionProvider())
    }
}


// MARK: - Private functionality

private extension ActionCalloutContext {
    
    var startIndex: Int {
        isLeading ? 0 : actions.count - 1
    }
    
    func isIndexValid(_ index: Int) -> Bool {
        index >= 0 && index < actions.count
    }
    
    func getAlignment(for geo: GeometryProxy) -> HorizontalAlignment {
        #if os(iOS)
        let center = UIScreen.main.bounds.size.width / 2
        let isTrailing = buttonFrame.origin.x > center
        return isTrailing ? .trailing : .leading
        #else
        return .leading
        #endif
    }
    
    #if os(iOS) || os(macOS) || os(watchOS)
    func shouldReset(for dragValue: DragGesture.Value) -> Bool {
        dragValue.translation.height > buttonFrame.height
    }
    
    func shouldUpdateSelection(with dragValue: DragGesture.Value) -> Bool {
        let translation = dragValue.translation.width
        if translation == 0 { return true }
        return isLeading ? translation > 0 : translation < 0
    }
    #endif
}
