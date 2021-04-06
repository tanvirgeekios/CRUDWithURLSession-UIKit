//
//  PostWebSecviecs.swift
//  CRUDWithUrlSession
//
//  Created by MD Tanvir Alam on 6/4/21.
//

import Foundation

enum NetworkingError:Error{
    case nodataAvailable
    case invalidURL
    case canNotProcessData
    case encodingEror
}

class PostWebServiecs {
    static let shared = PostWebServiecs()
    private let session = URLSession.shared
    
    func getPosts(completion:@escaping(Result<[Post], NetworkingError>)->Void){
        let urlStirng = EndPointSouce.getEndPoint(type: .Base) + EndPointSouce.getEndPoint(type: .Posts)
        
        guard let url = URL(string: urlStirng) else {
            completion(.failure(.invalidURL))
            return
        }
        // Create the url request
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let dataTask = session.dataTask(with: request) { data, response, error in
            guard let jsonData = data else{
                completion(.failure(.nodataAvailable))
                return
            }
            do{
                let decoder = JSONDecoder()
                let response = try decoder.decode([Post].self, from: jsonData)
                completion(.success(response))
            }catch{
                completion(.failure(.canNotProcessData))
            }
        }
        
        dataTask.resume()
    }
    
    func postPost(newPost:Post, completion:@escaping(Result<Post, NetworkingError>)->Void){
        let urlStirng = EndPointSouce.getEndPoint(type: .Base) + EndPointSouce.getEndPoint(type: .Posts)
        
        guard let url = URL(string: urlStirng) else {
            completion(.failure(.invalidURL))
            return
        }
        // Convert model to JSON data
        guard let jsonData = try? JSONEncoder().encode(newPost) else {
            completion(.failure(.encodingEror))
            return
        }
        // Create the url request
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type") // the request is JSON
        request.setValue("application/json", forHTTPHeaderField: "Accept") // the response expected to be in JSON format
        request.httpBody = jsonData
        
        let dataTask = session.dataTask(with: request) { data, response, error in
            guard let jsonData = data else{
                completion(.failure(.nodataAvailable))
                return
            }
            do{
                let decoder = JSONDecoder()
                let response = try decoder.decode(Post.self, from: jsonData)
                completion(.success(response))
            }catch{
                completion(.failure(.canNotProcessData))
            }
        }
        
        dataTask.resume()
    }
    
    
}
