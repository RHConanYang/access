//
//  File.swift
//  access
//
//  Created by 楊仁翰 on 2020/2/24.
//  Copyright © 2020 Renhen Yang. All rights reserved.
//
import Foundation
import Combine
import SwiftUI

struct UserEntry: Decodable, Identifiable{
    let id: Int
    let avatar_url: String
    let login: String
    let site_admin: Bool
}


class NetworkManaged: ObservableObject {
    @Published var userList: [UserEntry] = [UserEntry]()

    init() {
        let urlString = "https://api.github.com/users?since=135"
        guard let url = URL(string: urlString) else{return}
        URLSession.shared.dataTask(with: url) { (data, resp, err) in
            if let err = err {
                print(err)
                return
            }
            do {
                let users = try JSONDecoder().decode([UserEntry].self, from: data!)
                DispatchQueue.main.async {
                    self.userList = users
                    print(users)
                }
            } catch let jsonError {
                print(jsonError)
                return
            }
        }.resume()
    }
    
}




class ImageLoader:ObservableObject
{
    @Published var data:Data = Data()
    func getImage(imageURL:String) {
        guard let url = URL(string: imageURL) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                if let data = data {
                    self.data = data
                }
            }
            print(data!)
        }.resume()
    }
    init(imageURL:String) {
        getImage(imageURL: imageURL)
    }
}
