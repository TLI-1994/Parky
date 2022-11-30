//
//  DetailViewController.swift
//  Parky
//
//  Created by Haoyuan Shi on 11/22/22.
//

import UIKit
import SnappingLayout

class DetailViewController: UIViewController {
    let snappingLayout = SnappingLayout()
    let parkLabel = UILabel()
    let picImageView = UIImageView()
    let blockLabel = UIView()
    let block = UIView()
    let backButton = UIButton()
    let stackViewName = UIStackView()
    
    let parkAddress = UILabel()
    let untilLabel = UILabel()
    let ParkOpenTime = UILabel()
    let parkFee = UILabel()
    let isOpenLabel = UILabel()
    
    let userComment = UILabel()
    let addPhoto = UILabel()
    let commentBlock = UIView()
    
    var commentTxt = UITextField()
    let submitButton = UIButton()
    
    let locationLabel = UILabel()
    
    var parkComment: [Comment] = []
    let spacing: CGFloat = 10
    var direction: Bool = true
    
    var collectionView: UICollectionView!
    let commentReuseIdentifier: String = "commentReuseIdentifier"
    
    let likeButton = UIButton()
    var isLiked: Bool = false
    
    let park: Park
    weak var delegate: LikeDelegate?
    
    init(park: Park, delegate: LikeDelegate, isLiked: Bool) {
        self.park = park
        self.delegate = delegate
        self.isLiked = isLiked
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        // latest comment
        parkComment = park.comments
        
        picImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(picImageView)
        
        block.layer.backgroundColor = UIColor.white.cgColor
        block.layer.cornerRadius = 20
        block.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(block)
        
        blockLabel.layer.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.45).cgColor
        blockLabel.layer.cornerRadius = 20
        blockLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(blockLabel)
        
        let futuraFont = UIFont(name: "Futura", size: 16)!
        let futuraBoldFont = UIFont(name: "Futura-bold", size: 20)!
        
        parkLabel.text = park.name
        parkLabel.font = futuraBoldFont
        parkLabel.numberOfLines = 2
        parkLabel.textColor = .black
        parkLabel.textAlignment = .center
        parkLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(parkLabel)
        
        parkAddress.font = futuraFont
        parkAddress.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(parkAddress)
        
        untilLabel.font = futuraFont
        untilLabel.textColor = .darkGray
        untilLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(untilLabel)
        
        ParkOpenTime.font = futuraFont
        ParkOpenTime.textColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
        ParkOpenTime.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(ParkOpenTime)
        
        isOpenLabel.font = futuraBoldFont.withSize(16)
        isOpenLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(isOpenLabel)
        
        parkFee.font = futuraFont.withSize(12)
        parkFee.numberOfLines = 2
        parkFee.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(parkFee)
        
        userComment.font = futuraFont.withSize(20)
        userComment.text = "Comment"
        userComment.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(userComment)
        
        commentBlock.layer.backgroundColor = UIColor(red: 0.925, green: 0.925, blue: 0.925, alpha: 1).cgColor
        commentBlock.layer.cornerRadius = 15
        commentBlock.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(commentBlock)
        
        addPhoto.font = futuraBoldFont.withSize(14)
        addPhoto.text = "Add Photo"
        addPhoto.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(addPhoto)
        
        commentTxt.placeholder = "Start a new review"
        commentTxt.font = futuraFont.withSize(15)
        commentTxt.textAlignment = .left
        commentTxt.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(commentTxt)
        
        locationLabel.font = futuraFont.withSize(20)
        locationLabel.text = "Location"
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(locationLabel)
        
