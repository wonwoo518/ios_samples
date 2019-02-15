//
//  NetworkAgent.swift
//  TestAlamofire
//
//  Created by 1002237 on 05/12/2018.
//  Copyright © 2018 1002237. All rights reserved.
//

import Foundation
import Alamofire

struct NetworkConfig {
    static let serverUrl:String = "http://13.209.75.37:7777"
}

class NetworkAgent{
    static let shared = NetworkAgent()
    
    func request(api:String, method:HTTPMethod?, completion:((DogPlanetJsonModel?)->Void)?){
        Alamofire.request("\(NetworkConfig.serverUrl)\(api)", method: method ?? .get, parameters: nil).response { resp in
            if let data = resp.data{
                
                do{
                    let jsonDecoder = JSONDecoder()
                    let responseModel = try jsonDecoder.decode(DogPlanetJsonModel.self, from: data)
                    completion?(responseModel)
                }catch{

                }
            }
            
            
        }
    }
}
