//
//  CreateGoalVC.swift
//  Goals
//
//  Created by Steve Baker on 22/9/17.
//  Copyright © 2017 Steve Baker. All rights reserved.
//

import UIKit

class CreateGoalVC: UIViewController {

    
    //Outlets
    @IBOutlet weak var goalText: UITextView!
    @IBOutlet weak var shortTermButton: UIButton!
    @IBOutlet weak var longTermButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
       dismissSide()
    }
    
    @IBAction func longTermButtonPressed(_ sender: Any) {
    }
    
   
    @IBAction func shortTermButtonPressed(_ sender: Any) {
    }
    
    @IBAction func nextButtonPressed(_ sender: Any) {
        
    }
    
}
