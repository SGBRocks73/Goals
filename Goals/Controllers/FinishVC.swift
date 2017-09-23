//
//  FinishVC.swift
//  Goals
//
//  Created by Steve Baker on 22/9/17.
//  Copyright © 2017 Steve Baker. All rights reserved.
//

import UIKit
import CoreData

class FinishVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var createGoalButton: UIButton!
    @IBOutlet weak var pointText: UITextField!
    
    var goalDescription: String!
    var goalType: GoalType!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        createGoalButton.bindToKeyboard()
        pointText.delegate = self
    }
    
    func initData(description: String, type: GoalType) {
        self.goalType = type
        self.goalDescription = description
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        pointText.text = ""
    }
    
    func saveData(completion: (_ finished: Bool) -> ()) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        let goal = Goal(context: managedContext)
        
        goal.goalDescrition = goalDescription
        goal.goalCompleteValue = Int32(pointText.text!)!
        goal.goalType = goalType.rawValue
        goal.goalProgess = Int32(0)
        
        do {
            try managedContext.save()
            print("saved data \(goal.goalDescrition!)")
            completion(true)
        } catch {
            debugPrint(error.localizedDescription)
            completion(false)
        }
        
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func createGoalPressed(_ sender: Any) {
        if pointText.text != nil {
            self.saveData { (complete) in
                if complete {
                    dismiss(animated: true, completion: nil)
                }
            }
        }
    }
}
