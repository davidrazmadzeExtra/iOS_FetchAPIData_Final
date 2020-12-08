 //
 //  ViewController.swift
 //  FetchAPIData
 //
 //  Created by David Razmadze on 12/8/20.
 //
 
 import UIKit
 
 class TableController: UITableViewController {
  
  // MARK: - Properties
  var stocks: [Stock]? {
    didSet {
      DispatchQueue.main.async {
        self.tableView.reloadData()
      }
    }
  }
  
  // MARK: - Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.backgroundColor = .gray
    
    fetchSupportedStocks { (allStocks) in
      self.stocks = allStocks
    }
    
  }
  
  func fetchSupportedStocks(completion: @escaping([Stock]) -> Void) {
    let baseURL = "https://finnhub.io/api/v1/stock/symbol"
    
    let urlString = "\(baseURL)?exchange=US&token=\(Constant.apiKey)"
    guard let url = URL(string: urlString) else { return }
    
    let dataTask = URLSession.shared.dataTask(with: url) { (data, _, _) in
      guard let jsonData = data else { return }
      let decoder = JSONDecoder()
      
      do {
        let decodedData = try decoder.decode([Stock].self, from: jsonData)
        completion(decodedData)
      } catch {
        print(error.localizedDescription)
      }
    }
    dataTask.resume()
  }
  
 }
 
 // MARK: - UITableViewDelegate/UITableViewDataSource
 
 extension TableController {
  
  /// Number of cells in the first section
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return stocks?.count ?? 0
  }
  
  /// How to display each cell
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "TableviewCell", for: indexPath)
    
    let tickerSymbol = stocks?[indexPath.row].title ?? ""
    let companyName = stocks?[indexPath.row].companyName ?? ""
    cell.textLabel?.text = "\(String(describing: tickerSymbol)) - \(String(describing: companyName))"
    
    return cell
  }
  
 }
