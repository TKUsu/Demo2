//
//  Ext+EnDecoder.swift
//  APITest
//
//  Created by SuJustin on 2019/9/2.
//  Copyright © 2019 SuJustin. All rights reserved.
//

import Foundation

/// JSONDeconder().decode  return: Data
extension Decodable {
    /// [C] decoding to Dictionary
    static func decode(dic: Dictionary<AnyHashable, Any>) -> Self? {
        let decoder = JSONDecoder()
        do{
            return try decoder.decode(Self.self, from: dic.toData()!)
        }catch{
            print("[JSON Decoder faild] \(error)")
            //            let status = APIStatus(resultCode: "IOS-001", rCodeMsg: "JSON Decoder Faild")
            return nil
        }
    }
    // <NotUse>
    /// [C] decoding to Data
    static func decode(data: Data) -> Self? {
        let decoder = JSONDecoder()
        do{
            return try decoder.decode(Self.self, from: data)
        }catch{
            print("[JSON Decoder faild] \(error)")
            return nil
        }
    }
}
extension Encodable {
    // <NotUse>
    /// [C] encoding to Dictionary
    var encodeDic: Dictionary<String, AnyHashable>? {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(self)
            let json = try JSONSerialization.jsonObject(with: data, options: []) as! Dictionary<String, AnyHashable>
            return json
        } catch{
            print("[JSON Encoder faild] \(error)")
            return nil
        }
    }
    /// [C] encoding to Data
    var encodeData: Data? {
        let encoder = JSONEncoder()
        do {
            return try encoder.encode(self)
        } catch{
            print("[JSON Encoder faild] \(error)")
            return nil
        }
    }
}
extension Dictionary{
    /// [C] Use JSONSerialization.data(), default options = []
    func toData(options: JSONSerialization.WritingOptions = []) -> Data? {
        guard JSONSerialization.isValidJSONObject(self) else {
            return nil
        }
        do {
            return try JSONSerialization.data(withJSONObject: self, options: options)
        } catch  {
            print("[Dictionary ERROR Type] Dictionary isn't to Data: \(error) [\(#file)--\(#line)]")
        }
        return nil
    }
    /// [C] Use JSONSerialization.data(), default options = [], output self.
    func EncodByJSONString() -> String? {
        guard let data =  self.toData() else{ return nil }
        return String(data: data, encoding: .utf8)!.decodByJSON
    }
}
extension Data{
    /// [C] Use JSONSerialization.jsonObject(), default options = []
    func toDic(options: JSONSerialization.ReadingOptions = []) -> Dictionary<String, Any>? {
        do{
            return try JSONSerialization.jsonObject(with: self, options: options) as? Dictionary<String, Any>
        }catch{
            print("[Data ERROR Type] Data isn't to Dictionary: \(error) [\(#file)--\(#line)]")
        }
        return nil
    }
}

extension String{
    var decodByJSON: String{
        return self.replacingOccurrences(of: "\\/", with: "/", options: .caseInsensitive, range: nil)
    }
}
