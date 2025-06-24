//
//  NetworkManager_Tests.swift
//  Shoplet-AdminTests
//
//  Created by Macos on 24/06/2025.
//

import XCTest
@testable import Shoplet_Admin

final class NetworkManager_Tests: XCTestCase {

    var networkManager:NetworkManager!
    
    override func setUp() {
        networkManager = NetworkManager()
    }

    override func tearDown() {
        networkManager = nil
        super.tearDown()
    }

    func testGetAllProductsSuccess_responseNotNil() async throws {
        do {
            let response = try await networkManager.getProducts()
            XCTAssertNotNil(response)
        } catch {
            XCTFail("getProducts() threw an error: \(error)")
        }
    }
    func testGetAllCollectionsSuccess_responseNotNil() async throws {
        do {
            let response = try await networkManager.getCollections()
            XCTAssertNotNil(response)
        } catch {
            XCTFail("getCollections() threw an error: \(error)")
        }
    }
    func testGetPriceRulesSuccess_responseNotNil() async throws{
        do {
            let response = try await networkManager.getPriceRules()
            XCTAssertNotNil(response)
        } catch {
            XCTFail("getPriceRules() threw an error: \(error)")
        }
    }
    func testGetDiscountCodesSuccess_responseNotNil() async throws{
        do {
            let response = try await networkManager.getDiscountCodes(priceRuleId: 1414955106522)
            XCTAssertNotNil(response)
        } catch {
            XCTFail("getDiscountCodes() threw an error: \(error)")
        }
    }
    
    func testCreateProductSuccess() async throws{
        let request = ProductRequest(product: Product(title: "Testing product", description: "Product to test", vendor: "No vendor", productType: "Testing", tags: "test", variants: nil, images: nil))
        do {
            let response = try await networkManager.createProduct(product: request)
            XCTAssertNotNil(response)
        } catch {
            XCTFail("CreateProduct() threw an error: \(error)")
        }
    }
    
    func testUpdateProductFailure() async throws{
        let request = ProductRequest(product: Product(id: 1, title: "Testing product", description: "Product to test", vendor: "No vendor", productType: "Testing", tags: "test", variants: nil, images: nil))
        do {
                _ = try await networkManager.updateProduct(product: request)
            } catch let error as NetworkError {
                switch error {
                case .other(let message):
                    XCTAssertEqual(message, "Received invalid response from server.")
                default:
                    XCTFail("Expected .other error, got \(error)")
                }
            } catch {
                XCTFail("Expected NetworkError, got: \(error)")
            }
        
    }
    func testDeleteProductFailure() async throws{
        do {
                _ = try await networkManager.deleteProduct(id: 0)
            } catch let error as NetworkError {
                switch error {
                case .other(let message):
                    XCTAssertEqual(message, "Received invalid response from server.")
                default:
                    XCTFail("Expected .other error, got \(error)")
                }
            } catch {
                XCTFail("Expected NetworkError, got: \(error)")
            }
    }
    func testCreateCollectionSuccess_responseNotNil() async throws{
        let request = CollectionRequest(collection: Collection(title: "Testing collection", image: nil))
        do {
            let response = try await networkManager.createCollection(collection: request)
            XCTAssertNotNil(response)
        } catch {
            XCTFail("CreateCollectiones() threw an error: \(error)")
        }
    }
    func testUpdateCollectionFailure() async throws{
        let request = CollectionRequest(collection: Collection(id: 1, title: "Testing", image: nil))
        do {
                _ = try await networkManager.updateCollection(collection: request)
            } catch let error as NetworkError {
                switch error {
                case .other(let message):
                    XCTAssertEqual(message, "Received invalid response from server.")
                default:
                    XCTFail("Expected .other error, got \(error)")
                }
            } catch {
                XCTFail("Expected NetworkError, got: \(error)")
            }
    }
    func testDeleteCollectionFailure() async throws{
        do {
                _ = try await networkManager.deleteCollection(collectionId: 0)
            } catch let error as NetworkError {
                switch error {
                case .other(let message):
                    XCTAssertEqual(message, "Received invalid response from server.")
                default:
                    XCTFail("Expected .other error, got \(error)")
                }
            } catch {
                XCTFail("Expected NetworkError, got: \(error)")
            }
    }
    func testDeletePriceRuleFailure() async throws{
        do {
             _ = try await networkManager.deletePriceRule(id: 0)

            } catch let error as NetworkError {
                switch error {
                case .other(let message):
                    XCTAssertEqual(message, "Received invalid response from server.")
                default:
                    XCTFail("Expected .other error, got \(error)")
                }
            } catch {
                XCTFail("Expected NetworkError, got: \(error)")
            }
    }
    func testDeleteDiscountCodeFailure() async throws{
        do {
             _ = try await networkManager.deleteDiscountCode(ruleId: 0, codeId: 0)

            } catch let error as NetworkError {
                switch error {
                case .other(let message):
                    XCTAssertEqual(message, "Received invalid response from server.")
                default:
                    XCTFail("Expected .other error, got \(error)")
                }
            } catch {
                XCTFail("Expected NetworkError, got: \(error)")
            }
    }
    func testUpdateDiscountCodeFailure() async throws{
        let request = DiscountCodesRequest(discountCode: DiscountCode(code: "code"))
        do {
                _ = try await networkManager.updateDiscountCode(priceRuleId: 0, discountCode: request)
            } catch let error as NetworkError {
                switch error {
                case .other(let message):
                    XCTAssertEqual(message, "Received invalid response from server.")
                default:
                    XCTFail("Expected .other error, got \(error)")
                }
            } catch {
                XCTFail("Expected NetworkError, got: \(error)")
            }
    }
    func testCreateDiscountCodeFailure() async throws{
        let request = DiscountCodesRequest(discountCode: DiscountCode(code: "code"))
        do {
                _ = try await networkManager.createDiscountCode(priceRuleId: 0, discountCode: request)
            } catch let error as NetworkError {
                switch error {
                case .other(let message):
                    XCTAssertEqual(message, "Received invalid response from server.")
                default:
                    XCTFail("Expected .other error, got \(error)")
                }
            } catch {
                XCTFail("Expected NetworkError, got: \(error)")
            }
    }
    func testUpdatePriceRuleFailure() async throws{
        let request = PriceRuleRequest(priceRule: PriceRule(title: "Testing 10%", valueType: "percentage", value: "-10", customerSelection: "all", targetType: "line_item", targetSelection: "all", allocationMethod: "across"))
        do {
                _ = try await networkManager.updatePriceRule(priceRuleRequest: request)
            } catch let error as NetworkError {
                switch error {
                case .other(let message):
                    XCTAssertEqual(message, "Received invalid response from server.")
                default:
                    XCTFail("Expected .other error, got \(error)")
                }
            } catch {
                XCTFail("Expected NetworkError, got: \(error)")
            }
    }
    func testCreatePriceRuleFailure() async throws{
        let request = PriceRuleRequest(priceRule: PriceRule(title: "Testing 10%", valueType: "percentage", value: "-10", customerSelection: "all", targetType: "line_item", targetSelection: "all", allocationMethod: "across"))
        do {
                _ = try await networkManager.createPriceRule(rule: request)
            } catch let error as NetworkError {
                switch error {
                case .other(let message):
                    XCTAssertEqual(message, "Received invalid response from server.")
                default:
                    XCTFail("Expected .other error, got \(error)")
                }
            } catch {
                XCTFail("Expected NetworkError, got: \(error)")
            }
    }
}
