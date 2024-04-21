//
//  ApiModel.swift
//  ImageScroller
//
//  Created by madhur bansal on 21/04/24.
//

import Foundation

struct ApiModel: Codable {
    let thumbnail: Thumbnail
}

// MARK: - Thumbnail
struct Thumbnail: Codable {
    let domain: String
    let basePath: String
    let key: String
}
