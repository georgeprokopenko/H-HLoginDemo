//
//  UIScrollView+Extensions.swift
//  H&HLoginDemo
//
//  Created by George Prokopenko on 30/01/2019.
//  Copyright © 2019 George Prokopenko. All rights reserved.
//

import UIKit

extension UIScrollView {
    
    func adjustToKeyboard() {
        NotificationCenter.default.addObserver(self, selector: #selector(onKeyboardWillShow), name: .UIKeyboardDidShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(onKeyboardWillHide), name: .UIKeyboardWillHide, object: nil)
    }
    
    @objc private func onKeyboardWillShow(_ notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            
            let bottomOffset = UIScreen.main.bounds.height - self.convert(self.bounds, to: nil).maxY
            var keyboardOverlappingHeight = keyboardSize.height - bottomOffset
            keyboardOverlappingHeight = keyboardOverlappingHeight > 0 ? keyboardOverlappingHeight : 0.0
            
            self.contentInset = UIEdgeInsets(top: self.contentInset.top,
                                             left: self.contentInset.left,
                                             bottom: keyboardOverlappingHeight,
                                             right: self.contentInset.right)
            self.scrollIndicatorInsets = self.contentInset
            self.setContentOffset(CGPoint.init(x: 0, y: self.contentInset.bottom/2), animated: true)
            
            let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(onDismissKeyobardTap(_:)))
            tapRecognizer.cancelsTouchesInView = false
            self.addGestureRecognizer(tapRecognizer)
        }
    }
    
    @objc private func onKeyboardWillHide(_ notification: Notification) {
        self.contentInset = UIEdgeInsets(top: self.contentInset.top, left: self.contentInset.left, bottom: 0, right: self.contentInset.right)
        self.scrollIndicatorInsets = self.contentInset
    }
    
    @objc private func onDismissKeyobardTap(_ sender: UITapGestureRecognizer) {
        self.removeGestureRecognizer(sender)
        self.endEditing(true)
    }
    
}

