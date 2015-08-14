//
//  ViewController.swift
//  AppSpeech
//
//  Created by Michael on 29.07.15.
//  Copyright © 2015 Ocode. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var display: UILabel!
    
    var historyVC : HistoryTableViewController!
    
    var userIsInTheMiddleOfTyping = false
    var printedDot = false
    
    var shouldAddNewElement = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        historyVC = tabBarController?.viewControllers?.last as? HistoryTableViewController
    }
    
    @IBAction func digitPressed(sender: AnyObject) {
        var digit = sender.currentTitle!
        if digit == "π" {
            digit = String(M_PI)
        }
        if userIsInTheMiddleOfTyping {
            display.text = display.text! + digit!
        } else {
            display.text = digit
            userIsInTheMiddleOfTyping = true
        }
    }
    
    @IBAction func deleteAllDigits(sender: AnyObject) {
        display.text = "0"
        userIsInTheMiddleOfTyping = false
        operandStack.removeAll()
        historyVC.operations.removeAll()
    }
    
    var operandStack = Array<Double>()
    
    @IBAction func enter() {
        userIsInTheMiddleOfTyping = false
        operandStack.append(displayValue)
        printedDot = false
        
        print("operandStack = \(operandStack)")
    }
    
    @IBAction func operate(sender: AnyObject) {
        let operation = sender.currentTitle!!
        if userIsInTheMiddleOfTyping {
            enter()
        }
        switch operation {
        case "÷": performOperation("÷") { $0 / $1 }
        case "×": performOperation("×") { $0 * $1 }
        case "-": performOperation("-") { $0 - $1 }
        case "+": performOperation("+") { $0 + $1 }
        case "√": performOperation { sqrt($0) }
        case "sin": performOperation { sin($0) }
        case "cos": performOperation { cos($0) }
        default:
            break
        }
    }
    
    func performOperation(sign:String, operation: (Double,Double) -> Double) {
        if operandStack.count >= 2 {
            let operationStr = String(operandStack[operandStack.count-2]) + " \(sign) " + String(operandStack[operandStack.count-1]) + " = " + String(operation(operandStack[operandStack.count-2], operandStack[operandStack.count-1]))
            historyVC?.operations.append(operationStr)
            displayValue = operation(operandStack.removeLast(), operandStack.removeLast())
            enter()
        }
    }
    
    private func performOperation(operation: Double -> Double) {
        if operandStack.count >= 1 {
            display.text = "\(operation(operandStack.removeLast()))"
            displayValue = operation(operandStack.removeLast())
            enter()
        }
    }
    
    var displayValue: Double {
        get {
            return Double(display.text!)!
        }
        set {
            display.text = "\(newValue)"
            userIsInTheMiddleOfTyping = false
        }
    }
    
    @IBAction func displayDot(sender: AnyObject) {
        if !printedDot {
            if userIsInTheMiddleOfTyping {
                display.text! += "."
            } else {
                display.text = "."
                userIsInTheMiddleOfTyping = true
            }
            printedDot = true
        }
    }

}

