//
//  CartViewModelTests.swift
//  CartViewModelTests
//
//  Created by Luka Gujejiani on 12.05.24.
//

import XCTest
@testable import UnitTestingAssignment

final class CartViewModelTests: XCTestCase {
    
    var viewModel: CartViewModel!
    
    func testSucessfullySelectedItemsQuantity() {
        // Arrange
        let product1 = Product(id: 3, title: "Samsung Universe 9", description: "Samsung's new variant...", price: 1249, selectedQuantity: 2)
        let product2 = Product(id: 5, title: "Huawei P30", description: "...", price: 499, selectedQuantity: 1)
        let products = [product1, product2]
        
        // Act
        viewModel = CartViewModel()
        viewModel.selectedProducts = products
        
        // Assert
        XCTAssertEqual(viewModel.selectedItemsQuantity, 3)
    }
    
    func testTotalPrice() {
        // Arrange
        let product1 = Product(id: 3, title: "Samsung Universe 9", description: "Samsung's new variant...", price: 1249, selectedQuantity: 2)
        let product2 = Product(id: 5, title: "Huawei P30", description: "...", price: 499, selectedQuantity: 1)
        let products = [product1, product2]
        
        // Act
        viewModel = CartViewModel()
        viewModel.selectedProducts = products
        
        // Assert
        XCTAssertEqual(viewModel.totalPrice, 2997)
    }
    
    func testAddProductUsingId() {
        // Arrange
        let productID = 3
        let product = Product(id: productID, title: "Samsung Universe 9", description: "...", price: 1249, selectedQuantity: 1)
        viewModel = CartViewModel()
        viewModel.allproducts = [product] // Mock allproducts with the target product
        
        // Act
        viewModel.addProduct(withID: productID)
        
        // Assert
        XCTAssertEqual(viewModel.selectedItemsQuantity, 1)
        XCTAssertEqual(viewModel.selectedProducts.count, 1)
        XCTAssertEqual(viewModel.selectedProducts[0].id, productID)
    }
    
    func testAddProductUsingProduct() {
        //Arrange
        let product = Product(id: 3, title: "Samsung Universe 9", description: "...", price: 1249, selectedQuantity: 1)
        viewModel = CartViewModel()
        
        // Act
        viewModel.addProduct(product: product)
        
        // Assert
        XCTAssertEqual(viewModel.selectedProducts.count, 1)
        XCTAssertEqual(viewModel.selectedProducts[0].id, product.id)
        XCTAssertEqual(viewModel.selectedProducts[0].selectedQuantity, product.selectedQuantity)
    }
    
    func testRemoveProductWithID() {
        //Arrange
        let product1 = Product(id: 3, title: "Samsung Universe 9", description: "...", price: 1249, selectedQuantity: 2)
        let product2 = Product(id: 5, title: "Huawei P30", description: "...", price: 499, selectedQuantity: 1)
        viewModel = CartViewModel()
        viewModel.selectedProducts = [product1, product2]
        
        // Act
        viewModel.removeProduct(withID: 3)
        
        // Assert
        XCTAssertEqual(viewModel.selectedProducts.count, 1) // One product left
        XCTAssertEqual(viewModel.selectedProducts[0].id, 5) // Konkretni product with id 3 was removed
    }
    
    func testAddRandomProduct() {
        // Arrange
        let product1 = Product(id: 3, title: "Samsung Universe 9", description: "...", price: 1249, selectedQuantity: 2)
        let product2 = Product(id: 5, title: "Huawei P30", description: "...", price: 499, selectedQuantity: 1)
        viewModel = CartViewModel()
        viewModel.allproducts = [product1, product2]
        
        // Act
        viewModel.addRandomProduct()
        
        // Assert
        XCTAssertTrue(viewModel.selectedProducts.contains(where: { $0 == product1 || $0 == product2 }), "Random product should be added")
        XCTAssertTrue(viewModel.selectedProducts.count == 1, "One product should be chamatebuli")
    }
    
    func testClearCart() {
        //Arrange
        let product1 = Product(id: 3, title: "Samsung Universe 9", description: "...", price: 1249, selectedQuantity: 2)
        let product2 = Product(id: 5, title: "Huawei P30", description: "...", price: 499, selectedQuantity: 1)
        viewModel = CartViewModel()
        viewModel.selectedProducts = [product1, product2]
        
        // Act
        viewModel.clearCart()
        
        // Assert
        XCTAssertEqual(viewModel.selectedProducts.count, 0) //Products were removed
    }
    
    // MARK: - Testing Network call
    func testFetchProducts() {
        //Arrange
        viewModel = CartViewModel()
        
        // Act
        viewModel.viewDidLoad()
        viewModel.fetchProducts()
        
        // Assert
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) { [self] in
            XCTAssertNotNil(viewModel.allproducts, "Products should not be nil")
            XCTAssertEqual(viewModel.allproducts?.count, 30)
        }
    }
}
