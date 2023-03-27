//
//  ReviewListService.swift
//  RECIME
//
//  Created by Benjamin Bartolabac on 3/27/23.
//

import Foundation
import Combine

protocol ReviewListServiceProtocol {
    func getRecipes() -> AnyPublisher<[Recipe], Error>
}

class ReviewListServicImplementation: ReviewListServiceProtocol {
    
    func getRecipes() -> AnyPublisher<[Recipe], Error> {
        return DecoderHelper.decodeableToArray(fileName: "recipes")
    }
}
