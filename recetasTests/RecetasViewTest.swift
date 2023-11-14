//
//  RecetasViewTest.swift
//  recetasTests
//
//  Created by Admin on 13/11/23.
//

import XCTest
@testable import recetas

class RecetasViewTest: XCTestCase {
    var sut: RecetasView!
    
    override func setUpWithError() throws {
        let storyboard = UIStoryboard(name: "Recetas", bundle: nil)
        let view = storyboard.instantiateViewController(withIdentifier: "RecetasView") as! RecetasView
        sut = view
        sut.loadViewIfNeeded()
    }
    
    override func tearDownWithError() throws {
        sut = nil
    }
    
    func testLoadView() throws {
        _ = try XCTUnwrap(sut.tvRecetas, "Se debe crear el IBOutlet para el componente tvRecetas(UITableView)")
        _ = try XCTUnwrap(sut.tvRecetas.dequeueReusableCell(withIdentifier: "recetaCell")!, "Debe crearse una celda prototipo")
        _ = try XCTUnwrap(sut.txtBusqueda, "Se debe crear el IBOutlet para el componente txtBusqueda(UISearchBar)")
    }
    
    func testSearchBar_EstaVacio() throws {
        let busqueda = try XCTUnwrap(sut.txtBusqueda)
        XCTAssertEqual(busqueda.text, "", "La busqueda debería iniciar en blanco")
    }
    
    func testSearchBar_ActivarBusqueda() throws {
        let busqueda = try XCTUnwrap(sut.txtBusqueda)
        busqueda.text = "carne"
        XCTAssertEqual(busqueda.text?.isEmpty, busqueda.showsSearchResultsButton, "El boton de busqueda debe activarse si se escribe en el SearchBar")
    }
}
