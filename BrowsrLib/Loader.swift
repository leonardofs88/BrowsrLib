//
//  Loader.swift
//  BrowsrLib
//
//  Created by Leonardo Soares on 15/02/23.
//

import Foundation

internal class Loader: LoaderProtocol {
    
    fileprivate let sessionConfig: URLSessionConfiguration
    fileprivate let session: URLSession
    
    internal init() {
        sessionConfig = URLSessionConfiguration.default
        session = URLSession(configuration: sessionConfig)
    }
    
    internal func loadData(pageIndex: Int?, response: @escaping (Result<[Organization], Error>)->()) {
        
        var url = URL(string: "https://api.github.com/organizations")!
        if let index = pageIndex {
            url = url.appending(queryItems: [URLQueryItem(name: "per_page", value: "\(index)")])
        }
        var request = URLRequest(url: url)
        request.addValue("2022-11-28", forHTTPHeaderField: "X-GitHub-Api-Version")
        request.addValue("application/vnd.github+json", forHTTPHeaderField: "Accept")
        request.httpMethod = "GET"
        session.dataTask(with: request) { data, urlResponse, error in
            guard let data = data else { return }
            
            do {
                let results = try JSONDecoder().decode([Organization].self, from: data)
                response(.success(results))
            } catch {
                response(.failure(error))
            }
        }.resume()
    }
    
    internal func searchOrganization(searchTerm: String?, response: @escaping (Result<[Organization], Error>)->()) {
        guard let term = searchTerm else { return }
        guard let url = URL(string: "https://api.github.com/orgs/\(term)") else { return }
        var request = URLRequest(url: url)
        request.addValue("2022-11-28", forHTTPHeaderField: "X-GitHub-Api-Version")
        request.addValue("application/vnd.github+json", forHTTPHeaderField: "Accept")
        request.httpMethod = "GET"
        session.dataTask(with: request) { data, urlResponse, error in
            guard let data = data else { return }
            
            do {
                let result = try JSONDecoder().decode(Organization.self, from: data)
                response(.success([result]))
            } catch {
                response(.failure(error))
            }
        }.resume()
    }
    
    internal func getImage(from url: URL, results: @escaping (Result<Data, Error>) -> ()) {
        session.dataTask(with: url) { data, response, error in
            if let imageData = data {
                results(.success(imageData))
            }
            
            if let err = error {
                results(.failure(err))
            }
        }.resume()
    }
    
    internal func setFavorite(isFav: Bool, organization: String) {
        UserDefaults.standard.setValue(!isFav, forKey: organization)
    }
    
}
