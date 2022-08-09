//
//  TvShowNetworkDataSource.swift
//  Test
//
//  Created by Jiren on 07/08/22.
//

import Foundation
import Combine

class TvShowNetworkDataSource: TvShowListDataSourceProtocol {
    static let shared = TvShowNetworkDataSource()
    private var cancellables = Set<AnyCancellable>()
    private let jsonDecoder = JSONDecoder()
    private var array: [TvShowModel] = []
    
    func getArray() -> AnyPublisher<[TvShowModel], Error> {
        Future { [self] promise in
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [self] in
                promise(.success(array))
            }
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
    
    func getRest() {
        let userEndpointString = "http://www.omdbapi.com/?apikey=6045ee84&s=gam"
        if let url = URL(string: userEndpointString) {
            URLSession.shared.dataTaskPublisher(for: url)
                .map { $0.data }
                .decode(type: TvShowNetworkModel.self, decoder: jsonDecoder)
                .eraseToAnyPublisher()
                .sink(receiveCompletion: { completion in
                    // completion code
                    debugPrint(completion)
                }, receiveValue: { [self] value in
                    array.removeAll()
                    value.search.forEach { item in
                        array.append(
                            TvShowModel(
                                name: item.title,
                                isFavorite: false,
                                poster: item.poster
                            )
                        )
                    }
                })
                .store(in: &cancellables)
        }
    }
    
    private init() {
        getRest()
    }
    
    
}
