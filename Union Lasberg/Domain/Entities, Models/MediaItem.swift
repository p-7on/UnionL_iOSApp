//
//  MediaItem.swift
//  Union Lasberg
//
//  Created by Simon Puchner on 13.03.25.
//

import Foundation

struct MediaItem: Decodable {
    let id: Int
    let guid: RenderedText
    
    var imageURL: String {
        return guid.rendered
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case guid
    }
}
