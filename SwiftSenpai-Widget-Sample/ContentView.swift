//
//  ContentView.swift
//  SwiftSenpai-Widget-Sample
//
//  Created by Kah Seng Lee on 01/12/2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "applelogo")
                .imageScale(.large)
                .foregroundColor(.accentColor)
                .padding()
            Text("Swift Senpai Widget Demo")
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
