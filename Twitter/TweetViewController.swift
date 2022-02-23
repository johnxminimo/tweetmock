//
//  TweetViewController.swift
//  Twitter
//
//  Created by John Minimo on 2/22/22.
//  Copyright © 2022 Dan. All rights reserved.
//

import UIKit

class TweetViewController: UIViewController {

    @IBOutlet weak var tweetTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tweetTextView.becomeFirstResponder()
        // Do any additional setup after loading the view.
    }
    
    

    @IBAction func cancelTweet(_ sender: Any) {
        
        dismiss(animated: true) // dismisses view if cancel button is pressed
    }
    @IBAction func sendTweet(_ sender: Any) {
        
        if (!tweetTextView.text.isEmpty){
            
            TwitterAPICaller.client?.postTweet(tweetString: tweetTextView.text, success: {
                self.dismiss(animated: true)
            }, failure: { Error in
                print("error posting tweet")
                self.dismiss(animated: true, completion: nil)
            })
            
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
