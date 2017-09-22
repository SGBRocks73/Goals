//
//  GoalsVC.swift
//  Goals
//
//  Created by Steve Baker on 21/9/17.
//  Copyright © 2017 Steve Baker. All rights reserved.
//

import UIKit

class GoalsVC: UIViewController {

    //Outlets
    @IBOutlet weak var goalTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        goalTable.delegate = self
        goalTable.dataSource = self
        goalTable.isHidden = false 
        // Do any additional setup after loading the view.
    }
    
    @IBAction func addGoalPressed(_ sender: Any) {
        
    }
    
}

//tableViews
extension GoalsVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = goalTable.dequeueReusableCell(withIdentifier: "GoalCell") as? GoalCell else { return UITableViewCell()}
        cell.configCell(desritpion: "Eat healthy food", type: .shortTerm, progress: 3)
        return cell
    }
    
    
}
