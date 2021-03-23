//
//  LocationProvider.swift
//  Weather
//
//  Created by Asiel Cabrera Gonzalez on 3/22/21.
//

import Foundation
import SwiftUI
import CoreLocation
import Combine


public let defaultAuthorizationRequestType = CLAuthorizationStatus.authorizedWhenInUse

public let allowedAuthorizationTypes : Set<CLAuthorizationStatus> = Set([.authorizedWhenInUse, .authorizedAlways])


public class LocationProvider: NSObject, ObservableObject {
    
    public let lm = CLLocationManager()
    
    public let locationWillChange = PassthroughSubject<CLLocation, Never>()
    
    @Published public private(set) var location: CLLocation? {
        willSet {
            locationWillChange.send(newValue ?? CLLocation())
        }
    }
    
    @Published public var authorizationStatus: CLAuthorizationStatus?
    

    public var onAuthorizationStatusDenied : ()->Void = {presentLocationSettingsAlert()}
    

    public override init() {
        super.init()
        
        self.lm.delegate = self
        
        self.lm.desiredAccuracy = kCLLocationAccuracyBest
        self.lm.activityType = .fitness
        self.lm.distanceFilter = 10
        self.lm.allowsBackgroundLocationUpdates = true
        self.lm.pausesLocationUpdatesAutomatically = false
        #if os(iOS)
        self.lm.showsBackgroundLocationIndicator = true
        #endif
    }
    

    public func requestAuthorization(authorizationRequestType: CLAuthorizationStatus = defaultAuthorizationRequestType) -> Void {
        if self.authorizationStatus == CLAuthorizationStatus.denied {
            onAuthorizationStatusDenied()
        }
        else {
            switch authorizationRequestType {
            case .authorizedWhenInUse:
                self.lm.requestWhenInUseAuthorization()
            case .authorizedAlways:
                self.lm.requestAlwaysAuthorization()
            default:
                print("WARNING: Only `when in use` and `always` types can be requested.")
            }
        }
    }

    public func start() throws -> Void {
        self.requestAuthorization()
        
        if let status = self.authorizationStatus {
            guard allowedAuthorizationTypes.contains(status) else {
                throw LocationProviderError.noAuthorization
            }
        }
        else {

            #if DEBUG
            print(#function, "WARNING: No location authorization status set by delegate yet. Try to start updates anyhow.")
            #endif
         
        }
        self.lm.startUpdatingLocation()
    }
    

    public func stop() -> Void {
        self.lm.stopUpdatingLocation()
    }
    
}

/// Present an alert that suggests to go to the app settings screen.
public func presentLocationSettingsAlert(alertText : String? = nil) -> Void {
    #if os(iOS)
    let alertController = UIAlertController (title: "Enable Location Access", message: alertText ?? "The location access for this app is set to 'never'. Enable location access in the application settings. Go to Settings now?", preferredStyle: .alert)
    let settingsAction = UIAlertAction(title: "Settings", style: .default) { (_) -> Void in
        guard let settingsUrl = URL(string:UIApplication.openSettingsURLString) else {
            return
        }
        UIApplication.shared.open(settingsUrl)
    }
    alertController.addAction(settingsAction)
    let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
    alertController.addAction(cancelAction)
    UIApplication.shared.windows[0].rootViewController?.present(alertController, animated: true, completion: nil)
    #endif
}

public enum LocationProviderError: Error {
    case noAuthorization
}

extension LocationProvider: CLLocationManagerDelegate {
    public func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        self.authorizationStatus = status
        #if DEBUG
        print(#function, status.name)
        #endif

    }
    
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        self.location = location
    }
    
    public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        if let clErr = error as? CLError {
            switch clErr {
            case CLError.denied : do {
                print(#function, "Location access denied by user.")
                self.stop()
                self.requestAuthorization()
            }
            case CLError.locationUnknown : print(#function, "Location manager is unable to retrieve a location.")
            default: print(#function, "Location manager failed with unknown CoreLocation error.")
            }
        }
        else {
            print(#function, "Location manager failed with unknown error", error.localizedDescription)
        }
    }
}

extension CLAuthorizationStatus {
    var name: String {
        switch self {
        case .notDetermined: return "notDetermined"
        case .authorizedWhenInUse: return "authorizedWhenInUse"
        case .authorizedAlways: return "authorizedAlways"
        case .restricted: return "restricted"
        case .denied: return "denied"
        default: return "unknown"
        }
    }
}
