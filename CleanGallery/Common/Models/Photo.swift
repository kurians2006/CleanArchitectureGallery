//
//  Photo.swift
//  CleanGallery
//
//  Created by Naeem Paracha on 01/07/2021.
//

typealias Photos = [Photo]

struct ImageListResponse: Decodable {
    var total: Int
    var totalHits: Int
    var hits: [Photo]
}

struct Photo: Codable {
    
    let id: Int
    let largeImageURL: String
    let previewURL: String
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case largeImageURL = "largeImageURL"
        case previewURL = "previewURL"
    }
}
