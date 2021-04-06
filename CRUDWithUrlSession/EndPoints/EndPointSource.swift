//
//  Endpoints.swift
//  CRUDWithUrlSession
//
//  Created by MD Tanvir Alam on 6/4/21.
//

import Foundation

enum EndPoint {
    case Base, Posts, SpecificPost(Int)
}

class EndPointSouce {
    
//    static var basicHeaders = ["Content-Type":"application/json", "Accept":"application/json"]
//
//    static func CustomHeaders() -> [String:String] {
//        //let token = CoreDataManager.shared.getUserLoken()?.token ?? ""
//        //let CustomHeaders = ["Authorization":"Bearer \(token)",
//                             //"Content-Type":"application/json",
//                             //"Accept":"application/json"]
//        let CustomHeaders = ["Content-Type":"application/json",
//                             "Accept":"application/json"]
//        return CustomHeaders
//    }
//
//    static func MultiPartCustomHeaders() -> [String:String] {
//        //let token = CoreDataManager.shared.getUserLoken()?.token ?? ""
//        let multiPartCustomHeaders = [//"Authorization":"Bearer \(token)",
//                                      "Content-Type":"multipart/form-data",
//                                      "Accept":"application/json"]
//        return multiPartCustomHeaders
//    }
    
    static func getEndPoint(type:EndPoint) -> String {
        switch type {
        case .Base:
            return "https://jsonplaceholder.typicode.com"
        case .Posts:
            return "/posts"
        case .SpecificPost(let id):
            return "/posts/\(id)"
        }
    }
}
