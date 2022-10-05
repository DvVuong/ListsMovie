//
//  ViewController.swift
//  MovieList
//
//  Created by admin on 05/10/2022.
//

import UIKit

class ListMovieViewController: UIViewController {
    @IBOutlet private var listcolectionView: UICollectionView!
    
    lazy var presenter = ListsMoviePresenter(with: self)
    private let refreschControl = UIRefreshControl()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.loadData()
        setupColecctionView()
        setupRefrechControl()
    }
    private func setupRefrechControl(){
        if #available(iOS 10.0, *) {
            self.listcolectionView.refreshControl = refreschControl
        }
        else {
            self.listcolectionView.addSubview(refreschControl)
        }
        listcolectionView.refreshControl?.addTarget(self, action: #selector(swipeTo), for: .valueChanged)
    }
    @objc private func swipeTo(){
        listcolectionView.reloadData()
        listcolectionView.refreshControl?.endRefreshing()
    }
    private func setupColecctionView() {
        listcolectionView.delegate = self
        listcolectionView.dataSource = self
        let nib = UINib(nibName: "ListsMovieCollectionViewCell", bundle: nil)
        listcolectionView.register(nib, forCellWithReuseIdentifier: "MoveCell12")
        if let layout = listcolectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.minimumInteritemSpacing = 8
            layout.minimumLineSpacing = 8
            let totalSize = listcolectionView.frame.width - 0.1
            let numberRow = 2.0
            let size = (totalSize - 32  - (numberRow ) * layout.minimumInteritemSpacing) / 2
            layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10)
            layout.itemSize = CGSize(width: size, height: 450)
        }
        // REGISTER FOR HEADER
        let header = UINib(nibName: "HeaderCell", bundle: nil)
        listcolectionView.register(header, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerCell")
    }

}
extension ListMovieViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return 2
//    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter.numberOfItem()
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = listcolectionView.dequeueReusableCell(withReuseIdentifier: "MoveCell12", for: indexPath) as! ListsMovieCollectionViewCell
        if let data = presenter.cellForItemAt(at: indexPath.item) {
        cell.updateMovie(data: data)
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let data = presenter.cellForItemAt(at: indexPath.row) {
            let vc = DetailMovieViewController.intance(data: data)
            navigationController?.pushViewController(vc, animated: true
            )
        }
       
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerCell", for: indexPath) as! HeaderCell
            header.lbTitle.text = "Lists Movies"
            header.close = {
                print("asd")
            }
            return header
        default:
            break
        }
        return UICollectionReusableView()
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 50)
    }
    
    
}

extension ListMovieViewController: ListsMoviePresenterView {
    func showListMovie() {
        DispatchQueue.main.async {
            self.listcolectionView.reloadData()
        }
    }
    
    
}
