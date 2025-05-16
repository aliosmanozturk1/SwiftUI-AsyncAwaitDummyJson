//
//  ProductView.swift
//  DummyJsonAsyncAwait
//
//  Created by Ali Osman Öztürk on 16.05.2025.
//


import SwiftUI

struct ProductView: View {
    @StateObject private var viewModel = ProductViewModel()
    
    var body: some View {
        NavigationView {
            Group {
                if viewModel.isLoading {
                    ProgressView("Yükleniyor...")
                } else if let error = viewModel.errorMessage {
                    Text(error)
                        .foregroundColor(.red)
                        .multilineTextAlignment(.center)
                        .padding()
                } else {
                    List(viewModel.products) { product in
                        VStack(alignment: .leading) {
                            Text(product.title)
                                .font(.headline)
                            Text(product.description)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                            Text("Fiyat: \(product.price, specifier: "%.2f") $")
                                .font(.caption)
                                .foregroundColor(.blue)
                        }
                        .padding(.vertical, 4)
                    }
                }
            }
            .navigationTitle("Ürünler")
        }
        .task {
            await viewModel.fetchProducts()
        }
    }
}

struct ProductView_Previews: PreviewProvider {
    static var previews: some View {
        ProductView()
    }
}
