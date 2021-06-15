//
//  DetalhesViewController.swift
//  UiConcrete
//
//  Created by Paulo Danilo Conceição Lima on 19/05/21.
//

import Foundation
import UIKit
import Kingfisher

class DetalhesViewController: UIViewController {
    
    @IBOutlet weak var imgLabel: UIImageView!
    @IBOutlet weak var tituloLabel: UILabel!
    @IBOutlet weak var classificacaoLabel: UILabel!
    @IBOutlet weak var descricaoLabel: UILabel!

    var favorites = [["NomeDoFilme":"", "ImagemDoFilme": "", "DescricaoDoFilme": ""]]
    var i: Int = 0

                            
    
    var img: String?
    var tittle: String?
    var classificacao: String = ""
    var detalhesDoFilme: String = ""
    var favoritos:[String] = []
    
    
    
    
    override func viewDidLoad() {   
        super.viewDidLoad()
        //print(tittle ?? "Teste")
        tituloLabel.text = tittle
        imgLabel.kf.setImage(with: URL(string: img ?? "Oi"))
       // classificacaoLabel.text = classificacao
        descricaoLabel.text = detalhesDoFilme
        
        
    }
    @IBAction func salveFavorites(_ sender: Any) {
        favorites.append(["NomeDoFilme" : tituloLabel.text!])
        favorites.append(["ImagemDoFilme" : img!])
        favorites.append(["DescricaoDoFilme" : descricaoLabel.text!])
        
       
        NotificationCenter.default.post(name: ViewController.notificationName, object: nil, userInfo: ["NomeDoFilme": tituloLabel.text!, "DescricaoDoFilme": descricaoLabel.text!,"ImagemDoFilme":img! ])
       
    }
    
}