        submitButton.setImage(UIImage(named: "pencil"), for: .normal)
        submitButton.addTarget(self, action: #selector(submitComment), for: .touchUpInside)
        submitButton.setTitleColor(.black, for: .normal)
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(submitButton)
        
        backButton.setImage(UIImage(systemName: "arrow.backward"), for: .normal)
        backButton.tintColor = .white
        backButton.addTarget(self, action: #selector(backToMain), for: .touchUpInside)
        backButton.setTitleColor(.black, for: .normal)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(backButton)
        
        //let parkCommentLayout = UICollectionViewFlowLayout()
        snappingLayout.snapPosition = .center
        snappingLayout.minimumLineSpacing = spacing
        snappingLayout.minimumInteritemSpacing = spacing
        snappingLayout.scrollDirection = .horizontal
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: snappingLayout)
        collectionView.decelerationRate = .fast
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(CommentsCollectionViewCell.self, forCellWithReuseIdentifier: commentReuseIdentifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsHorizontalScrollIndicator = false
        //collectionView.layer.backgroundColor = UIColor.lightGray.cgColor
        view.addSubview(collectionView)
        
        stackViewName.translatesAutoresizingMaskIntoConstraints = false
        stackViewName.alignment = .center
        stackViewName.distribution = .equalSpacing
        stackViewName.axis = .vertical
        
        stackViewName.addArrangedSubview(parkLabel)
        stackViewName.addArrangedSubview(parkAddress)
        stackViewName.addArrangedSubview(ParkOpenTime)
        view.addSubview(stackViewName)
        
        likeButton.setImage(UIImage(systemName: "suit.heart"), for: .normal)
        likeButton.tintColor = .systemRed
        likeButton.addTarget(self, action: #selector(toggleLikeButton), for: .touchUpInside)
        likeButton.setTitleColor(.black, for: .normal)
        likeButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(likeButton)
        
        configure(parkObject: park)
        setupConstraints()
        startTimer()
        
    }
    
    func configure(parkObject: Park) {
        picImageView.image = UIImage(named: String(parkObject.id))
        parkLabel.text = parkObject.name
        parkAddress.text = parkObject.address
        parkFee.text = "\(parkObject.hourlyRate)   \(parkObject.dailyRate)"
        
        let tpr = OpenHourProcessor(openTime: parkObject.openHours).process()
        
        if tpr.start == "12:00 AM" && tpr.end == "11:59 PM" {
            isOpenLabel.text = "Open"
            isOpenLabel.textColor = UIColor(red: 0, green: 0.6, blue: 0.36, alpha: 1)
            untilLabel.text = "all day"
            ParkOpenTime.text = "Available time: all day"
        } else {
            if tpr.isOpen {
                untilLabel.text = "until \(tpr.end)"
                isOpenLabel.text = "Open"
                isOpenLabel.textColor = UIColor(red: 0, green: 0.6, blue: 0.36, alpha: 1)
            } else  {
                untilLabel.text = "until \(tpr.start)"
                isOpenLabel.text = "Close"
                isOpenLabel.textColor = .red
            }
            ParkOpenTime.text = "Available time: \(tpr.start) - \(tpr.end)"
        }
        
        if isLiked {
            likeButton.setImage(UIImage(systemName: makeLikeImageName()), for: .normal)
        }
        
    }
    
    func setupConstraints() {
        
        block.snp.makeConstraints { make in
            make.width.leading.bottom.equalTo(view)
            make.height.equalTo(view).multipliedBy(0.75)
        }
        
        picImageView.snp.makeConstraints { make in
            make.centerX.width.equalTo(view)
            make.height.equalTo(view.snp.width)
            make.bottom.equalTo(block.snp.top).offset(100)
        }
        
        blockLabel.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.bottom.equalTo(block.snp.top).offset(-40)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(50)
            make.width.equalTo(view).multipliedBy(0.85)
        }
        
        parkLabel.snp.makeConstraints { make in
            make.width.equalTo(view).multipliedBy(0.8)
        }
        
        stackViewName.snp.makeConstraints { make in
            make.centerY.equalTo(blockLabel)
            make.centerX.equalTo(view)
        }
        
        isOpenLabel.snp.makeConstraints { make in
            make.top.equalTo(block).offset(20)
            make.leading.equalTo(view).offset(20)
        }
        
        untilLabel.snp.makeConstraints { make in
            make.top.equalTo(block).offset(20)
            make.leading.equalTo(isOpenLabel.snp.trailing).offset(10)
        }
        
        parkFee.snp.makeConstraints { make in
            make.top.equalTo(untilLabel.snp.bottom).offset(10)
            make.leading.equalTo(view).offset(20)
        }
        
        userComment.snp.makeConstraints { make in
            make.top.equalTo(parkFee.snp.bottom).offset(24)
            make.leading.equalTo(view).offset(20)
        }
        
        commentBlock.snp.makeConstraints { make in
            make.width.equalTo(242)
            make.height.equalTo(36)
            make.leading.equalTo(view).offset(20)
            make.top.equalTo(userComment.snp.bottom).offset(12)
        }
        
        addPhoto.snp.makeConstraints { make in
            make.centerY.equalTo(commentBlock)
            make.leading.equalTo(commentBlock.snp.trailing).offset(20)
        }
        
        commentTxt.snp.makeConstraints { make in
            make.centerY.equalTo(commentBlock)
            make.leading.equalTo(commentBlock).offset(40)
            make.trailing.equalTo(commentBlock).offset(-60)
        }
        
        locationLabel.snp.makeConstraints { make in
            make.top.equalTo(collectionView.snp.bottom).offset(24)
            make.leading.equalTo(view).offset(20)
        }
        
        submitButton.snp.makeConstraints { make in
            make.width.height.equalTo(20)
            make.centerY.equalTo(commentBlock)
            make.leading.equalTo(commentBlock.snp.trailing).offset(-30)
        }
        
        backButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.leading.equalTo(view).offset(20)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(commentBlock.snp.bottom).offset(20)
            make.leading.equalTo(view).offset(20)
            make.height.equalTo(133)
            make.trailing.equalTo(view).offset(-20)
        }
        
        likeButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.trailing.equalTo(view).offset(-20)
        }
    }
    
    @objc func submitComment() {
        print("submit")
        
        if let unwrapcomment = commentTxt.text {
            NetworkManager.addComment(park_id: park.id, comment: unwrapcomment) { comment in
                self.parkComment = [comment] + self.parkComment
                self.collectionView.reloadData()
                self.collectionView?.scrollToItem(at: NSIndexPath(item: 0, section: 0) as IndexPath, at: .left, animated: true)
            }
        }
    }
    
    @objc func backToMain() {
        dismiss(animated: true)
        
    }
    
    @objc func toggleLikeButton() {
        isLiked.toggle()
        likeButton.setImage(UIImage(systemName: makeLikeImageName()), for: .normal)
        delegate?.toggleLikeButton()
        
    }
    
    func makeLikeImageName() -> String {
        if isLiked {
            return "suit.heart.fill"
        } else {
            return "suit.heart"
        }
    }
    
    
    // modified https://gist.github.com/wassim93/4611f509618986b831a40eb38064451a
    func startTimer() {
        
        _ =  Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(self.scrollAutomatically), userInfo: nil, repeats: true)
        
    }
    
    
    @objc func scrollAutomatically(_ timer1: Timer) {
        
        if let coll  = collectionView {
            for cell in coll.visibleCells {
                let indexPath: IndexPath? = coll.indexPath(for: cell)
                if ((indexPath?.row)! == parkComment.count - 1) {
                    direction = false
                }
                if (direction == true){
                    let indexPath1: IndexPath?
                    indexPath1 = IndexPath.init(row: (indexPath?.row)! + 1, section: (indexPath?.section)!)
                    
                    coll.scrollToItem(at: indexPath1!, at: .right, animated: true)
                    
                    if ((indexPath?.row)! == parkComment.count - 2) {
                        direction.toggle()
                    }
                }
                else{
                    let indexPath1: IndexPath?
                    indexPath1 = IndexPath.init(row: (indexPath?.row)! - 1, section: (indexPath?.section)!)
                    coll.scrollToItem(at: indexPath1!, at: .left, animated: true)
                    
                    if ((indexPath?.row)! == 0) {
                        direction.toggle()
                    }
                }
                
            }
        }
    }
    
    @objc func imageTapped(sender: UITapGestureRecognizer) {
        let imageView = sender.view as! UIImageView
        if imageView.image != UIImage(systemName: "car.fill") {
            let newImageView = UIImageView(image: imageView.image)
            newImageView.frame = UIScreen.main.bounds
            //newImageView.backgroundColor = .white
            newImageView.contentMode = .scaleAspectFit
            newImageView.isUserInteractionEnabled = true
            let tap = UITapGestureRecognizer(target: self, action: #selector(dismissFullscreenImage(sender:)))
            newImageView.addGestureRecognizer(tap)
            self.view.addSubview(newImageView)
            self.navigationController?.isNavigationBarHidden = true
            self.tabBarController?.tabBar.isHidden = true
        }
    }
    
    @objc func dismissFullscreenImage(sender: UITapGestureRecognizer) {
        self.navigationController?.isNavigationBarHidden = false
        self.tabBarController?.tabBar.isHidden = false
        sender.view?.removeFromSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension DetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return parkComment.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: commentReuseIdentifier, for: indexPath) as? CommentsCollectionViewCell {
            cell.configure(comment: parkComment[indexPath.row])
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(sender:)))
            cell.commentFig.isUserInteractionEnabled = true
            cell.commentFig.addGestureRecognizer(tapGestureRecognizer)
            return cell
        }
        else{
            return UICollectionViewCell()
        }
    }
}

extension DetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 350, height: 133)
    }
}

protocol LikeDelegate: UITableViewCell {
    func toggleLikeButton()
}

