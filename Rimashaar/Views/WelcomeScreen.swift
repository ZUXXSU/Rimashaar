import SwiftUI

struct WelcomeScreen: View {
    @State private var selectedTab: Tab = .house
    @Binding var path: NavigationPath
    
    var body: some View {
        ZStack(alignment: .bottom) {
            TabView(selection: $selectedTab) {
                HomeView().tag(Tab.house)
                ShopView().tag(Tab.bag)
                ArticleView().tag(Tab.book)
                ProfileView(path: $path).tag(Tab.person)
            }
            .edgesIgnoringSafeArea(.all)

            VStack(spacing: 0) {
                TopBar(selectedTab: $selectedTab)
                Spacer()
                BottomBar(selectedTab: $selectedTab)
            }
        }
        .navigationBarHidden(true)
    }
}

struct TopBar: View {
    @Binding var selectedTab: Tab
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color(.systemBackground))
                .frame(height: 60)
                .shadow(color: .black.opacity(0.1), radius: 1, y: 1)
            
            HStack {
                if selectedTab == .house {
                    VStack(alignment: .leading) {
                        HStack {
                            Text("Rimashaar")
                                .font(.subheadline)
                            Image(systemName: "chevron.down")
                                .imageScale(.small)
                        }
                        Text("Change Store")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                } else {
                    Text(selectedTab.title)
                        .font(.headline)
                }
                
                Spacer()
                
                if selectedTab == .house {
                    Image("ic_logo_rimashaar")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 40)
                }
                
                Spacer()
                
                Image(systemName: "magnifyingglass")
            }
            .padding(.horizontal, 20)
        }
    }
}

struct BottomBar: View {
    @Binding var selectedTab: Tab
    
    var body: some View {
        HStack {
            ForEach(Tab.allCases) { tab in
                Button(action: {
                    withAnimation {
                        selectedTab = tab
                    }
                }) {
                    VStack {
                        Image(systemName: selectedTab == tab ? tab.rawValue + ".fill" : tab.rawValue)
                            .imageScale(.large)
                        Text(tab.title)
                            .font(.caption)
                    }
                    .foregroundColor(selectedTab == tab ? .primary : .secondary)
                    .frame(maxWidth: .infinity)
                }
            }
        }
        .padding(.horizontal, 20)
        .frame(height: 70)
        .background(Color(.systemBackground))
        .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: -1)
    }
}
