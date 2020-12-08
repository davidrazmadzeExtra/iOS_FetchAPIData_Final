//
//  Stock.swift
//  FetchAPIData
//
//  Created by David Razmadze on 12/8/20.
//

import UIKit

struct Stock: Decodable {
  let title: String
  let companyName: String
  
  init(title: String, companyName: String) {
    self.title = title
    self.companyName = companyName
  }
  
  enum CodingKeys: String, CodingKey {
    case title = "displaySymbol"
    case companyName = "description"
  }
  
}
