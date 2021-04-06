//
//  ViewController.swift
//  CRUDWithUrlSession
//
//  Created by MD Tanvir Alam on 6/4/21.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //MARK:- outlets
    @IBOutlet weak var table: UITableView!
    
    //MARK:- variables
    var posts = [Post](){
        didSet{
            DispatchQueue.main.async {
                self.table.reloadData()
            }
        }
    }
    
    //MARK:- lifeCycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.delegate = self
        table.dataSource = self
        getPosts()
    }
    
    //MARK:- actions
    @IBAction func CreateAPostBTNpressed(_ sender: UIBarButtonItem) {
    }
    
    //MARK:- functions
    func getPosts(){
        PostWebServiecs.shared.getPosts { [weak self] result in
            switch result{
            case .success(let posts):
                self?.posts = posts
            case .failure(let error):
                switch error{
                case .nodataAvailable:
                    print("No data Available: \(error.localizedDescription)")
                case .invalidURL:
                    print("invalid url: \(error.localizedDescription)")
                case .canNotProcessData:
                    print("canNotProcessData: \(error.localizedDescription)")
                case .encodingEror:
                    print("Encoding Error: \(error.localizedDescription)")
                }
            }
        }
    }
    
    //MARK:- DelegateFunctions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "Postcell", for: indexPath)
        cell.textLabel?.text = posts[indexPath.row].title
        return cell
    }
}

