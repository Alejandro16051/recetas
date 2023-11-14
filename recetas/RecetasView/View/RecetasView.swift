//
//  ViewController.swift
//  recetas
//
//  Created by Admin on 12/11/23.
//

import UIKit
import Toaster

class RecetasView: UIViewController {
    private final let TAG = "RecetasView: "
    private let recetasViewModel = RecetasViewModel()
    
    // Bindings
    @IBOutlet weak var txtBusqueda: UISearchBar!
    @IBOutlet weak var tvRecetas: UITableView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    // Variables
    var recetas = [Recetas]()
    
    // Métodos
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        bind()
    }
    
    private func configureView() {
        // Carga
        navigationItem.title = "Yape Recetas"
        navigationItem.backButtonTitle = "Lista"
        indicator.isHidden = false
        indicator.startAnimating()
        recetasViewModel.obtenerRecetas()
    }
    
    private func bind() {
        recetasViewModel.refreshData = { [weak self] () in
            DispatchQueue.main.async {
                self?.recetas = self!.recetasViewModel.listaRecetas
                self?.tvRecetas.reloadData()
                self?.tvRecetas.keyboardDismissMode = .onDrag
                self?.indicator.stopAnimating()
                self?.indicator.isHidden = true
            }
        }
    }
    
}

// MARK: Extensión para el delegado del UITableView
extension RecetasView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(TAG, "Se encontró \(recetasViewModel.listaRecetas.count) recetas.")
        return recetas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let receta = recetas[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "recetaCell")!
        _ = cell.viewWithTag(0)!
        let ivReceta = cell.viewWithTag(1) as! UIImageView
        let lblTituloReceta = cell.viewWithTag(2) as! UILabel
        
        // Celda
        cell.layer.borderColor = CGColor.init(red: 104, green: 104, blue: 104, alpha: 1)
        
        
        // Imagen
        ivReceta.layer.cornerRadius = 5
        ivReceta.clipsToBounds = true
        ivReceta.contentMode = .scaleAspectFill
        ivReceta.loadFrom(url: receta.imagen_receta, PlaceHolderImage: UIImage(systemName: "exclamationmark.triangle.fill")!)
        
        // Titulo
        lblTituloReceta.sizeToFit()
        lblTituloReceta.text = receta.nombre_receta
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "DetalleReceta", bundle: nil)
        if let viewController = storyboard.instantiateViewController(withIdentifier: "DetalleRecetaView") as? DetalleRecetaView {
            viewController.receta = recetasViewModel.listaRecetas[indexPath.row]
            self.navigationController?.modalPresentationStyle = .fullScreen
            self.navigationController?.modalTransitionStyle = .coverVertical
            self.navigationController?.pushViewController(viewController, animated: true)
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

// MARK: Extensión para cargar UIImageViewd desde URL
extension UIImageView {
    func loadFrom(url: URL, PlaceHolderImage:UIImage) {
        if self.image == nil{
            self.image = PlaceHolderImage
        }
        
        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) -> Void in
            if error != nil {
                print(error ?? "No Error")
                return
            }
            DispatchQueue.main.async(execute: { () -> Void in
                let image = UIImage(data: data!)
                self.image = image
            })
        }).resume()
    }
}

// MARK: Extensión para filtrado de recetas
extension RecetasView: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let busqueda = searchBar.text?.lowercased() ?? ""
        
        if busqueda.isEmpty {
            recetas = recetasViewModel.listaRecetas
        } else {
            recetas = recetasViewModel.listaRecetas.filter { receta in
                let nombreRecetaEncontrados = receta.nombre_receta.lowercased().contains(busqueda)
                
                let ingredientesConcatenados = receta.ingredientes.joined(separator: " ").lowercased()
                let ingredientesRecetaEncontrados = ingredientesConcatenados.contains(busqueda)
                
                return nombreRecetaEncontrados || ingredientesRecetaEncontrados
            }
            
        }
        
        tvRecetas.reloadData()
        searchBar.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" { recetas = recetasViewModel.listaRecetas; tvRecetas.reloadData() }
    }
}
