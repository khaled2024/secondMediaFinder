//
//  MapVC.swift
//  testMyTestTwo
//
//  Created by KhaleD HuSsien on 18/10/2021.
//
import MapKit
import UIKit

protocol ShowLocationDelegation {
    func location(location: String)
}
class MapVC: UIViewController {
    //MARK: outlets
    @IBOutlet weak var confirmBtn: UIButton!
    @IBOutlet weak var addressShowLable: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    
    //MARK: Variable
    let locationManager = CLLocationManager()
    let regionInMeters: Double = 1000000
    var delegate: ShowLocationDelegation?
    
    //MARK: Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        checkLocationServices()
    }
    override func viewWillAppear(_ animated: Bool) {
        confirmBtn.layer.cornerRadius = 7.0
    }
    //MARK: private Functions
    private func centerMapOnUserLocation(){
        if let location = locationManager.location?.coordinate{
            let region = MKCoordinateRegion(center: location, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
            mapView.setRegion(region, animated: true)
            // here to reverse the address to the addressLable
            self.setAddressFrom(location: locationManager.location!)
        }
    }
    
    private func centerMapOnSpacificLocation(){
        let location = CLLocation(latitude: 30.741849, longitude: 31.00691)
        let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
        mapView.setRegion(region, animated: true)
        self.setAddressFrom(location: location)
    }

    private func checkLocationServices(){
        if CLLocationManager.locationServicesEnabled(){
            setUpLocationManager()
            checkLocationAuthorizationStatus()
        }else{
            getAlert(message: "please open location services")
        }
    }
    
   
    private func checkLocationAuthorizationStatus(){
        switch CLLocationManager.authorizationStatus() {
        case .authorizedAlways , .authorizedWhenInUse :
            centerMapOnUserLocation()
        case .denied , .restricted:
            // show alert
            getAlert(message: "show alert open ur location services")
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        @unknown default:
            print("Unknown status")
        }
    }
    
    private func setUpLocationManager(){
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    private func setAddressFrom(location: CLLocation){
        let geoCoder = CLGeocoder()
        geoCoder.reverseGeocodeLocation(location) { (placeMarks,error) in
            if let error = error {
                print("show alert ur location cant find it \(error.localizedDescription)")
            }else if let firstPlaceMark = placeMarks?.first {
                let countryname = firstPlaceMark.country ?? ""
                let cityname = firstPlaceMark.locality ?? ""
                let streetName = firstPlaceMark.thoroughfare ?? ""
                let region = firstPlaceMark.subLocality ?? ""
                self.addressShowLable.text = "\(countryname) \(cityname) \(region) \(streetName)"
            }
        }
    }
    
    //MARK: Actions
    @IBAction func confirmBtnTapped(_ sender: UIButton) {
        let location = addressShowLable.text ?? ""
        delegate?.location(location: location)
        self.dismiss(animated: true, completion: nil)
    }
}

//MARK: Extension
extension MapVC: MKMapViewDelegate{
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        let lat = mapView.centerCoordinate.latitude
        let long = mapView.centerCoordinate.longitude
        let location = CLLocation(latitude: lat, longitude: long)
        self.setAddressFrom(location: location)
    }
}
extension MapVC: CLLocationManagerDelegate{
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorizationStatus()
    }
}














