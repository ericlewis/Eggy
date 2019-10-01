import SwiftUI

struct SettingsButton: View {
    @EnvironmentObject var store: Store
    @ObservedObject var settings = SettingsStore.shared

    @State var isShowing = false
    
    func toggleSettings() {
        isShowing.toggle()
    }
    
    var body: some View {
        Button(action: toggleSettings) {
            Image(systemSymbol: .gear)
            .imageScale(.large)
            .padding([.vertical, .leading])
        }
        .sheet(isPresented: $isShowing) {
            NavigationView {
                SettingsView()
                .environmentObject(self.store)
                .navigationBarItems(trailing: DoneButton().tappable(action: self.toggleSettings))
            }
            .accentColor(.mixer(.systemOrange, .systemYellow, CGFloat(self.store.doneness)))
            .navigationViewStyle(StackNavigationViewStyle())
            .darkModify(shouldForce: self.settings.forceDarkMode)
        }
    }
}
