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
    
    var brain = CalculatorBrain()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        historyVC = tabBarController?.viewControllers?.last?.childViewControllers.first as? HistoryTableViewController
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
        let digit = sender.currentTitle
        
        if digit == "c" {
            display.text = "0"
//            operandStack.removeAll()
            historyVC.operations.removeAll()
            userIsInTheMiddleOfTyping = false
            
        } else if digit == "↰" {
            if display.text?.characters.last == "." {
                printedDot = false
            }
            display.text = (display.text != "" && display.text != "0") ?
                display.text!.substringToIndex(display.text!.endIndex.predecessor()) : "0"
            
            if (display.text == "") {
                display.text = "0"
                userIsInTheMiddleOfTyping = false
            }
        }
    }
    
    @IBAction func changeSign(sender: AnyObject) {
        displayValue = -displayValue
    }
    
    @IBAction func enter() {
        userIsInTheMiddleOfTyping = false
        printedDot = false
        if let result = brain.pushOperand(displayValue) {
            displayValue = result
        } else {
            displayValue = 0
        }
    }
    
    @IBAction func operate(sender: AnyObject) {
        if userIsInTheMiddleOfTyping {
            enter()
        }
        if let operation = sender.currentTitle! {
            if let result = brain.performOperation(operation) {
                displayValue = result
            } else {
                displayValue = 0
            }
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

