//
//  DetailMovieViewController.swift
//  MovieList
//
//  Created by admin on 05/10/2022.
//

import UIKit

class DetailMovieViewController: UIViewController{
   
    
    static func intance(data: Movie) -> DetailMovieViewController {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailScreen") as! DetailMovieViewController
        
        vc.presenter = DetailMoviewPresenter(with: vc, data: data)
        return vc
    }
    @IBOutlet weak var imgMovie: UIImageView!
    @IBOutlet weak var lbname: UILabel!
    @IBOutlet weak var tvoverview: UITextView!
    @IBOutlet weak var lbReleaseDate: UILabel!
    @IBOutlet weak var ratingControl: UIStackView!
    @IBOutlet weak var lbVoteaverage: UILabel!
    
    
    private var presenter: DetailMoviewPresenter!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        lbname.numberOfLines = 0

        // Do any additional setup after loading the view.
        presenter.loadData()
        setupImageMovie()
    }
    private func setupImageMovie(){
        imgMovie.contentMode = .scaleToFill
        imgMovie.layer.cornerRadius = 10
        imgMovie.layer.masksToBounds = true
    }
    
    

    

}

extension DetailMovieViewController: DetailMoviewPresenterView {
    func showData(data: Movie) {
        lbname.text = "Name Movie: \(data.title)"
        tvoverview.text = "Overview: \(data.overview)"
        lbVoteaverage.text = "\(data.voteaverage)"
        lbReleaseDate.text = "Release date: \(data.releaseDate)"
        ImageService.share.loadImage(with: "https://image.tmdb.org/t/p/w500" + data.posterPath) { image in
            self.imgMovie.image = image
        }
        for star in ratingControl.arrangedSubviews {
            star.isHidden = star.tag > Int(data.voteaverage)
        }
        
    }
}
