//
//  MoviesViewController.swift
//  TheMoviesDB
//
//  Created by Yael Bilu Eran on 11/04/2020.
//  Copyright © 2020 CodeQueen. All rights reserved.
//

import UIKit

class MoviesViewController: UITableViewController{
    
    var viewModel: BaseViewModel<Movie>!
    var genre : MovieGenre!
    private var cancelSubscription: CancelSubscription?
    private static let detailsSegue = "MoviesDetailsViewSegue"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Movies - \(genre.name)"
        tableView.register(MovieCell.nib, forCellReuseIdentifier: MovieCell.identifier)
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 198
        
        cancelSubscription = viewModel?.state.subscribe(on: .main) { [weak self] state in
            self?.handle(state)
        }
        
        viewModel?.onSelectItem = { [weak self] movie in
            self?.performSegue(withIdentifier: MoviesViewController.detailsSegue, sender: movie)
        }
        
        viewModel?.loadNextPage()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
    }
    
    
    /// Changes the representation regarding the view model state
    func handle(_ state: State) {
        switch state {
            
        case .loading, .empty:
            tableView.isHidden = true
            
        case .fatalError(let message):
            tableView.isHidden = false
            
            let alert = UIAlertController(
                title: "ERROR",
                message: message,
                preferredStyle: .alert
            )
            present(alert, animated: true)
            
        case .data:
            tableView.isHidden = false
            tableView.reloadData()
        default: break
        }
    }
    
    deinit {
        cancelSubscription?()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == MoviesViewController.detailsSegue {
            if let detailsVC = segue.destination as? MovieDetailsViewControiier, let movie = sender as? Movie{
                detailsVC.movie = movie
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.dataCount ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Force unwrap because there is no good way to handle this mistakes
        if let movie = viewModel?.data(at: indexPath.row){
            let cell = tableView.dequeueReusableCell(withIdentifier: MovieCell.identifier) as? MovieCell
            cell?.configure(with: movie, and: genre)
            return cell ?? UITableViewCell()
        }
        return UITableViewCell()
    }
    
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == viewModel.dataCount - 5 {
            viewModel.loadNextPage()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel.selectItem(at: indexPath.row)
    }
}



