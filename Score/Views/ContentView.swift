//
//  ContentView.swift
//  Score
//
//  Created by Евгений Иванов on 04.12.2020.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var playerStore: PlayerStore
    @State var selectedTab = 0
    
    var body: some View {
        
        ZStack {
            Color.mainBackgroundColor.edgesIgnoringSafeArea(.all)
            TabView(selection: $selectedTab) {
                NavigationView {
                    List {
                        ForEach (playerStore.players) { player in
//                            VStack(spacing: 0.0) {
                                PlayerCell(player: player)
//                            }
                            .listRowInsets(EdgeInsets())
                        }
                        .onDelete(perform: deletePlayer)
                        .buttonStyle(BorderlessButtonStyle())
                        .listRowBackground(Color.clear)
                    }
                    .background(Color.mainBackgroundColor)
                    .navigationBarTitle("", displayMode: .inline)
                    .navigationBarItems(
                        trailing:
                            Image(systemName: "person.crop.circle.badge.plus")
                            .foregroundColor(.white)
                            .onTapGesture(perform: addPlayer)
                    )
                }
                .background(Color.clear)
                .navigationViewStyle(StackNavigationViewStyle())
                .tabItem {
                    VStack {
                        Image(systemName: "square.and.pencil")
                            .resizable()
                        
                    }
                }.tag(0)
                Text("Tab Content 2").tabItem {
                    Text("60")
                        .font(.title)
                }.tag(1)
                Text("Tab Content 2").tabItem {
                    Image(systemName: "square.and.pencil")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                }.tag(2)
            }
            .accentColor(.white)
        }
    }
    
    init(playerStore: PlayerStore){
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().isTranslucent = true
        UINavigationBar.appearance().tintColor = .clear
        UINavigationBar.appearance().backgroundColor = .clear
        UITabBar.appearance().barTintColor = UIColor.barColor
        //    UINavigationBar.appearance().backgroundColor = UIColor(red: 28/255, green: 28/255, blue: 28/255, alpha: 0.9)
        UITableView.appearance().backgroundColor = .clear
        UITableViewCell.appearance().backgroundColor = .clear
        UITableView.appearance().separatorStyle = .none
        UINavigationBar.appearance().barTintColor = UIColor.barColor
        UINavigationBar.appearance().isTranslucent = false
        //For other NavigationBar changes, look here:(https://stackoverflow.com/a/57509555/5623035)
        self.playerStore = playerStore
    }
    
    func deletePlayer(offsets: IndexSet) {
        withAnimation {
            playerStore.players.remove(atOffsets: offsets)
        }
    }
    func addPlayer() {
        withAnimation {
            playerStore.addNewPlayer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(playerStore: PlayerStore())
    }
}
