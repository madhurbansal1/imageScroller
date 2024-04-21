//
//  LazyImage.swift
//  ImageScroller
//
//  Created by madhur bansal on 21/04/24.
//

import UIKit

class LazyImage: UIImageView {
    var task: URLSessionDataTask?
    var cache = NSCache<AnyObject, AnyObject>()
    
    func loadImage(url: URL) {
        self.image = .placeholder
        if let task = task {
            task.cancel()
        }
        if let image = cache.object(forKey: url.absoluteString as AnyObject) as? UIImage {
            self.image = image
            return
        }
        DispatchQueue.global().async { [weak self] in
            self?.task = URLSession.shared.dataTask(with: url, completionHandler: { data, response, error in
                guard error == nil, let data = data, let image = UIImage(data: data) else {
                    return
                }
                self?.cache.setObject(image as AnyObject, forKey: url.absoluteString as AnyObject)
                DispatchQueue.main.async {
                    self?.image = image
                }
            })
            self?.task?.resume()
        }
    }
}
