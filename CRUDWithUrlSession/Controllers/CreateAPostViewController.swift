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
   
    @IBAction func createBTNPressed(_ sender: UIButton) {
        print("Create Post btn pressed")
        let newPost = getUserInputs()
        createPost(with: newPost)
    }
    
    
//    //updatePost(with: newPost)
    @IBAction func updateBTNPressed(_ sender: UIButton) {
        print("update btn pressed")
        let newPost = getUserInputs()
        updatePost(with: newPost)
    }
    
    @IBAction func deleteAPost(_ sender: UIButton) {
        print("delete btn pressed")
        let newPost = getUserInputs()
        deleteApost(with: newPost.id)
    }
    
    //MARK:- functions
    func deleteApost(with id:Int){
        PostWebServiecs.shared.deletePost(withID: id) { (result) in
            switch result{
            
            case .success(let post):
                print("Success Deleting post:\(post)")
            case .failure(let error):
                switch error{
                case .nodataAvailable:
                    print("No data Available: \(error)")
                case .invalidURL:
                    print("Invalid URL: \(error)")
                case .canNotProcessData:
                    print("Can not process Data: \(error)")
                case .encodingError:
                    print("enodingError \(error)")
                case .statusCodeIsNotOkay:
                    print("SstatusCodeIsNot200 \(error)")
                }
            }
        }
    }
    
    func getUserInputs()->Post{
        let userId = Int(titleTextField.text ?? "0") ?? 0
        let id = Int(idTextField.text ?? "0") ?? 0
        let bodyText = bodyTextField.text ?? "No body"
        let titleText = titleTextField.text ?? "No title"
        let newPost = Post(userId: userId, id: id, title: titleText, body: bodyText)
        return newPost
    }
    
    func updatePost(with updatePost: Post){
        PostWebServiecs.shared.updatePost(with: updatePost) { [weak self] result in
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
                case .encodingError:
                    print("enodingError \(error)")
                case .statusCodeIsNotOkay:
                    print("SstatusCodeIsNot200 \(error)")
                }
            }
        }
    }
    
    func createPost(with newPost:Post){
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
                case .encodingError:
                    print("enodingError \(error)")
                case .statusCodeIsNotOkay:
                    print("SstatusCodeIsNot200 \(error)")
                }
            }
        }
    }
}
