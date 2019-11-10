//
//  NetworkingClient.swift
//  Rovers
//
//  Created by Peter Irving on 11/10/19.
//  Copyright © 2019 Peter Irving. All rights reserved.
//

import Foundation

class NetworkingClient {
        
    static let shared = NetworkingClient()
    
    var page = 1
    var morePages = true
    
    func getURL(rover: String?) -> URL? {
        guard let rover = rover else {
            return nil
        }
        return URL(string: "https://api.nasa.gov/mars-photos/api/v1/rovers/\(rover)/photos?sol=1001&page=\(page)&api_key=\(apiKey)")!
    }
    
    func fetch(rover: String, callback: @escaping([Photo]?, Error?) -> ()) {
        
        guard let url = getURL(rover: rover) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in

            if let error = error {
                print("error fetching images \(error.localizedDescription)")
                callback(nil, error)
                return
            }
            guard let data = data else {
                return
            }
            do {
                let request = try JSONDecoder().decode(ImagesPage.self, from: data)
                guard let images: [Photo] = request.photos else {
                    callback([], nil)
                    return
                }
                if images.count == 0 {
                    self.morePages = false
                }
                self.page = self.page + 1
                callback(images, nil)

            } catch {
                print(error, "error parsing")
                callback(nil, error)
            }
        }.resume()
    }
}
