//
//  ViewController.swift
//  JHCalculator
//
//  Created by 이재성 on 2019/10/09.
//  Copyright © 2019 김지혜. All rights reserved.
//

import UIKit

final class ViewController: UIViewController {
    //MARK:- 이넘
    enum OperatorStore {
        case plus
        case minus
        case multiply
        case divide
        case empty
        
        func isEmpty() -> Bool {
            return self == .empty
        }
    }
    //MARK: 이넘
    private var operatorClicked: Bool = false
    
    private var previousValue: Double = 0
    private var storedValue: Double = 0
    
    private var currentOperator: OperatorStore = .empty
    private var storedOperator: OperatorStore = .empty
    
    private var isMinus: Bool = false
    private var isDotted: Bool = false
    private var isFirstClicked: Bool = false
    //MARK: 스토리보드 연결된 변수들
    @IBOutlet private weak var allClearUIButton: UIButton!
    @IBOutlet private var numberUIButtons: [UIButton]!
    @IBOutlet private var operatorUIButtons: [UIButton]!
    @IBOutlet private weak var resultUILabel: UILabel!
    @IBOutlet private weak var toggleMinusButton: UIButton!
    @IBOutlet private weak var percentButton: UIButton!
    
    // MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        resultUILabel.text = "0";
        
        allClearUIButton.layer.cornerRadius = 30
        toggleMinusButton.layer.cornerRadius = 30
        percentButton.layer.cornerRadius = 30
        for numberUIButton in numberUIButtons {
            numberUIButton.layer.cornerRadius = 30
        }
        for operatorUIButton in operatorUIButtons {
            operatorUIButton.layer.cornerRadius = 30
        }
        
    }
}

extension ViewController {
    func clearStatus() {
        currentOperator = .empty
        isDotted = false
        isMinus = false
    }
    
    func uiLabelValueToDouble(_ resultUILabel: UILabel) -> Double {
        guard let value = resultUILabel.text else {
            return 0.0
        }
        
        return Double(value)!
    }
    
    func updateResultUILabel(_ button: Int) {
        if operatorClicked {
            resultUILabel.text = String(button)
            operatorClicked = false
        } else {
            let realValue = uiLabelValueToDouble(resultUILabel)
            guard let stringValue: String = resultUILabel.text else { return }
            
            if realValue == 0 {
                if isDotted {
                    resultUILabel.text = stringValue + String(button)
                } else {
                    resultUILabel.text = String(button)
                }
            } else {
                resultUILabel.text = stringValue + String(button)
            }
        }
    }
    
    func calculateWithOperator(currentValue: Double, clickedOperator: OperatorStore) {
        if currentOperator.isEmpty() {
            previousValue = currentValue
        } else {
            previousValue = calculateValue(value1: previousValue, operatorStore: clickedOperator, value2: currentValue)
            resultUILabel.text = formattingResult(previousValue)
        }
        currentOperator = clickedOperator
        operatorClicked = true
        isFirstClicked = true
    }
    
    func calculateValue(value1: Double, operatorStore: OperatorStore, value2: Double) -> Double {
        switch operatorStore {
        case .plus:
            return value1 + value2
        case .minus:
            return value1 - value2
        case .multiply :
            return value1 * value2
        case .divide:
            return value1 / value2
        case .empty:
            return 0
        }
    }
    
    func formattingResult(_ result: Double) -> String {
        let intResult = Double(Int(result))
        if result == intResult {
            return String(Int(result))
        } else {
            //return result.removeZerosFromEnd()
            return result.forTrailingZero()
        }
    }
}

extension Double {
    func removeZerosFromEnd() -> String {
        let formatter = NumberFormatter()
        let number = NSNumber(value: self)
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 8
        return String(formatter.string(from: number) ?? "")
    }
    
    func forTrailingZero() -> String {
        return String(format: "%g", self)
    }
}

// MARK:- action들
extension ViewController {
    @IBAction private func allClearUIButtonAction(_ sender: Any) {
        resultUILabel.text = "0"
        currentOperator = .empty
        storedOperator = .empty
        previousValue = 0
        operatorClicked = false
        isDotted = false
        isMinus = false
    }
    
