//
//  ContentView.swift
//  TestSwiftUI
//
//  Created by Shilpa Bansal on 18/04/20.
//  Copyright © 2020 Shilpa Bansal. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Text("Hello, World!").foregroundColor(Color.blue)
            TextFieldBottomLine(placeholder: "test")
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


struct TextFieldBottomLine: View {

    @State var text: String   = ""
    private var placeholder   = ""
    private let lineThickness = CGFloat(2.0)

    init(placeholder: String) {
        self.placeholder = placeholder
    }

    var body: some View {
        VStack {
            TextField(placeholder, text: $text)
            HorizontalLine(color: .gray)
        }
        .padding(.bottom, lineThickness)
    }
}


struct HorizontalLine: View {

    private var color: Color?   = nil
    private var height: CGFloat = 1.0

    init(color: Color, height: CGFloat = 1.0) {
        self.color  = color
        self.height = height
    }

    var body: some View {
        HorizontalLineShape().fill(self.color!).frame(minWidth: 0, maxWidth: .infinity, minHeight: height, maxHeight: height)
    }
}

struct HorizontalLineShape: Shape {

    func path(in rect: CGRect) -> Path {

        let fill = CGRect(x: 0, y: 0, width: rect.size.width, height: rect.size.height)
        var path = Path()
        path.addRoundedRect(in: fill, cornerSize: CGSize(width: 2, height: 2))

        return path
    }
}
