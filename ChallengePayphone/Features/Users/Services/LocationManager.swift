//
//  LocationManager.swift
//  ChallengePayphone
//
//  Created by José Briones on 24/6/26.
//

import CoreLocation
import Foundation
import Combine

struct Coordinate: Equatable {
    let latitude: Double
    let longitude: Double
}

enum LocationError: LocalizedError {
    case denied

    var errorDescription: String? {
        switch self {
        case .denied:
            return String(localized: "LOCATION_DENIED")
        }
    }
}

@MainActor
final class LocationManager: NSObject, ObservableObject {
    private let manager = CLLocationManager()
    private let geocoder = CLGeocoder()

    @Published var location: Coordinate?
    @Published var city: String?
    @Published var authorizationStatus: CLAuthorizationStatus = .notDetermined
    @Published var locationError: Error?

    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        authorizationStatus = manager.authorizationStatus
    }

    func requestLocation() {
        locationError = nil
        switch manager.authorizationStatus {
        case .notDetermined:
            manager.requestWhenInUseAuthorization()
        case .authorizedWhenInUse, .authorizedAlways:
            manager.requestLocation()
        default:
            locationError = LocationError.denied
        }
    }
}

extension LocationManager: CLLocationManagerDelegate {
    nonisolated func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let clLocation = locations.last else { return }
        let raw = clLocation.coordinate
        let coordinate = Coordinate(latitude: raw.latitude, longitude: raw.longitude)
        Task { @MainActor in
            self.location = coordinate
            do {
                let placemarks = try await self.geocoder.reverseGeocodeLocation(clLocation)
                self.city = placemarks.first?.locality
            } catch {
                // geocoding failure is non-fatal; location popup still shows
            }
        }
    }

    nonisolated func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        Task { @MainActor in
            self.locationError = error
        }
    }

    nonisolated func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        Task { @MainActor in
            self.authorizationStatus = manager.authorizationStatus
            if manager.authorizationStatus == .authorizedWhenInUse ||
               manager.authorizationStatus == .authorizedAlways {
                manager.requestLocation()
            }
        }
    }
}
