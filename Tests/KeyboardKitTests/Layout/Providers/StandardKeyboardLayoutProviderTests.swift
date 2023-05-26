//
//  StandardKeyboardLayoutProviderTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-02-17.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Quick
import Nimble
import KeyboardKit

class StandardKeyboardLayoutProviderTests: QuickSpec {
    
    override func spec() {
        
        var inputSetProvider: MockInputSetProvider!
        var context: KeyboardContext!
        var provider: StandardKeyboardLayoutProvider!
        
        beforeEach {
            context = KeyboardContext()
            inputSetProvider = MockInputSetProvider()
            inputSetProvider.alphabeticInputSetValue = AlphabeticInputSet(rows: [["a", "b", "c"], ["a", "b", "c"], ["a", "b", "c"]].map(InputSetRow.init))
            inputSetProvider.numericInputSetValue = NumericInputSet(rows: [["1", "2", "3"], ["1", "2", "3"], ["1", "2", "3"]].map(InputSetRow.init))
            inputSetProvider.symbolicInputSetValue = SymbolicInputSet(rows: [[",", ".", "-"], [",", ".", "-"], [",", ".", "-"]].map(InputSetRow.init))
            provider = StandardKeyboardLayoutProvider(
                inputSetProvider: inputSetProvider,
                dictationReplacement: .primary(.go))
        }
        
        describe("keyboard layout provider for context") {
            
            it("is phone provider if context device is phone") {
                context.deviceType = .phone
                let result = provider.keyboardLayoutProvider(for: context)
                expect(result).to(be(provider.iPhoneProvider))
            }
            
            it("is pad provider if context device is pad") {
                context.deviceType = .pad
                let result = provider.keyboardLayoutProvider(for: context)
                expect(result).to(be(provider.iPadProvider))
            }
        }
        
        describe("keyboard layout for context (just testing this one)") {
            
            it("is phone layout if context device is phone") {
                context.deviceType = .phone
                let layout = provider.keyboardLayout(for: context)
                let phoneLayout = provider.iPhoneProvider.keyboardLayout(for: context)
                let padLayout = provider.iPadProvider.keyboardLayout(for: context)
                expect(layout.itemRows).to(equal(phoneLayout.itemRows))
                expect(layout.itemRows).toNot(equal(padLayout.itemRows))
            }
            
            it("is pad layout if context device is pad") {
                context.deviceType = .pad
                let layout = provider.keyboardLayout(for: context)
                let phoneLayout = provider.iPhoneProvider.keyboardLayout(for: context)
                let padLayout = provider.iPadProvider.keyboardLayout(for: context)
                expect(layout.itemRows).toNot(equal(phoneLayout.itemRows))
                expect(layout.itemRows).to(equal(padLayout.itemRows))
            }
        }
        
        describe("registering input set provider") {
            
            it("changes the provider instance for all providers") {
                let newProvider = MockInputSetProvider()
                context.deviceType = .phone
                provider.register(inputSetProvider: newProvider)
                expect(provider.inputSetProvider).toNot(be(inputSetProvider))
                expect(provider.inputSetProvider).to(be(newProvider))
                expect(provider.iPhoneProvider.inputSetProvider).to(be(newProvider))
                expect(provider.iPadProvider.inputSetProvider).to(be(newProvider))
            }
        }
    }
}
