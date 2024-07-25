//
//  ViewController.swift
//  CombineFrameWorkLearning
//
//  Created by Gaurav Sharma on 25/07/24.
//

import UIKit

import Combine

class ViewController: UIViewController {
    
    @IBOutlet weak var tableViewProducts : UITableView!
    
    private var cancellables: Set<AnyCancellable> = []
    
    var products : [Products]?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        fetchProducts()
        
    }
    

}

//MARK: - Functions

extension ViewController{
    
    private func fetchProducts(){
        
        getProducts()
        
            .receive(on: DispatchQueue.main)
        
            .sink { completion in
                
                switch completion{
                    
                case .finished:
                    
                    print("Finished")
                    
                case .failure(let error):
                    
                    print(error.localizedDescription)
                    
                }
                
            } receiveValue: { products in
                
                self.products = products
                
                self.tableViewProducts.reloadData()
                
            }
        
            .store(in: &cancellables)
        
    }
    
}



//MARK: - TableView Methods

extension ViewController: UITableViewDataSource,UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableViewProducts.dequeueReusableCell(withIdentifier: "ProductsTVC", for: indexPath) as! ProductsTVC
        
        let product = products?[indexPath.row]
        cell.product = product
        
        return cell
        
    }
    
    
}
