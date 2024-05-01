//
//  NetworkManager.swift
//  iOSTestAssessment
//
//  Created by Shravan Gundawar on 01/05/24.
//

import Foundation
//Thread safe Singleton dsign pattern
final class NetworkManager {
    
    //MARK: Properties
    static let shared = NetworkManager()
    private init() {}
    private let lock = NSLock()
    private var privateInstance: NetworkManager?
    
    var instance: NetworkManager {
        lock.lock()
        defer {
            lock.unlock()
        }
        
        if privateInstance == nil {
            privateInstance = NetworkManager()
        }
        return privateInstance!
    }
    
    enum APIErrors: Error {
        case invalidURL
        case invalidResposne
    }

    //MARK: Methods
    func fetchDataFromAPI<T: Codable>(url: String) async throws -> T {
        
        guard let url = URL(string: url) else {
            throw APIErrors.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw APIErrors.invalidResposne
        }
        
        return try JSONDecoder().decode(T.self, from: data)
    }
}
