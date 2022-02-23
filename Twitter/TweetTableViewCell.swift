//
//  TweetTableViewCell.swift
//  Twitter
//
//  Created by John Minimo on 2/15/22.
//  Copyright © 2022 Dan. All rights reserved.
//

import UIKit

class TweetTableViewCell: UITableViewCell {

    @IBOutlet weak var favUIButton: UIButton!
    @IBOutlet weak var retweetUIButton: UIButton!
    @IBOutlet weak var tweetContentLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var screenNameUILabel: UILabel!
    @IBOutlet weak var userNameUILabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func favoritedTweet(_ sender: Any) {
    
    }
    
    @IBAction func retweetTweet(_ sender: Any) {
    
    }

    
    func setFavorite(_ isFavorited:Bool){
        if (isFavorited){
            favUIButton.setImage(#imageLiteral(resourceName:"favor-icon-red"), for: UIControl.State.normal)
        }
        else {
            favUIButton.setBackgroundImage(UIImage(named:"favor-icon"), for: UIControl.State.normal)
        }
    }
    
}
