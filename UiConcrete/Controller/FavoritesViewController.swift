//
//  FavoritesViewController.swift
//  UiConcrete
//
//  Created by Paulo Danilo Conceição Lima on 23/05/21.
//

import Foundation

import UIKit
import Kingfisher
import SwipeCellKit

class FavoritesViewController: UIViewController, SwipeCollectionViewCellDelegate{
  
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    let productID = "FavoritesCollectionViewCell"
    
    var nome = ["Paulo","Paulo","Paulo","Paulo","Paulo","Paulo","Paulo","Paulo","Paulo","Paulo"]
    var img = [#imageLiteral(resourceName: "Icon-29"),#imageLiteral(resourceName: "Icon-29"),#imageLiteral(resourceName: "Icon-29"),#imageLiteral(resourceName: "Icon-29"),#imageLiteral(resourceName: "Icon-29"),#imageLiteral(resourceName: "Icon-29"),#imageLiteral(resourceName: "Icon-29"),#imageLiteral(resourceName: "Icon-29"),#imageLiteral(resourceName: "Icon-29"),#imageLiteral(resourceName: "Icon-29")]
    var favoritees = [["NomeDoFilme":"", "ImagemDoFilme": "", "DescricaoDoFilme": ""]]
    var favTitulu:[String] = []
    var favImge:[String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // Do any additional setup after loading the view.
        self.collectionView.register(UINib(nibName: "FavoritesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: productID)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.reloadData()
        
        //print(favoritees)
    }
    
    
}

extension FavoritesViewController: UICollectionViewDataSource, UICollectionViewDelegate{
 
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        self.collectionView.reloadData()
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.collectionView.reloadData()
        return favTitulu.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: productID, for: indexPath) as! FavoritesCollectionViewCell
        cell.titLabel?.text = favTitulu[indexPath.row]
        cell.favImg.kf.setImage(with: URL(string: favImge[indexPath.row] ))
        cell.delegate = self
        //cell.titLabel.text = nome[indexPath.item]
        //cell.favImg.image = img[indexPath.item]
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, editActionsForItemAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }

           let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
               print("Oi")
            print(self.favTitulu[indexPath.item])
            print(self.favImge[indexPath.item])
            NotificationCenter.default.post(name: ViewController.notificationNameFav, object: nil, userInfo: ["titulo": self.favTitulu[indexPath.item], "imagem": self.favImge[indexPath.item]])
            
           }
           // customize the action appearance
           deleteAction.image = UIImage(named: "delete")

           return [deleteAction]
    }
    
    
   
}
 
    


extension FavoritesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,layout collectionViewLayout: UICollectionViewLayout,sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 300 , height: 170)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    }

}
