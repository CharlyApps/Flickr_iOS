//
//  ViewController.swift
//  Flickr
//
//  Created by Carlos Bastida on 21/09/21.
//

import UIKit

class ViewController: UIViewController {
    //MARK: - Variables
    private var viewModel: FeedViewModel!
    private var isLoading = false
    
    @IBOutlet weak var imagesCollectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    let apiClient = API()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.fetchDemoData(with: "home")
    }
    
    func fetchDemoData(with tag: String){
        if (self.isLoading == false){
            
            self.isLoading = true
            viewModel = FeedViewModel(request: tag, delegate: self)
            viewModel.fetchImageList()
        }
    }
    
    func genericAlert(text: String) {
        
        let alert = UIAlertController(title: "Error", message: text, preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }

}
extension ViewController: FeedViewModelDelegate{
    
    func onDataFetched() {
        
        DispatchQueue.main.async {
            if(self.viewModel.items.count == 0) {
                self.genericAlert(text: "Oops!, we couldn't find any image, try maybe with dogs or cats...")
            }
            else {
                
                self.isLoading = false
                
                self.imagesCollectionView.reloadData()
                
            }
            
        }
    }
    func onDataFailed() {
        
        DispatchQueue.main.async {
            self.genericAlert(text: "Oops! Something went wrong...")
        }
    }
    
    func onDataViewedFetched() {
        
    }

}
extension ViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.fetchDemoData(with: self.searchBar.text!)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.isLoading = false
        self.fetchDemoData(with: self.searchBar.text!)
        self.view.endEditing(true)
    }
}

extension ViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let vc = storyboard.instantiateViewController(withIdentifier: "detailVC") as! DetailViewController
        
        vc.item = viewModel.items[indexPath.row]
        
        DispatchQueue.main.async {

            self.present(vc, animated: true, completion: nil)
            
        }
        
    }
    
}

extension ViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        self.viewModel.items.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell: ImageCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCollectionCell", for: indexPath) as! ImageCollectionViewCell
                
        cell.configure(with: viewModel.items[indexPath.row])
        
        return cell
    }
    
    
}
extension ViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = collectionView.frame.size.width
        let customWidth = width / 3 - 3
            return CGSize(width: customWidth, height: 200.0)
        }
    
}
