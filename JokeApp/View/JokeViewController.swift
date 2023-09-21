//
//  JokeViewController.swift
//  JokeApp
//
//  Created by Nitin Jain on 21/09/23.
//

import UIKit

class JokeViewController: UIViewController {

    private let jokeViewModel: JokeViewModelType
  
    init(viewModel: JokeViewModelType) {
        self.jokeViewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .red
    }
}

