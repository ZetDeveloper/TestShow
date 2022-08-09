//
//  TvShowListDataSource.swift
//  Test
//
//  Created by Jiren on 05/08/22.
//

import Foundation
import Combine

class TvShowListDataSource: TvShowListDataSourceProtocol {
    
    static let shared = TvShowListDataSource()
    private var array: [TvShowModel] = []
    
    func getArray() -> AnyPublisher<[TvShowModel], Error>  {
        Future { [self] promise in
            promise(.success(array))
        }
        .eraseToAnyPublisher()
    }
    
    func setFavorite(id: UUID) {
        if let index = array.firstIndex(where: {$0.id == id}) {
            array[index].isFavorite = true
        }
    }
    
    func deteleById(id: UUID) {
        if let index = array.firstIndex(where: {$0.id == id}) {
            array.remove(at: index)
        }
    }
    
    func getMem() {
        for i in 1...100 {
            array.append(TvShowModel(
                name: "Tv Show name \(i)",
                poster: "https://m.media-amazon.com/images/M/MV5BZTU1OGNmZDktNjdiNC00OTlkLTgwZGYtZWNjNGMxODU4YjZiXkEyXkFqcGdeQXVyMjQwMjk0NjI@._V1_SX300.jpg")
            )
        }
    }
    
    private init() {
        getMem()
    }

}
