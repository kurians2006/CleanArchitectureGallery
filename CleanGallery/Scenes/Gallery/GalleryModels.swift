//
//  GalleryModels.swift
//  CleanGallery
//
//  Created by Naeem Paracha on 01/07/2021.
//

import UIKit

enum GalleryModels {

    // MARK: - Use Cases

    enum FetchPhotos {
        struct Request {
            var page : Int
        }

        struct Response {
            var photos: Photos
            var error: PhotoGalleryError?
        }

        struct ViewModel {
            var photos: [Photo]
        }
    }
    
    
    // MARK: - Types

    typealias PhotoGalleryError = Error<PhotoGalleryErrorType>
    
    enum PhotoGalleryErrorType {
        case networkError
        case unknown
    }

    struct Error<T> {
        var type: T
        var message: String?

        init(type: T) {
            self.type = type
        }
    }

}
