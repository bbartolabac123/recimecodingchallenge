//
//  DecoderHelper.swift
//  RECIME
//
//  Created by Benjamin Bartolabac on 3/27/23.
//

import Foundation
import Combine

final class DecoderHelper {

    class func loadJSON(filename: String) -> AnyPublisher<Data, Error> {
        let bundle = Bundle(for: DecoderHelper.self)
        return bundle.url(forResource: filename, withExtension: "json")
            .publisher
            .tryMap{ string in
                guard let data = try? Data(contentsOf: string) else {
                    fatalError("Failed to load \(filename) from bundle.")
                }
                return data
            }
            .mapError { error in
                return error
            }.eraseToAnyPublisher()
    }
    
    class func decodeableToArray<T: Decodable>(fileName: String) -> AnyPublisher<[T], Error> {
        loadJSON(filename: fileName)
              .decode(type: [T].self, decoder: JSONDecoder())
              .mapError { error in
                  return error
              }
              .eraseToAnyPublisher()
      }
}
