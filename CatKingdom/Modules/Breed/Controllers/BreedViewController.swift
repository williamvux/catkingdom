//
//  BreedViewController.swift
//  CatKingdom
//
//  Created by William on 19/10/25.
//

import UIKit

class BreedViewController: UIViewController {
    private let breadVM: BreedViewModel
    init(breadVM: BreedViewModel = .init()) {
        self.breadVM = breadVM
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let uiView = BreedUIView(viewModel: breadVM)
        
        addFullScreenSwiftUIView(safeArea: true, uiView)
    }
    

}
