//
//  InlineWidgetView.swift
//  ViewSizeWidgetExtension
//
//  Created by Kah Seng Lee on 09/12/2022.
//

import Foundation
import SwiftUI

/// Widget view for `accessoryInline`
struct InlineWidgetView: View {
    
    var body: some View {
        ViewThatFits {
            // Provide 2 subviews for `ViewThatFits` evaluation
            // Prioritizing from top to bottom
            Text("🤷🏻‍♂️ View size not available 🤷🏻‍♀️")
            Text("🤷🏻‍♂️ Nope! 🤷🏻‍♀️")
        }
    }
}
