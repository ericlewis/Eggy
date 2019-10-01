import SwiftUI

struct ContentView: View {
    @State var offset: CGSize = .zero
    
    let timer = TimerStore()
    
    var body: some View {
        EggView(offset: $offset)
        .environmentObject(Store(timer: timer, egg: EggStore()))
        .environmentObject(timer)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
