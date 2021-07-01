//
//  GalleryWorker.swift
//  CleanGallery
//
//  Created by Naeem Paracha on 01/07/2021.
//

import UIKit
import PromiseKit

class GalleryWorker {

    // MARK: - Properties

    typealias Models = GalleryModels

    // MARK: - Methods
    
    func getAllPhotos(page: Int) -> Promise<ImageListResponse>{
        return NetworkManager.callApi(NetworkService.getPhotos(page: page), dataReturnType: ImageListResponse.self)
    }

}