    @IBAction private func toggleMinusButtonAction(_ sender: Any) {
        let stringValue = resultUILabel.text!
        let realValue = uiLabelValueToDouble(resultUILabel)
        
        if realValue == 0 {
            if isMinus {
                resultUILabel.text = stringValue.replacingOccurrences(of: "-", with: "")
            } else {
                resultUILabel.text = "-" + stringValue
            }
            
            isMinus.toggle()
        } else if realValue < 0 {
            resultUILabel.text = formattingResult(realValue * -1)
        } else {
            resultUILabel.text = "-" + stringValue
        }
    }
    
    @IBAction func percentButtonAction(_ sender: Any) {
        let currentValue = uiLabelValueToDouble(resultUILabel)
        previousValue = calculateValue(value1: currentValue, operatorStore: .divide, value2: 100)
        resultUILabel.text = formattingResult(previousValue)
    }
    
    @IBAction func dotUIButtonAction(_ sender: Any) {
        guard isDotted == false, let value = resultUILabel.text else { return }
        resultUILabel.text = value + "."
        isDotted = true
    }
    
    @IBAction func zeroUIButtonAction(_ sender: Any) {
        let realValue = uiLabelValueToDouble(resultUILabel)
        guard let stringValue: String = resultUILabel.text else { return }
        
        if realValue != 0 {
            resultUILabel.text = stringValue + "0"
        } else {
            if isDotted {
                resultUILabel.text = stringValue + "0"
            }
        }
    }
    
    @IBAction func oneUIButtonAction(_ sender: Any) {
        updateResultUILabel(1)
    }
    @IBAction func twoUIButtonAction(_ sender: Any) {
        updateResultUILabel(2)
    }
    @IBAction func threeUIButtonAction(_ sender: Any) {
        updateResultUILabel(3)
    }
    @IBAction func fourUIButtonAction(_ sender: Any) {
        updateResultUILabel(4)
    }
    @IBAction func fiveUIButtonAction(_ sender: Any) {
        updateResultUILabel(5)
    }
    @IBAction func sixUIButtonAction(_ sender: Any) {
        updateResultUILabel(6)
    }
    @IBAction func sevenUIButtonAction(_ sender: Any) {
        updateResultUILabel(7)
    }
    @IBAction func eightUIButtonAction(_ sender: Any) {
        updateResultUILabel(8)
    }
    @IBAction func nineUIButtonAction(_ sender: Any) {
        updateResultUILabel(9)
    }
    @IBAction func divideUIButtonAction(_ sender: Any) {
        let currentValue = uiLabelValueToDouble(resultUILabel)
        calculateWithOperator(currentValue: currentValue, clickedOperator: .divide)
    }
    
    @IBAction func multipleUIButtonAction(_ sender: Any) {
        let currentValue = uiLabelValueToDouble(resultUILabel)
        calculateWithOperator(currentValue: currentValue, clickedOperator: .multiply)
    }
    
    @IBAction func minusUIButtonAction(_ sender: Any) {
        let currentValue = uiLabelValueToDouble(resultUILabel)
        calculateWithOperator(currentValue: currentValue, clickedOperator: .minus)
    }
    
    @IBAction func plusUIButtonAction(_ sender: Any) {
        let currentValue = uiLabelValueToDouble(resultUILabel)
        calculateWithOperator(currentValue: currentValue, clickedOperator: .plus)
    }
    
    @IBAction func isUIButtonAction(_ sender: Any) {
        let currentValue = uiLabelValueToDouble(resultUILabel)
        
        if isFirstClicked {
            storedValue = currentValue
            storedOperator = currentOperator
            isFirstClicked = false
        }
        
        previousValue = calculateValue(value1: previousValue, operatorStore: storedOperator, value2: storedValue)
        resultUILabel.text = formattingResult(previousValue)
        
        operatorClicked = true
        clearStatus()
    }
    
}
