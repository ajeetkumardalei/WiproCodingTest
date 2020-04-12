//
//  Helper.swift
//  WiproCodingTest
//
//  Created by AjeetZone on 11/04/20.
//  Copyright © 2020 AjeetZone. All rights reserved.
//



import UIKit
import NVActivityIndicatorView



class Helper: NSObject {
    static let sharedInstance = Helper()
    private var loaderView: NVActivityIndicatorView?
    
    
    func showLoader() {
        if loaderView == nil {
            let frame = CGRect(x: 0, y: 0, width: IS_IPAD() ? 80 : 50, height: IS_IPAD() ? 80 : 50)
            loaderView = NVActivityIndicatorView(frame: frame, type: .ballClipRotatePulse)
            loaderView?.center = CGPoint(x: UIScreen.main.bounds.width / 2.0, y: (UIScreen.main.bounds.height / 2.0))
            loaderView?.color = .red
            loaderView?.startAnimating()
            UIApplication.shared.windows.first?.addSubview(loaderView!)
        }
    }

    func hideLoader() {
        if loaderView != nil {
            loaderView?.removeFromSuperview()
            loaderView = nil
        }
    }

    func IS_IPAD() -> Bool {
        switch UIDevice.current.userInterfaceIdiom {
        case .phone: // It's an iPhone
            return false
        case .pad: // It's an iPad
            return true
        case .unspecified: // undefined
            return false
        default:
            return false
        }
    }
    
}
