//
//  CatInteractor.swift
//  SwiftTest
//
//  Created by BmnGamer on 15/07/23.
//

import Foundation
import Alamofire

protocol CatImagesInteractorProtocol: AnyObject {
    func featchImagesCat()
}

class CatImagesInteractor: CatImagesInteractorProtocol {
    
    var presenter: CatImagesPresenterProtocol?
    
    init(presenter: CatImagesPresenterProtocol) {
        self.presenter = presenter
    }
    func featchImagesCat() {
        AF.request(CatImagesConstants.apiUrl, headers: [CatImagesConstants.authorization: CatImagesConstants.clientId]).responseJSON { response in
            switch response.result {
            case .success(let value):
                if let valueResponse = value as? [String: Any],
                   let data = valueResponse["data"] as? [[String: Any]] {
                    self.getImages(data) { result in
                        self.presenter?.catImagesFetched(result)
                    }
                }
            case .failure(let error):
                print("Error fetching cat images: \(error.localizedDescription)")
            }
        }
    }
    
    func getImages(_ data: [[String: Any]], completion: @escaping ([UIImage]) -> Void) {
        var imagesArray: [UIImage]? = []
        for image in data {
            guard let image = image["images"] as? [[String: Any?]] else {return}
            if let imageLink = image.first?["link"] as? String, let url = URL(string: imageLink) {
                AF.request(url).responseData { response in
                    if let imageData = response.data,
                       let image = UIImage(data: imageData) {
                        imagesArray?.append(image)
                    }
                }
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                if let images = imagesArray {
                    completion(images)
                }
            }
        }
    }
}
