//
//  UserListViewModel.swift
//  iOSTestAssessment
//
//  Created by Shravan Gundawar on 01/05/24.
//

import Foundation
class UserListViewModel {
    
    //MARK: Properties
    var userLisrDataArray = [UserDataModel]()
    var selectedUserDetails: UserDataModel?
    
    //MARK: Methods
    func fetchUserData(completion: @escaping (Result<[UserDataModel], Error>) -> Void) {
            Task {
                do {
                    let userdata: [UserDataModel] = try await NetworkManager.shared.instance.fetchDataFromAPI(url: APIConstants.userListAPI)
                    completion(.success(userdata))
                } catch {
                    completion(.failure(error))
                }
            }
        }
}
