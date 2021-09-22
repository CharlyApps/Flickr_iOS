//
//  FeedModel.swift
//  Flickr
//
//  Created by Carlos Bastida on 21/09/21.
//

import Foundation
struct FeedResponse: Codable {
    var title: String?
    var link: String?
    var description: String?
    var modified: String?
    var generator: String?
    var items: [Item]?
}
struct Item: Codable {
    var title: String?
    var link: String?
    var media: Media?
    var date_taken: String?
    var description: String?
    var published: String?
    var author: String?
    var author_id: String?
    var tags: String?

}
struct Media: Codable {
    var m: String?
}
