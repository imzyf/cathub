//
//  SearchViewController.swift
//  cathub
//
//  Created by  moma on 2019/2/14.
//  Copyright © 2019 yifans. All rights reserved.
//

import IGListKit
import SwifterSwift
import UIKit

class SearchViewController: ViewController {

    var cats: [Cat]?

    override func viewDidLoad() {
        super.viewDidLoad()
        cats = [Cat(), Cat()]

        view.addSubview(collectionView)
        adapter.collectionView = collectionView
        adapter.dataSource = self
     
        SwifterSwift.delay(milliseconds: 2000) { [weak self] in
            self?.cats?.append(Cat())
            self?.adapter.performUpdates(animated: true, completion: nil)
        }
    }

    lazy var adapter: ListAdapter = {
        return ListAdapter(updater: ListAdapterUpdater(), viewController: self, workingRangeSize: 0)
    }()

    let collectionView: ListCollectionView = {
        let layout = ListCollectionViewLayout(stickyHeaders: false, topContentInset: 0, stretchToEdge: false)
        let view = ListCollectionView(frame: .zero, listCollectionViewLayout: layout)
        view.backgroundColor = .white
        return view
    }()

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }
}

extension SearchViewController: ListAdapterDataSource {

    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return cats ?? []
    }

    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        return SearchSectionController()
    }

    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return nil
    }
}
