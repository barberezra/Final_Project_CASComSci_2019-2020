import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var labelView: UILabel!
    @IBOutlet weak var findButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    struct Response: Codable {
        let name: String
    }
    
    @IBAction func grab() {
        let apiURL = URL(string: "https://swapi.dev/api/planets/12/")!
        let task = URLSession.shared.dataTask(with: apiURL) { (data, response, error) in
            if let data = data {
                do { let dictionary = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
                    print(dictionary)
                    let res = try JSONDecoder().decode(Response.self, from: data)
                    let name = res.name
                    DispatchQueue.main.async() {
                    self.labelView.text = String(res.name)
                    }
            }
                catch {
                    print("This errored out for some reason :(")
                }
            }
        }
        task.resume()
    }
}

