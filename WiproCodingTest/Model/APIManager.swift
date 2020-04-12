//
//  APIManager.swift
//  WiproCodingTest
//
//  Created by AjeetZone on 11/04/20.
//  Copyright © 2020 AjeetZone. All rights reserved.
//

import Foundation
import SystemConfiguration



class APIManager: NSObject {
    static let shared = APIManager()
    
    
    private func connectedToNetwork() -> Bool {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
        zeroAddress.sin_family = sa_family_t(AF_INET)
        guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, { $0.withMemoryRebound(to: sockaddr.self, capacity: 1) { SCNetworkReachabilityCreateWithAddress(nil, $0) } })
            else { return false }
        
        var flags: SCNetworkReachabilityFlags = []
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
            return false
        }
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        return (isReachable && !needsConnection)
    }
    
    private func operation(with urlStr:String, completionSuccess: @escaping(_ dataToSend: Data) -> Void ) {
        if connectedToNetwork() {
            
            guard let url = URL(string: urlStr) else {return}
            
            let dataTask = URLSession.shared.dataTask(with: url) { (data, urlResponse, error) in
                
                if let err = error {
                    debugPrint("Client error! == \(err.localizedDescription)")
                    return
                }
                
                //success
                guard let dataResponse = data, let httpResponse = urlResponse as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {print("Server error!"); return }

                completionSuccess(dataResponse)
            }
            
            dataTask.resume()
            
        } else {
            debugPrint(Constant.NetworkManager.apiNoNetworkMessage)
        }
        
    }
    
    func getCanadaInfo(with CompletionSuccess:@escaping(_ response: CanadaInfo) -> Void) {
        let fullURL = Constant.SERVER.baseURL
        
        operation(with: fullURL) { (dataToSend) in
            
            guard let mydata = String(decoding: dataToSend, as: UTF8.self).data(using: .utf8) else {return}
            
            do {
                let model = try JSONDecoder().decode(CanadaInfo.self, from: mydata)
                CompletionSuccess(model)

            } catch {
                debugPrint("JSON error: \(error.localizedDescription)")
            }
        }
    }
    
}




