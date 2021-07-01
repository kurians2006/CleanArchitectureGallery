//
//  GalleryPresenter.swift
//  CleanGallery
//
//  Created by Naeem Paracha on 01/07/2021.
//

import UIKit

protocol GalleryPresentationLogic {
    func presentFetchPhotos(response: GalleryModels.FetchPhotos.Response)
}

class GalleryPresenter: GalleryPresentationLogic {
    
    // MARK: - Properties
    
    typealias Models = GalleryModels
    weak var viewController: GalleryDisplayLogic?
    
    // MARK: - Use Case - Fetch Photos
    
    func presentFetchPhotos(response: Models.FetchPhotos.Response){
        if let error = response.error{
            viewController?.displayErrorMessage(message: error.message!)
        }else{
            let photos = response.photos.map({ Photo(id: $0.id, largeImageURL:  $0.largeImageURL, previewURL: $0.previewURL) })
            let viewModel = Models.FetchPhotos.ViewModel(photos: photos)
            viewController?.displayPhotos(viewModel: viewModel)
        }
    }
}

