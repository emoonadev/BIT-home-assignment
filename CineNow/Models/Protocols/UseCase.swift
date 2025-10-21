//
//  UseCase.swift
//  CineNow
//
//  Created by Mickael Belhassen on 21/10/2025.
//

import Foundation

protocol UseCase {
    associatedtype Route: APIController

    var networkManager: NetworkManagerService { get }
    var apiController: Route.Type { get }
}
