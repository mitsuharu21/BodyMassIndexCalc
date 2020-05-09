//
//  ResultViewController.swift
//  BodyMassIndexCalc
//
//  Created by admin on 2020/05/08.
//  Copyright © 2020 kt. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {

    var height: Float = 0
    var bodyWeight: Float = 0
    var suitableBmi : Float = 22
    
    @IBOutlet weak var bmiField: UITextField!
    @IBOutlet weak var suitableWeight: UITextField!
    @IBOutlet weak var differenceWeight: UITextField!
    @IBOutlet weak var resultText: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // 小数第3位で四捨五入
        let bmiValue = round(Float(bodyWeight / (height * height))*100)/100
        bmiField.text = "\(bmiValue)"
        
        let suitableWeightValue = round((height * height) * suitableBmi * 100)/100
        suitableWeight.text = "\(suitableWeightValue)"
        
        let differenceWeightValue = round((bodyWeight - suitableWeightValue)*100)/100
        differenceWeight.text = "\(differenceWeightValue)"
        
        if bmiValue < 18.5 {
            resultText.text = "低体重"
        }else if 18.5 <= bmiValue && bmiValue < 25 {
            resultText.text = "普通体重"
        }else if 25 <= bmiValue && bmiValue < 30 {
            resultText.text = "肥満（１度）"
        }else if 30 <= bmiValue && bmiValue < 35 {
            resultText.text = "肥満（２度）"
        }else if 35 <= bmiValue && bmiValue < 40 {
            resultText.text = "肥満（３度）"
        }else if 40 <= bmiValue {
            resultText.text = "肥満（４度）"
        }

    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
