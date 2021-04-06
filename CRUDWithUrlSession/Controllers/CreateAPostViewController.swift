//
//  CreateAPostViewController.swift
//  CRUDWithUrlSession
//
//  Created by MD Tanvir Alam on 6/4/21.
//

import UIKit

class CreateAPostViewController: UIViewController {

    //MARK:- Outlets
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var bodyTextField: UITextField!
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var userIdTextField: UITextField!
    
    //MARK:- LifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    //MARK:- actions
    @IBAction func createPostBTNPressed(_ sender: UIButton) {
        let userId = Int(titleTextField.text ?? "0") ?? 0
        let id = Int(idTextField.text ?? "0") ?? 0
        let bodyText = bodyTextField.text ?? "No body"
        let titleText = titleTextField.text ?? "No title"
        let newPost = Post(userId: userId, id: id, title: titleText, body: bodyText)
        PostWebServiecs.shared.postPost(newPost: newPost) { [weak self] result in
            switch result{
            case .success(let post):
                print("Success:\(post)")
                
            case .failure(let error):
                switch error{
                case .nodataAvailable:
                    print("No data Available: \(error)")
                case .invalidURL:
                    print("Invalid URL: \(error)")
                case .canNotProcessData:
                    print("Can not process Data: \(error)")
                case .encodingEror:
                    print("enodingError \(error)")
                }
            }
        }
    }
}
