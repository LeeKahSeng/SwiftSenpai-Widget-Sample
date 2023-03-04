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
    let deeplinkCommand: String
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
        .widgetURL(URL(string: "tap-me-widget://\(entry.deeplinkCommand)"))
    }
}

struct TapMeWidgetTimelineProvider: IntentTimelineProvider {
    
    func placeholder(in context: Context) -> TapMeWidgetEntry {
        
        TapMeWidgetEntry(
            date: Date(),
            backgroundColor: Color(uiColor: .systemRed),
            deeplinkCommand: ""
        )
    }

    func getSnapshot(for configuration: TapMeConfigurationIntent,
                     in context: Context,
                     completion: @escaping (TapMeWidgetEntry) -> ()) {
        
        let entry = TapMeWidgetEntry(
            date: Date(),
            backgroundColor: Color(uiColor: .systemRed),
            deeplinkCommand: ""
        )

        completion(entry)
    }

    func getTimeline(for configuration: TapMeConfigurationIntent,
                     in context: Context,
                     completion: @escaping (Timeline<TapMeWidgetEntry>) -> ()) {
        
        let backgroundColor = configuration.backgroundColor
        
        let color = color(for: backgroundColor)
        let command = command(for: backgroundColor)
        
        let entry = TapMeWidgetEntry(
            date: Date(),
            backgroundColor: color,
            deeplinkCommand: command
        )
        
        let timeline = Timeline(entries: [entry], policy: .atEnd)
        completion(timeline)
    }
    
    /// Provide deeplink command
    private func command(for bgColor: BgColor) -> String {
        switch bgColor {
        case .blue:
            return "show-blue"
        case .green:
            return "show-green"
        case .red:
            return "show-red"
        case .orange:
            return "show-orange"
        case .unknown:
            fatalError("Unknow color")
        }
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
        .configurationDisplayName("Tap Me Widget")
        .description("Please tap me!")
        .supportedFamilies([
            .systemSmall,
            .systemMedium,
        ])
    }
}
