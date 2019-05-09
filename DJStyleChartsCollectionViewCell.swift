//
//  DJStyleChartsCollectionViewCell.swift
//  DejaFashion
//
//  Created by levi duan on 2019/4/17.
//  Copyright © 2019 Mozat. All rights reserved.
//

import UIKit

class DJStyleChartsCollectionViewCell: UICollectionViewCell {
    
    private lazy var backgoundImageView: UIImageView = {
        let backgoundImageView = UIImageView(frame: .zero)
        backgoundImageView.translatesAutoresizingMaskIntoConstraints = false
        backgoundImageView.backgroundColor = UIColor(fromHexString: "cccccc")
        backgoundImageView.contentMode = .scaleAspectFill
        backgoundImageView.clipsToBounds = true
        return backgoundImageView
    }()
    
    var isFirstCell : Bool = false {
        didSet {
            self.buildViewLayout()
        }
    }
    
    private lazy var rankView: UIView = {
        let rankView = UIView(frame: .zero)
        rankView.backgroundColor = UIColor(fromHexString: "FFDB4A")
        return rankView
    }()
    
    private lazy var likeView: UIView = {
        let likeView = UIView(frame: .zero)
        likeView.backgroundColor = UIColor(fromHexString: "4A4A4A", alpha: 0.7)
        return likeView
    }()
    
    private lazy var rankLabel: UILabel = {
        let rankLabel = UILabel(frame: .zero)
        rankLabel.textAlignment = .center
        rankLabel.lineBreakMode = .byWordWrapping
        rankLabel.numberOfLines = 0
        rankLabel.font = DJFont.mediumHelveticaFont(ofSize: 16)
        rankLabel.text = "1"
        rankLabel.sizeToFit()
        rankLabel.textColor = UIColor(fromHexString: "000000")
        return rankLabel
    }()
    
    private lazy var likeCountLabel: UILabel = {
        let likeCountLabel = UILabel(frame: .zero)
        likeCountLabel.textAlignment = .center
        likeCountLabel.lineBreakMode = .byWordWrapping
        likeCountLabel.numberOfLines = 0
        likeCountLabel.font = DJFont.mediumHelveticaFont(ofSize: 16)
        likeCountLabel.textColor = UIColor(fromHexString: "FFFFFF")
        return likeCountLabel
    }()
    
    private lazy var likeImageView: UIImageView = {
        let likeImageView = UIImageView(frame: .zero)
        likeImageView.translatesAutoresizingMaskIntoConstraints = false
        likeImageView.image = UIImage(named: "newlike")
        likeImageView.contentMode = .scaleAspectFit
        likeImageView.clipsToBounds = true
        return likeImageView
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.clipsToBounds = true
    }
    
    func cellSetDataWithModel(fashionchallengeModel : DJStyleChartsStreetSnaps?, index: NSInteger) {
        likeCountLabel.text = fashionchallengeModel?.likeCount ?? " "
        rankLabel.text = String(index+1)
        backgoundImageView.sd_setImageWithURLStr(fashionchallengeModel?.image?.imageUrl)
        buildViewLayout()
    }
    
    func buildViewLayout() {
        self.removeAllSubViews()
        addSubview(backgoundImageView)
        addSubview(rankView)
        addSubview(rankLabel)
        addSubview(likeView)
        addSubview(likeCountLabel)
        addSubview(likeImageView)
        
        rankView.removeConstraints(rankView.constraints)
        likeView.removeConstraints(likeView.constraints)
        likeImageView.removeConstraints(likeImageView.constraints)
        
        backgoundImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            backgoundImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            backgoundImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            backgoundImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            backgoundImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),
        ])
        
        if (isFirstCell == true) {
            rankLabel.font = DJFont.mediumHelveticaFont(ofSize: 16)
            likeCountLabel.font = DJFont.mediumHelveticaFont(ofSize: 16)
            rankView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                rankView.leadingAnchor.constraint(equalTo: backgoundImageView.leadingAnchor, constant: 0),
                rankView.topAnchor.constraint(equalTo: backgoundImageView.topAnchor, constant: 0),
                rankView.heightAnchor.constraint(equalToConstant: 28.0),
                rankView.widthAnchor.constraint(equalToConstant: 28.0),
            ])
            
            likeImageView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                likeImageView.leadingAnchor.constraint(equalTo: likeView.leadingAnchor, constant: 8),
                likeImageView.centerYAnchor.constraint(equalTo: likeView.centerYAnchor, constant: 0),
                likeImageView.heightAnchor.constraint(equalToConstant: 12.0),
                likeImageView.widthAnchor.constraint(equalToConstant: 12.0),
            ])
            
            rankLabel.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                rankLabel.centerXAnchor.constraint(equalTo: rankView.centerXAnchor, constant: 0),
                rankLabel.centerYAnchor.constraint(equalTo: rankView.centerYAnchor, constant: 0),
            ])
            
            likeView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                likeView.topAnchor.constraint(equalTo: rankView.topAnchor, constant: 0),
                likeView.leadingAnchor.constraint(equalTo: rankView.trailingAnchor, constant: 0),
                likeView.trailingAnchor.constraint(equalTo: likeCountLabel.trailingAnchor, constant: 8.0),
                likeView.heightAnchor.constraint(equalToConstant: 28.0),
            ])
            
            likeCountLabel.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                likeCountLabel.leadingAnchor.constraint(equalTo: likeImageView.trailingAnchor, constant: 4),
                likeCountLabel.centerYAnchor.constraint(equalTo: likeView.centerYAnchor, constant: 0),
            ])
            
        }
        else {
            rankLabel.font = DJFont.mediumHelveticaFont(ofSize: 14)
            likeCountLabel.font = DJFont.mediumHelveticaFont(ofSize: 14)
            rankView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                rankView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
                rankView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),
                rankView.heightAnchor.constraint(equalToConstant: 22.0),
                rankView.widthAnchor.constraint(equalToConstant: 22.0),
            ])
            
            rankLabel.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                rankLabel.centerXAnchor.constraint(equalTo: rankView.centerXAnchor, constant: 0),
                rankLabel.centerYAnchor.constraint(equalTo: rankView.centerYAnchor, constant: 0),
            ])
            
            likeView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                likeView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),
                likeView.leadingAnchor.constraint(equalTo: rankView.trailingAnchor, constant: 0),
                likeView.heightAnchor.constraint(equalToConstant: 22.0),
                likeView.trailingAnchor.constraint(equalTo: likeCountLabel.trailingAnchor, constant: 5.0),
            ])
            
            likeImageView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                likeImageView.leadingAnchor.constraint(equalTo: likeView.leadingAnchor, constant: 5),
                likeImageView.centerYAnchor.constraint(equalTo: likeView.centerYAnchor, constant: 0),
                likeImageView.heightAnchor.constraint(equalToConstant: 10.0),
                likeImageView.widthAnchor.constraint(equalToConstant: 10.0),
                ])
            
            likeCountLabel.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                likeCountLabel.leadingAnchor.constraint(equalTo: likeImageView.trailingAnchor, constant: 4),
                likeCountLabel.centerYAnchor.constraint(equalTo: likeView.centerYAnchor, constant: 0),
            ])
        }
    }
    
}
