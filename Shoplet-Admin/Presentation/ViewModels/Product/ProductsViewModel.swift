//
//  ProductViewModel.swift
//  Shoplet-Admin
//
//  Created by Macos on 03/06/2025.
//

import Foundation

class ProductsViewModel : ObservableObject {
    
    @Published var productList:[Product]?
    @Published var isLoading = true
    @Published var userError: NetworkError? = nil
    
    private let getProductsUseCase: GetProductsUseCaseProtocol
    private let deleteProductUseCase: DeleteProductsUseCaseProtocol
    private let createProductUseCase: CreateProductsUseCaseProtocol
    private let updateProductUseCase: UpdateProductUseCaseProtocol
    init(getProductsUseCase: GetProductsUseCaseProtocol,
         deleteProductUseCase: DeleteProductsUseCaseProtocol,
         createProductUseCase: CreateProductsUseCaseProtocol,
         updateProductUseCase:UpdateProductUseCaseProtocol
    ) {
        self.getProductsUseCase = getProductsUseCase
        self.deleteProductUseCase = deleteProductUseCase
        self.createProductUseCase = createProductUseCase
        self.updateProductUseCase = updateProductUseCase
    }
    
    func fetchProducts() {
        getProductsUseCase.execute { [weak self] result in
            switch result {
            case .success(let response):
                self?.isLoading = false
                self?.userError = nil
                self?.productList = response.products
            case .failure(let error):
                self?.userError = error
                print(error.localizedDescription)
            }
        }
    }
    func deleteProduct(productId:Int){
        deleteProductUseCase.execute(productId:productId) { [weak self] result in
            switch result {
            case .success( _):
                self?.isLoading = false
                self?.userError = nil
                if let index = self?.productList?.firstIndex(where: { $0.id == productId }) {
                    self?.productList?.remove(at: index)
                        }
            case .failure(let error):
                self?.userError = error
            }
        }
    }
    func createProduct(product:ProductRequest){
        createProductUseCase.execute(product: product){ [weak self] result in
            switch result {
            case .success( _):
                self?.isLoading = false
                self?.userError = nil
                self?.productList?.append(product.product)
            case .failure(let error):
                self?.userError = error
            }
        }
    }
    func updateProduct(product:ProductRequest){
        updateProductUseCase.execute(product: product){[weak self] result in
                switch result {
                case .success( _):
                    self?.isLoading = false
                    self?.userError = nil
                    //self?.productList?.append(product.product)
                case .failure(let error):
                    self?.userError = error
                }
        }
    }
}
