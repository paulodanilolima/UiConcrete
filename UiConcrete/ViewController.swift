//
//  ViewController.swift
//  UiConcrete
//
//  Created by Paulo Danilo Conceição Lima on 10/05/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    let productID = "CollectionViewCell"
    
    
    let nome = ["Paulo", "Paulo" , "Paulo", "Paulo", "Paulo", "Paulo", "Paulo", "Paulo" , "Paulo", "Paulo"]
    let img = [#imageLiteral(resourceName: "image6"), #imageLiteral(resourceName: "image6"), #imageLiteral(resourceName: "image6"), #imageLiteral(resourceName: "image6"), #imageLiteral(resourceName: "image6"), #imageLiteral(resourceName: "image6"), #imageLiteral(resourceName: "image6"), #imageLiteral(resourceName: "image6"), #imageLiteral(resourceName: "image6"), #imageLiteral(resourceName: "image6")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
            
        self.collectionView.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CollectionViewCell")
        self.collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: productID)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.reloadData()
        
        
    }


}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource{

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.nome.count    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: productID, for: indexPath) as! CollectionViewCell
        cell.backgroundColor = .green
        cell.label?.text = self.nome[indexPath.item]
        cell.img?.image = self.img[indexPath.item]
        
        print(nome[indexPath.item])
        print(img[indexPath.item])
        
        return cell
    }
    
    
    
}
