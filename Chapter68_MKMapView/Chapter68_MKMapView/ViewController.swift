//
//  ViewController.swift
//  Chapter68_MKMapView
//
//  Created by 小鍋涼太 on 2021/10/05.
//

import UIKit
import MapKit

class ViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    private var locationManager: CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // §68.1 Change map-type
        mapView.mapType = .standard
//        mapView.mapType = .satellite
//        mapView.mapType = .satelliteFlyover
        
        // §68.2 Simulate a custom location
        // Taipie.gpxのようなものを設定すると、シミュレータの現在位置が追加できる。
        
        // §68.3 Set Zoom/Region for Map
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        mapView.delegate = self
    
        // §68.4 Local search implementation using MKLocalSearch
        // 自然言語で検索できるようになる
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = "温泉"
        request.region = mapView.region
        let search = MKLocalSearch(request: request)
        search.start { res, err in
            if res?.mapItems.count == 0 {
                print("マッチしませんでした")
            } else {
                res?.mapItems.forEach {
                    print("\($0.name ?? ""): \($0.phoneNumber ?? "")")
                }
            }
        }
        
        // §68.5 OpenStreetMap Tile-Overlay
        let urlTemplate = "https://tile.openstreetmap.org/{z}/{x}/{y}.png"
        let overlay = MKTileOverlay(urlTemplate: urlTemplate)
        overlay.canReplaceMapContent = true
        mapView.addOverlay(overlay, level: .aboveLabels)
        
        // §68.6 Scroll to coordinate and zoom-level
        // See mnbayan/MKMapViewExtension.swift (gist)
        
        // §68.7 Working With Annotation
        let koukyoAnnotation = MKPointAnnotation()
        koukyoAnnotation.title = "皇居"
        koukyoAnnotation.subtitle = "いいところ"
        koukyoAnnotation.coordinate = CLLocationCoordinate2D(latitude: 35.685, longitude: 139.753)
        mapView.addAnnotation(koukyoAnnotation)
        let allAnnotations = mapView.annotations
        for annotation in allAnnotations {
            let annotationView = mapView.view(for: annotation)
            if let annotationView = annotationView {
                annotationView.image = UIImage(named: "star")
            }
        }
        
        // §68.6 Add MKMapView
        _ = MKMapView(frame: CGRect(x: 0, y: 0, width: 320, height: 500))
        
        // §68.10 Adding Pin/Point Annotation on map
        mapView.register(nil, forAnnotationViewWithReuseIdentifier: "PinAnnotationView")
        
        // §68.11  Adjust the map view's visible rect in order to display all annotations
        mapView.showAnnotations(mapView.annotations, animated: true)
    }

}

extension ViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        // §68.3 Set Zoom/Region for Map
        // ユーザーの位置を中心に1kmの範囲のズームレベルにしたい
        let userLocation = mapView.userLocation
        let region = MKCoordinateRegion(center: userLocation.location!.coordinate, latitudinalMeters: 1_000, longitudinalMeters: 1_000)
        mapView.setRegion(region, animated: false)
    }
    
    // §68.5 これがないと動かない。
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if overlay is MKTileOverlay {
            let renderer = MKTileOverlayRenderer(overlay: overlay)
            return renderer
        } else {
            return MKTileOverlayRenderer()
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation.isKind(of: MKUserLocation.self) {
            return nil
        }
        if annotation.isKind(of: MKPointAnnotation.self) {
            guard let pinView = mapView.dequeueReusableAnnotationView(withIdentifier: "PinAnnotationView") else {
                let pinView = MKAnnotationView()
                pinView.canShowCallout = true
                let pienImage = UIImage(named: "mac")
                pinView.image = pienImage
                pinView.calloutOffset = CGPoint(x: 0, y: 32)
                return pinView
            }
            pinView.annotation = annotation
            return pinView
        }
        return nil
    }
    
}

extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.startUpdatingLocation()
            // §68.9 Show UserLocation and UserTracking example
            // これがないと、MKMapViewDelegateのdidUpdateすら呼ばれない。。
            mapView.showsUserLocation = true
            
            mapView.userTrackingMode = .follow
        }
    }
}
