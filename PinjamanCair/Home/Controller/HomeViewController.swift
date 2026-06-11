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
    
    private lazy var notNetView: NotNetWorkView = {
        let view = NotNetWorkView(frame: .zero)
        view.isHidden = true
        return view
    }()
    
    private let networkMonitor = NetworkMonitor.shared
    
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
        
        if UIDevice.current.model == "iPad" {
            monitorNetwork()
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
        
        view.addSubview(notNetView)
        notNetView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        notNetView.tapBlock = { [weak self] in
            guard let self = self else { return }
            self.loadHomeData()
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
        notNetView.isHidden = true
        homeView.interveningModel = model
    }
    
    func showLoanView(with visualModels: [visualModel]) {
        homeView.isHidden = true
        loanView.isHidden = false
        notNetView.isHidden = true
        
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

extension HomeViewController {
    
    private func monitorNetwork() {
        networkMonitor.startListening { [weak self] status in
            guard let self = self else { return }
            print("status======\(status.description)")
            switch status {
            case .unknown:
                self.notNetView.isHidden = false
                
            case .notReachable:
                self.notNetView.isHidden = false
                
            case .reachable(_):
                self.notNetView.isHidden = true
            }
        }
        
    }
    
}


import UIKit
import AVFoundation

class CameraViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, CustomCameraOverlayViewDelegate {
    func didTapShutterButton() {
        
    }
    
    func didTapCancelButton() {
        
    }
    

    var imagePicker: UIImagePickerController!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCamera()
    }

    func setupCamera() {
        // 1. 检查相机是否可用
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
            print("相机不可用")
            return
        }

        // 2. 初始化图片选择器
        imagePicker = UIImagePickerController()
        imagePicker.sourceType = .camera
        imagePicker.delegate = self
        // 隐藏默认的控制面板，以便完全显示我们的自定义视图
        imagePicker.showsCameraControls = false
        // 允许用户通过手势对焦
        imagePicker.allowsEditing = false

        // 3. 创建并设置自定义覆盖视图
        let overlay = CustomCameraOverlayView(frame: self.view.bounds)
        overlay.delegate = self // 用于处理按钮点击等事件
        imagePicker.cameraOverlayView = overlay

        // 4. 以模态形式弹出相机界面
        present(imagePicker, animated: true, completion: nil)
    }

    // 拍照成功后保存或处理图片
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let capturedImage = info[.originalImage] as? UIImage {
            // 在这里处理拍摄到的图片，例如保存到相册
            UIImageWriteToSavedPhotosAlbum(capturedImage, nil, nil, nil)
        }
        picker.dismiss(animated: true, completion: nil)
    }
}

// 自定义覆盖视图的代理，用于将按钮点击事件传回给视图控制器
protocol CustomCameraOverlayViewDelegate: AnyObject {
    func didTapShutterButton()
    func didTapCancelButton()
}

// MARK: - 自定义覆盖视图
class CustomCameraOverlayView: UIView {

    weak var delegate: CustomCameraOverlayViewDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        // 1. 添加灰色蒙版
        let overlayLayer = CAShapeLayer()
        overlayLayer.fillColor = UIColor.black.withAlphaComponent(0.6).cgColor
        overlayLayer.fillRule = .evenOdd
        self.layer.addSublayer(overlayLayer)
        
        // 2. 添加中间的透明矩形区域
        let maskRect = CGRect(x: 50, y: 200, width: self.bounds.width - 100, height: 300)
        let path = UIBezierPath(rect: self.bounds)
        let transparentPath = UIBezierPath(rect: maskRect)
        path.append(transparentPath.reversing())
        overlayLayer.path = path.cgPath

        // 3. 美化矩形边框 (可选)
        let borderLayer = CAShapeLayer()
        borderLayer.path = UIBezierPath(rect: maskRect).cgPath
        borderLayer.fillColor = UIColor.clear.cgColor
        borderLayer.strokeColor = UIColor.white.cgColor
        borderLayer.lineWidth = 2.0
        self.layer.addSublayer(borderLayer)

        // 4. 添加顶部的广告/说明区域
        let adLabel = UILabel(frame: CGRect(x: 20, y: 100, width: self.bounds.width - 40, height: 60))
        adLabel.text = "📢 这是广告位：扫描二维码参与活动"
        adLabel.textColor = .white
        adLabel.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        adLabel.textAlignment = .center
        adLabel.font = UIFont.boldSystemFont(ofSize: 16)
        self.addSubview(adLabel)

        // 5. 添加自定义按钮 (因为默认控件被隐藏了)
        let shutterButton = UIButton(frame: CGRect(x: self.bounds.midX - 35, y: self.bounds.height - 100, width: 70, height: 70))
        shutterButton.backgroundColor = .white
        shutterButton.layer.cornerRadius = 35
        shutterButton.layer.borderWidth = 3
        shutterButton.layer.borderColor = UIColor.lightGray.cgColor
        shutterButton.addTarget(self, action: #selector(shutterTapped), for: .touchUpInside)
        self.addSubview(shutterButton)
        
        let cancelButton = UIButton(frame: CGRect(x: 30, y: self.bounds.height - 90, width: 60, height: 40))
        cancelButton.setTitle("取消", for: .normal)
        cancelButton.setTitleColor(.white, for: .normal)
        cancelButton.addTarget(self, action: #selector(cancelTapped), for: .touchUpInside)
        self.addSubview(cancelButton)
    }
    
    // 在视图布局变化时更新蒙版图层的大小 (例如设备旋转)
    override func layoutSubviews() {
        super.layoutSubviews()
        // 更新图层的frame和path，确保蒙版与视图新的大小匹配。
        if let overlayLayer = self.layer.sublayers?.first(where: { $0 is CAShapeLayer }) as? CAShapeLayer {
            let maskRect = CGRect(x: 50, y: 200, width: self.bounds.width - 100, height: 300)
            let path = UIBezierPath(rect: self.bounds)
            path.append(UIBezierPath(rect: maskRect).reversing())
            overlayLayer.frame = self.bounds
            overlayLayer.path = path.cgPath
        }
    }
    
    @objc func shutterTapped() {
        delegate?.didTapShutterButton()
    }
    
    @objc func cancelTapped() {
        delegate?.didTapCancelButton()
    }
}
