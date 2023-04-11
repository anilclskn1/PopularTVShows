//
//  APIClient.swift
//  PopularTVShows
//
//  Created by Anıl Çalışkan on 12.04.2023.
//

import Foundation

enum APIError: Error {
    case invalidURL
    case invalidResponse
    case requestFailed(Error)
    case decodingFailed(Error)
}

class APIClient {
    
    let baseURL: URL
    
    init(baseURL: URL) {
        self.baseURL = baseURL
    }
    
    func getPopularTVShows(page: Int, completion: @escaping (Result<TVShowsResponse, APIError>) -> Void) {
        let endpoint = "/tv/popular?api_key=972c9e3f0c7a3f8310c159d1e73fcd13"
        let url = URL(string: "\(baseURL)\(endpoint)")!
        print(url)
        
        var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true)
        urlComponents?.queryItems = [
            URLQueryItem(name: "page", value: String(page))
        ]
        
        guard let finalURL = urlComponents?.url else {
            completion(.failure(.invalidURL))
            return
        }

        let task = URLSession.shared.dataTask(with: finalURL) { (data, response, error) in
            if let error = error {
                completion(.failure(.requestFailed(error)))
                return
            }
            

            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                print(response.debugDescription)
                completion(.failure(.invalidResponse))
                
                return
            }

            guard let data = data else {
                completion(.failure(.invalidResponse))
                return
            }

            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            do {
                let tvShowsResponse = try decoder.decode(TVShowsResponse.self, from: data)
                print(tvShowsResponse.tvShows)
                completion(.success(tvShowsResponse))
            } catch {
                completion(.failure(.decodingFailed(error)))
            }
        }
        
        task.resume()
    }
    
}
