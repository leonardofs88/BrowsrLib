//
//  LoaderProtocol.swift
//  BrowsrLib
//
//  Created by Leonardo Soares on 15/02/23.
//

import Foundation
import UIKit

public protocol LoaderProtocol: AnyObject{
    func loadData(pageIndex: Int?, response: @escaping (Result<[Organization], Error>)->())
    func searchOrganization(searchTerm: String?, response: @escaping (Result<[Organization], Error>)->())
    func getImage(from url: URL, results: @escaping (Result<Data, Error>) -> ())
    func setFavorite(isFav: Bool, organization: String)
}
