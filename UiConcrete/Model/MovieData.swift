//
//  File.swift
//  concrete
//
//  Created by Paulo Danilo Conceição Lima on 22/04/21.
//

import Foundation

struct MovieData: Decodable {
    let page: Int
    var total_pages: Int
    let results:[results]
}

struct results: Decodable {
    let adult: Bool
    let poster_path: String?
    let release_date: String
    let original_title: String
    let overview: String
    //let genre_ids: [Int]
    
}
