//
//  MyTextWidget.swift
//  MyTextWidget
//
//  Created by Kah Seng Lee on 04/02/2023.
//

import WidgetKit
import SwiftUI
import Intents

struct MyTextEntry: TimelineEntry {
    let date: Date
    let myText: String
    let fontSize: Int
    let borderColor: Color
}

struct MyTextWidgetView: View {
    
    let entry: MyTextEntry
    
    var body: some View {
        Text(entry.myText)
            .font(.system(size: CGFloat(entry.fontSize)))
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 6)
                    .stroke(entry.borderColor, lineWidth: 2)
            )
    }
}

struct MyTextTimelineProvider: IntentTimelineProvider {
    
    func placeholder(in context: Context) -> MyTextEntry {
       
        MyTextEntry(
            date: Date(),
            myText: "Hello! 👋",
            fontSize: 15,
            borderColor: .clear
        )
    }

    func getSnapshot(for configuration: MyTextConfigurationIntent,
                     in context: Context,
                     completion: @escaping (MyTextEntry) -> ()) {
        
        let myText = configuration.myText ?? "Hello! 👋"
        let fontSize = Int(truncating: configuration.fontSize ?? 16)
        let color = color(for: configuration.borderColor)

        let entry = MyTextEntry(
            date: Date(),
            myText: myText,
            fontSize: fontSize,
            borderColor: color
        )

        completion(entry)
    }

    func getTimeline(for configuration: MyTextConfigurationIntent,
                     in context: Context,
                     completion: @escaping (Timeline<MyTextEntry>) -> ()) {
        
        let myText = configuration.myText ?? "Hello! 👋"
        let fontSize = Int(truncating: configuration.fontSize ?? 16)
        let color = color(for: configuration.borderColor)

        let entry = MyTextEntry(
            date: Date(),
            myText: myText,
            fontSize: fontSize,
            borderColor: color
        )

        let timeline = Timeline(entries: [entry], policy: .atEnd)
        completion(timeline)
    }
    
    /// Convert `BorderColor` to `Color`
    private func color(for borderColor: BorderColor) -> Color {
        switch borderColor {
        case .red:
            return .red
        case .green:
            return .green
            
        case .blue:
            return .blue
            
        case .unknown:
            fatalError("Unknow color")
        }
    }
}

struct MyTextWidget: Widget {
    
    let kind = "com.SwiftSenpaiDemo.MyTextWidget"
    
    var body: some WidgetConfiguration {
        IntentConfiguration(
            kind: kind,
            intent: MyTextConfigurationIntent.self,
            provider: MyTextTimelineProvider()
        ) { entry in
            MyTextWidgetView(entry: entry)
        }
        .configurationDisplayName("MyText Widget")
        .description("Show you favorite text!")
        .supportedFamilies([
            .systemSmall,
        ])
    }
}
