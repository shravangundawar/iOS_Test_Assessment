//
//  UserDetailsViewController.swift
//  iOSTestAssessment
//
//  Created by Shravan Gundawar on 01/05/24.
//

import UIKit

class UserDetailsViewController: UIViewController {
    
    //MARK: Properties
    var userDetailsVM: UserDetailsViewModel?
    
    
    //MARK: UI Outlets
    @IBOutlet weak var userIdLbl: UILabel!
    @IBOutlet weak var idLbl: UILabel!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var bodyLbl: UILabel!
    
    //MARK: Viewcontroller Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        displayUserDetails()
    }
    
    //MARK: Methods
    
    func displayUserDetails() {
        guard let userDetails = userDetailsVM?.userDetails else {
            return
        }
        
        userIdLbl.text = String(describing: userDetails.userId)
        idLbl.text = String(describing: userDetails.id)
        titleLbl.text = userDetails.title
        bodyLbl.text = userDetails.body
    }
}
