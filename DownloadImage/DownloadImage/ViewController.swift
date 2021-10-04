//
//  ViewController.swift
//  DownloadImage
//
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var Button: UIButton!
    @IBOutlet weak var activityInd: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityInd.isHidden = true
        activityInd.hidesWhenStopped = true
        
    }

    @IBAction func getImage(_ sender: UIButton) {
        
        activityInd.isHidden = false
        activityInd.startAnimating()
        
        guard let url = URL(string: "https://picsum.photos/240/240") else { return }
        
        let session = URLSession.shared
        
        session.dataTask(with: url) { (data, response, error) in
            
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.activityInd.stopAnimating()
                    self.image.image = image
                }
            }
        }.resume()
        
    }
    
}




















