//
//  TvShowRepository.swift
//  Test
//
//  Created by Jiren on 05/08/22.
//

import Foundation
import Combine

class TvShowRepository {
    
    var dataSource: TvShowListDataSourceProtocol {
        return TvShowNetworkDataSource.shared
    }
    private var cancellables = Set<AnyCancellable>()
    
    func getTvShowList() -> AnyPublisher<[TvShowModel], Error> {
        Future { [self] promise in
            dataSource.getArray()
                .sink(receiveCompletion: { completion in
                    // completion code
                    debugPrint(completion)
                }, receiveValue: { value in
                    promise(.success(value))
                })
                .store(in: &cancellables)
           
        }
        .eraseToAnyPublisher()
    }
    
    func favorite(id: UUID) {
        dataSource.setFavorite(id: id)
    }
    
    func delete(id: UUID) {
        dataSource.deteleById(id: id)
    }
    
}
