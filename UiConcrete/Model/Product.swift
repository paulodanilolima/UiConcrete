//
//  Product.swift
//  UiConcrete
//
//  Created by Paulo Danilo Conceição Lima on 10/05/21.
//

import Foundation


struct Product {
    
    var img: String
    var titulo: String
    var descre: String
    var classi: Bool
   // var genre: Int
    mutating func imprime(tituloo: String, imgg: String, desc: String, classifi: Bool){
        img = imgg
        titulo = tituloo
        descre = desc
        classi = classifi
        //genre = genree
    }
    
    func getImg() -> String {
        return img
    }
    
    func getdescre() -> String {
        return descre
    }
    func getClassifica() -> Bool {
        return classi
    }
    func getTitulo() -> String {
        return titulo
    }
    /*func getGenre() -> String{
        
        
        
        if genre == 28{
            return "action"
        } else if genre == 16{
            return "animated"
        }else if genre == 18{
            return "drama"
        }else if genre == 10751{
            return "family"
        }else if genre == 14{
            return "fantasy"
        }else if genre == 36{
            return "history"
        }else if genre == 35{
            return "comedy"
        }else if genre == 10752{
            return "war"
        }else if genre == 80{
            return "crime"
        }else if genre == 10402{
            return "music"
        }else if genre == 9648{
            return "mystery"
        }else if genre == 10749{
            return "romance"
        }else if genre == 878{
            return "sci fi"
        }else if genre == 27{
            return "horror"
        }else if genre == 10770{
            return "TV movie"
        }else if genre == 53    {
            return "thriller"
        }else if genre == 37{
            return "western"
        }else if genre == 12{
            return "adventure"
        }
        return "oi"
    }*/
    
}
