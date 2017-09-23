//
//  GoalsVC.swift
//  Goals
//
//  Created by Steve Baker on 21/9/17.
//  Copyright © 2017 Steve Baker. All rights reserved.
//

import UIKit
import CoreData

let appDelegate = UIApplication.shared.delegate as? AppDelegate

class GoalsVC: UIViewController {

    //Outlets
    @IBOutlet weak var goalTable: UITableView!
    
    
    var goals = [Goal]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        goalTable.delegate = self
        goalTable.dataSource = self
        goalTable.isHidden = false
        goalTable.rowHeight = 80
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        fetchData { (finished) in
            if finished {
                if goals.count > 0 {
                    goalTable.isHidden = false
                    
                } else {
                    goalTable.isHidden = true
                }
            }
        }
        goalTable.reloadData()
    }
    
    @IBAction func addGoalPressed(_ sender: Any) {
        guard let createGoalVC = storyboard?.instantiateViewController(withIdentifier: "CreateGoalVC") else { return }
        presentSide(createGoalVC)
    }
    
}

//tableViews
extension GoalsVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return goals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = goalTable.dequeueReusableCell(withIdentifier: "GoalCell") as? GoalCell else { return UITableViewCell()}
        let goal = goals[indexPath.row]
        cell.configCell(goal: goal)
        return cell
    }
}

extension GoalsVC {
    
    func fetchData(completion: (_ complete: Bool) -> ()) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        let fetchRequest = NSFetchRequest<Goal>(entityName: "Goal")
        do {
            try goals =  managedContext.fetch(fetchRequest)
            completion(true)
        } catch {
            debugPrint(error.localizedDescription)
            completion(false)
        }
    }
    
}
