//
//  ArticleModel.swift
//  News
//
//  Created by Andrey Samchenko on 20.08.2021.
//

import Foundation

func getCurrentDate() -> String{
    let date = Date()
    let format = DateFormatter()
    format.dateFormat = "yyyy-MM-dd"
    let formattedDate = format.string(from: date)

    print("formattedDate -> \(formattedDate)")
    return formattedDate
}

class Variables {
    static let newsAPIDOTorgKey: String = "a043af83b2ef483b8362fcf292557608"
    static let newsURL = URL(string:
        "https://newsapi.org/v2/everything?q=apple&from=2021-08-19&to=2021-08-19&sortBy=popularity&apiKey=95daf9a1b8bb430c9a3c378e16476eac")
}

var articles: [Article] {
    let data = try? Data(contentsOf: pathToArticlesInFS)
    if data == nil {
        return []
    }
    let rootDictionaryAny = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments)
    if rootDictionaryAny == nil {
        return []
    }
    
    let rootDictionary = rootDictionaryAny as? Dictionary<String, Any>
    if rootDictionaryAny == nil {
        return []
    }
    
    if let articlesArray = rootDictionary!["articles"] as? [Dictionary<String, Any>] {
        var parsedArticles: [Article] = []
        for dict in articlesArray {
            let newArticle = Article(dictionary: dict)
            parsedArticles.append(newArticle)
        }
        return parsedArticles
    }
    
    return []
}

var pathToArticlesInFS: URL {
    let usersLibraryPath = NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true)[0]+"/data.json"
    let pathToFetchedJSON = URL(fileURLWithPath: usersLibraryPath)
    return pathToFetchedJSON
}

func fetchArticles(complitionHandler: (()->Void)?) {
    let session = URLSession(configuration: .default)
    let downloadTask = session.downloadTask(with: Variables.newsURL!) {(urlFile, Result, Error) in
        if urlFile != nil {
            try? FileManager.default.copyItem(at: urlFile!, to: pathToArticlesInFS)
            complitionHandler?()
        }
    }
    downloadTask.resume()
}
