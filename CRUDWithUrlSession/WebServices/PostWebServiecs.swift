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
    case encodingError
    case statusCodeIsNotOkay
}

class PostWebServiecs {
    static let shared = PostWebServiecs()
    private let session = URLSession.shared
    
    //Get Method
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
            guard let response = response as? HTTPURLResponse else {
                print("Response is nil")
                return
            }
            if response.statusCode == 200{
                do{
                    let decoder = JSONDecoder()
                    let responseObject = try decoder.decode([Post].self, from: jsonData)
                    completion(.success(responseObject))
                }catch{
                    completion(.failure(.canNotProcessData))
                }
            }else{
                completion(.failure(.statusCodeIsNotOkay))
            }
            
        }
        
        dataTask.resume()
    }
    
    //Post method
    func postPost(newPost:Post, completion:@escaping(Result<Post, NetworkingError>)->Void){
        let urlStirng = EndPointSouce.getEndPoint(type: .Base) + EndPointSouce.getEndPoint(type: .Posts)
        
        guard let url = URL(string: urlStirng) else {
            completion(.failure(.invalidURL))
            return
        }
        // Convert model to JSON data
       
            guard let jsonData = try? JSONEncoder().encode(newPost) else {
                completion(.failure(.encodingError))
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
            guard let response = response as? HTTPURLResponse else {
                print("Response is nil")
                return
            }
            if response.statusCode == 201{
                do{
                    let decoder = JSONDecoder()
                    let response = try decoder.decode(Post.self, from: jsonData)
                    completion(.success(response))
                }catch{
                    completion(.failure(.canNotProcessData))
                }
            }else{
                completion(.failure(.statusCodeIsNotOkay))
            }
            
        }
        
        dataTask.resume()
    }
    
    //Put Method for updating data
    func updatePost(with updatePost:Post, completion:@escaping(Result<Post, NetworkingError>)->Void){
        let urlStirng = EndPointSouce.getEndPoint(type: .Base) + EndPointSouce.getEndPoint(type: .SpecificPost(updatePost.id))
        
        guard let url = URL(string: urlStirng) else {
            completion(.failure(.invalidURL))
            return
        }
        // Convert model to JSON data
        guard let jsonData = try? JSONEncoder().encode(updatePost) else {
            print("Encoding error")
            completion(.failure(.encodingError))
            return
        }
        // Create the url request
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type") // the request is JSON
        request.setValue("application/json", forHTTPHeaderField: "Accept") // the response expected to be in JSON format
        request.httpBody = jsonData
        
        let dataTask = session.dataTask(with: request) { data, response, error in
            guard let jsonData = data else{
                completion(.failure(.nodataAvailable))
                return
            }
//            guard let response = response as? HTTPURLResponse, (200 ..< 299) ~= response.statusCode else {
//                print("Error: HTTP request failed")
//                return
//            }
            guard let response = response as? HTTPURLResponse else {
                print("Response is nil")
                return
            }
            if response.statusCode == 200{
                do{
                    let decoder = JSONDecoder()
                    let responseDataObject = try decoder.decode(Post.self, from: jsonData)
                    completion(.success(responseDataObject))
                }catch{
                    completion(.failure(.canNotProcessData))
                }
            }else{
                completion(.failure(.statusCodeIsNotOkay))
            }
            
        }
        
        dataTask.resume()
    }
    
    //Delete A Post
    func deletePost(withID id:Int, completion:@escaping(Result<Post, NetworkingError>)->Void){
        let urlStirng = EndPointSouce.getEndPoint(type: .Base) + EndPointSouce.getEndPoint(type: .SpecificPost(id))
        
        guard let url = URL(string: urlStirng) else {
            completion(.failure(.invalidURL))
            return
        }

        // Create the url request
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        request.setValue("application/json", forHTTPHeaderField: "Accept") // the response expected to be in JSON format
        
        let dataTask = session.dataTask(with: request) { data, response, error in
            guard let jsonData = data else{
                completion(.failure(.nodataAvailable))
                return
            }
//            guard let response = response as? HTTPURLResponse, (200 ..< 299) ~= response.statusCode else {
//                print("Error: HTTP request failed")
//                return
//            }
            guard let response = response as? HTTPURLResponse else {
                print("Response is nil")
                return
            }
            if response.statusCode == 200{
                do{
                    let decoder = JSONDecoder()
                    debugPrint(jsonData)
                    let responseDataObject = try decoder.decode(Post.self, from: jsonData)
                    completion(.success(responseDataObject))
                }catch{
                    print("Data Deleted but respons is not a post")
                    completion(.failure(.canNotProcessData))
                }
            }else{
                completion(.failure(.statusCodeIsNotOkay))
            }
            
        }
        
        dataTask.resume()
    }
    
    
}
