//
//  LoanView.swift
//  PinjamanCair
//
//  Created by hekang on 2026/4/16.
//

import UIKit
import SnapKit

class LoanView: UIView {
    
    var applyBlock: ((String) -> Void)?
    
    var tabBarHeight: CGFloat {
        let bottomSafeArea = UIApplication.shared.windows.first?.safeAreaInsets.bottom ?? 0
        return 49 + bottomSafeArea
    }
    
    var modelArray: [visualModel]? {
        didSet {
            guard let modelArray = modelArray else { return }
            let cardModel = modelArray[0].intervening?[0]
            headView.interveningModel = cardModel
            
            let listArray = modelArray[1].intervening ?? []
            setupListView(with: listArray)
        }
    }
    
    private var listItemViews: [LoanListItemView] = []
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: .zero)
        scrollView.contentInsetAdjustmentBehavior = .never
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.backgroundColor = .clear
        return scrollView
    }()
    
    lazy var contentView: UIView = {
        let contentView = UIView()
        return contentView
    }()
    
    lazy var headView: LoanHeadView = {
        let headView = LoanHeadView(frame: .zero)
        headView.applyBlock = { [weak self] productID in
            guard let self = self else { return }
            self.applyBlock?(productID)
        }
        return headView
    }()
    
    lazy var whiteView: UIView = {
        let whiteView = UIView()
        whiteView.backgroundColor = UIColor(hex: "#FFFFFF")
        whiteView.layer.cornerRadius = 20
        whiteView.layer.masksToBounds = true
        whiteView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        return whiteView
    }()
    
    lazy var oneImageView: UIImageView = {
        let oneImageView = UIImageView()
        oneImageView.image = UIImage(named: "pc_c_imgae")
        return oneImageView
    }()
    
    lazy var footerView: UIView = {
        let footerView = UIView()
        footerView.backgroundColor = UIColor(hex: "#FFFFFF")
        return footerView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(footerView)
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(headView)
        contentView.addSubview(whiteView)
        whiteView.addSubview(oneImageView)
    }
    
    private func setupConstraints() {
        
        footerView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(400)
        }
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalTo(scrollView.snp.width)
        }
        
        headView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.right.equalToSuperview()
            make.height.equalTo(247)
        }
        
        whiteView.snp.makeConstraints { make in
            make.top.equalTo(headView.snp.bottom).offset(15)
            make.left.right.equalToSuperview()
            make.height.equalTo(0)
            make.bottom.equalToSuperview().offset(-(tabBarHeight + 10))
        }
        
        oneImageView.snp.makeConstraints { make in
            make.top.left.equalToSuperview().inset(24)
            make.size.equalTo(CGSize(width: 61, height: 27))
        }
    }
    
    private func setupListView(with models: [interveningModel]) {
        listItemViews.forEach { $0.removeFromSuperview() }
        listItemViews.removeAll()
        
        guard !models.isEmpty else {
            let onlyImageHeight: CGFloat = 27 + 24 + 24
            updateWhiteViewHeight(bottomY: onlyImageHeight)
            return
        }
        
        let itemWidth: CGFloat = 343
        let itemHeight: CGFloat = 120
        let spacing: CGFloat = 12
        let topMargin: CGFloat = 16
        
        let startY = 24 + 27 + topMargin
        
        for (index, model) in models.enumerated() {
            let itemView = LoanListItemView()
            whiteView.addSubview(itemView)
            listItemViews.append(itemView)
            itemView.interveningModel = model
            itemView.applyBlock = { [weak self] productID in
                guard let self = self else { return }
                self.applyBlock?(productID)
            }
            
            let currentY = startY + CGFloat(index) * (itemHeight + spacing)
            
            itemView.snp.makeConstraints { make in
                make.top.equalToSuperview().offset(currentY)
                make.centerX.equalToSuperview()
                make.width.equalTo(itemWidth)
                make.height.equalTo(itemHeight)
            }
        }
        
        let lastItemBottom = startY + CGFloat(models.count - 1) * (itemHeight + spacing) + itemHeight
        let bottomMargin: CGFloat = 30
        let whiteViewBottom = lastItemBottom + bottomMargin
        
        updateWhiteViewHeight(bottomY: whiteViewBottom)
    }
    
    private func updateWhiteViewHeight(bottomY: CGFloat) {
        whiteView.snp.updateConstraints { make in
            make.height.equalTo(bottomY)
        }
        
        self.setNeedsLayout()
        self.layoutIfNeeded()
    }
}


