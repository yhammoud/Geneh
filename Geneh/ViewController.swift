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

    let url = "http://10.229.123.237:3000/api/exchange_rate"
    let graphUrl = "https://www.google.com/finance/chart?q=CURRENCY:USDEGP&tkr=1&p=5Y&chst=vkc&chs=269x94&chsc=1&ei=vP4lWO2qM8rrmQHt74Ag"
    @IBOutlet weak var graph: UIImageView!
    @IBOutlet weak var geneh: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        Alamofire.request(url)
            .responseJSON { response in
                print(response.request as Any)  // original URL request
                print(response.response as Any) // HTTP URL response
                print(response.data as Any)     // server data
                print(response.result)
                if let JSON = response.result.value {
                    self.geneh.text = "\(JSON) EGP"
                    self.load_image(urlString: self.graphUrl)
                    print("JSON: \(JSON)")
                    
                }
                
        }
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
        Alamofire.request(url)
            .responseJSON { response in
                print(response.request as Any)  // original URL request
                print(response.response as Any) // HTTP URL response
                print(response.data as Any)     // server data
                print(response.result)
                if let JSON = response.result.value {
                    self.geneh.text = "\(JSON) EGP"
                    print("JSON: \(JSON)")
                }
                
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

