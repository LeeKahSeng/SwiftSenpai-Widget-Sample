//
//  ColorViews.swift
//  SwiftSenpai-Widget-Sample
//
//  Created by Kah Seng Lee on 02/03/2023.
//

import Foundation
import SwiftUI

struct RedView: View {
    var body: some View {
        VStack {
            Text("Red View")
                .font(.largeTitle)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(uiColor: .systemRed))
    }
}

struct BlueView: View {
    var body: some View {
        VStack {
            Text("Blue View")
                .font(.largeTitle)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(uiColor: .systemBlue))
    }
}

struct OrangeView: View {
    var body: some View {
        VStack {
            Text("Orange View")
                .font(.largeTitle)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(uiColor: .systemOrange))
    }
}

struct GreenView: View {
    var body: some View {
        VStack {
            Text("Green View")
                .font(.largeTitle)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(uiColor: .systemGreen))
    }
}
