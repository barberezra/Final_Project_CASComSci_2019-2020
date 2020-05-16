import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var imageURL = URL(string: "https://d2ciprw05cjhos.cloudfront.net/files/v3/styles/gs_standard/public/images/19/07/ptx.jpg?itok=Nmbx3Ivy")!
        let task = URLSession.shared.dataTask(with: imageURL) { (data, response, error) in
            if error == nil {
                let loadedImage = UIImage(data: data!)
                self.imageView.image = loadedImage!
            }
        }
        task.resume()
        
    }
    

}
