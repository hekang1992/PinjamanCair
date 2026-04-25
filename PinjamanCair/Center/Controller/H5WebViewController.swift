//
//  H5WebViewController.swift
//  PinjamanCair
//
//  Created by hekang on 2026/4/18.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import WebKit
import StoreKit

class H5WebViewController: CommonViewController {
    
    var pageUrl: String = ""
    
    private let viewModel = ImageViewModel()
    
    lazy var headImageView: UIImageView = {
        let headImageView = UIImageView()
        headImageView.image = UIImage(named: "cen_bg_image")
        headImageView.contentMode = .scaleAspectFill
        return headImageView
    }()
    
    lazy var webView: WKWebView = {
        let config = WKWebViewConfiguration()
        let userContentController = WKUserContentController()
        let methodNames = ["BelieveWith", "CouldFemale", "HelpWithout", "CloseOr", "HoarDay"]
        for name in methodNames {
            userContentController.add(self, name: name)
        }
        config.userContentController = userContentController
        
        let webView = WKWebView(frame: .zero, configuration: config)
        webView.navigationDelegate = self
        webView.allowsBackForwardNavigationGestures = true
        return webView
    }()
    
    lazy var progressView: UIProgressView = {
        let progressView = UIProgressView(progressViewStyle: .bar)
        progressView.progressTintColor = .systemBlue
        progressView.trackTintColor = .lightGray
        progressView.isHidden = true
        return progressView
    }()
    
    // MARK: - Rx
    private let titleRelay = PublishRelay<String>()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupRx()
        loadWebView()
        addObservers()
    }
    
    @MainActor
    deinit {
        webView.removeObserver(self, forKeyPath: "estimatedProgress")
    }
    
    // MARK: - Setup
    private func setupUI() {
        view.addSubview(headImageView)
        headImageView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(482)
        }
        
        view.addSubview(headView)
        headView.configTitle("")
        headView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.height.equalTo(42)
            make.left.right.equalToSuperview()
        }
        
        headView.backBlock = { [weak self] in
            guard let self = self else { return }
            if self.webView.canGoBack {
                self.webView.goBack()
            }else {
                self.navigationController?.popToRootViewController(animated: true)
            }
        }
        
        view.addSubview(webView)
        webView.snp.makeConstraints { make in
            make.top.equalTo(headView.snp.bottom)
            make.left.right.bottom.equalToSuperview()
        }
        
        view.addSubview(progressView)
        progressView.snp.makeConstraints { make in
            make.top.equalTo(headView.snp.bottom)
            make.left.right.equalToSuperview()
            make.height.equalTo(2)
        }
    }
    
    private func setupRx() {
        titleRelay
            .debounce(.milliseconds(300), scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] title in
                self?.headView.configTitle(title)
            })
            .disposed(by: disposeBag)
    }
    
    private func loadWebView() {
        let reallyUrl = DeviceParamService.buildRequestURL(url: pageUrl, base: "")
        guard let url = URL(string: reallyUrl) else { return }
        let request = URLRequest(url: url)
        webView.load(request)
    }
    
    private func addObservers() {
        webView.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)
    }
    
    // MARK: - KVO
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            let progress = Float(webView.estimatedProgress)
            progressView.progress = progress
            progressView.isHidden = progress >= 1.0
            if progress >= 1.0 {
                progressView.setProgress(0, animated: false)
            }
        }
    }
}

extension H5WebViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        webView.title.map { titleRelay.accept($0) }
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        progressView.isHidden = true
    }
}

extension H5WebViewController: WKScriptMessageHandler {
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        switch message.name {
        case "BelieveWith":
            BelieveWith()
            
        case "CouldFemale":
            let params = message.body as? [String] ?? []
            let pageUrl = params.first ?? ""
            guard pageUrl.isEmpty else {
                if pageUrl.hasPrefix(URLSchemeRecognizer.scheme_url) {
                    URLSchemeRecognizer.recognizeScheme(from: pageUrl, with: self)
                }else {
                    self.pageUrl = pageUrl
                    self.loadWebView()
                }
                return
            }
            
        case "HelpWithout":
            HelpWithout()
            
        case "CloseOr":
            CloseOr()
            
        case "HoarDay":
            HoarDay()
            
        default:
            break
        }
    }
    
    func BelieveWith() {
        DispatchQueue.main.async { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
    }
    
    func HelpWithout() {
        DispatchQueue.main.async {
            NotificationCenter.default.post(name: .changeRootViewController, object: nil)
        }
    }
    
    func CloseOr() {
        DispatchQueue.main.async {
            if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                SKStoreReviewController.requestReview(in: scene)
            }
        }
    }
    
    func HoarDay() {
        locationManager.getCurrentLocation { locationDict in }
        Task {
            try? await Task.sleep(nanoseconds: 2_000_000_000)
            let parameters = ["wild": "9", "riddle": String(Int(Date().timeIntervalSince1970))]
            viewModel.pointInfo(parameters: parameters)
        }
    }
}
