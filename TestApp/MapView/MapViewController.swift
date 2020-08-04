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

protocol AddMarkProtocol: class {
    func addNewMark(marker: GMSMarker)
}

final class MapViewController: UIViewController, AddMarkProtocol {
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var searchAdress: UITextField!
    private var presenter: MapViewPresenter!
    let locationManager = CLLocationManager()
    let marker = GMSMarker()
    var resultsViewController: GMSAutocompleteResultsViewController?
    var zoom: Float = 15
    var currentLocation: CLLocation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = MapViewPresenter()
        presenter.delegate = self
        searchAdress.isHidden = true
        mapView.isMyLocationEnabled = true
        mapView.delegate = self
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        mapView.settings.myLocationButton = true
    }
    
    func gotoPlaces() {
        searchAdress.resignFirstResponder()
        let acController = GMSAutocompleteViewController()
        acController.delegate = self
        present(acController, animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        presenter.observe()
    }
    
    @IBAction func searchAdresBtn(_ sender: UIButton) {
        gotoPlaces()
    }
    
    func addNewMark(marker: GMSMarker){
        marker.map = mapView
    }
    
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        let addNewOrderVC = self.storyboard?.instantiateViewController(withIdentifier: "addNewOrderVC") as! AddOrderViewController
        marker.position = CLLocationCoordinate2DMake(coordinate.latitude, coordinate.longitude)
        addNewOrderVC.position = marker.position
        present(addNewOrderVC, animated: true, completion: nil)
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

