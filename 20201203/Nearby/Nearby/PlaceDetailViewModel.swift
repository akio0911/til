//
//  PlaceDetailViewModel.swift
//  Nearby
//
//  Created by akio0911 on 2020/12/03.
//

import Combine
import CoreLocation

struct LocationManager {
    static let sharedManager = LocationManager(latitude: 35.658584, longitude: 139.7454316)
    
    let latitude: Double
    let longitude: Double
}

struct NearbyPlace {
    let name: String
    let openStatus: Bool?
    let location: CLLocation?
    let imageURL: String?
}

final class PlaceDetailViewModel {
    // MARK: Output
    @Published private(set) var title = ""
    @Published private(set) var distance = ""
    @Published private(set) var isOpen = false
    @Published private(set) var placeImageUrl: String = ""
    @Published private(set) var location: CLLocation? = nil
    
    private let place: NearbyPlace
    
    init(place: NearbyPlace) {
        self.place = place
        configureOutput()
    }
    
    private func configureOutput() {
        title = place.name
        let openStat = place.openStatus ?? false
        isOpen = openStat
        location = place.location
        placeImageUrl = place.imageURL ?? ""
        
        let currentLocation = CLLocation(
            latitude: LocationManager.sharedManager.latitude,
            longitude: LocationManager.sharedManager.longitude
        )
        guard let distance = place.location?.distance(from: currentLocation) else { return }
        self.distance = String(format: "%.2f mi", distance / 1609.344)
    }
}
