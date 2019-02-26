//
//  ViewController.swift
//  cathub
//
//  Created by  moma on 2019/2/14.
//  Copyright © 2019 yifans. All rights reserved.
//

import RxSwift
import UIKit

class ViewController: UIViewController {
    
     let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()

    }

    deinit {
//        logDebug("\(type(of: self)): Deinited")
    }

    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
//        logDebug("\(type(of: self)): Received Memory Warning")
    }
}

extension ViewController {
    func setupUI() {
        view.backgroundColor = .white
    }

}
