//
//  RectangularWidgetView.swift
//  ViewSizeWidgetExtension
//
//  Created by Kah Seng Lee on 09/12/2022.
//

import Foundation
import SwiftUI
import WidgetKit

/// Widget view for `accessoryRectangular`
struct RectangularWidgetView: View {
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                AccessoryWidgetBackground()
                    .cornerRadius(8)
                GeometryReader { geometry in
                    Text("\(Int(geometry.size.width)) x \(Int(geometry.size.height))")
                        .font(.headline)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
            }
            .containerBackground(for: .widget) { }
        }
    }
}
