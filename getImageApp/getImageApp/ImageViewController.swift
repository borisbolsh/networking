//
//  ImageViewController.swift
//  getImageApp
//
//

import UIKit

class ImageViewController: UIViewController {
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var activeIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activeIndicator.isHidden = true
        activeIndicator.hidesWhenStopped = true
        getImage()
    }
    
    func getImage() {
        activeIndicator.isHidden = false
        activeIndicator.startAnimating()
        
        guard let url = URL(string: "https://picsum.photos/400/800") else { return }
        
        let session = URLSession.shared
        
        session.dataTask(with: url) { (data, response, error) in
            
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.activeIndicator.stopAnimating()
                    self.image.image = image
                }
            }
        }.resume()
    }
    
    
}
