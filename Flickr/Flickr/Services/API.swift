//
//  API.swift
//  Flickr
//
//  Created by Carlos Bastida on 21/09/21.
//

import Foundation

class API{
    ///Main url allows to use different endpoints
    let mainUrl = "https://api.flickr.com/services/feeds"
    let photosApi = "/photos_public.gne?format=json&nojsoncallback=1&tags="
    
    func getImagesData(with tag: String, completion: @escaping(FeedResponse?, Error?)->()){
        
        ///Escape string with host allowed characters to avoid crash like ? ' ...
        ///
        let queryString = tag.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        
        let url = URL(string: "\(mainUrl)\(photosApi)\(queryString!)")

        URLSession.shared.dataTask(with: url!){
            data, response, error in
            
            if let err = error {
                completion(nil, err)
                return
            }
            
            guard let data = data else {return}
            
            do{
                let response = try JSONDecoder().decode(FeedResponse.self, from:data)
                completion(response, nil)
            }
            catch
            {
                completion(nil, error)
            }
        }.resume()
    }
}
