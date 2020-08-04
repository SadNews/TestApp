//
//  MapViewController.swift
//  TestApp
//
//  Created by Андрей Ушаков on 31.07.2020.
//  Copyright © 2020 Андрей Ушаков. All rights reserved.
//
import UIKit
import GoogleMaps
import GooglePlaces
import Firebase

//func addMark(latitude: Double, longitude: Double, title: String, subtitle: String) {
// let position = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
//   let marker = GMSMarker(position: position)
//   marker.title = "Привет кот"
//   marker.map = mapView
//}

class MapViewController: UIViewController, AddOrderViewControllerDelegate, addMarkProtocol {
    func addNewMark(latitude: Double, longitude: Double, title: String, subtitle: String) {
        let position = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
           let marker = GMSMarker(position: position)
           marker.title = "Привет кот"
           marker.map = mapView
    }
    
    func addMark(marker: GMSMarker) {
        marker.title = "Привет кот"
        marker.map = mapView
    }
    
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var addressLabel: UILabel!
    private var presenter: MapViewPresenter!
    var resultsViewController: GMSAutocompleteResultsViewController?
    var searchController: UISearchController?
    var zoom: Float = 15
    let locationManager = CLLocationManager()
    var currentLocation: CLLocation?
    let marker = GMSMarker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = MapViewPresenter()
        presenter.delegate = self
        resultsViewController?.delegate = self
        setupSearchController()
        mapView.isMyLocationEnabled = true
        mapView.delegate = self
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        mapView.settings.myLocationButton = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        presenter.observe()
    }
    
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        let popup = self.storyboard?.instantiateViewController(withIdentifier: "PopupVC") as! AddOrderViewController
        let vc5 = self.storyboard?.instantiateViewController(withIdentifier: "vc5") as! ViewControllerTime
        marker.position = CLLocationCoordinate2DMake(coordinate.latitude, coordinate.longitude)
        popup.position = marker.position
        vc5.delegate = self
        present(popup, animated: true, completion: nil)
    }
    
    
    @IBAction func btnZoomIn(_ sender: UIButton) {
        zoom = zoom + 1
        self.mapView.animate(toZoom: zoom)
    }
    @IBAction func btnZoomOut(_ sender: UIButton) {
        zoom = zoom - 1
        self.mapView.animate(toZoom: zoom)
    }
}

// MARK: - CLLocationManagerDelegate
extension MapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        guard status == .authorizedWhenInUse else {
            return
        }
        
        locationManager.startUpdatingLocation()
        mapView.isMyLocationEnabled = true
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            return
        }
        
        mapView.camera = GMSCameraPosition(target: location.coordinate, zoom: 15, bearing: 0, viewingAngle: 0)
        locationManager.stopUpdatingLocation()
    }
}

// MARK: - GMSMapViewDelegate
extension MapViewController: GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
        reverseGeocodeCoordinate(position.target)
    }
    
    func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {
           zoom = mapView.camera.zoom
       }
}
extension UIViewController {
    func presentOnRoot(viewController: AddOrderViewController){
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        self.present(navigationController, animated: false, completion: nil)
    }
}

extension MapViewController: GMSAutocompleteResultsViewControllerDelegate {
        func resultsController(_ resultsController: GMSAutocompleteResultsViewController, didAutocompleteWith place: GMSPlace) {
      print(place)
    }
    
    func resultsController(_ resultsController: GMSAutocompleteResultsViewController, didFailAutocompleteWithError error: Error) {
        print("Error: \(error.localizedDescription)")

    }
}
extension MapViewController {
    func setupSearchController() {
        resultsViewController = GMSAutocompleteResultsViewController()
        searchController = UISearchController(searchResultsController: resultsViewController)
        searchController?.searchResultsUpdater = resultsViewController

        let searchBar = searchController!.searchBar
        searchBar.sizeToFit()
        searchBar.placeholder = "Search for places"
        navigationItem.titleView = searchController?.searchBar
        definesPresentationContext = true
        searchController?.hidesNavigationBarDuringPresentation = false
    }
}
extension MapViewController {
private func reverseGeocodeCoordinate(_ coordinate: CLLocationCoordinate2D) {
       let geocoder = GMSGeocoder()
       
       geocoder.reverseGeocodeCoordinate(coordinate) { response, error in
           
           guard let address = response?.firstResult(), let lines = address.lines else {
               return
           }
           
           self.addressLabel.text = lines.joined(separator: "\n")
           
           let labelHeight = self.addressLabel.intrinsicContentSize.height
           self.mapView.padding = UIEdgeInsets(top: self.view.safeAreaInsets.top, left: 0,
                                               bottom: labelHeight, right: 0)
           
           UIView.animate(withDuration: 0.25) {
               self.view.layoutIfNeeded()
           }
       }
    }
}
