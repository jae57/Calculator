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
    private var operationClickClear: Bool = false
    private var previousValue: Double = 0
    private var storedValue: Double = 0
    private var operatorStore: OperatorStore = .empty
    private var isDotted: Bool = false
    private var isFirstClicked: Bool = false
    //MARK: 스토리보드 연결된 변수들
    @IBOutlet private weak var allClearUIButton: UIButton!
    @IBOutlet private var numberUIButtons: [UIButton]!
    @IBOutlet private var operatorUIButtons: [UIButton]!
    @IBOutlet private weak var resultUILabel: UILabel!
    @IBAction private func allClearUIButtonAction(_ sender: Any) {
        resultUILabel.text = "0"
        operatorStore = .empty
        previousValue = 0
        isDotted = false
    }
    
    // MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        resultUILabel.text = "0";
        
        allClearUIButton.layer.cornerRadius = 30
        for numberUIButton in numberUIButtons {
            numberUIButton.layer.cornerRadius = 30
        }
        for operatorUIButton in operatorUIButtons {
            operatorUIButton.layer.cornerRadius = 30
        }
    }
}

extension ViewController {
    func resetStatus() {
        operatorStore = .empty
        isDotted = false
    }
    
    func updateResultUILabel(_ button: Int) {
        guard let value = resultUILabel.text else { return }
        if Double(value) == 0 || operatorStore.isEmpty() {
            if isDotted {
                resultUILabel.text = value + String(button)
            } else {
                resultUILabel.text = String(button)
            }
        } else {
            resultUILabel.text = value + String(button)
        }
        isDotted = true
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
    
    func formattingResult(result: Double) -> String {
        let intResult = Double(Int(result))
        if result == intResult {
            return String(Int(result))
        } else {
            return String(result)
        }
    }
}

// MARK:- action들
extension ViewController {
    @IBAction func dotUIButtonAction(_ sender: Any) {
        guard isDotted == false, let value = resultUILabel.text else { return }
        resultUILabel.text = value + "."
        isDotted = true
    }
    @IBAction func zeroUIButtonAction(_ sender: Any) {
        guard let value = resultUILabel.text else { return }
        if Double(value) != 0 {
            resultUILabel.text = value + "0"
        } else {
            if isDotted {
                resultUILabel.text = value + "0"
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
        guard let value = resultUILabel.text else { return }
        let currentValue = Double(value)
        
        if operatorStore.isEmpty() {
            previousValue = currentValue!
        } else {
            previousValue = calculateValue(value1: previousValue, operatorStore: operatorStore, value2: currentValue!)
            resultUILabel.text = formattingResult(result: previousValue)
        }
        operatorStore = .divide
        isDotted = false
    }
    @IBAction func multipleUIButtonAction(_ sender: Any) {
        guard let value = resultUILabel.text else { return }
        let currentValue = Double(value)
        
        if operatorStore.isEmpty() {
            previousValue = currentValue!
        } else {
            previousValue = calculateValue(value1: previousValue, operatorStore: operatorStore, value2: currentValue!)
            resultUILabel.text = formattingResult(result: previousValue)
        }
        operatorStore = .multiply
        isDotted = false
    }
    
    @IBAction func minusUIButtonAction(_ sender: Any) {
        guard let value = resultUILabel.text else { return }
        let currentValue = Double(value)
        
        if operatorStore.isEmpty() {
            previousValue = currentValue!
        } else {
            previousValue = calculateValue(value1: previousValue, operatorStore: operatorStore, value2: currentValue!)
            resultUILabel.text = formattingResult(result: previousValue)
        }
        operatorStore = .minus
        isDotted = false
    }
    @IBAction func plusUIButtonAction(_ sender: Any) {
        guard let value = resultUILabel.text else { return }
        let currentValue = Double(value)
        
        if operatorStore.isEmpty() {
            previousValue = currentValue!
        } else {
            previousValue = calculateValue(value1: previousValue, operatorStore: operatorStore, value2: currentValue!)
            resultUILabel.text = formattingResult(result: previousValue)
        }
        operatorStore = .plus
        isDotted = false
    }
    @IBAction func isUIButtonAction(_ sender: Any) {
        guard let value = resultUILabel.text else { return }
        let currentValue = Double(value)
        
        if isFirstClicked {
            storedValue = Double(value)!
            previousValue = calculateValue(value1: previousValue, operatorStore: operatorStore, value2: currentValue!)
            resultUILabel.text = formattingResult(result: previousValue)
            isFirstClicked = false
        } else {
            previousValue = calculateValue(value1: previousValue, operatorStore: operatorStore, value2: storedValue)
            resultUILabel.text = formattingResult(result: previousValue)
        }
        
    }
    
}
