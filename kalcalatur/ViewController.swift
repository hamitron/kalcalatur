//
//  ViewController.swift
//  kalcalatur
//
//  Created by Hamilton Karl on 1/13/16.
//  Copyright © 2016 Hamilton Karl. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var calculatedNumberDisplay: UILabel!
    
    var userIsInTheMiddleOfTypingANumber = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func calcButton(sender: UIButton) {
        let digit = sender.currentTitle!
        if userIsInTheMiddleOfTypingANumber {
            calculatedNumberDisplay.text = calculatedNumberDisplay.text! + digit
        } else {
            calculatedNumberDisplay.text = digit
            userIsInTheMiddleOfTypingANumber = true
        }
    }
    
    var operandStack = Array<Double>()
    @IBAction func clearDisplay(sender: UIButton) {
        calculatedNumberDisplay.text! = "0"
        userIsInTheMiddleOfTypingANumber = false
        operandStack.removeAll()
    }
    @IBAction func operate(sender: UIButton) {
        if userIsInTheMiddleOfTypingANumber {
            enter()
        }
        if let operation = sender.currentTitle {
            switch operation {
            case "✖️": performOperation {$0 * $1}
            case "➕": performOperation {$0 + $1}
            case "➖": performOperation {$1 - $0}
            case "➗": performOperation {$1 / $0}
            default: break
            }
        }
    }
    
    func performOperation(operation: (Double, Double) -> Double) {
        if operandStack.count >= 2 {
            displayValue = operation(operandStack.removeLast(), operandStack.removeLast())
            enter()
        }
    }

    @IBAction func addToStack(sender: UIButton) {
        enter()
    }
    
    func enter() {
        operandStack.append(displayValue)
        print("\(operandStack)")
        userIsInTheMiddleOfTypingANumber = false
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var displayValue: Double {
        get {
            return NSNumberFormatter().numberFromString(calculatedNumberDisplay.text!)!.doubleValue
        }
        set{
            calculatedNumberDisplay.text = "\(newValue)"
            userIsInTheMiddleOfTypingANumber = false
        }
    }


}

