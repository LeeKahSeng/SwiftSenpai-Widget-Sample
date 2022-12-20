//
//  CircularWidgetView.swift
//  ViewSizeWidgetExtension
//
//  Created by Kah Seng Lee on 09/12/2022.
//

import Foundation
import SwiftUI
import WidgetKit

/// Widget view for `accessoryCircular`
struct CircularWidgetView: View {
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                AccessoryWidgetBackground()
                VStack {
                    Text("W: \(Int(geometry.size.width))")
                        .font(.headline)
                    Text("H: \(Int(geometry.size.height))")
                        .font(.headline)
                }
            }
        }
    }
}
