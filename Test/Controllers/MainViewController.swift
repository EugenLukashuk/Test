//
//  MainViewController.swift
//  Test
//
//  Created by Eugen on 16.07.2021.
//

import UIKit


class MainViewController: UIViewController {
    @IBOutlet weak var menuBtn: UIButton!
    @IBOutlet weak var serchBtn: UIButton!
    @IBOutlet weak var segmantedControl: UISegmentedControl!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib.init(nibName: "StoriesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "StoriesCollectionViewCell")
        collectionView.register(UINib.init(nibName: "VideoCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "VideoCollectionViewCell")
        collectionView.register(UINib.init(nibName: "FavoritesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "FavoritesCollectionViewCell")
    }
    
    @IBAction func serchBtnTouchUpInside(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        guard let resultViewController = storyBoard.instantiateViewController(withIdentifier: "SearchViewController") as? SearchViewController else { return }
        resultViewController.modalPresentationStyle = .fullScreen
        self.present(resultViewController, animated: true, completion: nil)
    }
    
    @IBAction func segmentedControlTouchUpInside(_ sender: Any) {
        collectionView.isPagingEnabled = false
        collectionView.scrollToItem(at:IndexPath(item: segmantedControl.selectedSegmentIndex, section: 0), at: .right, animated: true)
        collectionView.isPagingEnabled = true
    }
}

extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.row {
        case 0:
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StoriesCollectionViewCell", for: indexPath) as? StoriesCollectionViewCell {
                return cell
            }
        case 1:
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VideoCollectionViewCell", for: indexPath) as? VideoCollectionViewCell {
                return cell
            }
        case 2:
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FavoritesCollectionViewCell", for: indexPath) as? FavoritesCollectionViewCell {
                return cell
            }
        default:
            break
        }
        
        return UICollectionViewCell()
    }
}

extension MainViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let x = scrollView.contentOffset.x
        let w = scrollView.bounds.size.width
        let currentPage = Int(ceil(x/w))
        
        self.segmantedControl.selectedSegmentIndex = currentPage
    }
}

extension MainViewController: UICollectionViewDelegateFlowLayout{
     func collectionView(_ collectionView: UICollectionView,
                           layout collectionViewLayout: UICollectionViewLayout,
                           sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: collectionView.frame.size.width, height: collectionView.frame.size.height)
    }
}
