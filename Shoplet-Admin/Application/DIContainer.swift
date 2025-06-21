//
//  DIContainer.swift
//  Shoplet-Admin
//
//  Created by mahmoud on 21/06/2025.
//

import Foundation

final class DIContainer {
    static let shared = DIContainer()
    
    private var dependencies: [String: Any] = [:]
    
    private init() {
        registerDependencies()
    }
    
    func register<T>(_ type: T.Type, instance: T) {
        let key = String(describing: type)
        dependencies[key] = instance
    }

    func resolve<T>(_ type: T.Type = T.self) -> T {
        let key = String(describing: type)
        guard let dependency = dependencies[key] as? T else {
            fatalError("No dependency found for \(key)")
        }
        return dependency
    }

    private func registerDependencies() {
        // Products
        let productRepository = ProductRepository()
        register(ProductsViewModel.self,
                 instance: ProductsViewModel(
                    getProductsUseCase: GetProductsUseCase(repository: productRepository),
                    deleteProductUseCase: DeleteProductsUseCase(repository: productRepository),
                    createProductUseCase: CreateProductsUseCase(repository: productRepository),
                    updateProductUseCase: UpdateProductUseCase(repository: productRepository)
                 )
        )

        // Collections
        let collectionsRepo = CollectionsRepository()
        register(CollectionsViewModel.self,
                 instance: CollectionsViewModel(
                    getCollectionsUseCase: GetCollectionsUseCase(repository: collectionsRepo),
                    createCollectionUseCase: CreateCollectionUseCase(repository: collectionsRepo),
                    updateCollectionUseCase: UpdateCollectionUseCase(repository: collectionsRepo),
                    deleteCollectionUseCase: DeleteCollectionUseCase(repository: collectionsRepo)
                 )
        )

        // PriceRules
        let couponRepo = CouponsRepository()
        register(PriceRulesViewModel.self,
                 instance: PriceRulesViewModel(
                    getPriceRulesUseCase: GetPriceRulesUseCase(repository: couponRepo),
                    createPriceRulesUseCase: CreatePriceRulesUseCase(repository: couponRepo),
                    deletePriceRulesUseCase: DeletePriceRulesUseCase(repository: couponRepo),
                    updatePriceRulesUseCase: UpdatePriceRulesUseCase(repository: couponRepo)
                 )
        )
        //discount codes
        
        register(DiscountCodeViewModel.self,
                 instance: DiscountCodeViewModel(
                    getDiscountCodesUseCase: GetDiscountCodesUseCase(repository: couponRepo)
                    , createDiscountCodesUseCase: CreateDiscountCodeUseCase(repository: couponRepo), deleteDiscountCodesUseCase: DeleteDiscountCodeUseCase(repository: couponRepo), updateDiscountCodesUseCase: UpdateDiscountCodeUseCase(repository: couponRepo))
                 )
    }
}
