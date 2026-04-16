//
//  LoginViewController.swift
//  PinjamanCair
//
//  Created by hekang on 2026/4/16.
//

import UIKit
import SnapKit

class LoginViewController: CommonViewController {
    
    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: "login_bg_image")
        bgImageView.contentMode = .scaleAspectFill
        return bgImageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(bgImageView)
        bgImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        view.addSubview(headView)
        headView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.height.equalTo(42)
            make.left.right.equalToSuperview()
        }
        
        headView.backBlock = { [weak self] in
            guard let self = self else { return }
            self.dismiss(animated: true)
        }
    }

}
