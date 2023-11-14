//
//  Recetas.swift
//  recetas
//
//  Created by Admin on 12/11/23.
//

import Foundation

struct Recetas: Codable {
    let id_receta: Int64
    let nombre_receta: String
    let imagen_receta: URL
    let descripcion_receta: String
    let pasos_receta: [String]
    let ingredientes: [String]
    let coordenadas_origen: CoordenadasOrigen
}

struct CoordenadasOrigen: Codable {
    let latitud: Double
    let longitud: Double
}
