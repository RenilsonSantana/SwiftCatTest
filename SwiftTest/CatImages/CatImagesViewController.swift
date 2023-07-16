//
//  ViewController.swift
//  SwiftTest
//
//  Created by BmnGamer on 15/07/23.
//

import UIKit
import Alamofire

protocol CatImagesViewProtocol: AnyObject {
    func setupImagesCats(_ images: [UIImage])
}

class CatImagesViewController: UIViewController, CatImagesViewProtocol {
    
    private var presenter: CatImagesPresenterProtocol?
    private var interactor: CatImagesInteractorProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        interactor?.featchImagesCat()
    }
    
    private func setup() {
        let viewController = self
        let presenter = CatImagesPresenter(view: viewController)
        let interactor = CatImagesInteractor(presenter: presenter)
        
        self.presenter = presenter
        self.interactor = interactor
    }
    
    func setupImagesCats(_ images: [UIImage]) {
        let imageSize: CGFloat = 80
        let spacing: CGFloat = 10.0
        let numberOfImagesPerRow = 4
        let numberOfRows = Int(ceil(Double(images.count) / Double(numberOfImagesPerRow)))
        let totalSpacing = spacing * CGFloat(numberOfImagesPerRow - 1)
        let horizontalPadding: CGFloat = 20.0
        let verticalPadding: CGFloat = 20.0
        
        let containerHeight = CGFloat(numberOfRows) * imageSize + (CGFloat(numberOfRows - 1) * spacing)
        let containerWidth = view.frame.width - (2 * horizontalPadding)
        
        let container = UIView()
        container.frame = CGRect(x: horizontalPadding, y: verticalPadding, width: containerWidth, height: containerHeight)
        container.backgroundColor = .clear
        
        var currentX: CGFloat = 0.0
        var currentY: CGFloat = 0.0
        var index = 0
        for image in images {
            let imageView = UIImageView()
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            imageView.frame = CGRect(x: currentX, y: currentY, width: imageSize, height: imageSize)
            container.addSubview(imageView)
            imageView.image = image
            currentX += imageSize + spacing
            
            if (index + 1) % numberOfImagesPerRow == 0 {
                currentX = 0.0
                currentY += imageSize + spacing
            }
            view.addSubview(container)
            index = index + 1
        }
    }
}
