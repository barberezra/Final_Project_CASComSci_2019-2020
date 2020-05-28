import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var labelView: UILabel!
    @IBOutlet weak var findButton: UIButton!
    @IBOutlet weak var textField: UITextField!
    var inputNum: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.delegate = self
        
    }
    
    struct Response: Codable {
        let name: String
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        //textField code
        textField.resignFirstResponder()  //if desired
        grab()
        return true
    }
    
    
    func grab() {
        let inputNum = textField.text!
        let apiURL = URL(string: "https://swapi.dev/api/planets/\(inputNum)/")!
        let task = URLSession.shared.dataTask(with: apiURL) { (data, response, error) in
            if let data = data {
                do { let dictionary = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
                    print(dictionary)
                    let res = try JSONDecoder().decode(Response.self, from: data)
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

