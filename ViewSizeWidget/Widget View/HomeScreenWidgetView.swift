//
//  HomeScreenWidgetView.swift
//  ViewSizeWidgetExtension
//
//  Created by Kah Seng Lee on 11/12/2022.
//

import Foundation
import SwiftUI

/// Widget view for Home Screen widgets
struct HomeScreenWidgetView: View {

    let entry: ViewSizeEntry

    var body: some View {
        GeometryReader { geometry in
            VStack {

                // Show view size
                Text("\(Int(geometry.size.width)) x \(Int(geometry.size.height))")
                    .font(.system(.title2, weight: .bold))

                // Show provider info
                Text(entry.providerInfo)
                    .font(.footnote)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.green)
        }
    }
}
