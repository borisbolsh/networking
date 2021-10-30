//
//  ViewController.swift
//  news
//
//

import UIKit

class ViewController: UIViewController {

    let sessionConfiguration = URLSessionConfiguration.default
    let session = URLSession.shared
    let decoder = JSONDecoder()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        getPosts()
    }

    func getPosts() {

        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }

        session.dataTask(with: url) { [weak self] (data, response, error) in

            guard let strongSelf = self else { return }

            if error == nil, let parseData = data {

                let posts = try? strongSelf.decoder.decode([Post].self, from: parseData)

                print("Posts: \(posts?.count) ")
            } else {
                print("Error: \(error?.localizedDescription)")
            }

        }.resume()


    }


}
