//
//  MapViewController.swift
//  WeatherTest
//
//  Created by Eugeniy on 13.08.2020.
//  Copyright © 2020 Eugeniy. All rights reserved.
//

import UIKit
import GoogleMaps

class MapViewController: UIViewController {
    // Координаты Ростова
//    let defLat = 47.222531
//    let defLng = 39.718705
    
    var currentLocation: CLLocation = CLLocation(latitude: 47.222531, longitude: 39.718705)
    var locationManager: CLLocationManager!
    var zoomLevel: Float = 11.0
    var mapView: GMSMapView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupMap()
    }
    
    func setupMap() {
        
        // Initialize the location manager.
        locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.distanceFilter = 50
        locationManager.startUpdatingLocation()
        locationManager.delegate = self
        
        let camera = GMSCameraPosition.camera(withLatitude: currentLocation.coordinate.latitude, longitude: currentLocation.coordinate.longitude, zoom: zoomLevel)
        mapView = GMSMapView.map(withFrame: self.view.frame, camera: camera)
        mapView.settings.myLocationButton = true
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mapView.isMyLocationEnabled = true
        mapView.delegate = self

        self.view.addSubview(mapView)
    }

    func getNearestForecast() {
        
        // удаляем старые маркеры
        mapView.clear()
        
        let marker = GMSMarker(position: currentLocation.coordinate)
        marker.map = mapView
        
        let citiesVC = self.tabBarController?.viewControllers?[1] as! CityListViewController
        citiesVC.cities = []
        
        WeatherAPIWorker.shared.getForecastAround(lat: currentLocation.coordinate.latitude, lng: currentLocation.coordinate.longitude, count: 20) { (err, list) in
            if (err != nil) {
                return
            }
            
            list?.list?.forEach({ (cast) in
                if let coords = cast.coord, let lat = coords.lat, let lon = coords.lon {
                    let marker = GMSMarker()
                    marker.position = CLLocationCoordinate2D(latitude: lat, longitude: lon)
                    marker.title = cast.name
                    marker.snippet = "Температура: \(cast.main?.temp ?? 0) ℃ \n\(cast.weather?[0].description ?? "")"
                    marker.map = self.mapView
                    marker.icon = GMSMarker.markerImage(with: .black)
                }
            })
            
            citiesVC.cities = list?.list ?? []
            
        }
    }

}

extension MapViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location: CLLocation = locations.last!
        print("Location: \(location)")

        let camera = GMSCameraPosition.camera(withLatitude: location.coordinate.latitude,
                                            longitude: location.coordinate.longitude,
                                            zoom: zoomLevel)
        self.currentLocation = location

        if mapView.isHidden {
        mapView.isHidden = false
        mapView.camera = camera
        } else {
        mapView.animate(to: camera)
        }

    }
    
    // Handle authorization for the location manager.
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
      switch status {
      case .restricted:
        print("Location access was restricted.")
      case .denied:
        print("User denied access to location.")
        // Display the map using the default location.
        mapView.isHidden = false
      case .notDetermined:
        print("Location status not determined.")
      case .authorizedAlways: fallthrough
      case .authorizedWhenInUse:
        print("Location status is OK.")
      @unknown default:
        fatalError()
      }
    }

    // Handle location manager errors.
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
      locationManager.stopUpdatingLocation()
      print("Error: \(error)")
    }
}

extension MapViewController: GMSMapViewDelegate {
    
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        currentLocation = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        getNearestForecast()
    }
    
    func mapView(_ mapView: GMSMapView, didTapMyLocation location: CLLocationCoordinate2D) {
        currentLocation = CLLocation(latitude: location.latitude, longitude: location.longitude)
        getNearestForecast()
    }
    
}
