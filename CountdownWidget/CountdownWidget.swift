//
//  CountdownWidget.swift
//  CountdownWidget
//
//  Created by Kah Seng Lee on 30/12/2022.
//

import WidgetKit
import SwiftUI

struct CountdownEntry: TimelineEntry {
    let date: Date
    let status: String
    let guageValue: CGFloat
}

struct CountdownWidgetView: View {
    
    let entry: CountdownEntry
    
    var body: some View {
        Text("Hello World")
    }
}

struct CountdownTimelineProvider: TimelineProvider {

    typealias Entry = CountdownEntry

    func placeholder(in context: Context) -> Entry {
        return CountdownEntry(
            date: Date(),
            status: "Counting down...",
            guageValue: 5.0
        )
    }

    func getSnapshot(in context: Context, completion: @escaping (Entry) -> ()) {
        let entry = CountdownEntry(
            date: Date(),
            status: "Counting down...",
            guageValue: 5.0
        )
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        let entry = CountdownEntry(
            date: Date(),
            status: "Counting down...",
            guageValue: 5.0
        )
        let timeline = Timeline(entries: [entry], policy: .never)
        completion(timeline)
    }
}

@main
struct CountdownWidget: Widget {
    
    let kind = "com.SwiftSenpaiDemo.CountdownWidgetView"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(
            kind: kind,
            provider: CountdownTimelineProvider()
        ) { entry in
            CountdownWidgetView(entry: entry)
        }
        .configurationDisplayName("Countdown Widget")
        .description("This is a demo widget.")
        .supportedFamilies([
            .systemSmall,
        ])
    }
}
