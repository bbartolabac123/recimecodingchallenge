//
//  ViewState.swift
//  RECIME
//
//  Created by Benjamin Bartolabac on 3/27/23.
//

import Foundation

public enum ViewState<T> {
  
    case start, loading, success(data: T), empty, error(message: String)
    
    public var rawValue: Int {
        switch self {
        case .start: return 0
        case .loading: return 1
        case .success: return 2
        case .empty: return 3
        case .error: return 4
        }
    }
}
