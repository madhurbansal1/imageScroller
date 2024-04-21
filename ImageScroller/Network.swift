//
//  Network.swift
//  ImageScroller
//
//  Created by madhur bansal on 21/04/24.
//

import Foundation

class Network {
    func getImages(completion: @escaping (([ApiModel], String) -> Void)) {
        let urlStr = "https://acharyaprashant.org/api/v2/content/misc/media-coverages?limit=100"
        let url = URL(string: urlStr)!
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil else {
                completion([], error?.localizedDescription ?? "error in getting images")
                return
            }
            guard let data = data else {
                completion([], "data returned in null")
                return
            }
            do {
                let imageArr = try JSONDecoder().decode([ApiModel].self, from: data)
                completion(imageArr, "")
            } catch {
                completion([], "error in parsing data")
            }
        }.resume()
    }
}
