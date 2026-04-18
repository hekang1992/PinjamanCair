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
    
    lazy var headView: AppHeadView = {
        let headView = AppHeadView(frame: .zero)
        return headView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }

}

extension CommonViewController {
    
    func toH5Page(with pageUrl: String) {
        let webVc = H5WebViewController()
        webVc.pageUrl = pageUrl
        self.navigationController?.pushViewController(webVc, animated: true)
    }
    
}
