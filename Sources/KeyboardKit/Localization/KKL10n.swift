//
//  KKL10n.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-02-25.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 This enum defines keyboard-specific, localized texts.
 */
public enum KKL10n: String, CaseIterable, Identifiable {

    case
        done,
        go,
        ok,
        `return`,
        search,
        space,
    
        keyboardTypeAlphabetic,
        keyboardTypeNumeric,
        keyboardTypeSymbolic
}

public extension KKL10n {

    /**
     The bundle to use to retrieve localized strings.

     You should only override this value when the entire set
     of localized texts should be loaded from another bundle.
     */
    static var bundle: Bundle = .keyboardKit
}

public extension KKL10n {
    
    /**
     The item's unique identifier.
     */
    var id: String { rawValue }
    
    /**
     The item's localization key.
     */
    var key: String { rawValue }
    
    /**
     The item's localized text.
     */
    var text: String {
        NSLocalizedString(key, bundle: Self.bundle, comment: "")
    }

    /**
     Whether or not the KKL10n case has been localized for a
     certain `locale`.
     */
    func hasText(for locale: KeyboardLocale) -> Bool {
        text(for: locale.locale) != rawValue
    }
    
    /**
     The item's localized text for a certain `context`.
     */
    func text(for context: KeyboardContext) -> String {
        text(for: context.locale)
    }
    
    /**
     The item's localized text for a certain `locale`.
     */
    func text(for locale: KeyboardLocale) -> String {
        text(for: locale.locale)
    }
    
    /**
     The item's localized text for a certain `locale`.
     */
    func text(for locale: Locale) -> String {
        guard
            let bundlePath = Self.bundle.bundlePath(for: locale),
            let bundle = Bundle(path: bundlePath)
        else { return "" }
        return NSLocalizedString(key, bundle: bundle, comment: "")
    }
}

extension Bundle {
    
    func bundlePath(for locale: Locale) -> String? {
        bundlePath(named: locale.identifier) ?? bundlePath(named: locale.languageCode)
    }
    
    func bundlePath(named name: String?) -> String? {
        path(forResource: name ?? "", ofType: "lproj")
    }
}

#if os(iOS) || os(tvOS)
struct KKL10n_Previews: PreviewProvider {
    
    static let context: KeyboardContext = {
        let context = KeyboardContext.preview
        context.locale = KeyboardLocale.swedish.locale
        return context
    }()
    
    static var previews: some View {
        NavigationView {
            List {
                ForEach(KKL10n.allCases) { item in
                    VStack(alignment: .leading, spacing: 10) {
                        Text("\(item.key)")
                        VStack(alignment: .leading) {
                            Text("Locale: \(item.text(for: context))")
                            ForEach(KeyboardLocale.allCases) {
                                Text("\($0.id): \(item.text(for: $0))")
                            }
                        }.font(.footnote)
                    }.padding(.vertical, 4)
                }
            }.navigationBarTitle("Translations")
        }
    }
}
#endif
