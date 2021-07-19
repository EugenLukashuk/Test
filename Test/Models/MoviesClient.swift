//
//  MoviesClient.swift
//  Test
//
//  Created by Eugen on 16.07.2021.
//

import Foundation

class MoviesClient {
    private var decoder: JSONDecoder {
        let decode = JSONDecoder()
        decode.keyDecodingStrategy = .convertFromSnakeCase
        return decode
    }
    
    func fetchSummary(moviesData: @escaping (MoviesData) -> Void) {
        let stringURL = API_KEY
        guard let url = URL(string: stringURL) else { return }
        
        URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            guard let data = data, error == nil else{  return  }
            do {
                guard let parseData = try self?.decoder.decode(MoviesData.self, from: data) else { return }
                DispatchQueue.main.async {
                    moviesData(parseData)
                }
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
    }
}


