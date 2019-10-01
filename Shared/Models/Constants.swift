struct Constants {
    static let timeInterval = 0.1
    static let boilingPoint: Double = 100
    static let heatCoefficient: Double = 31
    static let yolkToWhiteRatio: Double = 0.86
    
    struct EggRange {
        static let temp: ClosedRange<Double> = 1...23
        static let size: ClosedRange<Double> = 38...80
        static let doneness: ClosedRange<Double> = 56...85
    }
    
    struct SliderDefault {
        static let temp = 0.2
        static let size = 0.5
        static let doneness = 0.7
    }
}
