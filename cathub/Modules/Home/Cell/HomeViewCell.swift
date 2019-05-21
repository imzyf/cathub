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
        
        
        let colors = [Color.Material.orange50,
                      Color.Material.orange100,
                      Color.Material.orange200,
                      Color.Material.orange300,
                      Color.Material.orange400,
                      Color.Material.orange500,
                      Color.Material.orange600,
                      Color.Material.orange700,
                      Color.Material.orange800,
                      Color.Material.orange900,
                      Color.Material.orangeA100,
                      Color.Material.orangeA200,
                      Color.Material.orangeA400,
                      Color.Material.orangeA700]
        backgroundColor = colors.randomElement()!
        
        
        addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview()
            make.height.equalToSuperview()
        }
        addSubview(idLabel)
        idLabel.snp.makeConstraints { make in
            make.trailing.bottom.equalToSuperview().inset(4)
        }
    }
 
    /// MARK: Views
    private lazy var imageView: ImageView = {
        let view = ImageView()
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var idLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = "xxx"
        label.font = .systemFont(ofSize: 8)
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
