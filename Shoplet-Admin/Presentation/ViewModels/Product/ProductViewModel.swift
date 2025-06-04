//
//  ProductViewModel.swift
//  Shoplet-Admin
//
//  Created by Macos on 03/06/2025.
//

import Foundation

class ProductViewModel : ObservableObject {
    
    @Published var productList:[Product]?
    
    private let getProductsUseCase: GetProductsUseCaseProtocol
    private let deleteProductUseCase: DeleteProductsUseCaseProtocol
    
    init(getProductsUseCase: GetProductsUseCaseProtocol, deleteProductUseCase: DeleteProductsUseCaseProtocol) {
        self.getProductsUseCase = getProductsUseCase
        self.deleteProductUseCase = deleteProductUseCase
    }
    
    func fetchProducts() {
        getProductsUseCase.execute { [weak self] result in
            switch result {
            case .success(let products):
                print("Success: \(products.count) products")
                self?.productList = products
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    func deleteProduct(productId:Int){
        deleteProductUseCase.execute(productId:productId,completion: { result in
//            switch result {
//            case .success(let response):
//                print(response)
//            case .failure(let error):
//                print(error)
//            }
        }
        )
    }
}
