//
//  APIServer.swift
//  APITest
//
//  Created by SuJustin on 2019/9/2.
//  Copyright © 2019 SuJustin. All rights reserved.
//

import Foundation

class APIServer {
    static let shared: APIServer = APIServer()
    
    enum APIURL: String {
        case earthQuake =  "https://sta.ci.taiwan.gov.tw/STA_Earthquake_v2/v1.0/Things"
        case wearth = "https://sta.ci.taiwan.gov.tw/STA_Weather/v1.0/Datastreams?$expand=Thing,Observations($orderby=Observations/phenomenonTime%20desc;$top=1)&$filter=substringof(%27%E6%B0%A3%E8%B1%A1%E7%AB%99_open_now-%27,Thing/name)&$count=true"
    }
    
    private let decoder = JSONDecoder()
    
    func call (_ apiurl: APIURL, Complete: @escaping( (_ status: Bool, _ res: Codable) -> ())) {
        var request = URLRequest(url: URL(string: apiurl.rawValue)!)
        request.httpMethod = "GET"
//        request.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler:{
            data, response, error -> Void in
//            print(response!)
            guard let data = data else {return}
            DispatchQueue.main.async {
                switch apiurl{
                case .earthQuake:
                    Complete(true, Earthquake.decode(data: data))
                case .wearth:
                    Complete(true, Weather.decode(data: data))
                }
            }
        })
        
        task.resume()
    }
}
