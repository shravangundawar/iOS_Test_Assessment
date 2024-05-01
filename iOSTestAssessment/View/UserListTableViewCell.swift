//
//  UserListTableViewCell.swift
//  iOSTestAssessment
//
//  Created by Shravan Gundawar on 01/05/24.
//

import UIKit

class UserListTableViewCell: UITableViewCell {

    //MARK: UI Outlets

    @IBOutlet weak var idLbl: UILabel!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var backgroundStackView: UIStackView!
    
    //MARK: Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        cellSetup()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func cellSetup() {
        titleLbl.lineBreakMode = .byWordWrapping
        titleLbl.numberOfLines = 0
        backgroundStackView.backgroundColor = .systemIndigo
        backgroundStackView.layer.cornerRadius = 10
    }
}
