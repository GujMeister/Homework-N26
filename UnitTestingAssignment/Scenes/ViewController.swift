//
//  ViewController.swift
//  UnitTestingAssignment
//
//  Created by Chuck Norris on 11.05.1992.
//

import UIKit

final class ViewController: UIViewController {
    
    private let cartViewModel = CartViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        cartViewModel.viewDidLoad()
    }
}

extension Product: Equatable {
    static func == (lhs: Product, rhs: Product) -> Bool {
        return lhs.id == rhs.id &&
               lhs.title == rhs.title &&
               lhs.description == rhs.description &&
               lhs.price == rhs.price &&
               lhs.selectedQuantity == rhs.selectedQuantity
    }
}
