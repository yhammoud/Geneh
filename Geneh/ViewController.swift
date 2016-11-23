//
//  ViewController.swift
//  Geneh
//
//  Created by Youssef Hammoud on 11/10/16.
//  Copyright © 2016 Geneh. All rights reserved.
//

import UIKit
import Alamofire
import MBProgressHUD

class ViewController: UIViewController {

    let url = "https://currencynotification.herokuapp.com/api/exchange_rate"
    let graphUrl = "https://www.google.com/finance/chart?q=CURRENCY:USDEGP&tkr=1&p=1M&chst=vkc&chs=269x94&chsc=1&ei=vP4lWO2qM8rrmQHt74Ag"
    @IBOutlet weak var graph: UIImageView!
    @IBOutlet weak var geneh: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        refresh()
    }
    
    func load_image(urlString:String)
    {
        
        let imgURL: NSURL = NSURL(string: urlString)!
        let request: NSURLRequest = NSURLRequest(url: imgURL as URL)
        NSURLConnection.sendAsynchronousRequest(
            request as URLRequest, queue: OperationQueue.main,
            completionHandler: {(response: URLResponse?, data: Data?, error: Error?) -> Void in
                if error == nil {
                    self.graph.image = UIImage(data: data!)
                }
        })
        
    }
    
    @IBAction func refresh(_ sender: UIButton) {
        refresh()
    }
    
    func refresh() {
        showSpinner()
        Alamofire.request(url)
            .responseJSON { response in
                print(response.response)
                print(response.result.error)

                print(response.data)

                if let JSON = response.result.value {
                    self.geneh.text = "\(JSON) EGP"
                    self.load_image(urlString: self.graphUrl)
                }
                self.hideSpinner()
        }

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func showSpinner() {
        let loadingNotification = MBProgressHUD.showAdded(to: self.view, animated: true)
        loadingNotification.mode = MBProgressHUDMode.indeterminate
        loadingNotification.label.text = "Loading"
    }
    
    func hideSpinner() {
        MBProgressHUD.hide(for: self.view, animated: true)
    }

}

