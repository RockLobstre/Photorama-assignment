//
//  PhotosViewController.swift
//  in-class-assignment
//
//  Created by Matin Salehi on 2019-03-14.
//  Copyright © 2019 centennial. All rights reserved.
//


import Foundation
import UIKit

class PhotosViewController: UIViewController {
    @IBOutlet var imageView:UIImageView!
    var store: PhotoStore!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        store.fetchInterestingPhotos{
            (PhotoResult) ->Void in
            switch PhotoResult{
            case let .success(photos):
                print("Successfully found \(photos.count) photos.")
                
                if let firstPhoto = photos.first {
                    self.updateImageView(for: firstPhoto)
                }
                
            case let .failure(error):
                print("Error fetching interesting photos: \(error)" )
            }
        }
    }
    func updateImageView(for photo: Photo) {
        store.fetchImage(for: photo){
            (imageResult) -> Void in
            
            switch imageResult {
            case let .success(image):
                self.imageView.image = image
            case let .failure(error):
                print("Error downloading image: \(error)")
                
            }
        }
    }
}
