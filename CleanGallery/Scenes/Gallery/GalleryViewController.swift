//
//  GalleryViewController.swift
//  CleanGallery
//
//  Created by Naeem Paracha on 01/07/2021.
//

import UIKit
import SDWebImage
import ImageViewer_swift
import SwiftSpinner

protocol GalleryDisplayLogic: AnyObject {
    func displayPhotos(viewModel: GalleryModels.FetchPhotos.ViewModel)
    func displayErrorMessage(message: String)
}

class GalleryViewController: UIViewController, GalleryDisplayLogic {

    // MARK: - Outlets
    @IBOutlet weak var photoCollection: UICollectionView!
    
    // MARK: - Properties
    
    typealias Models = GalleryModels
    var router: (NSObjectProtocol & GalleryRoutingLogic & GalleryDataPassing)?
    var interactor: GalleryBusinessLogic?
    
    private var isAlbumListOpen = false
    private var images: [Photo]?
    private var imageurls: [URL]?
    
    // MARK: - Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: - Setup
    
    private func setup() {
        let viewController = self
        let interactor = GalleryInteractor()
        let presenter = GalleryPresenter()
        let router = GalleryRouter()
        
        viewController.router = router
        viewController.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }

    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupFetchPhotos()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    func setupView(){
        let cellNib = UINib(nibName: "ThumbnailCell", bundle: nil)
        photoCollection.register(cellNib, forCellWithReuseIdentifier: "ThumbnailCell")
        photoCollection.dataSource = self
        photoCollection.delegate = self
        photoCollection.setCollectionViewLayout(GalleryFlowLayout(), animated: false)
    }

    // MARK: - Use Case - Fetch Photos
    func setupFetchPhotos() {
        SwiftSpinner.useContainerView(photoCollection)
        SwiftSpinner.show("Loading...")
        let request = Models.FetchPhotos.Request()
        interactor?.fetchPhotos(request: request)
    }
    
    func displayPhotos(viewModel: Models.FetchPhotos.ViewModel) {
        images = viewModel.photos
        imageurls = images?.compactMap({URL(string: $0.largeImageURL)})
        photoCollection.reloadData()
        SwiftSpinner.hide()
    }
    
    func displayErrorMessage(message: String) {
        SwiftSpinner.hide()
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }

}


extension GalleryViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:ThumbnailCell = collectionView
            .dequeueReusableCell(withReuseIdentifier: "ThumbnailCell",
                                 for: indexPath) as! ThumbnailCell
        
        cell.imageView.sd_setImage(with: URL(string: images![indexPath.item].previewURL))
        cell.imageView.setupImageViewer(
            urls: imageurls!,
            initialIndex: indexPath.item,
            options: [
                .theme(.light),
            ],
            from: self)
        
        return cell
    }
    
    
}

