//
//  TvShowListViewModel.swift
//  Test
//
//  Created by Jiren on 05/08/22.
//

import SwiftUI
import Combine

class TvShowListViewModel: ObservableObject {
    @Published var array: [TvShowModel] = []
    private var cancellables = Set<AnyCancellable>()
    var repository = TvShowRepository()
    @Published var isloading = true
    
    func favorite(id: UUID) {
        isloading = true
        repository.favorite(id: id)
        getTvShowList()
    }
    
    func delete(id: UUID) {
        isloading = true
        repository.delete(id: id)
        getTvShowList()
    }
    
    func getTvShowList() {
        repository.getTvShowList()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [self] completion in
                // completion code
                isloading = false
                debugPrint(completion)
            }, receiveValue: { [self] value in
                array.removeAll()
                array = value
            })
            .store(in: &cancellables)
    }
}

