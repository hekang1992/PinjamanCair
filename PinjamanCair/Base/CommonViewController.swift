//
//  CommonViewController.swift
//  PinjamanCair
//
//  Created by hekang on 2026/4/15.
//

import UIKit
import RxSwift
import RxCocoa
import Combine

class CommonViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    
    var cancellables = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }

}
