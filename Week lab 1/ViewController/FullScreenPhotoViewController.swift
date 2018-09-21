//
//  FullScreenPhotoViewController.swift
//  Week lab 1
//
//  Created by Joseph Andy Feidje on 9/21/18.
//  Copyright © 2018 Softmatech. All rights reserved.
//

import UIKit

class FullScreenPhotoViewController: UIViewController, UIScrollViewDelegate{

    
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageZoomView: UIImageView!
    var imageURL = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let urls = URL(string: imageURL)!
        scrollView.delegate = self
        print("******************************",urls)
        // Do any additional setup after loading the view.
        imageZoomView.af_setImage(withURL: urls)
        scrollView.contentSize = imageZoomView.image!.size
    }

    @IBAction func closeAction(_ sender: UIButton) {
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageZoomView
    }
    

}
