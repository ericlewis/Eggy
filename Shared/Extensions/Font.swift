import SwiftUI

extension Font {
    static func rounded(_ style: TextStyle) -> Font {
        Self.system(style, design: .rounded)
    }
    
    static var largeTitleRounded: Font {
        Self.rounded(.largeTitle)
    }

    static var titleRounded: Font {
        Self.rounded(.title)
    }

    static var headlineRounded: Font {
        Self.rounded(.headline)
    }

    static var subheadlineRounded: Font {
        Self.rounded(.subheadline)
    }

    static var bodyRounded: Font {
        Self.rounded(.body)
    }

    static var calloutRounded: Font {
        Self.rounded(.callout)
    }

    static var footnoteRounded: Font {
        Self.rounded(.footnote)
    }

    static var captionRounded: Font {
        Self.rounded(.caption)
    }
}
