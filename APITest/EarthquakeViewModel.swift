//
//  EarthquakeViewModel.swift
//  APITest
//
//  Created by SuJustin on 2019/9/4.
//  Copyright © 2019 SuJustin. All rights reserved.
//

import Foundation

protocol EarthquakeDelegate {
    func ServerRequest(resquest: Earthquake)
}

class EarthquakeViewModel: NSObject {
    
    var delegate: EarthquakeDelegate?
    
    private var earthQuake: Earthquake!
    private let server: APIServer = APIServer.shared
    
    override init() {
        super.init()
        SyncServer()
    }
    
    func SyncServer() {
        server.call(.earthQuake) { (isSuccess, res) in
            guard isSuccess, let res = res as? Earthquake else {return}
            self.earthQuake = res
            self.delegate?.ServerRequest(resquest: res)
        }
    }
    
    func getDetailData(row: Int) -> [[String]] {
        let earthQuakeValue = earthQuake.value[row]
        let valueDic = earthQuakeValue.encodeDic!
        var values: [[String]] = []
        for (key, value) in valueDic{
            values.append([key, value.description])
        }
        return values
    }
    
    func getName(row: Int) -> String {
        return earthQuake!.value[row].name
    }
    
    func getID(row: Int) -> String {
        return "\(earthQuake!.value[row].iotID)"
    }
}
