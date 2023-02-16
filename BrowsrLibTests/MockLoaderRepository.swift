//
//  MockLoaderRepository.swift
//  BrowsrLibTests
//
//  Created by Leonardo Soares on 16/02/23.
//

import Foundation
import XCTest

@testable import BrowsrLib

class MockLoaderRepository: LoaderProtocol {
    func loadData(pageIndex: Int?, response: @escaping (Result<[BrowsrLib.Organization], Error>) -> ()) {
        let bundle = Bundle(for: type(of: self))
        let path = bundle.url(forResource: "organizations", withExtension: "json")
        do {
            if let url = path {
                let data = try Data(contentsOf: url, options: .mappedIfSafe)
                let jsonResult = try JSONDecoder().decode([Organization].self, from: data)
                response(.success(jsonResult))
            }
        } catch {
            response(.failure(error))
        }
    }
    
    func searchOrganization(searchTerm: String?, response: @escaping (Result<[BrowsrLib.Organization], Error>) -> ()) {
        let bundle = Bundle(for: type(of: self))
        let path = bundle.url(forResource: "github", withExtension: "json")
        do {
            if let url = path {
                let data = try Data(contentsOf: url, options: .mappedIfSafe)
                let jsonResult = try JSONDecoder().decode(Organization.self, from: data)
                response(.success([jsonResult]))
            }
        } catch {
            response(.failure(error))
        }
    }
    
    func getImage(from url: URL, results: @escaping (Result<Data, Error>) -> ()) {
        //not implemented
    }
    
    func setFavorite(isFav: Bool, organization: Organization) {
        //not implemented
    }
}
