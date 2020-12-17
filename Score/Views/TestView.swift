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

import SwiftUI

struct TestContentView: View {
  var body: some View {
    TabBar(items: [
      (Image(systemName: "tray"), Text("Inbox")),
      (Image(systemName: "archivebox"), Text("Archive")),
      (Image(systemName: "doc.text"), Text("Drafts")),
    ])
  }
}

struct TestContentView_Previews: PreviewProvider {
  static var previews: some View {
    TestContentView()
  }
}

struct FirstNonNilPreferenceKey<T>: PreferenceKey {
  static var defaultValue: T? { nil }
  
  static func reduce(
    value: inout T?,
    nextValue: () -> T?
  ) {
    value = value ?? nextValue()
  }
}

struct TabBar: View {
  @State private var selectedItemIndex: Int = 0
  let items: [(image: Image, text: Text)]
  
  var body: some View {
    HStack {
      ForEach(items.indices, content: tabItem(index:))
    }
    .backgroundPreferenceValue(FirstNonNilPreferenceKey<Anchor<CGRect>>.self) { boundsAnchor in
      GeometryReader { proxy in
        boundsAnchor.map { anchor in
          indicator(
            width: proxy[anchor].width,
            offset: .init(
              width: proxy[anchor].minX,
              height: proxy[anchor].height
            )
          )
        }
      }
    }
  }
  
  private func tabItem(index: Int) -> some View {
    Button(
      action: {
        withAnimation(.default) {
          self.selectedItemIndex = index
        }
      },
      label: {
        VStack {
          items[index].image
          items[index].text
        }
      }
    )
      .accentColor(isSelected(index) ? .accentColor : .primary)
      .anchorPreference(
        key: FirstNonNilPreferenceKey<Anchor<CGRect>>.self,
        value: .bounds,
        transform: { anchor in self.isSelected(index) ? .some(anchor) : nil }
      )
  }
  
  private func isSelected(_ index: Int) -> Bool {
    index == selectedItemIndex
  }
}

private func indicator(
  width: CGFloat,
  offset: CGSize
) -> some View {
  Rectangle()
    .foregroundColor(.accentColor)
    .frame(width: width, height: 1)
    .offset(offset)
}
