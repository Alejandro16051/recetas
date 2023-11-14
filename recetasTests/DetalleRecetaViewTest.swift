//
//  DetalleRecetaViewTest.swift
//  recetasTests
//
//  Created by Admin on 14/11/23.
//

import XCTest
@testable import recetas

class DetalleRecetaViewTest: XCTestCase {
    var sut: DetalleRecetaView!
    
    override func setUpWithError() throws {
        let storyboard = UIStoryboard(name: "DetalleReceta", bundle: nil)
        let view = storyboard.instantiateViewController(withIdentifier: "DetalleRecetaView") as! DetalleRecetaView
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
        _ = try XCTUnwrap(sut.ivReceta, "Se debe crear el IBOutlet para el componente ivReceta(UIImageView)")
        _ = try XCTUnwrap(sut.lblDescripcion, "Se debe crear el IBOutlet para el componente lblDescripcion(UILabel)")
        _ = try XCTUnwrap(sut.lblIngredientes, "Se debe crear el IBOutlet para el componente lblIngredientes(UILabel)")
        _ = try XCTUnwrap(sut.lblInstrucciones, "Se debe crear el IBOutlet para el componente lblInstrucciones(UILabel)")
        _ = try XCTUnwrap(sut.btnMapaOrigenReceta, "Se debe crear el IBOutlet para el componente btnMapaOrigenReceta(UIButton)")
    }
    
    func testCamposReceta_EstaVacia() throws {
        XCTAssertEqual(sut.ivReceta.image != nil, true, "Se debe enviar data(imagen) de receta desde view anterior")
        XCTAssertNotEqual(sut.lblDescripcion.text, "", "Se debe enviar data(descripcion) de receta desde view anterior")
        XCTAssertNotEqual(sut.lblIngredientes.text, "", "Se debe enviar data(ingredientes) de receta desde view anterior")
        XCTAssertNotEqual(sut.lblInstrucciones.text, "", "Se debe enviar data(instrucciones) de receta desde view anterior")
        XCTAssertEqual(sut.receta?.coordenadas_origen != nil, true, "Se debe enviar data(coordenadas_origen) de receta desde view anterior")
    }
    
    func testBoton_VerOrigenReceta() throws {
        XCTAssertEqual(sut.receta?.coordenadas_origen != nil, sut.btnMapaOrigenReceta.isEnabled, "Se debe enviar data(coordenadas_origen) de receta desde view anterior")
    }
}
