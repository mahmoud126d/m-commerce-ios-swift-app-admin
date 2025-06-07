//
//  Shoplet_AdminApp.swift
//  Shoplet-Admin
//
//  Created by Macos on 03/06/2025.
//

import SwiftUI

@main
struct Shoplet_AdminApp: App {
    var body: some Scene {
        WindowGroup {
            let networkManager = NetworkManager()
            let repository = ProductRepository(networkManager: networkManager)
            let getProductsUseCase = GetProductsUseCase(repository: repository)
            let deleteProductsUseCase = DeleteProductsUseCase(repository: repository)
            let createProductsUseCase = CreateProductsUseCase(repository: repository)
            let viewModel = ProductViewModel(
                getProductsUseCase: getProductsUseCase,
                deleteProductUseCase: deleteProductsUseCase, 
                createProductUseCase: createProductsUseCase)
            ProductsView(viewModel: viewModel)
        }
    }
}
