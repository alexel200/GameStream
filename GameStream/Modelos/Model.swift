//
//  Model.swift
//  GameStream
//
//  Created by Jhon Rueda on 24/08/22.
//

import Foundation

struct Resultados:Codable{
    var results:[Game]
}

struct Games:Codable{
    var games:[Game]
}

struct Game:Codable, Hashable{
    var title: String
    var studio: String
    var contentRaiting: String
    var publicationYear: String
    var description: String
    var platforms: [String]
    var tags: [String]
    var videosUrls: videosUrls
    var galleryImages: [String]
}

struct videosUrls:Codable,Hashable{
    var mobile:String
    var tablet: String
}
