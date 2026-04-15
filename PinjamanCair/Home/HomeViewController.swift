//
//  HomeViewController.swift
//  PinjamanCair
//
//  Created by hekang on 2026/4/15.
//

import UIKit
import Combine

class HomeViewController: CommonViewController {
    
    private var homeViewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        homeViewModel.getHomeDataInfo()
        
        homeViewModel
            .$homeModel
            .receive(on: DispatchQueue.main)
            .compactMap { $0 }
            .sink { model in
                
            }
            .store(in: &cancellables)
        
        homeViewModel
            .$errorMsg
            .receive(on: DispatchQueue.main)
            .compactMap { $0 }
            .sink { errorMsg in
                
            }
            .store(in: &cancellables)
    }
    
}
