//
//  IntroductionViewController.swift
//  MoneyLover
//
//  Created by xhieu21 on 13/03/2023.
//

import UIKit

class IntroductionViewController: UIViewController {

//MARK: - Properties
  @IBOutlet weak var slideView: UICollectionView!
  @IBOutlet weak var pageControl: UIPageControl!
  @IBOutlet weak var startButton: UIButton!
  @IBOutlet weak var versionLabel: UILabel!

  let categoryData = CategoryManager().dataSource
  let bannerManager = BannerManager()
  var pageIndex = 0
  var timer: Timer?

  //MARK: - Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    configUI()
    configSlideView()
    registerCell()
    timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(nextPage), userInfo: nil, repeats: true)
  }

  //MARK: - Methods

  @objc func nextPage() {
    if slideView.contentOffset.x < slideView.contentSize.width - slideView.frame.width {
			var currentContentOffsetX = slideView.contentOffset.x
			currentContentOffsetX += slideView.frame.width
			// thay vì slideView.contentOffset.x += slideView.frame.width thì setContentOffset để animation scroll
			slideView.setContentOffset(CGPoint(x: currentContentOffsetX, y: 0), animated: true)
      updatePageIndex(index: Int(currentContentOffsetX / slideView.frame.width))
    } else {
      slideView.contentOffset.x = 0
      updatePageIndex(index: 0)
    }
  }

  func configUI() {
    versionLabel.text = Resource.Title.appVersion
    startButton.roundCorners()
  }

  func registerCell() {
    slideView.register(LabelViewCell.nib(), forCellWithReuseIdentifier: LabelViewCell.identifier)
    slideView.register(ImageViewCell.nib(), forCellWithReuseIdentifier: ImageViewCell.identifier)
  }

  func configSlideView() {
    slideView.delegate = self
    slideView.dataSource = self
  }

  func updatePageIndex(index: Int) {
    pageControl.currentPage = index
  }

  @IBAction func startButtonAction(_ sender: UIButton) {
		UserDefaults.standard.isNotFirstLaunch = true
    timer?.invalidate()
    if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
      appDelegate.window?.rootViewController = TabViewController()
    }
  }

}

//MARK: - Conform UICollectionViewDataSource
extension IntroductionViewController: UICollectionViewDataSource {

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return bannerManager.itemInSection.count
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    switch bannerManager.itemInSection[indexPath.row] {
    case .category:
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LabelViewCell.identifier, for: indexPath) as? LabelViewCell
      guard let cell = cell else { return UICollectionViewCell() }
      cell.addCategory(categories: categoryData)
      return cell
    case .bannerPage:
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageViewCell.identifier, for: indexPath) as? ImageViewCell
      guard let cell = cell else { return UICollectionViewCell() }
      cell.setupUI(background: bannerManager.bannerData[indexPath.row - 1].backgroundImg, image: bannerManager.bannerData[indexPath.row - 1].mainImg, title: bannerManager.bannerData[indexPath.row - 1].title)
      return cell
    }

  }

}

//MARK: - Conform UICollectionViewDelegateFlowLayout
extension IntroductionViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let deviceWidth = UIScreen.main.bounds.width
    return CGSize(width: deviceWidth, height: (4*deviceWidth)/3)
///    hoặc có thể lấy chính width, height của collectionView.
///    collectionView.frame.width
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 0.0
  }

  func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    pageIndex = Int(scrollView.contentOffset.x / scrollView.frame.width)
    updatePageIndex(index: pageIndex)
  }

  func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
    /// nếu user trượt slide thì dừng tự động trượt
    timer?.invalidate()
    /// quay lại page 1
    if scrollView.contentSize.width < scrollView.frame.width + scrollView.contentOffset.x {
        scrollView.contentOffset.x = 0
    }
  }
}
