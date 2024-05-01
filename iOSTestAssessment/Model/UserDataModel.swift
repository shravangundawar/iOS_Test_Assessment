//
//  UserDataModel.swift
//  iOSTestAssessment
//
//  Created by Shravan Gundawar on 01/05/24.
//

import Foundation

struct UserDataModel: Codable {

    let userId: Int
    let id: Int
    let title: String
    let body: String

    //TODO: Kept for future reference if property name mofification requires
//    enum CodeingKeys: String, CodingKey {
//        case userId
//        case recordId = "id"
//        case title
//        case details = "body"
//    }
}
