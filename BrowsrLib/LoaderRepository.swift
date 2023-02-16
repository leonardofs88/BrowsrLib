//
//  LoaderRepository.swift
//  BrowsrLib
//
//  Created by Leonardo Soares on 15/02/23.
//

import Foundation

public class LoaderRepository: LoaderProtocol {
    
    public init() {
        // exposing initializer
    }
    
    public func searchOrganization(searchTerm: String?, response: @escaping (Result<[Organization], Error>) -> ()) {
        Loader().searchOrganization(searchTerm: searchTerm) { response($0) }
    }
    
    public func loadData(pageIndex: Int?, response: @escaping (Result<[Organization], Error>)->()) {
        Loader().loadData(pageIndex: pageIndex) { response($0) }
    }
    
    public func getImage(from url: URL, results: @escaping (Result<Data, Error>) -> ()) {
        Loader().getImage(from: url, results: results)
    }

    public func setFavorite(isFav: Bool, organization: String) {
        Loader().setFavorite(isFav: isFav, organization: organization)
    }
}
