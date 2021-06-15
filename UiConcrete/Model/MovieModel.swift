//
//  MovieModel.swift
//  concrete
//
//  Created by Paulo Danilo Conceição Lima on 24/04/21.
//

import Foundation

struct MovieModel {
    let adult: [Bool]
    let poster_path: [String]
    let release_date: [String]
    let original_title: [String]
    let overview:[String]
    let total_pages: Int
   // let generos: [Int]
    
    
    var releaseDataString: String {
        return String(format: "%.1f", release_date)
    }
    
}
