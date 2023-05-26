import Foundation

@available(*, deprecated, renamed: "HapticFeedbackEngine")
public typealias HapticFeedbackPlayer = HapticFeedbackEngine

#if os(iOS)
@available(*, deprecated, renamed: "StandardHapticFeedbackEngine")
public typealias StandardHapticFeedbackPlayer = StandardHapticFeedbackEngine
#endif

@available(*, deprecated, renamed: "DisabledHapticFeedbackEngine")
public typealias DisabledHapticFeedbackPlayer = DisabledAudioFeedbackEngine

public extension HapticFeedback {

    @available(*, deprecated, renamed: "engine")
    static var player: HapticFeedbackEngine {
        get { engine }
        set { engine = newValue }
    }
}

public extension HapticFeedbackEngine {

    @available(*, deprecated, renamed: "trigger")
    func play(_ feedback: HapticFeedback) { trigger(feedback) }
}
