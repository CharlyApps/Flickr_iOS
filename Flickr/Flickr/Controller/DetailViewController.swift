//
//  DetailViewController.swift
//  Flickr
//
//  Created by Carlos Bastida on 21/09/21.
//

import UIKit
import SDWebImage
import TTGTagCollectionView

class DetailViewController: UIViewController {
    
    public var item: Item?

    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var imageSizeLabel: UILabel!
    @IBOutlet weak var tagView: TTGTextTagCollectionView!
    @IBOutlet weak var scrollView: UIScrollView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setValues()
        // Do any additional setup after loading the view.
    }
    
    // MARK: - Configuration Methods
    func setValues(){
        if let imageItem = item{
            self.itemImage.sd_setImage(with: URL(string: (imageItem.media?.m)!))
            self.artistLabel.text = self.getAuthorName(author: imageItem.author!)
            self.descriptionLabel.text = imageItem.description?.htmlToString
            self.imageSizeLabel.text = "Image Size: \(self.itemImage.image?.size.width ?? 0.0)w x \(self.itemImage.image?.size.height ?? 0.0)h"
            self.setFormatedDates()
            self.setTags()
        }
        
    }
    
    func setFormatedDates(){
        
        let dateFormatterGet = DateFormatter()
        let dateFormatterPrint = DateFormatter()
        
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatterPrint.dateFormat = "MMM d, yyyy"
        
        let dateTaken = dateFormatterPrint.string(from: dateFormatterGet.date(from: item!.date_taken!)!)
        
        self.dateLabel.text = "Taken: \(dateTaken)"
        
    }
    
    func getAuthorName(author: String) -> String{
        ///Small algorithm to trim the author name
        ///
        /// mymail@flickr ("ARTIST")
        
        if (author.contains("(") && (author.contains(")"))) {
            
            var firstIndex = author.firstIndex(of: "(")
            firstIndex = author.index(after: firstIndex!)
            
            let lastIndex = author.lastIndex(of: ")")
                
            return "\(author[firstIndex!..<lastIndex!])"

        }
        	
        return author
    }
    
    func setTags()
    {
        let tags = item?.tags?.components(separatedBy: " ")
        
        for t in tags!{
            
            let content = TTGTextTagStringContent.init(text: t)
                content.textColor = UIColor.white
                content.textFont = UIFont.boldSystemFont(ofSize: 16)
                        
            let normalStyle = TTGTextTagStyle.init()
                normalStyle.backgroundColor = UIColor.purple
                normalStyle.extraSpace = CGSize.init(width: 8, height: 8)
                        
            let tag = TTGTextTag.init()
                tag.content = content
                tag.style = normalStyle
                        
            tagView.addTag(tag)
        }
        
    }
    
    // MARK: - ACTIONS
    @IBAction func closeViewController(sender: UIButton){
        
        self.dismiss(animated: true, completion: nil
        )
    }
    
    @IBAction func shareImage(sender: UIButton) {
        
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Share me now!", message: "Choose an option to share:", preferredStyle: .actionSheet)
            
            let imageAction = UIAlertAction (title: "Image", style: .default, handler: {action in
                self.shareData(data: self.itemImage.image!)
            })
            
            let textAction = UIAlertAction (title: "Description", style: .default, handler: {action in
                self.shareData(data: self.descriptionLabel.text!)
            })
            
            let cardAction = UIAlertAction (title: "Image Card", style: .default, handler: {action in
                
                let renderImage = UIGraphicsImageRenderer(size: self.scrollView.contentSize)
                
                let image = renderImage.image { ctx in
                    self.scrollView.drawHierarchy(in: self.scrollView.bounds, afterScreenUpdates: true)
                }
                
                self.shareData(data: image)
            })
            
            let cancelAction = UIAlertAction (title: "Cancel", style: .destructive, handler: {action in
                
            })
            
            alert.addAction(imageAction)
            alert.addAction(textAction)
            alert.addAction(cardAction)
            alert.addAction(cancelAction)

            self.present(alert, animated: true, completion: nil)
        }
        
            
    }
    func shareData(data: Any){
                    
        let activityViewController = UIActivityViewController(activityItems: [data], applicationActivities: nil)
        
        activityViewController.popoverPresentationController?.sourceView = self.view
                    
        self.present(activityViewController, animated: true, completion: nil)
    }


}
