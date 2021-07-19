//
//  StoriesCollectionViewCell.swift
//  Test
//
//  Created by Eugen on 16.07.2021.
//

import UIKit

class StoriesCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var tableView: UITableView!
    
    private var viewModel = StoriesViewModel()

    override func awakeFromNib() {
        super.awakeFromNib()
        viewModel.delegate = self
        tableView.backgroundColor = .clear
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "StoryTableViewCell", bundle: nil), forCellReuseIdentifier: "StoryTableViewCell")
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib.init(nibName: "StoryTopCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "StoryTopCollectionViewCell")
    }
    
    func scrollToItem(index: Int) {
        collectionView.isPagingEnabled = false
        self.collectionView.scrollToItem(at:IndexPath(item: index, section: 0), at: .right, animated: true)
        collectionView.isPagingEnabled = true
    }

    @objc private func nextStory() {
        if pageControl.currentPage < pageControl.numberOfPages - 1 {
            pageControl.currentPage += 1
        } else {
            pageControl.currentPage = 0
        }
        scrollToItem(index: pageControl.currentPage)
    }
    
    @IBAction func pageControlTouchUpInside(_ sender: Any) {
        scrollToItem(index: pageControl.currentPage)
    }
}

//MARK:- TableView
extension StoriesCollectionViewCell: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.stories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "StoryTableViewCell", for: indexPath) as? StoryTableViewCell {
            cell.configure(story: viewModel.stories[indexPath.row])
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            return cell
        }
        
        return UITableViewCell()
    }
}

extension StoriesCollectionViewCell: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 400
    }
}

//MARK:- CollectionView
extension StoriesCollectionViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard viewModel.stories.count < 5 else { return 5 }
        return viewModel.stories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StoryTopCollectionViewCell", for: indexPath) as? StoryTopCollectionViewCell {
            cell.configure(story: viewModel.stories[indexPath.row])
            return cell
        }
        
        return UICollectionViewCell()
    }
}

extension StoriesCollectionViewCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let x = scrollView.contentOffset.x
        let w = scrollView.bounds.size.width
        let currentPage = Int(ceil(x/w))
        self.pageControl.currentPage = currentPage
    }
}

extension StoriesCollectionViewCell: UICollectionViewDelegateFlowLayout{
     func collectionView(_ collectionView: UICollectionView,
                           layout collectionViewLayout: UICollectionViewLayout,
                           sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: collectionView.frame.size.width, height: collectionView.frame.size.height)
    }
}

extension StoriesCollectionViewCell: UpdateStoriesTableViewProtocol {
    func updateTableView() {
        tableView.reloadData()
        collectionView.reloadData()
        
        if viewModel.stories.count < 5 {
            pageControl.numberOfPages = viewModel.stories.count
        } else {
            pageControl.numberOfPages = 5
        }
        
        let t = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(self.nextStory), userInfo: nil, repeats: true)
        RunLoop.current.add(t, forMode: .common)
    }
}
