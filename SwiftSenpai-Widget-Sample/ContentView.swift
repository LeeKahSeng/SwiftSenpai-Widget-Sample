//
//  ContentView.swift
//  SwiftSenpai-Widget-Sample
//
//  Created by Kah Seng Lee on 01/12/2022.
//

import SwiftUI

struct ContentView: View {
    
    @State private var showRedView = false
    @State private var showBlueView = false
    @State private var showGreenView = false
    @State private var showOrangeView = false
    
    var body: some View {
        VStack {
            Image(systemName: "applelogo")
                .imageScale(.large)
                .foregroundColor(.accentColor)
                .padding()
            Text("Swift Senpai Widget Demo")
        }
        .padding()
        .sheet(isPresented: $showRedView) {
            RedView()
        }
        .sheet(isPresented: $showOrangeView) {
            OrangeView()
        }
        .sheet(isPresented: $showGreenView) {
            GreenView()
        }
        .sheet(isPresented: $showBlueView) {
            BlueView()
        }
        .onOpenURL { url in
            handleWidgetDeeplink(url)
        }
    }
    
    private func handleWidgetDeeplink(_ url: URL) {
        
        guard
            let scheme = url.scheme,
            let host = url.host else {
            // Invalid URL format
            return
        }
        
        guard scheme == "tap-me-widget" else {
            // The deeplink is not trigger by widget
            return
        }
        
        switch host {
        case "show-red":
            showRedView = true
        case "show-blue":
            showBlueView = true
        case "show-orange":
            showOrangeView = true
        case "show-green":
            showGreenView = true
        default:
            break
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
