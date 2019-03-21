//
//  AppDelegate.swift
//  YoutubeApp
//
//  Created by Sameh sayed on 3/1/19.
//  Copyright © 2019 Sameh sayed. All rights reserved.
//

import Foundation
import UIKit

protocol SpinnerDelegate
{
    func showSpinner(disableView:Bool)
    func removeSpinner()
}

class Spinner:UIActivityIndicatorView
{
    static let shared = Spinner(style:UIActivityIndicatorView.Style.gray)
    
    private override init(style: UIActivityIndicatorView.Style)
    {
        super.init(style: style)
        
    }
    
    required init(coder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
}


extension SpinnerDelegate where Self:UIView
{
    
    func showSpinner(disableView:Bool = true)
    {
        let spinner = Spinner.shared
        spinner.center = center
        spinner.color = UIColor.darkGray
        addSubview(spinner)
        isUserInteractionEnabled = false
        spinner.startAnimating()
    }
    
    func removeSpinner()
    {
        isUserInteractionEnabled = true
        Spinner.shared.stopAnimating()
    }
}

extension SpinnerDelegate where Self:UIViewController
{
  
    func showSpinner(disableView:Bool = true)
    {
        let spinner = Spinner.shared
        spinner.center = view.center
        spinner.color = UIColor.darkGray
        view.addSubview(spinner)
        view.isUserInteractionEnabled = false
        spinner.startAnimating()
    }
    
    func removeSpinner()
    {
        view.isUserInteractionEnabled = true
        Spinner.shared.stopAnimating()
    }

}
