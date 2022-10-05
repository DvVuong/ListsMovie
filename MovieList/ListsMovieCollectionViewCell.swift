//
//  ListsMovieCollectionViewCell.swift
//  MovieList
//
//  Created by admin on 05/10/2022.
//

import UIKit

class ListsMovieCollectionViewCell: UICollectionViewCell {
    @IBOutlet private weak var viewCell: UIView!
    @IBOutlet weak var ratingControl: UIStackView!
    
    
    @IBOutlet private weak var imgMovie: UIImageView!
    @IBOutlet private weak var voteaverage: UILabel!
    
    @IBOutlet private weak var lbNameMovie: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        lbNameMovie.textColor = .black
        //imgMovie.contentMode = .scaleToFill
        imgMovie.layer.cornerRadius = 8
        imgMovie.layer.masksToBounds = true
        lbNameMovie.textAlignment = NSTextAlignment.left
        lbNameMovie.numberOfLines = 0
        voteaverage.textAlignment = .right
       
       
    }
    
    func updateMovie(data: Movie) {
        lbNameMovie.text = data.title
        voteaverage.text = String(data.voteaverage)
        ImageService.share.loadImage(with: "https://image.tmdb.org/t/p/w500" + data.posterPath) { image in
            self.imgMovie.image = image
        }
        
//        for star in ratingControl.arrangedSubviews {
//            star.isHidden = star.tag > Int(data.voteaverage)
//        }
//
        for i in 0..<ratingControl.arrangedSubviews.count {
            ratingControl.arrangedSubviews[i].isHidden = (i + 1) > Int(data.voteaverage)
        }
        

    }
    

}
