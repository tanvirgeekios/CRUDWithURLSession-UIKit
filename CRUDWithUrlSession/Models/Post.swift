//
//  Post.swift
//  CRUDWithUrlSession
//
//  Created by MD Tanvir Alam on 6/4/21.
//

import Foundation

struct Post:Codable{
    var userId: Int
    var id: Int
    var title: String
    var body: String
}
