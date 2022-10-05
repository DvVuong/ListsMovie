//
//  ListsMoviePresenter.swift
//  MovieList
//
//  Created by admin on 05/10/2022.
//

import Foundation
protocol ListsMoviePresenterView: NSObject {
    func showListMovie() 
}
class ListsMoviePresenter {
    private weak var view: ListsMoviePresenterView?
    private var listsMovie = [Movie]()
    
    init(with view: ListsMoviePresenterView) {
        self.view = view
    }
    
    func loadData() {
        let url = URL(string: "https://api.themoviedb.org/3/discover/movie?api_key=4e4ef9a58cbb994af3e8b095b1d5036a&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=4&with_watch_monetization_types=flatrate")
        let task = URLSession.shared.dataTask(with: url!) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let json = try JSONDecoder().decode(MovieRespone.self, from: data)
                self.listsMovie = json.results
                self.listsMovie.append(contentsOf: json.results)
            }
            catch {
                print(error.localizedDescription)
            }
        }
        task.resume()
        view?.showListMovie()
    }
    func numberOfItem() -> Int {
        return listsMovie.count
    }
    func cellForItemAt(at index: Int) -> Movie? {
       if  index <= 0 && index > numberOfItem() {
            return nil
        }
        return listsMovie[index]
    }
        
}
    
    
