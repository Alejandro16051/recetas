//
//  DetailView.swift
//  recetas
//
//  Created by Admin on 12/11/23.
//

import UIKit

class DetalleRecetaView: UIViewController {
    private final let TAG = "DetalleRecetaView: "
    
    // Bindings
    @IBOutlet weak var ivReceta: UIImageView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var lblDescripcion: UILabel!
    @IBOutlet weak var lblIngredientes: UILabel!
    @IBOutlet weak var lblInstrucciones: UILabel!
    @IBOutlet weak var btnMapaOrigenReceta: UIButton!
    
    // Variables
    var receta: Recetas?
    
    // Métodos
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        loadReceta()
        bind()
    }
    
    private func configureView() {
        // Carga
        navigationItem.backButtonTitle = "Detalle"
        indicator.isHidden = false
        indicator.startAnimating()
        
        // Imagen
        ivReceta.layer.cornerRadius = 5
        ivReceta.clipsToBounds = true
        ivReceta.contentMode = .scaleAspectFill
        
        // Textos
        lblDescripcion.textAlignment = .left
        lblIngredientes.textAlignment = .left
        lblInstrucciones.textAlignment = .left
        
        // Botón
        btnMapaOrigenReceta.tintColor = UIColor.white
        btnMapaOrigenReceta.backgroundColor = UIColor.purple
        btnMapaOrigenReceta.layer.cornerRadius = 5
        btnMapaOrigenReceta.layer.borderWidth = 0.5
    }
    
    private func bind() {
        DispatchQueue.main.async {
            self.indicator.stopAnimating()
            self.indicator.isHidden = true
        }
    }
    
    private func loadReceta() {
        // Titulo
        navigationItem.title = receta!.nombre_receta
        
        // Imagen
        ivReceta.loadFrom(url: receta!.imagen_receta, PlaceHolderImage: UIImage(systemName: "exclamationmark.triangle.fill")!)
        
        // Descripcion
        lblDescripcion.text = receta!.descripcion_receta
        
        // Ingredientes
        lblIngredientes.text = receta!.ingredientes.map{ "• \($0)" }.joined(separator: "\n")
        
        // Instrucciones
        lblInstrucciones.text = receta!.pasos_receta.map{ "• \($0)" }.joined(separator: "\n")
    }
    
    @IBAction func didTapVerOrigenReceta(_ sender: Any) {
        let storyboard = UIStoryboard(name: "MapReceta", bundle: nil)
        if let viewController = storyboard.instantiateViewController(withIdentifier: "MapRecetaView") as? MapRecetaView {
            viewController.receta = receta!
            self.navigationController?.modalPresentationStyle = .fullScreen
            self.navigationController?.modalTransitionStyle = .coverVertical
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
}
