//
//  HomeViewController.swift
//  PinjamanCair
//
//  Created by hekang on 2026/4/15.
//

import UIKit
import Combine
import SnapKit
import RxSwift
import RxCocoa
import MJRefresh

class HomeViewController: CommonViewController {
    
    private var homeViewModel = HomeViewModel()
    
    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: "login_bg_image")
        bgImageView.contentMode = .scaleAspectFill
        return bgImageView
    }()
    
    lazy var homeView: HomeView = {
        let homeView = HomeView(frame: .zero)
        return homeView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(bgImageView)
        bgImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        view.addSubview(homeView)
        homeView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.left.right.bottom.equalToSuperview()
        }
        
        self.homeView.scrollView.mj_header = MJRefreshNormalHeader(refreshingBlock: { [weak self] in
            guard let self = self else { return }
            self.getHomeDataInfo()
        })
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getHomeDataInfo()
    }
}

extension HomeViewController {
    
    private func getHomeDataInfo() {
        homeViewModel.getHomeDataInfo()
        
        homeViewModel
            .$homeModel
            .receive(on: DispatchQueue.main)
            .compactMap { $0 }
            .sink { [weak self] model in
                guard let self = self else { return }
                self.homeView.scrollView.mj_header?.endRefreshing()
            }
            .store(in: &cancellables)
        
        homeViewModel
            .$errorMsg
            .receive(on: DispatchQueue.main)
            .compactMap { $0 }
            .sink { [weak self] errorMsg in
                guard let self = self else { return }
                self.homeView.scrollView.mj_header?.endRefreshing()
            }
            .store(in: &cancellables)
    }
    
}
