//
//  TvShowListDataSourceProtocol.swift
//  Test
//
//  Created by Jiren on 05/08/22.
//

import Foundation
import Combine

protocol TvShowListDataSourceProtocol {
    func getArray() -> AnyPublisher<[TvShowModel], Error> 
    func setFavorite(id: UUID)
    func deteleById(id: UUID)
    
    
}
