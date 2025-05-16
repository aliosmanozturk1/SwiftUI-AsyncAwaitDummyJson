//
//  ProductViewModel.swift
//  DummyJsonAsyncAwait
//
//  Created by Ali Osman Öztürk on 16.05.2025.
//

import Foundation

@MainActor
class ProductViewModel: ObservableObject {
    @Published var products: [Product] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    
    func fetchProducts() async {
        isLoading = true
        errorMessage = nil
        
        guard let url = URL(string: "https://dummyjson.com/products") else {
            errorMessage = "Geçersiz URL"
            isLoading = false
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decodedResponse = try JSONDecoder().decode(ProductResponse.self, from: data)
            self.products = decodedResponse.products
        } catch {
            errorMessage = "Veri çekilemedi: \(error.localizedDescription)"
        }
        
        isLoading = false
    }
}
