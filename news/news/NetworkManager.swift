//
//  NetworkManager.swift
//  news
//
//

import Foundation

enum getPostsResult {
    case success(posts: [Post])
    case failure(error: Error)
}

class NetworkManager {
    
    let sessionConfiguration = URLSessionConfiguration.default
    let session = URLSession.shared
    let decoder = JSONDecoder()
    
    func getPosts(completion: @escaping (getPostsResult) -> Void) {

            guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else {
                return
            }

            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            
            session.dataTask(with: url) { [weak self] (data, response, error) in

                let result: getPostsResult
                
                defer {
                    DispatchQueue.main.async {
                        completion(result)
                    }
                }
                
                guard let strongSelf = self else {
                    result = .success(posts: [])
                    return
                }

                if error == nil, let parseData = data {

                    guard let posts = try? strongSelf.decoder.decode([Post].self, from: parseData) else {
                        result = .success(posts: [])
                        return
                    }

                    result = .success(posts: posts)
                } else {
                    result = .failure(error: error!)
                }
                completion(result)
            }.resume()


        }
}
