//
//  LoadingSpinner.swift
//  H&HLoginDemo
//
//  Created by George Prokopenko on 29/01/2019.
//  Copyright © 2019 George Prokopenko. All rights reserved.
//

import UIKit

class LoadingSpinner {
    
    private struct Constants {
        static let spinnerAppearDelay = 0.4
        static let spinnerAppearDuration = 0.3
    }
    
    private static var spinnerView: UIView?
    
    class func show() {
        UIApplication.shared.beginIgnoringInteractionEvents()
        
        guard self.spinnerView == nil else { return }
        
        self.spinnerView = self.generateSpinnerView()
        // Some async operations are quick enough to omit spinner
        // Display it with delay if by that time .hide() hasn't already been requested
        DispatchQueue.global().asyncAfter(deadline: .now() + Constants.spinnerAppearDelay) {
            guard let spinnerView = self.spinnerView else { return }
            
            DispatchQueue.main.async {
                let app = UIApplication.shared.delegate as! AppDelegate
                if var topController = app.window?.rootViewController {
                    while let presentedViewController = topController.presentedViewController {
                        topController = presentedViewController
                    }
                    updateSpinnerFrame(topController.view.frame)
                    spinnerView.alpha = 0.0
                    topController.view.addSubview(spinnerView)
                    UIView.animate(withDuration: Constants.spinnerAppearDuration) { spinnerView.alpha = 1.0 }
                }
            }
        }
    }
    
    class func hide() {
        UIApplication.shared.endIgnoringInteractionEvents()
        
        guard let spinner = self.spinnerView else { return }
        
        self.spinnerView = nil
        if spinner.alpha == 1.0 {
            UIView.animate(withDuration: Constants.spinnerAppearDuration, animations: { spinner.alpha = 0.0 }) { _ in
                spinner.removeFromSuperview()
            }
        }
    }
    
    // MARK: - Private
    
    private class func generateSpinnerView() -> UIView {
        let indicator = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        indicator.startAnimating()
        let overlayView = UIView(frame: .zero)
        overlayView.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        overlayView.addSubview(indicator)
        return overlayView
    }
    
    private class func updateSpinnerFrame(_ frame: CGRect) {
        guard let spinner = self.spinnerView else { return }
        spinner.frame = frame
        spinner.subviews.first?.center = spinner.center
    }
}

