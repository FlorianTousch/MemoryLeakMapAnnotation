//
//  ContentView.swift
//  TestAnnotation
//
//  Created by Florian on 03/01/2023.
//

import SwiftUI
import MapKit

class Annotation: NSObject, Identifiable, MKAnnotation {
    let id: String
    var coordinate: CLLocationCoordinate2D

    init(id: String = UUID().uuidString, coordinate: CLLocationCoordinate2D = CLLocationCoordinate2D.randomCoordinate()) {
        self.id = id
        self.coordinate = coordinate
    }
}

struct ContentView: View {
    @State private var region: MKCoordinateRegion = .defaultRegion
    var items: [Annotation]

    var body: some View {
        ZStack {
            // That works
            // Map(coordinateRegion: $region)

            // That cause memory leak 🥲
            Map(coordinateRegion: $region, annotationItems: items) { annotation in
                MapAnnotation(coordinate: annotation.coordinate, anchorPoint: CGPoint(x: 0.5, y: 1)) {
                    Image(systemName: "circle")
                }
            }
            .ignoresSafeArea()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(items: [Annotation(coordinate: .defaultCoordinate), Annotation()])
    }
}

extension MKCoordinateRegion {
    static let defaultRegion = MKCoordinateRegion(center: .defaultCoordinate,
                                                  span: MKCoordinateSpan(latitudeDelta: 0.2,
                                                                         longitudeDelta: 0.2))
}

extension CLLocationCoordinate2D {
    static func randomCoordinate() -> CLLocationCoordinate2D {
        let lat = Double.random(in: -90...90)
        let lon = Double.random(in: -180...180)
        return CLLocationCoordinate2D(latitude: lat, longitude: lon)
    }

    static let defaultCoordinate = CLLocationCoordinate2D(latitude: 48.8729646, longitude: 2.3332676)
}
