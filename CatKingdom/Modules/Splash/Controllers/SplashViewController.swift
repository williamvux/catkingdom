//
//  ViewController.swift
//  CatKingdom
//
//  Created by William on 19/10/25.
//

import UIKit

final class SplashViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
        addFullScreenSwiftUIView(safeArea: false, SplashUIView())
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.navigationController?.pushViewController(BreedViewController(), animated: true)
        }
    }


}

