//
//  InputTextFieldView.swift
//  H&HLoginDemo
//
//  Created by George Prokopenko on 29/01/2019.
//  Copyright © 2019 George Prokopenko. All rights reserved.
//

import UIKit

class InputTextFieldView: UIView {
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var separatorLine: UIView!
    var mode: Mode?
    var validationIsOn: Bool = false
    var validationHelper = FieldValidationHelper()
    var isValid : Bool = false
    
    enum Mode {
        case login
        case password
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupElements()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupElements()
    }
    
    private func setupElements() {
        backgroundColor = .clear
        
        view = loadViewFromNib()
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.translatesAutoresizingMaskIntoConstraints = true
        
        addSubview(view)
        
        self.textField.delegate = self
    }
    
    private func loadViewFromNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let nibView = nib.instantiate(withOwner: self, options: nil).first as! UIView
        
        return nibView
    }
    
    //MARK: -
    
    func setup(withMode mode: Mode, validation validationIsOn: Bool) {
        self.mode = mode
        self.validationIsOn = validationIsOn
        
        switch mode {
        case .login:
            self.title.text = "Логин"
        case .password:
            self.title.text = "Пароль"
            self.textField.isSecureTextEntry = true
        }
    }
}

extension InputTextFieldView : UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch self.mode {
        case .login?:
            if self.validationIsOn, let text = textField.text {
                let isValid = self.validationHelper.isValidEmail(email: text)
                self.separatorLine.backgroundColor = isValid ? UIColor.init(white: 0.9, alpha: 1.0) : UIColor.red
                self.isValid = isValid
                
            }
        case .password?:
            if self.validationIsOn, let text = textField.text {
                let isValid = self.validationHelper.isPasswordValid(password: text)
                self.separatorLine.backgroundColor = isValid ? UIColor.init(white: 0.9, alpha: 1.0) : UIColor.red
                self.isValid = isValid
            }
        default:
            print()
    
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.separatorLine.backgroundColor = UIColor.init(white: 0.9, alpha: 1.0)
    }
}


