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
        fetchDataObjects()
        goalTable.reloadData()
    }
    
    func fetchDataObjects() {
        fetchData { (finished) in
            if finished {
                if goals.count > 0 {
                    goalTable.isHidden = false
                    
                } else {
                    goalTable.isHidden = true
                }
            }
        }
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
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .none
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "DELETE") { (rowAction, indexPath) in
            self.removeGoal(indexPath: indexPath)
            self.fetchDataObjects()
            self.goalTable.deleteRows(at: [indexPath], with: .automatic)
        }
        deleteAction.backgroundColor = #colorLiteral(red: 0.9088812934, green: 0, blue: 0, alpha: 1)
        let addProgressAction = UITableViewRowAction(style: .normal, title: "ADD 1") { (rowAction, indexPath) in
            self.setGoalProgress(indexPath: indexPath)
            self.goalTable.reloadRows(at: [indexPath], with: .automatic)
        }
        addProgressAction.backgroundColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        return [deleteAction, addProgressAction]
    }
}

//extensions
extension GoalsVC {
    func setGoalProgress(indexPath: IndexPath) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        let goal = goals[indexPath.row]
        if goal.goalProgess < goal.goalCompleteValue {
            goal.goalProgess = goal.goalProgess + 1
        } else {
            return
        }
        do {
           try managedContext.save()
        } catch {
            debugPrint(error.localizedDescription)
        }
    }
    
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
    
    func removeGoal(indexPath: IndexPath) {
        guard let managedContect = appDelegate?.persistentContainer.viewContext else { return }
        let goal = goals[indexPath.row]
        managedContect.delete(goal)
        do {
           try managedContect.save()
        } catch {
            debugPrint(error.localizedDescription)
        }
        
    }
    
}
