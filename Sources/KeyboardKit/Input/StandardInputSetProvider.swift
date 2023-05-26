//
//  StandardInputSetProvider.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-12-01.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This input set provider is initialized with a collection of
 localized providers and will use the provider with the same
 locale as the context.
 */
open class StandardInputSetProvider: InputSetProvider {
    
    /**
     Create a standard provider.
     
     Injecting a context and not a locale keeps the provider
     dynamic when the context changes language.
     
      - Parameters:
        - context: The keyboard context to use.
        - providers: The action providers to use.
     */
    public init(
        context: KeyboardContext,
        providers: [LocalizedInputSetProvider] = [EnglishInputSetProvider()]
    ) {
        self.context = context
        let dict = Dictionary(uniqueKeysWithValues: providers.map { ($0.localeKey, $0) })
        providerDictionary = LocaleDictionary(dict)
    }
    
    private let context: KeyboardContext
    
    /**
     This is used to resolve the a provider for the context.
     */
    public var providerDictionary: LocaleDictionary<InputSetProvider>
    
    /**
     Get the provider to use, given the provided context.
     */
    open func provider(for context: KeyboardContext) -> InputSetProvider {
        providerDictionary.value(for: context.locale) ?? EnglishInputSetProvider()
    }
    
    /**
     The input set to use for alphabetic keyboards.
     */
    open var alphabeticInputSet: AlphabeticInputSet {
        provider(for: context).alphabeticInputSet
    }
    
    /**
     The input set to use for numeric keyboards.
     */
    open var numericInputSet: NumericInputSet {
        provider(for: context).numericInputSet
    }
    
    /**
     The input set to use for symbolic keyboards.
     */
    open var symbolicInputSet: SymbolicInputSet {
        provider(for: context).symbolicInputSet
    }
}
