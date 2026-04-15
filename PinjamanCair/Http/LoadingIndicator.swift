//
//  LoadingIndicator.swift
//  PinjamanCair
//
//  Created by hekang on 2026/4/15.
//

import UIKit
import SnapKit

class LoadingIndicator {
    
    static let shared = LoadingIndicator()
    
    private let containerView = UIView()
    
    private let whiteView = UIView()
    
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    
    private init() {
        setupViews()
    }
    
    private func setupViews() {
        containerView.backgroundColor = UIColor(white: 0, alpha: 0.5)
        
        whiteView.backgroundColor = .white
        whiteView.layer.cornerRadius = 10
        whiteView.layer.masksToBounds = true
        
        activityIndicator.hidesWhenStopped = true
    }
    
    func show() {
        if Thread.isMainThread {
            performShow()
        } else {
            DispatchQueue.main.async { [weak self] in
                self?.performShow()
            }
        }
    }
    
    private func performShow() {
        guard let window = UIApplication.shared.connectedScenes
            .compactMap({ $0 as? UIWindowScene })
            .first?.windows
            .first(where: { $0.isKeyWindow }) else {
            return
        }
        
        if containerView.superview != nil {
            return
        }
        
        window.addSubview(containerView)
        window.addSubview(whiteView)
        
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        whiteView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(100)
        }
        
        activityIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        whiteView.addSubview(activityIndicator)
        
        activityIndicator.startAnimating()
    }
    
    func hide() {
        if Thread.isMainThread {
            performHide()
        } else {
            DispatchQueue.main.async { [weak self] in
                self?.performHide()
            }
        }
    }
    
    private func performHide() {
        activityIndicator.stopAnimating()
        activityIndicator.removeFromSuperview()
        whiteView.removeFromSuperview()
        containerView.removeFromSuperview()
    }
}
