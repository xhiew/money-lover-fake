//
//  ImageViewCell.swift
//  MoneyLover
//
//  Created by xhieu21 on 14/03/2023.
//

import UIKit

class ImageViewCell: UICollectionViewCell {

  @IBOutlet weak var backgroundImage: UIImageView!
  @IBOutlet weak var mainImage: UIImageView!
  @IBOutlet weak var mainLabel: UILabel!

  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }

  func setupUI(background: UIImage? = Resource.Image.OnBoarding.waveBackgroundImg,
               image: UIImage? = Resource.Image.OnBoarding.paymentSuccessImg,
               title: String?) {
    backgroundImage.image = background
    mainImage.image = image
    mainLabel.text = title
  }

}
