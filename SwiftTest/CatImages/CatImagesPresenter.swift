//
//  CatImagesPresenter.swift
//  SwiftTest
//
//  Created by BmnGamer on 15/07/23.
//

import UIKit
import Foundation

protocol CatImagesPresenterProtocol {
    func catImagesFetched(_ imags: [UIImage])
}

class CatImagesPresenter: CatImagesPresenterProtocol {
    weak var view: CatImagesViewProtocol?
    
    init(view: CatImagesViewProtocol) {
        self.view = view
    }
    
    func catImagesFetched(_ images: [UIImage]) {
        view?.setupImagesCats(images)
    }
}
