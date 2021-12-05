//
//  MovieCell.swift
//  testMyTestTwo
//
//  Created by KhaleD HuSsien on 07/11/2021.
//

import UIKit
import SDWebImage

class MovieCell: UITableViewCell {
    //MARK: - outlets
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var mediaImageView: UIImageView!
    @IBOutlet weak var ArtistName: UILabel!
    @IBOutlet weak var TrackName: UILabel!
    @IBOutlet weak var imageMediaBtn: UIButton!
    @IBOutlet weak var countryMedia: UILabel!
    @IBOutlet weak var typeOfMedia: UILabel!
    @IBOutlet weak var releaseDate: UILabel!
    //MARK: - lifeCycle
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpImageLayout()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    //MARK: - functions
    
    private func setData(media: Media){
        let myString = media.releaseDate!
        let mySubstring = myString.prefix(4)
        let myReleaseData = String(mySubstring)
        self.releaseDate.text = myReleaseData
        self.mediaImageView.sd_setImage(with: URL(string: media.PosterUrl), completed: nil)
        self.countryMedia.text = media.country
        self.typeOfMedia.text = media.typeOfMedia
    }
    
    private func bouncingAnimation(){
        let imageFrameX = mediaImageView.frame.origin.x
        self.mediaImageView.frame.origin.x += 4
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, animations: {
            self.mediaImageView.frame.origin.x -= 10
            self.mediaImageView.frame.origin.x = imageFrameX
        }, completion: nil)
    }
    
    private func setUpImageLayout(){
        mediaImageView.layer.cornerRadius = (mediaImageView.frame.size.width  ) / 7
        mediaImageView.clipsToBounds = true
        mediaImageView.layer.borderWidth = 4
        mediaImageView.layer.borderColor  = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
        imageMediaBtn.titleLabel?.text = ""
    }
    
    func resultOfSegment(result: String , media: Media){
        if result == ResultSegment.music{
            self.ArtistName.text = media.artistName
            self.descriptionLabel.text = media.trackName
            setData(media: media)
        }else if result == ResultSegment.tvShow{
            self.ArtistName.text = media.artistName
            self.descriptionLabel.text = media.longDescription
            setData(media: media)
        }else if result == ResultSegment.movie{
            self.ArtistName.text = media.trackName
            self.descriptionLabel.text = media.longDescription
            setData(media: media)
        }else if result == ResultSegment.all{
            self.ArtistName.text = media.artistName
            self.ArtistName.text = media.trackName
            self.descriptionLabel.text = media.longDescription
            setData(media: media)
        }else{
            print("Error in resultOfSegment ")
        }
    }
    
    //MARK: - Actions (for animation)
    @IBAction func imageTapped(_ sender: UIButton) {
        bouncingAnimation()
    }
}
