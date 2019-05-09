//
//  DetailViewController.swift
//  QuickDock
//
//  Created by LTXX on 2019/5/9.
//  Copyright © 2019 LTXX. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    // MARK: - Constants
    // Constants for Storyboard/ViewControllers.
    private static let storyboardName = "MainStoryboard"
    private static let viewControllerIdentifier = "DetailViewController"
    
    // Constants for state restoration.
    private static let restoreImage = "restoreImageKey"
    
    // MARK: - Properties
    var image: Image!
    
    @IBOutlet private weak var yearLabel: UILabel!
    @IBOutlet private weak var priceLabel: UILabel!
    
    // MARK: - Initialization
    class func detailViewControllerForImage(_ image: Image) -> UIViewController {
        let storyboard = UIStoryboard(name: DetailViewController.storyboardName, bundle: nil)
        
        let viewController =
            storyboard.instantiateViewController(withIdentifier: DetailViewController.viewControllerIdentifier)
        
        if let detailViewController = viewController as? DetailViewController {
            detailViewController.image = image
        }
        return viewController
    }
    
    // MARK: - View Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if #available(iOS 11.0, *) {
            self.navigationItem.largeTitleDisplayMode = .automatic
        }
        title = image.title
    }
}

// MARK: - UIStateRestoration

extension DetailViewController {
    
    override func encodeRestorableState(with coder: NSCoder) {
        super.encodeRestorableState(with: coder)
        
        // Encode the image.
        coder.encode(image, forKey: DetailViewController.restoreImage)
    }
    
    override func decodeRestorableState(with coder: NSCoder) {
        super.decodeRestorableState(with: coder)
        
        // Restore the image.
        if let decodedImage = coder.decodeObject(forKey: DetailViewController.restoreImage) as? Image {
            image = decodedImage
        } else {
            fatalError("A image did not exist. In your app, handle this gracefully.")
        }
    }
}
