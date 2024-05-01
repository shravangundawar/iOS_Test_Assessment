//
//  UserListViewController.swift
//  iOSTestAssessment
//
//  Created by Shravan Gundawar on 01/05/24.
//

import UIKit


class UserListViewController: UIViewController {
    
    //MARK: UI Outlets
    @IBOutlet weak var userListTableView: UITableView!
    
    //MARK: Properties
    let userListVM = UserListViewModel()
    let cellReuseIdentifier = "UserListTableViewCell"
    let loaderView = LoaderView()

    
    //MARK: Viewcontroller Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupLoader()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        showLoader()
        //API response is very quick, just for the sake of displaying loader kept 2sec delay, can be removed in future
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { [weak self] in
            self?.getUserList()
        }
    }
    
    //MARK: Methods
    private func setupTableView() {
        // Register the table view cell class and its reuse id
        userListTableView.register(UINib(nibName: "UserListTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: cellReuseIdentifier)
        // Set table view properties
        userListTableView.rowHeight = UITableView.automaticDimension
        userListTableView.estimatedRowHeight = 130 // Set an estimated row height
    }
    
    private func setupLoader() {
        view.addSubview(loaderView)
        loaderView.translatesAutoresizingMaskIntoConstraints = false
        
        // Center the loader view
        NSLayoutConstraint.activate([
            loaderView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loaderView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        // Hide the loader initially
        loaderView.hide()
        userListTableView.isHidden = true
    }
    
    // Show loader when needed
    private func showLoader() {
        loaderView.show()
        userListTableView.isHidden = true
    }
    
    // Hide loader when needed
    private func hideLoader() {
        loaderView.hide()
        userListTableView.isHidden = false
    }
    
    @MainActor
    func getUserList() {
        userListVM.fetchUserData { [weak self] result in
            DispatchQueue.main.async {
                
                switch result {
                case .success(let data):
                    self?.userListVM.userLisrDataArray = data
                    self?.userListTableView.reloadData()
                case .failure(let error):
                    print("Error fetching user data: \(error)")
                }
                self?.hideLoader()
            }
        }
    }
    
    func goToUserDeatilsScreen(selectedUserDetails: UserDataModel) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let userDetailsVC = storyBoard.instantiateViewController(withIdentifier: "UserDetailsViewController") as! UserDetailsViewController
        //Bind selected data for next screen
        let userDetailsVM = UserDetailsViewModel(userDetails: selectedUserDetails)
        userDetailsVC.userDetailsVM = userDetailsVM
        self.navigationController?.pushViewController(userDetailsVC, animated: true)
    }
    
}

//MARK: TableView Datasource
extension UserListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userListVM.userLisrDataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // create a new cell if needed or reuse an old one
        if let cell = userListTableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as? UserListTableViewCell {
            
            // set the text from the data model
            cell.idLbl?.text = String(describing: userListVM.userLisrDataArray[indexPath.row].id)
            cell.titleLbl?.text = userListVM.userLisrDataArray[indexPath.row].title
            
            return cell
        }
        return UITableViewCell()
    }
}

//MARK: TableView Delegate
extension UserListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        goToUserDeatilsScreen(selectedUserDetails: userListVM.userLisrDataArray[indexPath.row])
    }
}
