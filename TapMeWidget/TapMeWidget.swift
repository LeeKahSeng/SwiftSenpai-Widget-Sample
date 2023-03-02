//
//  TapMeWidget.swift
//  TapMeWidget
//
//  Created by Kah Seng Lee on 02/03/2023.
//

import WidgetKit
import SwiftUI
import Intents

struct TapMeWidgetEntry: TimelineEntry {
    let date: Date
    let backgroundColor: Color
}

struct TapMeWidgetView: View {
    
    let entry: TapMeWidgetEntry
    
    var body: some View {
        VStack {
            Text("Tap Me!")
                .font(.title)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(entry.backgroundColor)
    }
}

struct TapMeWidgetTimelineProvider: IntentTimelineProvider {
    
    func placeholder(in context: Context) -> TapMeWidgetEntry {
        
        TapMeWidgetEntry(
            date: Date(),
            backgroundColor: Color(uiColor: .systemRed)
        )
    }

    func getSnapshot(for configuration: TapMeConfigurationIntent,
                     in context: Context,
                     completion: @escaping (TapMeWidgetEntry) -> ()) {
        
        let entry = TapMeWidgetEntry(
            date: Date(),
            backgroundColor: Color(uiColor: .systemRed)
        )

        completion(entry)
    }

    func getTimeline(for configuration: TapMeConfigurationIntent,
                     in context: Context,
                     completion: @escaping (Timeline<TapMeWidgetEntry>) -> ()) {
        
        let color = color(for: configuration.backgroundColor)
        
        let entry = TapMeWidgetEntry(
            date: Date(),
            backgroundColor: color
        )
        
        let timeline = Timeline(entries: [entry], policy: .atEnd)
        completion(timeline)
    }
    
    /// Convert `BgColor` to `Color`
    private func color(for bgColor: BgColor) -> Color {
        switch bgColor {
        case .blue:
            return Color(uiColor: .systemBlue)
        case .green:
            return Color(uiColor: .systemGreen)
        case .red:
            return Color(uiColor: .systemRed)
        case .orange:
            return Color(uiColor: .systemOrange)
        case .unknown:
            fatalError("Unknow color")
        }
    }
}

struct TapMeWidget: Widget {
    
    let kind = "com.SwiftSenpaiDemo.TapMeWidget"
    
    var body: some WidgetConfiguration {
        IntentConfiguration(
            kind: kind,
            intent: TapMeConfigurationIntent.self,
            provider: TapMeWidgetTimelineProvider()
        ) { entry in
            TapMeWidgetView(entry: entry)
        }
        .configurationDisplayName("MyText Widget")
        .description("Show you favorite text!")
        .supportedFamilies([
            .systemSmall,
            .systemMedium,
        ])
    }
}
