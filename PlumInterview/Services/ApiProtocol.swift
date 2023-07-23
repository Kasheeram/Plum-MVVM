//
//  ApiProtocol.swift
//  PlumInterview
//
//  Created by kashee on 22/07/23.
//

import Foundation


protocol ApiProtocol {
    func getData<T: Decodable>(url: String, completion: @escaping (Result<T, PlumError>) -> ())
}


enum PlumError: Error, CustomNSError {
    case apiError
    case invalidUrl
    
    var localizedDescription: String {
        switch self {
        case .apiError: return "Failed to fetch data"
        case .invalidUrl: return "Invalid url"
        }
    }
    
    var errorUserInfo: [String : Any] {
        [NSLocalizedDescriptionKey: localizedDescription]
    }
}

