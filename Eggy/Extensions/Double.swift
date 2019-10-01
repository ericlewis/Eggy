import Foundation

extension Double {
    func rescale(from fromRange: (Double, Double), to toRange: (Double, Double)) -> Double {
        func interpolate(_ x: Double) -> Double {
            return toRange.0 * (1 - x) + toRange.1 * x;
        }

        func uninterpolate(_ x: Double) -> Double {
            let b = (fromRange.1 - fromRange.0) != 0 ? fromRange.1 - fromRange.0 : 1 / fromRange.1;
            return (x - fromRange.0) / b
        }

        func rescale(_ x: Double)  -> Double {
            return interpolate( uninterpolate(x) )
        }
        
        return rescale(self)
    }
    
    func rescale(from fromRange: ClosedRange<Double>, to toRange: ClosedRange<Double>) -> Double {
        func interpolate(_ x: Double) -> Double {
            return toRange.lowerBound * (1 - x) + toRange.upperBound * x;
        }

        func uninterpolate(_ x: Double) -> Double {
            let b = (fromRange.upperBound - fromRange.lowerBound) != 0 ? fromRange.upperBound - fromRange.lowerBound : 1 / fromRange.upperBound;
            return (x - fromRange.lowerBound) / b
        }

        func rescale(_ x: Double)  -> Double {
            return interpolate( uninterpolate(x) )
        }
        
        return rescale(self)
    }
    
    func scaledTemp() -> Double {
        rescale(from: 0...1, to: Constants.EggRange.temp)
    }
    
    func scaledSize() -> Double {
        rescale(from: 0...1, to: Constants.EggRange.size)
    }
    
    func scaledDoneness() -> Double {
        rescale(from: 0...1, to: Constants.EggRange.doneness)
    }
}
