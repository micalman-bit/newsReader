//
//  Article.swift
//  News
//
//  Created by Andrey Samchenko on 20.08.2021.
//

import Foundation

struct Article {
    var source: String
    var author: String
    var title: String
    var description: String
    var url: String
    var urlToImage: String
    var publishedAt: String
    var content: String
    
    init(dictionary: Dictionary<String, Any>) {
        source = (dictionary["source"] as? Dictionary<String, Any> ?? ["": ""])["name"] as? String ?? ""
        author = dictionary["author"] as? String ?? ""
        title = dictionary["title"] as? String ?? ""
        description = dictionary["description"] as? String ?? ""
        url = dictionary["url"] as? String ?? ""
        urlToImage = dictionary["urlToImage"] as? String ?? ""
        publishedAt = dictionary["publishedAt"] as? String ?? ""
        content = dictionary["content"] as? String ?? ""
    }
}
