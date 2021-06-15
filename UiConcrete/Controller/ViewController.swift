//
//  ViewController.swift
//  UiConcrete
//
//  Created by Paulo Danilo Conceição Lima on 10/05/21.
//

import UIKit
import Kingfisher

class ViewController: UIViewController, UITextFieldDelegate, MovieManagerDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    
    @IBOutlet weak var searchTextField: UITextField!
    var movieManager = MovieManager()
    let productID = "CollectionViewCell"
    var quantidade = 0
    var titulo: [String] = []
    var classificacao: [Bool] = []
    var poster: [String] = []
    var lancamento: [String] = []
    var descricao: [String] = []
    var genero: [Int] = []
    var movieSender = Product(img: " ", titulo: " ", descre: " ", classi: true)
    static let notificationName = Notification.Name("myNotificationName")
    static let notificationNameFav = Notification.Name("FavNotificationName")
    var favorites = [["NomeDoFilme":"", "ImagemDoFilme": "", "DescricaoDoFilme": ""]]
    var NomeDoFilme: String = ""
    var ImagemDoFilme: String = ""
    var DescricaoDoFilme: String = ""
    var favTitulo:[String] = []
    var favImg:[String] = []
    var rmNome: String = ""
    var rmImg: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchTextField.delegate = self
        movieManager.delegate = self
        // Do any additional setup after loading the view.
        self.collectionView.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: productID)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        NotificationCenter.default.addObserver(self, selector: #selector(onNotification(notification:)), name: ViewController.notificationName, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(onNotification(notificationFav:)), name: ViewController.notificationNameFav, object: nil)
        movieManager.fetchMoviePopular(movieName: " ")
        self.collectionView.reloadData()
        self.collectionView.reloadData()
    }
    @objc func onNotification(notification:Notification){
        NomeDoFilme = notification.userInfo!["NomeDoFilme"]! as! String
        ImagemDoFilme = notification.userInfo!["ImagemDoFilme"]! as! String
        DescricaoDoFilme = notification.userInfo!["DescricaoDoFilme"]! as! String
        
        favTitulo.append(NomeDoFilme)
        favImg.append(ImagemDoFilme)
        //favorites.append(["DescricaoDoFilme" : DescricaoDoFilme])
    }
    
    @objc func onNotification(notificationFav:Notification){
        //print(notificationFav.userInfo!)
        //print(notificationFav.userInfo!["titulo"]!)
        //print(notificationFav.userInfo!["imagem"]!)
        for n in 0...favTitulo.count - 1{
            if favTitulo[n] == notificationFav.userInfo!["titulo"]! as! String{
                favTitulo.remove(at: n)
                favImg.remove(at: n)
                
            }
        }
        
    }
    
    @IBAction func searchPressed(_ sender: UIButton) {
        searchTextField.endEditing(true)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        return true
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            
            return true
        }else{
            textField.placeholder = "Digite Algo"
            return false
        }
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        //Use de SearchTextFild.text to get the movie
        if var movie = searchTextField.text {
            let newString = movie.replacingOccurrences(of: " ", with: "+")
            print(newString)
            movie = newString
            
            
            movieManager.fetchMovie(movieName: movie)
            self.collectionView.reloadData()
            
        }
        searchTextField.text = ""
    }
    func didUpdateMovie(movie: MovieModel){
        quantidade = movie.total_pages + 1
        classificacao = movie.adult
        titulo = movie.original_title
        lancamento = movie.release_date
        poster = movie.poster_path
        descricao=movie.overview

    }
    
    @IBAction func FavoritePress(_ sender: UIButton) {
        
        //self.performSegue(withIdentifier: "GoToFavorites", sender: self)
        
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        self.collectionView.reloadData()
        self.collectionView.reloadData()
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        collectionView.reloadData()
        collectionView.reloadData()
        return quantidade
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: productID, for: indexPath) as! CollectionViewCell
        cell.label?.text = titulo[indexPath.item]
        cell.img.kf.setImage(with: URL(string: poster[indexPath.item]))
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        movieSender.imprime(tituloo: titulo[indexPath.item], imgg: poster[indexPath.item], desc: descricao[indexPath.item], classifi: classificacao[indexPath.item])
        self.performSegue(withIdentifier: "GoToDetalhes", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GoToDetalhes" {
            let destinactionVC = segue.destination as! DetalhesViewController
            destinactionVC.img = movieSender.getImg()
            destinactionVC.tittle = movieSender.getTitulo()
            destinactionVC.detalhesDoFilme = movieSender.getdescre()
            // destinactionVC.classificacao = movieSender.getGenre()
        }
        if segue.identifier == "GoToFavorites" {
            let destinactionVC = segue.destination as! FavoritesViewController
            destinactionVC.favTitulu = favTitulo
            destinactionVC.favImge = favImg
        }
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,layout collectionViewLayout: UICollectionViewLayout,sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 150 , height: 270)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 15, left: 35, bottom: 0, right: 35)
    }
    
    
    
}
