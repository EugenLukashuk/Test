//
//  StoryTopCollectionViewCell.swift
//  Test
//
//  Created by Eugen on 17.07.2021.
//

import UIKit

class StoryTopCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var storyImage: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var releaseDateLbl: UILabel!
    @IBOutlet weak var popularityLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(story: Story) {
        if let path = story.backdropPath {
            storyImage.setImageFromURL(url: IMAGE_URL + path)
        }
        titleLbl.text = story.title
        releaseDateLbl.text = "Release: " + (story.releaseDate ?? "")
        popularityLbl.text = "Popularity: " + String(story.popularity ?? 0)
    }

}
