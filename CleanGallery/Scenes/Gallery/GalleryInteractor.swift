//
//  GalleryInteractor.swift
//  CleanGallery
//
//  Created by Naeem Paracha on 01/07/2021.
//

import UIKit
import Moya


protocol GalleryBusinessLogic {
    func fetchPhotos(request: GalleryModels.FetchPhotos.Request)
}

protocol GalleryDataStore {
    var userId: String? { get set }
}


class GalleryInteractor: GalleryBusinessLogic, GalleryDataStore {

    // MARK: - Properties

    typealias Models = GalleryModels

    lazy var worker = GalleryWorker()
    var presenter: GalleryPresentationLogic?

    var userId: String?

    // MARK: - Use Case - Fetch Album Photos
    
    func fetchPhotos(request: Models.FetchPhotos.Request){
        var response: Models.FetchPhotos.Response!
        var er: Models.PhotoGalleryError!
        
        worker.getAllPhotos(page: request.page).done{ photosList in
            response = Models.FetchPhotos.Response(photos: photosList.hits)
        }.catch { error in
            switch error{
            case MoyaError.underlying( _ as NSError, _):
                er = Models.PhotoGalleryError(type: .networkError)
                er.message = error.localizedDescription
                response = Models.FetchPhotos.Response(photos: [], error: er)
            default:
                er = Models.PhotoGalleryError(type: .unknown)
                er.message = error.localizedDescription
                response = Models.FetchPhotos.Response(photos: [], error: er)
            }
        }.finally {
            self.presenter?.presentFetchPhotos(response: response)
        }
    }
}
