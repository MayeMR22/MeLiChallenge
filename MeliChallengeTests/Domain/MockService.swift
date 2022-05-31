//
//  MockService.swift
//  MeliChallengeTests
//
//  Created by Mayerly Rios on 30/05/22.
//

import Foundation
@testable import MeliChallenge

struct MockService {
    static let categoryId: String = "MCO1747"
    static let productId: String = "MCO464124554"
    static let searchText: String = "iphone"
    
    static let productModel = Product(siteId: "", query: nil, paging: nil, results: [Results(id: "MCO464124554", siteId: "MCO", title: "Combo 2 Forros Protector Sillas Carro Auto Mascota Perro", seller: Seller(id: 152737872, carDealer: false, realEstateAgency: false), price: 56900, prices: Prices(id: "MCO464124554", prices: nil), salePrice: nil, currencyId: "COP", availableQuantity: 500, soldQuantity: 500, buyingMode: "buy_it_now", listingTypeId: "gold_special", stopTime: "2040-10-22T15:30:20.000Z", condition: "new", permalink: "https://articulo.mercadolibre.com.co/MCO-464124554-combo-2-forros-protector-sillas-carro-auto-mascota-perro-_JM", thumbnail: "http://http2.mlstatic.com/D_646062-MCO43036011644_082020-I.jpg", acceptsMercadopago: true, installments: Installments(quantity: 36, amount: 1580.56, rate: 0, currencyId: "COP"), attributes: [Attributes(name: "Marca", valueId: nil, valueName: "VELBROS", attributeGroupId: "OTHERS", attributeGroupName: "Otros", source: 3376461333454861, id: "BRAND")], originalPrice: nil, categoryId: "MCO178000")])
    
    static let searchResult = SearchResult(siteId: "MCO", query: "", paging: Paging(total: 100, offset: 0, limit: 20, primaryResults: 100), results: [Results(id: "MCO464124554", siteId: "MCO", title: "Motorola G6 Plus 64 Gb Nimbus", seller: Seller(id: 152737872, carDealer: false, realEstateAgency: false), price: 56900, prices: Prices(id: "MCO464124554", prices: nil), salePrice: nil, currencyId: "COP", availableQuantity: 500, soldQuantity: 500, buyingMode: "buy_it_now", listingTypeId: "gold_special", stopTime: "2040-10-22T15:30:20.000Z", condition: "new", permalink: "https://articulo.mercadolibre.com.co/MCO-464124554-combo-2-forros-protector-sillas-carro-auto-mascota-perro-_JM", thumbnail: "http://http2.mlstatic.com/D_646062-MCO43036011644_082020-I.jpg", acceptsMercadopago: true, installments: Installments(quantity: 36, amount: 1580.56, rate: 0, currencyId: "COP"), attributes: [Attributes(name: "Marca", valueId: nil, valueName: "VELBROS", attributeGroupId: "OTHERS", attributeGroupName: "Otros", source: 3376461333454861, id: "BRAND")], originalPrice: nil, categoryId: "MCO178000"), Results(id: "MCO464124554", siteId: "MCO", title: "Motorola G44", seller: Seller(id: 152737872, carDealer: false, realEstateAgency: false), price: 56900, prices: Prices(id: "MCO464124554", prices: nil), salePrice: nil, currencyId: "COP", availableQuantity: 500, soldQuantity: 500, buyingMode: "buy_it_now", listingTypeId: "gold_special", stopTime: "2040-10-22T15:30:20.000Z", condition: "new", permalink: "https://articulo.mercadolibre.com.co/MCO-464124554-combo-2-forros-protector-sillas-carro-auto-mascota-perro-_JM", thumbnail: "http://http2.mlstatic.com/D_646062-MCO43036011644_082020-I.jpg", acceptsMercadopago: true, installments: Installments(quantity: 36, amount: 1580.56, rate: 0, currencyId: "COP"), attributes: [Attributes(name: "Marca", valueId: nil, valueName: "VELBROS", attributeGroupId: "OTHERS", attributeGroupName: "Otros", source: 3376461333454861, id: "BRAND")], originalPrice: nil, categoryId: "MCO178000")])
    
    static let description = Description(plainText: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.")
    
    static let categoryModel = [CategoryModel(id: "MCO1747", name: "Accesorios para Vehículos"), CategoryModel(id: "MCO441917", name: "Agro"), CategoryModel(id: "MCO1403", name: "Alimentos y Bebidas")]
}
