//
//  GenreViewController.swift
//  TheMoviesDB
//
//  Created by Yael Bilu Eran on 11/04/2020.
//  Copyright © 2020 CodeQueen. All rights reserved.
//

import UIKit

class GenreViewController: UICollectionViewController{
    
    private var viewModel: BaseViewModel<MovieGenre>
    private var cancelSubscription: CancelSubscription?
    private static let SegueToMovies = "MoviesViewSegue"
    
    required init?(coder aDecoder: NSCoder) {
        self.viewModel = GenreViewModel()
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(GenreCell.nib, forCellWithReuseIdentifier: GenreCell.identifier)
        collectionView.register(SectionHeader.self,forSupplementaryViewOfKind:UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header")
        
        let item = UIBarButtonItem(image: UIImage(named: "AppIcon"), style: .plain, target: nil, action: nil)
        navigationItem.leftBarButtonItem = item
        
        
        cancelSubscription = viewModel.state.subscribe(on: .main) { [weak self] state in
            self?.handle(state)
        }
        viewModel.onSelectItem = { [weak self] genre in
            self?.performSegue(withIdentifier: GenreViewController.SegueToMovies, sender: genre)
        }
        viewModel.loadNextPage()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.dataCount
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView{
        if kind == UICollectionView.elementKindSectionHeader {
             let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath) as? SectionHeader
            return sectionHeader ?? UICollectionReusableView()
        } else { //No footer in this case but can add option for that
             return UICollectionReusableView()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 40)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GenreCell.identifier, for: indexPath) as? GenreCell{
            let genre  = viewModel.data(at: indexPath.row)
            cell.genre = genre
            return cell
        }
        return UICollectionViewCell()
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == GenreViewController.SegueToMovies {
            if let detailsVC = segue.destination as? MoviesViewController , let genre = sender as? MovieGenre{
                detailsVC.viewModel = MoviesViewModel()
                detailsVC.genre = genre
            }
        }
    }
    
    // MARK: UICollectionViewDelegate
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        viewModel.selectItem(at: indexPath.row)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 2, left: 4, bottom: 2, right: 4)
    }
    
    
    /// Changes the representation regarding the view model state
    func handle(_ state: State) {
        switch state {
            
        case .loading, .empty:
            collectionView.isHidden = true
           
        case .fatalError(let message):
            collectionView.isHidden = true
            
            let alert = UIAlertController(
                title: "ERROR",
                message: message,
                preferredStyle: .alert
            )
            present(alert, animated: true)
            
        case .data:
            collectionView.isHidden = false
            collectionView.reloadData()
        default: break
        }
    }
}

extension GenreViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let itemWidth = collectionView.bounds.width - 20
        let itemHeight = itemWidth * 0.15
        return CGSize(width: itemWidth  , height: itemHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 4
    }
}

