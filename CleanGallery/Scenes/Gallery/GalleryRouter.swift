//
//  GalleryRouter.swift
//  CleanGallery
//
//  Created by Naeem Paracha on 01/07/2021.
//

import UIKit

protocol GalleryRoutingLogic {
    func routePhotoDetail()
}

protocol GalleryDataPassing {
    var dataStore: GalleryDataStore? { get }
}

class GalleryRouter: NSObject, GalleryRoutingLogic, GalleryDataPassing {

    // MARK: - Properties

    weak var viewController: GalleryViewController?
    var dataStore: GalleryDataStore?

    // MARK: - Routing

    func routePhotoDetail() {
        
        
    }

    
}

