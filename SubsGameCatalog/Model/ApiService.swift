//
//  ApiService.swift
//  SubsGameCatalog
//
//  Created by Nanang Makfi Mubarok on 22/08/21.
//

import UIKit

class ApiService{
    let apiKey = Bundle.main.object(forInfoDictionaryKey: "API_KEY") as? String
    
    func getData(completion: @escaping ([Game]) -> Void){
        var components = URLComponents(string: "https://api.rawg.io/api/games")!
        
        components.queryItems = [
            URLQueryItem(name: "key", value: apiKey),
            URLQueryItem(name: "page_size", value: "10")
        ]
        
        let request = URLRequest(url: components.url!)
        
        let task = URLSession.shared.dataTask(with: request){data, response, error in
            if error != nil{
                print("failed")
            }
            else if let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200{
                let decoder = JSONDecoder()
                
                do{
                    let listGame = try decoder.decode(Games.self, from: data).games
                    completion(listGame)
                }
                catch{
                    print("invalid response")
                }
            }
        }
        
        task.resume()
    }
    
    func getDetailGame(id: String, completion: @escaping (GameDetail) -> Void){
        var components = URLComponents(string: "https://api.rawg.io/api/games/"+id)!
        
        components.queryItems = [
            URLQueryItem(name: "key", value: apiKey),
        ]
        
        let request = URLRequest(url: components.url!)
        
        let task = URLSession.shared.dataTask(with: request){data, response, error in
            if error != nil{
                print("failed")
            }
            else if let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200{
                let decoder = JSONDecoder()
                
                do{
                    let detailGame = try decoder.decode(GameDetail.self, from: data)
                    completion(detailGame)
                }
                catch{
                    print("invalid response")
                }
            }
        }
        
        task.resume()
    }
}
