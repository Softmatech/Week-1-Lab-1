//
//  PhotosViewController.swift
//  Week lab 1
//
//  Created by Joseph Andy Feidje on 9/14/18.
//  Copyright © 2018 Softmatech. All rights reserved.
//

import UIKit
import AlamofireImage

class PhotosViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var photosView: UITableView!
    var posts : [[String: Any]] = []
    var refreshControl: UIRefreshControl!
    var urlImage = URL(string: "")
    var datee = ""
     var cell = UITableViewCell()
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
        headerView.backgroundColor = UIColor(white: 1, alpha: 0.9)
        
        let profileView = UIImageView(frame: CGRect(x: 10, y: 10, width: 30, height: 30))
        profileView.clipsToBounds = true
        profileView.layer.cornerRadius = 15;
        profileView.layer.borderColor = UIColor(white: 0.7, alpha: 0.8).cgColor
        profileView.layer.borderWidth = 1;
        
        // Set the avatar
        profileView.af_setImage(withURL: URL(string: "https://api.tumblr.com/v2/blog/humansofnewyork.tumblr.com/avatar")!)
        
        var label: UILabel! // Add a UILabel for the date here
        label = UILabel()
        getSectionRow(cell, sender: cell)
        print("date : ",datee)
        label.text = datee // let label = ...
        label.font = UIFont.systemFont(ofSize: 10)
        label.sizeToFit()
        label.center = CGPoint(x: 110, y: 25)
        headerView.addSubview(profileView)
        headerView.addSubview(label)
         // Use the section number to get the right URL
        
        return headerView
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return posts.count
    }
    
    //code to get photo counts
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    //code to get the photo and display
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoCell", for: indexPath) as! PhotoCell
        let post = posts[indexPath.section]
        if let photos = post["photos"] as? [[String: Any]]{
            
            let photo = photos[0]
            let originalSize = photo["original_size"] as! [String: Any]
            let urlString = originalSize["url"] as! String
                urlImage = URL(string: urlString)!
            cell.selectionStyle = .gray
            let backgroundView = UIView()
            backgroundView.backgroundColor = UIColor.red
            cell.selectedBackgroundView = backgroundView
            getSectionRow(cell, sender: cell)
            cell.imageCellView.af_setImage(withURL: urlImage!,placeholderImage: cell.placeholderImage,imageTransition: .crossDissolve(0.5))
        }
        return cell
    }
    
    
    func readPhotos(){
        let url = URL(string: "https://api.tumblr.com/v2/blog/humansofnewyork.tumblr.com/posts/photo?api_key=Q6vHoaVm5L1u2ZAW1fqv3Jw48gFzYVg9P0vH0VHl3GVy6quoGV")!
        
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        session.configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
        
        //create a task to get the data
        let task = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
                self.networkErrorAlert()
            }
            else if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
//                print(dataDictionary)
                // Get the dictionary from the response key
                let responseDictionary = dataDictionary["response"] as! [String: Any]
                // Store the returned array of dictionaries in our posts property
                self.posts = responseDictionary["posts"] as! [[String: Any]]
                self.tableView.reloadData()
                self.refreshControl.endRefreshing()
            }
        }
        task.resume()
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView.rowHeight = 250
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(PhotosViewController.didPullToRefresh(_:)), for: .valueChanged)
        tableView.insertSubview(refreshControl, at: 0)
        readPhotos()
    }
    @objc func didPullToRefresh(_ refreshControl: UIRefreshControl) {
        readPhotos()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func networkErrorAlert(){
        let alertController = UIAlertController(title: "Network Error", message: "It's Seems there is a network error. Please try again later.", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Try Again", style: UIAlertActionStyle.default, handler: { (action) in self.readPhotos()}))
        self.present(alertController, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
            cell = sender as! UITableViewCell
        let secondView = segue.destination as! PhotoDetailsViewController
        secondView.urlImages = getSectionRow(cell, sender: cell)
    }
    
    func getSectionRow(_: UITableViewCell, sender: Any?) -> String{
        cell = sender as! UITableViewCell
        var urlString = ""
        if let indexpath = tableView.indexPath(for: cell) {
            var post = posts[indexpath.section]
            if let photos = post["photos"] as? [[String: Any]]{
                let photo = photos[0]
                let originalSize = photo["original_size"] as! [String: Any]
                urlString = originalSize["url"] as! String
                datee = post["date"] as! String
//                print("********************** ",post["date"])
            }
        }
        return urlString
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
