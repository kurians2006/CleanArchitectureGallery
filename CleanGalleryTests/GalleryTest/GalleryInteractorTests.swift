//
//  GalleryInteractorTests.swift
//  CleanGalleryTests
//
//  Created by Naeem Paracha on 02/07/2021.
//

@testable import CleanGallery
import XCTest

class GalleryInteractorTests: XCTestCase {

    // MARK: - Subject Under Test (SUT)

    typealias Models = GalleryModels
    var sut: GalleryInteractor!

    // MARK: - Test Lifecycle

    override func setUp() {
        super.setUp()
        setupGalleryInteractor()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    // MARK: - Test Setup

    func setupGalleryInteractor() {
        sut = GalleryInteractor()
    }
}
