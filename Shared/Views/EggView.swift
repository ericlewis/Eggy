import SwiftUI

// TODO: kill reactor

struct EggView: View {
    static let ratio: CGFloat = 0.7
    @EnvironmentObject var store: Store
    @EnvironmentObject var timer: TimerStore

    @Binding var offset: CGSize
        
    let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .percent
        
        return formatter
    }()
    
    var body: some View {
        let drag = DragGesture()
            .onChanged { self.offset = $0.translation }
            .onEnded { _ in
                self.offset = .zero
        }
        
        struct ArcShape: Shape {
            let pct: CGFloat
            
            func path(in rect: CGRect) -> Path {

                var p = Path()

                p.addArc(center: CGPoint(x: rect.width / 2.0, y:rect.height / 2.0),
                         radius: rect.height / 2.0 + 5.0,
                         startAngle: .degrees(0),
                         endAngle: .degrees(360.0 * Double(pct)), clockwise: false)

                return p.strokedPath(.init(lineWidth: 10, lineCap: .round))
            }
        }
        
        var pct: CGFloat {
            CGFloat((timer.estimatedTime - timer.timeRemaining) / timer.estimatedTime)
        }
        
        var yolkResponse: Double {
            if timer.state == .running {
                return timer.doneness.rescale(from: (0, 1), to: (0.34, 0.22))
            } else {
                return store.doneness.rescale(from: (0, 1), to: (0.34, 0.22))
            }
        }
        
        var scaleSize: CGFloat {
            if timer.state == .running {
                return CGFloat(timer.size.rescale(from: 0...1, to: 0.93...1))
            } else {
                return CGFloat(store.size.rescale(from: 0...1, to: 0.93...1))
            }
        }
        
        var orangeColor: UIColor {
            #if os(watchOS)
            return .orange
            #else
            return .systemOrange
            #endif
        }
        
        var yellowColor: UIColor {
            #if os(watchOS)
            return .yellow
            #else
            return .systemYellow
            #endif
        }
        
        return GeometryReader { geo in
            ZStack {
                Circle()
                    .fill(Color.white)
                    .shadow(color: Color(.displayP3, white: 0, opacity: 0.13), radius: 15, x: 0, y: 0)
                    .frame(width: geo.frame(in: .local).width, height: geo.frame(in: .local).height)
                    .offset(x: self.offset.width, y: self.offset.height)
                    .animation(self.offset == .zero ? .spring() : .interactiveSpring())
                                
                Group {
                    Circle()
                        .fill(Color.mixer(orangeColor, yellowColor, CGFloat(self.timer.state == .running ? self.timer.doneness : self.store.doneness)))
                        .background(ArcShape(pct: 1).foregroundColor(.secondary).opacity(self.timer.state == .running ? 1 : 0).scaleEffect(self.timer.state == .running ? 1 : 0.9))
                        .overlay(ArcShape(pct: pct).foregroundColor(Color.mixer(orangeColor, yellowColor, CGFloat(self.timer.state == .running ? self.timer.doneness : self.store.doneness))).opacity(self.timer.state == .running ? 1 : 0).scaleEffect(self.timer.state == .running ? 1 : 0.9))
                    Text(self.timer.state == .running ? " " + self.formatter.string(for: pct >= 1 ? 1 : Double(pct))! + " " : "     ")
                    .foregroundColor(.black)
                    .font(.largeTitleRounded)
                    .bold()
                    .transition(.opacity)
                    .opacity(self.timer.state == .running ? 1 : 0)
                }
                .frame(width: geo.frame(in: .local).width * Self.ratio, height: geo.frame(in: .local).height * Self.ratio)
                .offset(x: self.offset.width, y: self.offset.height)
                .animation(self.offset == .zero ? .spring() : .interactiveSpring(response: yolkResponse, dampingFraction: 0.55))
            }
            .frame(width: geo.frame(in: .local).width, height: geo.frame(in: .local).height)
        }
        .aspectRatio(1.0, contentMode: .fit)
        .scaleEffect(scaleSize)
        .gesture(drag)
    }
}
