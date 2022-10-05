//
//  DetailMoviewPresenter.swift
//  MovieList
//
//  Created by admin on 05/10/2022.
//

import Foundation
protocol DetailMoviewPresenterView: NSObject {
    func showData(data: Movie)
}
class DetailMoviewPresenter {
    private weak var view: DetailMoviewPresenterView?
    private var data: Movie?
    init(with view: DetailMoviewPresenterView, data: Movie) {
        self.view = view
        self.data = data
    }
    func loadData() {
        if let data = data {
            view?.showData(data: data)
        }
    }
}
