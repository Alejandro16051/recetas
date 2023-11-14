//
//  RecetasViewModel.swift
//  recetas
//
//  Created by Admin on 12/11/23.
//

import Foundation

class RecetasViewModel {
    private final let TAG = "RecetasViewModel: "
    
    // Funciones
    var refreshData = { () -> () in }
    //Datasource
    var listaRecetas: [Recetas] = [] {
        didSet {
            refreshData()
        }
    }
    
    func obtenerRecetas() {
        var request = URLRequest(url: URL(string: "https://demo3269625.mockable.io/recetas")!)
        request.httpMethod = "GET"
        request.addValue("applications/json; charset=utf8", forHTTPHeaderField: "Content-Type")
        request.addValue("APP_RECETAS", forHTTPHeaderField: "application")
        
        URLSession.shared.dataTask(with: request) {(data, response, error) in
            guard let data = data, error == nil, let respuesta = response as? HTTPURLResponse else {
                print(self.TAG, "Ha habido un error en la conexión: \(error!)")
                return
            }
            
            // Si respuesta OK
            if respuesta.statusCode == 200 {
                print(self.TAG, "Traemos del servicio \(String(describing: data))")
                
                do {
                    let decoder = JSONDecoder()
                    // Obtiene y retorna data parseada del servicio
                    self.listaRecetas = try decoder.decode([Recetas].self, from: data)
                } catch {
                    print("No se pudo parsear el archivo JSON, error: \(error.localizedDescription)")
                }
            } else {
                print(self.TAG, "Ha habido un error: \(respuesta.statusCode)")
            }
        }.resume()
    }
}
