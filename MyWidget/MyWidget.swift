//
//  MyWidget.swift
//  MyWidget
//
//  Created by MiguelRuizHdz on 12/9/22.
//

import WidgetKit
import SwiftUI

// MODELO VAR

struct Modelo: TimelineEntry {
    var date: Date
    var mensaje: String
}

// PROVIDER

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> Modelo {
        return Modelo(date: Date(), mensaje: "")
    }
    
    func getSnapshot(in context: Context, completion: @escaping (Modelo) -> Void) {
        completion(Modelo(date: Date(), mensaje: ""))
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<Modelo>) -> Void) {
        let entry = Modelo(date: Date(), mensaje: "Hello Hacker!")
        completion(Timeline(entries: [entry], policy: .never))
    }
    
    typealias Entry = Modelo
}

// DISEÑO - VISTA

struct vista: View {
    let entry : Provider.Entry
    var body: some View {
        Text(entry.mensaje)
    }
}

// CONFIGURACIÓN
@main
struct HelloWidget: Widget {
    var body: some WidgetConfiguration{
        StaticConfiguration(kind: "widget", provider: Provider()) {
            entry in
            vista(entry: entry)
        }.description("descripcion del widget")
        .configurationDisplayName("nombre widget")
        .supportedFamilies([.systemExtraLarge, .systemLarge, .systemMedium, .systemSmall])
    }
}
