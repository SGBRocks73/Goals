//
//  GoalCell.swift
//  Goals
//
//  Created by Steve Baker on 22/9/17.
//  Copyright © 2017 Steve Baker. All rights reserved.
//

import UIKit

class GoalCell: UITableViewCell {

    @IBOutlet weak var goalDescritionLabel: UILabel!
    @IBOutlet weak var goalTypeLabel: UILabel!
    @IBOutlet weak var goalProgressLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configCell(desritpion: String, type: GoalType, progress: Int) {
        self.goalDescritionLabel.text = desritpion
        self.goalTypeLabel.text = type.rawValue
        self.goalProgressLabel.text = String(progress)
    }
}
