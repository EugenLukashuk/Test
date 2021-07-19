//
//  StoriesViewModel.swift
//  Test
//
//  Created by Eugen on 16.07.2021.
//

import Foundation

protocol UpdateStoriesTableViewProtocol: AnyObject {
    func updateTableView()
}

protocol UpdateSearchDataProtocol: AnyObject {
    func update(with stories: [Story])
}

class StoriesViewModel {
    var stories = [Story]()
    weak var delegate: UpdateStoriesTableViewProtocol?
    weak var delegateSearch: UpdateSearchDataProtocol?
    private var model = StoriesModel()
    
    init() {
        model.delegate = self
    }
}

extension StoriesViewModel: StoriesProtocol {
    func updateStories(stories: [Story]) {
        self.stories = stories
        delegate?.updateTableView()
        delegateSearch?.update(with: stories)
    }
}
