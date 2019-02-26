//
//  SearchCell.swift
//  cathub
//
//  Created by  moma on 2019/2/14.
//  Copyright © 2019 yifans. All rights reserved.
//

import Kingfisher
import RxSwift
import SwifterSwift
import UIKit

final class HomeViewCell: CollectionViewCell, BindableType {
    
    // MARK: ViewModel
    var viewModel: HomeViewCellModelType!
    private var disposeBag = DisposeBag()
 
    override func setupUI() {
        super.setupUI()
        addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview()
            make.height.equalTo(snp.width).inset(44)
        }
        imageView.clipsToBounds = true
        backgroundColor = .random
        addSubview(idLabel)
        idLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
 
    /// MARK: Views
    private lazy var imageView: ImageView = {
        let view = ImageView()
        view.contentMode = .scaleAspectFill 
        return view
    }()
    
    private lazy var idLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = "xxx"
        return label
    }()
    
    // MARK: BindableType
    func bindViewModel() {
        let inputs = viewModel.inputs
        let outputs = viewModel.outputs
     
        outputs.id
            .bind(to: idLabel.rx.text)
            .disposed(by: disposeBag)
        outputs.photo
            .map { $0.url }
            .bind(to: imageView.rx.imageURL)
            .disposed(by: disposeBag)
    }
}
