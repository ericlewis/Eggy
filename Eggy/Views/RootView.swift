import SwiftUI

extension View {
    func darkModify(shouldForce: Bool) -> AnyView {
        if shouldForce {
            return self.environment(\.colorScheme, .dark).eraseToAnyView()
        }
        
        return self.eraseToAnyView()
    }
}

struct RootView: View {
    @EnvironmentObject var store: Store
    @ObservedObject var settings = SettingsStore.shared

    init() {
        setupNavigationBarAppearances()
    }
    
    private func setupNavigationBarAppearances() {
        let descriptor = UIFontDescriptor.preferredFontDescriptor(withTextStyle: .title1).withSymbolicTraits(.traitBold)?.withDesign(UIFontDescriptor.SystemDesign.rounded)
        let descriptor2 = UIFontDescriptor.preferredFontDescriptor(withTextStyle: .largeTitle).withSymbolicTraits(.traitBold)?.withDesign(UIFontDescriptor.SystemDesign.rounded)
        UINavigationBar.appearance().largeTitleTextAttributes = [NSAttributedString.Key.font:UIFont.init(descriptor: descriptor2!, size: 34)]
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.font:UIFont.init(descriptor: descriptor!, size: 17)]
    }
    
    var body: some View {
        NavigationView {
            if UIDevice.current.userInterfaceIdiom == .pad {
            ContentView()
            .alert(isPresented: $store.showCancelTimer, content: { () -> Alert in
                Alert(title: Text("Are you sure you want to stop this running timer?"), primaryButton: .cancel(), secondaryButton: .destructive(Text("Stop Timer"), action: self.store.stopTimer))
            })
            } else {
            ContentView()
            .actionSheet(isPresented: $store.showCancelTimer) {
                ActionSheet(title: Text("Are you sure you want to stop this running timer?"), message: nil, buttons: [.destructive(Text("Stop Timer"), action: self.store.stopTimer), .cancel()])
            }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .accentColor(.mixer(.systemOrange, .systemYellow, CGFloat(self.store.doneness)))
        .darkModify(shouldForce: settings.forceDarkMode)
    }
}
