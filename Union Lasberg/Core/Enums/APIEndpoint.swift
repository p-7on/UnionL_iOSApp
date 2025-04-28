//
//  APIEndpoint.swift
//  Union Lasberg
//
//  Created by Simon Puchner on 18.03.25.
//

import Foundation

enum APIEndpoint: String {
    case homePosts = "https://www.union-lasberg.at/wp-json/wp/v2/posts"
    case clubPosts = "https://www.union-lasberg.at/wp-json/wp/v2/posts?categories=9"
    case soccerPosts = "https://www.union-lasberg.at/wp-json/wp/v2/posts?categories=2"
    case tennisPosts = "https://www.union-lasberg.at/wp-json/wp/v2/posts?categories=4"
    case runningPosts = "https://www.union-lasberg.at/wp-json/wp/v2/posts?categories=8"
    case fitnessPosts = "https://www.union-lasberg.at/wp-json/wp/v2/posts?categories=13"
    case media = "https://www.union-lasberg.at/wp-json/wp/v2/media/"
    
    var url: String {
        return self.rawValue
    }
}
