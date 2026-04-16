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
        
        self.homeView.loanMentBlock = { [weak self] in
            guard let self = self else { return }
            guard UserSessionManager.isLoggedIn() else { popLogin(); return }
            ToastConfig.showMessage("贷款协议")
        }
        
        self.homeView.applyBlock = { [weak self] productID in
            guard let self = self else { return }
            guard UserSessionManager.isLoggedIn() else { popLogin(); return }
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getHomeDataInfo()
        setupBindings()
    }
}

extension HomeViewController {
    
    private func popLogin() {
        let popVc = BaseNavigationController(rootViewController: LoginViewController())
        popVc.modalPresentationStyle = .overFullScreen
        self.present(popVc, animated: true)
    }
    
    private func getHomeDataInfo() {
        homeViewModel.getHomeDataInfo()
    }
    
    private func setupBindings() {
        homeViewModel
            .$homeModel
            .receive(on: DispatchQueue.main)
            .compactMap { $0 }
            .sink { [weak self] model in
                guard let self = self else { return }
                self.homeView.scrollView.mj_header?.endRefreshing()
                let remains = model.remains ?? ""
                if remains == "0" {
                    if let modelArray = findJournalB(meantime: model.meantime ?? meantimeModel()) {
                        self.setupHomeUI(with: modelArray[0])
                    }else {
                        
                    }
                }
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
    
    func findJournalB(meantime: meantimeModel) -> [interveningModel]? {
        return meantime.visual?
            .first(where: { $0.cut == "journalb" })?
            .intervening
    }
    
    private func setupHomeUI(with model: interveningModel) {
        self.homeView.interveningModel = model
    }
    
}
