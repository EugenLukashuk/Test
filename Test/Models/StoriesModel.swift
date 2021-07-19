//
//  StoriesModel.swift
//  Test
//
//  Created by Eugen on 16.07.2021.
//

import Foundation

protocol StoriesProtocol: AnyObject {
    func updateStories(stories: [Story])
}


class StoriesModel {
    weak var delegate: StoriesProtocol?
    private var moviesClient = MoviesClient()
    private var stories = [Story]()
    
    init() {
        moviesClient.fetchSummary() { [weak self] newsData in
            if let stories = newsData.results {
                self?.stories = stories
                self?.delegate?.updateStories(stories: stories)
            }
        }
    }
}
