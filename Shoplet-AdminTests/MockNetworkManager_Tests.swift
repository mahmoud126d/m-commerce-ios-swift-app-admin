//
//  MockNetworkManager_Tests.swift
//  Shoplet-AdminTests
//
//  Created by Macos on 28/06/2025.
//

import XCTest
@testable import Shoplet_Admin

final class MockNetworkManager_Tests: XCTestCase {

    private var mockNetworkManager:MockNetworkManager?
    override func setUp() {
        mockNetworkManager = MockNetworkManager()
    }

    override func tearDown() {
        mockNetworkManager = nil
    }

    func testGetProductsReturnsMockProduct() async throws {
        // Given
        guard let mockNetworkManager = mockNetworkManager else {
            XCTFail("MockNetworkManager is nil")
            return
        }

        // When
        let response = try await mockNetworkManager.getProducts()

        // Then
        XCTAssertFalse(response.products.isEmpty, "Product list should not be empty")
        XCTAssertEqual(response.products.first?.title, "Mock Product")
        XCTAssertEqual(response.products.first?.id, 1)
    }

}
