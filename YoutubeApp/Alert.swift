//
//  AlertExt.swift
//  Aswaq
//
//  Created by sameh on 9/5/18.
//  Copyright © 2018 soleek. All rights reserved.
//

import Foundation
import UIKit

class Alert
{
   
    class func show(title:String,message:String)
    {
        let topWindow = UIWindow(frame: UIScreen.main.bounds)
        topWindow.rootViewController = UIViewController()
        topWindow.windowLevel = UIWindow.Level.alert + 1
        let alert = UIAlertController(title: title , message: message , preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("Ok", comment: "confirm"), style: .cancel, handler: {(_ action: UIAlertAction) -> Void in
            topWindow.isHidden = true
        }))
        topWindow.makeKeyAndVisible()
        topWindow.rootViewController?.present(alert, animated: true, completion: nil)
    }
}
