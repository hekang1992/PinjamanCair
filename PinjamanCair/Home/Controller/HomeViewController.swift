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
    
    private enum Constants {
        static let remainsZero = "0"
        static let journalB = "journalb"
        static let loginBgImage = "login_bg_image"
    }
    
    // MARK: - Properties
    private var homeViewModel = HomeViewModel()
    
    // MARK: - UI Components
    private lazy var bgImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: Constants.loginBgImage)
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var homeView: HomeView = {
        let view = HomeView(frame: .zero)
        view.isHidden = true
        return view
    }()
    
    private lazy var loanView: LoanView = {
        let view = LoanView(frame: .zero)
        view.isHidden = true
        return view
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupCallbacks()
        setupBindings()
        Task {
            await IDFAManager.requestIDFAWithDelay()
        }
        
        if UserSessionManager.isLoggedIn() {
            locationManager.getCurrentLocation { locationDict in }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadHomeData()
    }
}

// MARK: - UI Setup
private extension HomeViewController {
    
    func setupUI() {
        view.addSubview(bgImageView)
        bgImageView.snp.makeConstraints { $0.edges.equalToSuperview() }
        
        view.addSubview(homeView)
        homeView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.left.right.bottom.equalToSuperview()
        }
        
        view.addSubview(loanView)
        loanView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.left.right.bottom.equalToSuperview()
        }
    }
    
    func setupCallbacks() {
        homeView.scrollView.mj_header = MJRefreshNormalHeader(refreshingBlock: { [weak self] in
            self?.loadHomeData()
        })
        
        loanView.scrollView.mj_header = MJRefreshNormalHeader(refreshingBlock: { [weak self] in
            self?.loadHomeData()
        })
        
        homeView.loanMentBlock = { [weak self] in
            guard let self = self else { return }
            guard UserSessionManager.isLoggedIn() else {
                self.presentLogin()
                return
            }
            ToastConfig.showMessage("贷款协议")
        }
        
        homeView.applyBlock = { [weak self] productID in
            guard let self = self else { return }
            guard UserSessionManager.isLoggedIn() else {
                self.presentLogin()
                return
            }
            self.homeViewModel.enterInfo(parameters: ["undoubtedly": productID])
        }
        
        loanView.applyBlock = { [weak self] productID in
            guard let self = self else { return }
            guard UserSessionManager.isLoggedIn() else {
                self.presentLogin()
                return
            }
            self.homeViewModel.enterInfo(parameters: ["undoubtedly": productID])
        }
        
    }
}

// MARK: - Data Loading
private extension HomeViewController {
    
    func loadHomeData() {
        homeViewModel.getHomeDataInfo()
        if UserSessionManager.isLoggedIn() {
            locationManager.getCurrentLocation { [weak self] locationDict in
                guard let self = self else { return }
                if let locationDict = locationDict {
                    if LanguageManager.currentLanguage() == .indonesian {
                        homeViewModel.uploadLocationInfo(parameters: locationDict)
                    }
                }else {
                    if LanguageManager.currentLanguage() == .indonesian {
                        showSettingsAlert()
                    }
                }
            }
            
            if LanguageManager.currentLanguage() == .indonesian {
                let collector = DeviceInfoCollector()
                collector.collectAllInfo { [weak self] deviceInfo in
                    guard let self = self else { return }
                    if let jsonData = try? JSONEncoder().encode(deviceInfo),
                       let jsonString = String(data: jsonData, encoding: .utf8) {
                        let parameters = ["meantime": jsonString]
                        homeViewModel.uploadAppInfo(parameters: parameters)
                    }
                }
            }
            
        }
    }
    
    func findJournalB(meantime: meantimeModel?) -> [interveningModel]? {
        return meantime?.visual?
            .first(where: { $0.cut == Constants.journalB })?
            .intervening
    }
}

// MARK: - UI Updates
private extension HomeViewController {
    
    func updateUIWithHomeModel(_ model: BaseModel) {
        homeView.scrollView.mj_header?.endRefreshing()
        loanView.scrollView.mj_header?.endRefreshing()
        
        if model.remains == Constants.remainsZero {
            if let journalModels = findJournalB(meantime: model.meantime),
               let firstModel = journalModels.first {
                showHomeView(with: firstModel)
            } else {
                showLoanView(with: model.meantime?.visual ?? [])
            }
        }
    }
    
    func updateUIWithError(_ errorMsg: String) {
        homeView.scrollView.mj_header?.endRefreshing()
        loanView.scrollView.mj_header?.endRefreshing()
    }
    
    func updateUIWithEnterModel(_ model: BaseModel) {
        guard model.remains == Constants.remainsZero else { return }
        
        let pageUrl = model.meantime?.mere ?? ""
        if pageUrl.hasPrefix(URLSchemeRecognizer.scheme_url) {
            URLSchemeRecognizer.recognizeScheme(from: pageUrl, with: self)
        } else {
            navigateToH5Page(with: pageUrl)
        }
    }
    
    func showHomeView(with model: interveningModel) {
        homeView.isHidden = false
        loanView.isHidden = true
        homeView.interveningModel = model
    }
    
    func showLoanView(with visualModels: [visualModel]) {
        homeView.isHidden = true
        loanView.isHidden = false
        
        let filteredModels = visualModels.filter { $0.cut != "journala" }
        self.loanView.modelArray = filteredModels
    }
    
    func navigateToH5Page(with url: String) {
        toH5Page(with: url)
    }
    
    func presentLogin() {
        let navController = BaseNavigationController(rootViewController: LoginViewController())
        navController.modalPresentationStyle = .overFullScreen
        present(navController, animated: true)
    }
}

// MARK: - Bindings
private extension HomeViewController {
    
    func setupBindings() {
        bindHomeModel()
        bindErrorMsg()
        bindEnterModel()
    }
    
    func bindHomeModel() {
        homeViewModel
            .$homeModel
            .receive(on: DispatchQueue.main)
            .compactMap { $0 }
            .sink { [weak self] model in
                self?.updateUIWithHomeModel(model)
            }
            .store(in: &cancellables)
    }
    
    func bindErrorMsg() {
        homeViewModel
            .$errorMsg
            .receive(on: DispatchQueue.main)
            .compactMap { $0 }
            .sink { [weak self] errorMsg in
                self?.updateUIWithError(errorMsg)
            }
            .store(in: &cancellables)
    }
    
    func bindEnterModel() {
        homeViewModel
            .$enterModel
            .receive(on: DispatchQueue.main)
            .compactMap { $0 }
            .sink { [weak self] model in
                self?.updateUIWithEnterModel(model)
            }
            .store(in: &cancellables)
    }
}

extension HomeViewController {
    
    private func showSettingsAlert() {
        let today = Calendar.current.startOfDay(for: Date())
        let lastShownKey = "LastSettingsAlertDate"
        
        if let lastShownDate = UserDefaults.standard.object(forKey: lastShownKey) as? Date {
            let lastShownDay = Calendar.current.startOfDay(for: lastShownDate)
            if lastShownDay == today {
                return
            }
        }
        
        UserDefaults.standard.set(today, forKey: lastShownKey)
        
        let alert = UIAlertController(
            title: "Permission Required".localized,
            message: "Location permission is disabled. Please enable it in Settings to allow your loan application to be processed.".localized,
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "Cancel".localized, style: .cancel))
        alert.addAction(UIAlertAction(title: "Go to Settings".localized, style: .default) { _ in
            if let settingsURL = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(settingsURL)
            }
        })
        
        self.present(alert, animated: true)
    }
    
}
