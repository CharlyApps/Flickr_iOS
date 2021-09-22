//
//  FeedViewModel.swift
//  Flickr
//
//  Created by Carlos Bastida on 21/09/21.
//

import Foundation
protocol FeedViewModelDelegate: AnyObject {
    
    func onDataFetched()
    
    func onDataFailed()
    
    func onDataViewedFetched()
    
}
final class FeedViewModel{
    //MARK: - View Model Variables
    private weak var delegate: FeedViewModelDelegate?
    private var feedResponse = FeedResponse()
    private var isLoading = false
    
    let apiClient = API()
    var currentRequest : String
    
    var totalCount: Int {
        if let items = feedResponse.items {
            return items.count
        }
        return 0
    }
    
    var items: [Item]
    {
        if let items = feedResponse.items {
            return items
        }
        return [Item]()
    }
    //MARK: - View Model Init

    init(request: String, delegate: FeedViewModelDelegate) {
        self.currentRequest = request
        self.delegate = delegate
    }
    //MARK: - View Model functions

    func fetchImageList(){

        apiClient.getImagesData(with: self.currentRequest, completion: {[weak self] (FeedResponse, Error)in
            if let err = Error {
                self!.delegate?.onDataFailed()
                return
            }
            self!.feedResponse = FeedResponse!
            self!.delegate?.onDataFetched()
        })
        
        
    }
    
}
