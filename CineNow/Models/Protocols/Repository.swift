//
//  UseCase.swift
//  CineNow
//
//  Created by Mickael Belhassen on 21/10/2025.
//

import Foundation

protocol RemoteDataSource {
    associatedtype Route: APIController

    var api: NetworkManagerService { get }
    var controller: Route.Type { get }
}
