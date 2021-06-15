//
//  MovieManager.swift
//  concrete
//
//  Created by Paulo Danilo Conceição Lima on 19/04/21.
//

import Foundation

protocol MovieManagerDelegate {
    func didUpdateMovie(movie: MovieModel)
}

struct MovieManager {
    
    let movieURL = "https://api.themoviedb.org/3/search/movie?api_key=b95fdda6b595103b26600aa0b7ddccbf"
    
    var delegate: MovieManagerDelegate?
    
    func fetchMovie(movieName: String){
        let urlString = "\(movieURL)&query=\(movieName)"
        performRequest(urlString: urlString)
            print(urlString)
    }
    func fetchMoviePopular(movieName: String){
            let urlString = "https://api.themoviedb.org/3/movie/popular?api_key=b95fdda6b595103b26600aa0b7ddccbf&language=en-US&page=1&maximun=20"
            performRequest(urlString: urlString)
            print(urlString)
    }
    
    func performRequest(urlString: String){
        if let url = URL(string: urlString){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error!)
                    return
                }
                if let safeData = data {
                    if  let movie = self.paserJSON(movieData: safeData){
                        self.delegate?.didUpdateMovie(movie: movie)
                    }
                }
            }
            task.resume()
        }
    }
    func paserJSON(movieData: Data) -> MovieModel?{
        let decoder = JSONDecoder()
        do {
            var decodedData = try decoder.decode(MovieData.self, from: movieData)
            
            var classificacao: [Bool] = []
            var poster: [String] = []
            var lancamento: [String] = []
            var titulo:[String] = []
            var descricao:[String] = []
            //var genero:[Int] = []
            
            
            if decodedData.total_pages > 20 {
                decodedData.total_pages = 19
            }
            
            for n in 0...decodedData.total_pages {
                //print("Perto do erro olha a quantidade\(decodedData.total_pages)")
                
                classificacao.append(decodedData.results[n].adult)
                poster.append("https://image.tmdb.org/t/p/original" + decodedData.results[n].poster_path! )
                lancamento.append(decodedData.results[n].release_date)
                titulo.append(decodedData.results[n].original_title)
                descricao.append(decodedData.results[n].overview)
                //genero.append(decodedData.results[n].genre_id[])
            }
            
            let movie = MovieModel(adult: classificacao, poster_path: poster, release_date: lancamento, original_title: titulo, overview: descricao, total_pages: decodedData.total_pages)
            
            
            return movie
        }catch{
            print(error)
            return nil
        }
    }
}

