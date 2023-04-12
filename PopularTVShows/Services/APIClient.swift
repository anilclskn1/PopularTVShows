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
    
    var isPaginating = false
    let baseURL: URL
    let apiKey: String
    
    init(baseURL: URL, apiKey: String) {
        self.baseURL = baseURL
        self.apiKey = apiKey
    }
    
    func getPopularTVShows(pagination: Bool = false, page: Int, completion: @escaping (Result<TVListResponse, APIError>) -> Void) {
        if pagination {
            isPaginating = true
        }
        let endpoint = "/3/tv/popular"
        let url = buildURL(endpoint: endpoint, queryItems: [
            URLQueryItem(name: "api_key", value: apiKey),
            URLQueryItem(name: "language", value: "en-US"),
            URLQueryItem(name: "page", value: String(page))
        ])
        print(url)
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
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
                let tvShowsResponse = try decoder.decode(TVListResponse.self, from: data)
                print(tvShowsResponse)
                completion(.success(tvShowsResponse))
            } catch {
                completion(.failure(.decodingFailed(error)))
                print(error.localizedDescription)

            }
        }
        
        task.resume()
        if pagination {
            self.isPaginating = false
        }
    }
    
    private func buildURL(endpoint: String, queryItems: [URLQueryItem]) -> URL {
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)!
        urlComponents.path = endpoint
        urlComponents.queryItems = queryItems
        return urlComponents.url!
    }
}
