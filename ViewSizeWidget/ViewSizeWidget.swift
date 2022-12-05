//
//  ViewSizeWidget.swift
//  ViewSizeWidget
//
//  Created by Kah Seng Lee on 01/12/2022.
//

import WidgetKit
import SwiftUI

// MARK: - The Timeline Entry
struct ViewSizeEntry: TimelineEntry {
    let date: Date
    let providerInfo: String
}

// MARK: - The Widget View
struct ViewSizeWidgetView : View {
   
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

// MARK: - The Timeline Provider
struct ViewSizeTimelineProvider: TimelineProvider {
    
    typealias Entry = ViewSizeEntry
    
    func placeholder(in context: Context) -> Entry {
        // This data will be masked
        return ViewSizeEntry(date: Date(), providerInfo: "placeholder")
    }

    func getSnapshot(in context: Context, completion: @escaping (Entry) -> ()) {
        let entry = ViewSizeEntry(date: Date(), providerInfo: "snapshot")
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        let entry = ViewSizeEntry(date: Date(), providerInfo: "timeline")
        let timeline = Timeline(entries: [entry], policy: .never)
        completion(timeline)
    }
}

// MARK: - The Widget Configuration
@main
struct ViewSizeWidget: Widget {
    
    var body: some WidgetConfiguration {
        StaticConfiguration(
            kind: "com.SwiftSenpaiDemo.ViewSizeWidget",
            provider: ViewSizeTimelineProvider()
        ) { entry in
            ViewSizeWidgetView(entry: entry)
        }
        .configurationDisplayName("View Size Widget")
        .description("This is a demo widget.")
        .supportedFamilies([
            .systemSmall,
            .systemMedium,
            .systemLarge,
        ])
    }
}

struct ViewSizeWidget_Previews: PreviewProvider {
    static var previews: some View {
        ViewSizeWidgetView(entry: ViewSizeEntry(date: Date(), providerInfo: "preview"))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
