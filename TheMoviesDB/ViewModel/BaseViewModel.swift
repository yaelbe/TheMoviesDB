//
//  BaseViewModel.swift
//  TheMoviesDB
//
//  Created by Yael Bilu Eran on 11/04/2020.
//  Copyright © 2020 CodeQueen. All rights reserved.
//

import Foundation

enum State {
    case empty
    case loading
    case data
    case fatalError(String)
    case pageError(String)
}

class BaseViewModel<T> {
    
    // Output
    let state: Observable<State>
    // Input
    var onSelectItem: ((T) -> Void)?
    
    let lock = DispatchQueue(label: "com.MoviesListModel.dispatchQueue")

    private var cancelSubscription: CancelSubscription?
    private var data: [T] = []{
        didSet {
            state.value = .data
        }
    }

    init(){
        self.state = Observable(State.data)
    }
    
    deinit {
        cancelSubscription?()
    }
    
    func data(at index: Int) -> T? {
        guard 0..<data.count ~= index else { return nil }
        return data[index]
    }
    
    var dataCount: Int {
        return data.count
    }
    
    func selectItem(at index: Int) {
        guard let item = data(at: index) else { return }
        onSelectItem?(item)
    }
    
    func loadNextPage() {
        load()
    }
    
    func load(){}
    
    func add(data dataToAdd: [T]) {
        lock.async { [weak self] in
            guard let self = self else { return }
            self.data += dataToAdd
        }
    }
}
