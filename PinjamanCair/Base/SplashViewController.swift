//
//  SplashViewController.swift
//  PinjamanCair
//
//  Created by hekang on 2026/4/15.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class SplashViewController: CommonViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.post(name: .changeRootViewController, object: nil)
    }

}
