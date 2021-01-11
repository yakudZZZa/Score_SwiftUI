//
//  ContentView.swift
//  Score
//
//  Created by Евгений Иванов on 04.12.2020.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var playerStore: PlayerStore
    @State var selectedTab = 0
    
    var body: some View {
        
        ZStack {
            Color.mainBackgroundColor.edgesIgnoringSafeArea(.all)
            TabView(selection: $selectedTab) {
                NavigationView {
                    List {
                        ForEach (playerStore.players, id: \.self) { player in
                            PlayerCell(
                                index: playerStore.getIndex(of: player),
                                name: player.name,
                                score: player.score,
                                selectedColorIndex: player.selectedColorIndex,
                                backgroundColor: player.backgroundColor
                            )
                        }
                        .onDelete(perform: self.deletePlayer)
                        .onMove(perform: playerStore.move)
                        .buttonStyle(BorderlessButtonStyle())
                    }
                    .background(Color.mainBackgroundColor)
                    .navigationBarTitle("", displayMode: .inline)
                    .navigationBarItems(
                        trailing:
                            Image(systemName: "person.crop.circle.badge.plus")
                            .foregroundColor(.white)
                            .onTapGesture(perform: self.addNewPlayer)
                    )
                }
                .navigationViewStyle(StackNavigationViewStyle())
                .tabItem {
                    Image(systemName: "square.and.pencil")
                        .resizable()
                }.tag(0)
                Text("Tab Content 2").tabItem {
                    Text("60")
                        .font(.title)
                }.tag(1)
                Text("Tab Content 3").tabItem {
                    Image(systemName: "gearshape")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                }.tag(2)
            }
            .accentColor(.white)
        }
    }
    
    init(){
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().isTranslucent = true
        UINavigationBar.appearance().tintColor = .clear
        UINavigationBar.appearance().backgroundColor = .clear
        UITabBar.appearance().barTintColor = UIColor.barColor
        UITableView.appearance().backgroundColor = .clear
        UITableView.appearance().separatorStyle = .none
        UINavigationBar.appearance().barTintColor = UIColor.barColor
        UINavigationBar.appearance().isTranslucent = false
    }
    
    func deletePlayer(offsets: IndexSet) {
        withAnimation {
            playerStore.deletePlayer(offsets: offsets)
        }
    }
    
    func addNewPlayer() {
        withAnimation {
            playerStore.addNewPlayer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(PlayerStore())
    }
}
