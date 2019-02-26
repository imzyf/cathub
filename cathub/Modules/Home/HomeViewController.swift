//
//  SearchViewController.swift
//  cathub
//
//  Created by  moma on 2019/2/14.
//  Copyright © 2019 yifans. All rights reserved.
//
 
import RxDataSources
import RxSwift
import SwifterSwift
import SwiftyJSON
import UIKit

class HomeViewController: ViewController, BindableType {
 
    typealias HomeSectionModel = SectionModel<String, HomeViewCellModelType>
 
    // MARK: ViewModel
    var viewModel: HomeViewModelType!
    
    // MARK: Private
    private var refreshControl: UIRefreshControl!
    private var dataSource: RxCollectionViewSectionedReloadDataSource<HomeSectionModel>!
    private var collectionViewDataSource: CollectionViewSectionedDataSource<HomeSectionModel>.ConfigureCell {
        return { _, collectionView, indexPath, cellModel in
            var cell = collectionView.dequeueReusableCell(withReuseIdentifier: R.reuseIdentifier.homeViewCell, for: indexPath)!
            cell.bind(to: cellModel)
            if let pinterestLayout = collectionView.collectionViewLayout as? PinterestLayout {
                cellModel.outputs.photoSize
                    .map { CGSize(width: $0.0, height: $0.1) }
                    .bind(to: pinterestLayout.rx.updateSize(indexPath))
                    .disposed(by: self.disposeBag)
            }
            return cell
        }
    }
    private let collectionViewLayout: UICollectionViewLayout!
    private var collectionView: UICollectionView!
    
    // MARK: Override
    init(collectionViewLayout: UICollectionViewLayout) {
        self.collectionViewLayout = collectionViewLayout
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(collectionView)
        
        configureNavigationController()
        configureCollectionView()
        configureRefreshControl()
        refresh()
    }
 
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }
    
    func bindViewModel() {
        let inputs = viewModel.inputs
        let outputs = viewModel.outputs
        
        outputs.isRefreshing
            .bind(to: refreshControl.rx.isRefreshing)
            .disposed(by: disposeBag)
        outputs.homeViewCellModelTypes
            .map { [HomeSectionModel(model: "", items: $0)] }
            .bind(to: collectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        collectionView.rx.reachedBottom()
            .skipUntil(outputs.isRefreshing)
            .bind(to: inputs.loadMore)
            .disposed(by: disposeBag)
    }
}

/// ui
extension HomeViewController {
    
    private func configureNavigationController() {
        navigationItem.title = "CatHub"
    }
    
    private func configureCollectionView() {
        view.addSubview(collectionView)
        collectionView.backgroundColor = .white
        collectionView.register(R.nib.homeViewCell)
        dataSource = RxCollectionViewSectionedReloadDataSource<HomeSectionModel>(
            configureCell: collectionViewDataSource
        )
    }
 
    private func configureRefreshControl() {
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        collectionView.addSubview(refreshControl)
    }
 
    @objc private func refresh() {
        viewModel.inputs.refresh()
    }
}
