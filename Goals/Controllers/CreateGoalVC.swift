//
//  CreateGoalVC.swift
//  Goals
//
//  Created by Steve Baker on 22/9/17.
//  Copyright © 2017 Steve Baker. All rights reserved.
//

import UIKit

class CreateGoalVC: UIViewController, UITextViewDelegate {

    
    //Outlets
    @IBOutlet weak var goalText: UITextView!
    @IBOutlet weak var shortTermButton: UIButton!
    @IBOutlet weak var longTermButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    var goalType: GoalType = .shortTerm
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nextButton.bindToKeyboard()
        shortTermButton.setSelectedColour()
        longTermButton.setDeselectedColour()
        goalText.delegate = self
        // Do any additional setup after loading the view.
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        goalText.text = ""
        goalText.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
       dismissSide()
    }
    
    @IBAction func longTermButtonPressed(_ sender: Any) {
        goalType = .longTerm
        longTermButton.setSelectedColour()
        shortTermButton.setDeselectedColour()
    }
    
   
    @IBAction func shortTermButtonPressed(_ sender: Any) {
        goalType = .shortTerm
        shortTermButton.setSelectedColour()
        longTermButton.setDeselectedColour()
    }
    
    @IBAction func nextButtonPressed(_ sender: Any) {
        if goalText.text != "" && goalText.text != "What is your Goal?" {
            guard let finishVC = storyboard?.instantiateViewController(withIdentifier: "FinishVC") as? FinishVC else { return }
            finishVC.initData(description: goalText.text, type: goalType)
            presentingViewController?.presentSecondary(finishVC)
            
        }
    }
    
}

