//
//  TestView.swift
//  Score
//
//  Created by Евгений Иванов on 04.12.2020.
//

import SwiftUI

struct TestView: View {
    
    init() {
        
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().isTranslucent = true
        UINavigationBar.appearance().tintColor = .clear
        UINavigationBar.appearance().backgroundColor = .clear
        UINavigationBar.appearance().backgroundColor = UIColor(white: 0, alpha: 0.5)
    }
    
    var body: some View {
        
        NavigationView {
            ZStack {
                Color(.lightGray).edgesIgnoringSafeArea(.all)
                VStack() {
                    Spacer()
                    Text("Hello").foregroundColor(.white)
                    Spacer()
                }
            }
            .navigationBarTitle(Text("First View"), displayMode: .inline)
        }
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
