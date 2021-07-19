//
//  SearchViewController.swift
//  Test
//
//  Created by Eugen on 17.07.2021.
//

import UIKit

class SearchViewController: UIViewController {
    @IBOutlet weak var closeBtn: UIButton!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    private var viewModel = StoriesViewModel()
    private var filteredData = [Story]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegateSearch = self
        tableView.backgroundColor = .clear
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "StoryTableViewCell", bundle: nil), forCellReuseIdentifier: "StoryTableViewCell")
        searchBar.delegate = self
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        tap.cancelsTouchesInView = false
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction func serchBtnTouchUpInside(_ sender: Any) {
        dismiss(animated: true)
    }
}

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "StoryTableViewCell", for: indexPath) as? StoryTableViewCell {
            cell.configure(story: filteredData[indexPath.row])
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            return cell
        }
        
        return UITableViewCell()
    }
}

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 400
    }
}

extension SearchViewController: UpdateSearchDataProtocol {
    func update(with stories: [Story]) {
        filteredData = stories
        tableView.reloadData()
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredData = searchText.isEmpty ? viewModel.stories : viewModel.stories.filter { item -> Bool in
            return item.title?.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
        }
        tableView.reloadData()
    }
}
