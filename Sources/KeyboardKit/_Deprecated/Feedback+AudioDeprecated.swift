import Foundation

@available(*, deprecated, renamed: "AudioFeedback")
public typealias SystemAudio = AudioFeedback

@available(*, deprecated, renamed: "AudioFeedbackEngine")
public typealias SystemAudioPlayer = AudioFeedbackEngine

#if os(iOS) || os(macOS) || os(tvOS)
@available(*, deprecated, renamed: "StandardAudioFeedbackEngine")
public typealias StandardSystemAudioPlayer = StandardAudioFeedbackEngine
#endif

@available(*, deprecated, renamed: "DisabledAudioFeedbackEngine")
public typealias DisabledSystemAudioPlayer = DisabledAudioFeedbackEngine

public extension AudioFeedback {

    @available(*, deprecated, renamed: "engine")
    static var player: AudioFeedbackEngine {
        get { engine }
        set { engine = newValue }
    }

    @available(*, deprecated, renamed: "trigger")
    func play() { trigger() }
}

public extension AudioFeedbackEngine {

    @available(*, deprecated, renamed: "trigger")
    func play(_ feedback: AudioFeedback) { trigger(feedback) }
}
