//
//  PhotoDetailsViewController.swift
//  Week lab 1
//
//  Created by Joseph Andy Feidje on 9/20/18.
//  Copyright © 2018 Softmatech. All rights reserved.
//

import UIKit


class PhotoDetailsViewController: UIViewController {

    @IBOutlet weak var photoDetailsimageView: UIImageView!
    var urlImages = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("-------------------------------- ",urlImages)
        // Do any additional setup after loading the view.
        let urls = URL(string: urlImages)
        photoDetailsimageView.af_setImage(withURL: urls!)
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTap(sender:)))
        
        // Optionally set the number of required taps, e.g., 2 for a double click
        tapGestureRecognizer.numberOfTapsRequired = 2
        
        // Attach it to a view of your choice. If it's a UIImageView, remember to enable user interaction
        photoDetailsimageView.isUserInteractionEnabled = true
        photoDetailsimageView.addGestureRecognizer(tapGestureRecognizer)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func didTap(sender: UITapGestureRecognizer) {
        let location = sender.location(in: view)
        // User tapped at the point above. Do something with that if you want.
        print("Location --->>>> ",location)
    }
    
    @IBAction func didpanTray(_ sender: UITapGestureRecognizer) {
        let location = sender.location(in: view)
        print("Location --->>>> ",location)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var DetailsViewController = segue.destination as! FullScreenPhotoViewController
        
        DetailsViewController.imageURL = urlImages
    }

}
