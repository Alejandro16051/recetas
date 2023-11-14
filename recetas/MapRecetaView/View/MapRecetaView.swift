//
//  MapView.swift
//  recetas
//
//  Created by Admin on 12/11/23.
//

import UIKit
import GoogleMaps

class MapRecetaView: UIViewController {
    private final let TAG = "MapRecetaView: "
    
    // Bindings
    @IBOutlet var mapView: GMSMapView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    // Variables
    var receta: Recetas?
    
    // Métodos
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        loadMap()
        bind()
    }
    
    private func configureView() {
        // Carga
        navigationItem.title = "Mapa Origen"
        indicator.isHidden = false
        indicator.startAnimating()
    }
    
    private func bind() {
        DispatchQueue.main.async {
            self.indicator.stopAnimating()
            self.indicator.isHidden = true
        }
    }
}

extension MapRecetaView: GMSMapViewDelegate {
    func loadMap() {
        mapView.camera = GMSCameraPosition.camera(withLatitude: receta!.coordenadas_origen.latitud, longitude: receta!.coordenadas_origen.longitud, zoom: 12.0)
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mapView.delegate = self
        
        // Marker
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: receta!.coordenadas_origen.latitud, longitude: receta!.coordenadas_origen.longitud)
        marker.title = receta!.nombre_receta
        marker.snippet = "Origen de la receta \(receta!.nombre_receta)"
        marker.map = mapView
        marker.icon = GMSMarker.markerImage(with: UIColor.red)
    }
    
}
