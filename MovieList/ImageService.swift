//
//  ImageService.swift
//  MovieList
//
//  Created by admin on 05/10/2022.
//

import Foundation
import UIKit
class ImageService {
    static let share = ImageService()
    private let cacheImage = NSCache<NSString, UIImage>()
    private init() {}
    
     func loadImage(with url: String, complete: @escaping(UIImage?) -> Void) {
        let cacheID = NSString(string: url)
        if let image = cacheImage.object(forKey: cacheID) {
            complete(image)
        }
        guard let url = URL(string: url) else {  return }
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                return
            }
            DispatchQueue.main.async {
            guard let image = UIImage(data: data) else {
                complete(nil)
                return
            }
            self.cacheImage.setObject(image, forKey: cacheID)
            complete(image)
            }
        }
         task.resume()
    }
}
