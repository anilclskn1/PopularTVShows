//
//  DetailAPIClient.swift
//  PopularTVShows
//
//  Created by Anıl Çalışkan on 12.04.2023.
//

import Foundation

enum DetailAPIError: Error {
    case invalidURL
    case invalidResponse
    case requestFailed(Error)
    case decodingFailed(Error)
}

class DetailAPIClient {
    
    let baseURL: URL
    let apiKey: String
    
    init(baseURL: URL, apiKey: String) {
        self.baseURL = baseURL
        self.apiKey = apiKey
    }
    
    func getTVShowDetails(tvShowId: Int, completion: @escaping (Result<TVShowDetailsResponse, DetailAPIError>) -> Void) {
        let endpoint = "/3/tv/\(tvShowId)"
        let url = buildURL(endpoint: endpoint, queryItems: [
            URLQueryItem(name: "api_key", value: apiKey),
            URLQueryItem(name: "language", value: "en-US")
        ])
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(.requestFailed(error)))
                return
            }

            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
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
                let tvShowResponse = try decoder.decode(TVShowDetailsResponse.self, from: data)
                completion(.success(tvShowResponse))
            } catch {
                completion(.failure(.decodingFailed(error)))
            }
        }
        
        task.resume()
    }
    
    private func buildURL(endpoint: String, queryItems: [URLQueryItem]) -> URL {
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)!
        urlComponents.path = endpoint
        urlComponents.queryItems = queryItems
        return urlComponents.url!
    }
}

