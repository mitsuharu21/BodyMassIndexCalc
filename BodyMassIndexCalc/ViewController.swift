//
//  ViewController.swift
//  BodyMassIndexCalc
//
//  Created by admin on 2020/05/07.
//  Copyright © 2020 kt. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var heightField: UITextField!
    @IBOutlet weak var bodyWeightField: UITextField!
    @IBOutlet weak var calcButton: UIButton!
    @IBOutlet weak var clearButton: UIButton!
    
    var alertController: UIAlertController!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.heightField.keyboardType = UIKeyboardType.decimalPad
        self.bodyWeightField.keyboardType = UIKeyboardType.decimalPad

        self.calcButton.layer.borderColor = UIColor.gray.cgColor
        self.clearButton.layer.borderColor = UIColor.gray.cgColor
        
        heightField.becomeFirstResponder()
    }
    
    func alert(title:String, message:String) {
        alertController = UIAlertController(title: title,
                                            message: message,
                                            preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK",
                                                style: .default,
                                                handler: nil))
        present(alertController, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let viewController = segue.destination as! ResultViewController
        
        if let height = Float(heightField.text!){
            
            if height < 1 {
                heightField.becomeFirstResponder()
                alert(title: "警告", message: "身長：1以上を入力してください。")
            }
            
            viewController.height = height / 100
        }else{
            heightField.becomeFirstResponder()
            alert(title: "警告", message: "身長：数値を入力してください。")
        }

        if let bodyWeight = Float(bodyWeightField.text!){

            if bodyWeight < 1 {
                bodyWeightField.becomeFirstResponder()
                alert(title: "警告", message: "体重：1以上を入力してください。")
            }

            viewController.bodyWeight = bodyWeight
        }else{
            bodyWeightField.becomeFirstResponder()
            alert(title: "警告", message: "体重：数値を入力してください。")
        }
    }
    
    @IBAction func heightEditingChanged(_ sender: Any) {

        if heightField.text == "" || bodyWeightField.text == "" {
            calcButton.isEnabled = false
        } else {
            calcButton.isEnabled = true
        }

    }
    
    @IBAction func weightEditingChanged(_ sender: Any) {
        
        if heightField.text == "" || bodyWeightField.text == "" {
            calcButton.isEnabled = false
        } else {
            calcButton.isEnabled = true
        }
        
    }
    
    @IBAction func tapClearButton(_ sender: Any){
        heightField.text = ""
        bodyWeightField.text = ""
        
        heightField.becomeFirstResponder()
        calcButton.isEnabled = false
    }
    
    @IBAction func restart(_ segue: UIStoryboardSegue){
        heightField.text = ""
        bodyWeightField.text = ""
        
        heightField.becomeFirstResponder()
        calcButton.isEnabled = false
    }
}

private var maxLengths = [UITextField: Int]()

extension UITextField {
    
    @IBInspectable var maxLength: Int {
        get {
            guard let length = maxLengths[self] else {
                return Int.max
            }
            
            return length
        }
        set {
            maxLengths[self] = newValue
            addTarget(self, action: #selector(limitLength), for: .editingChanged)
        }
    }
    
    @objc func limitLength(textField: UITextField) {
        guard let prospectiveText = textField.text, prospectiveText.count > maxLength else {
            return
        }
        
        let selection = selectedTextRange
        let maxCharIndex = prospectiveText.index(prospectiveText.startIndex, offsetBy: maxLength)
        
        #if swift(>=4.0)
        text = String(prospectiveText[..<maxCharIndex])
        #else
        text = prospectiveText.substring(to: maxCharIndex)
        #endif
        
        selectedTextRange = selection
    }
    
}
