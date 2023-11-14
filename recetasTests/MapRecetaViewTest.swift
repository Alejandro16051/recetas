//
//  MapRecetaViewTest.swift
//  recetasTests
//
//  Created by Admin on 14/11/23.
//

import XCTest
@testable import recetas

class MapRecetaViewTest: XCTestCase {
    var sut: MapRecetaView!

    override func setUpWithError() throws {
        let storyboard = UIStoryboard(name: "MapReceta", bundle: nil)
        let view = storyboard.instantiateViewController(withIdentifier: "MapRecetaView") as! MapRecetaView
        view.receta = Recetas(id_receta: 1,
                              nombre_receta: "Receta TEST",
                              imagen_receta: URL(string: "https://www.google.com/images/branding/googlelogo/2x/googlelogo_color_150x54dp.png")!,
                              descripcion_receta: "Descripcion de receta TEST",
                              pasos_receta: ["Instruccion 1", "Instruccion 2"],
                              ingredientes: ["Ingrediente 1", "Ingrediente 2"],
                              coordenadas_origen: CoordenadasOrigen(latitud: 1.0,longitud: 1.0)
                             )
        sut = view
        sut.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func testLoadView() throws {
        _ = try XCTUnwrap(sut.mapView, "Se debe crear el IBOutlet para el componente mapView(GMSMapView)")
    }


}
