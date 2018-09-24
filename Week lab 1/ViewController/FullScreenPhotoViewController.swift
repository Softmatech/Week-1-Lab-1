//
//  FullScreenPhotoViewController.swift
//  Week lab 1
//
//  Created by Joseph Andy Feidje on 9/21/18.
//  Copyright © 2018 Softmatech. All rights reserved.
//

import UIKit

class FullScreenPhotoViewController: UIViewController, UIScrollViewDelegate, UIGestureRecognizerDelegate{

    
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageZoomView: UIImageView!
    
    @IBOutlet var didTapPress: UITapGestureRecognizer!
    var imageURL = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let urls = URL(string: imageURL)!
        scrollView.delegate = self
        print("******************************",urls)
        // Do any additional setup after loading the view.
        imageZoomView.af_setImage(withURL: urls)
        scrollView.contentSize = imageZoomView.image!.size
        didTapPress.delegate = self
        //................................................
        // The didTap: method will be defined in Step 3 below.
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didpanTray(_:)))
        
        // Optionally set the number of required taps, e.g., 2 for a double click
        tapGestureRecognizer.numberOfTapsRequired = 2
        
        // Attach it to a view of your choice. If it's a UIImageView, remember to enable user interaction
    imageZoomView.isUserInteractionEnabled = true
    imageZoomView.addGestureRecognizer(tapGestureRecognizer)
    }

    @IBAction func closeAction(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageZoomView
    }
    
    @IBAction func didpanTray(_ sender: UITapGestureRecognizer) {
        viewForZooming(in: scrollView)
        print("-------------------------------")
    }
    
}
