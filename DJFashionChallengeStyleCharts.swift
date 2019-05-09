//
//  DJFashionChallengeStyleCharts.swift
//  DejaFashion
//
//  Created by levi duan on 2019/4/17.
//  Copyright © 2019 Mozat. All rights reserved.
//

import UIKit

class DJFashionChallengeStyleCharts: UIView {
    
    private var bgColor : UIColor = UIColor.clear
    
    private var chartsBarScrollView = DJStyleChartsBarScrollView(frame: .zero)
    
    private var styleChartsTask = DJFashionStyleChartsNetTask()
    
    var regionDataArray = [DJRegionsModel]()
    
    private var styleChartsDataArray = [DJStyleChartsStreetSnaps]()
    
    private var appcallRegionId: Int = 0
    
    private var failedCount : Int = 0
    
    private var currentRegionId : Int = 7
    
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel(frame: .zero)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textAlignment = .center
        titleLabel.lineBreakMode = .byWordWrapping
        titleLabel.numberOfLines = 1
        titleLabel.font = DJFont.mediumHelveticaFont(ofSize: 18)
        titleLabel.text = "Style Charts"
        titleLabel.sizeToFit()
        titleLabel.textColor = UIColor(fromHexString: "262729")
        return titleLabel
    }()
    
    private lazy var flowLayout: UICollectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumInteritemSpacing = 10.0
        flowLayout.minimumLineSpacing = 10.0
        flowLayout.scrollDirection = .horizontal
        return flowLayout
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = UIColor.clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.scrollsToTop = false
        collectionView.isPagingEnabled = false
        collectionView.clipsToBounds = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(DJStyleChartsCollectionViewCell.self, forCellWithReuseIdentifier: "DJStyleChartsCollectionViewCell")
        collectionView.alwaysBounceVertical = false
        collectionView.bounces = false
        return collectionView
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame : CGRect) {
        super.init(frame: frame)
        backgroundColor = bgColor
        chartsBarScrollView.buildView()
        chartsBarScrollView.barDelegate = self
        self.addSubview(titleLabel)
        self.addSubview(chartsBarScrollView)
        self.addSubview(collectionView)
        sendstyleChartsNetTask(regionId: 0)
        buildViewLayout()
    }
    
    func buildViewLayout() {
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 23),
            ])
        
        chartsBarScrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            chartsBarScrollView.topAnchor.constraint(equalTo: self.topAnchor, constant: 34.0),
            chartsBarScrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            chartsBarScrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            chartsBarScrollView.heightAnchor.constraint(equalToConstant: 32.0),
            ])
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: chartsBarScrollView.bottomAnchor, constant: 10.0),
            collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            collectionView.heightAnchor.constraint(equalToConstant: 266.0),
            ])
    }
    
    func sendAppcallRegionId(regionId: Int) {
        var i: Int = 0
        if (regionDataArray.count > 0) {
            while(i<regionDataArray.count) {
                let model : DJRegionsModel =  regionDataArray[i]
                if (model.regionsId == regionId) {
                    chartsBarScrollView.setCurrentButtonIndex(currentIndex: i)
                    sendstyleChartsNetTask(regionId: regionId)
                    break
                }
                i = i+1
            }
        }
        else {
            self.appcallRegionId = regionId
        }
    }
}

extension DJFashionChallengeStyleCharts: MONetTaskDelegate {
 
    func sendstyleChartsNetTask(regionId: Int) {
        if (regionId == 0) {
            // 
        }
        else {
            styleChartsTask.regionId = regionId
            self.currentRegionId = regionId
        }
        MONetTaskQueue.instance().add(self, uri: styleChartsTask.uri())
        MONetTaskQueue.instance().add(styleChartsTask)
    }
    
    func netTaskDidEnd(_ task: MONetTask!) {
        if task is DJFashionStyleChartsNetTask {
            if let task = task as? DJFashionStyleChartsNetTask {
                if let fashionRegionsList = task.result?.fashionRegionsList {
                    if (regionDataArray.count == 0) {
                        regionDataArray = fashionRegionsList
                        chartsBarScrollView.titleArray.removeAll()
                        for titleLabel in regionDataArray {
                            chartsBarScrollView.titleArray.append(titleLabel.name ?? "singapore")
                        }
                        chartsBarScrollView.buildView()
                        
                        if (self.appcallRegionId != 0) {
                            var i: Int = 0
                            while(i<regionDataArray.count) {
                                let model : DJRegionsModel =  regionDataArray[i]
                                if (model.regionsId == self.appcallRegionId) {
                                    chartsBarScrollView.setCurrentButtonIndex(currentIndex: i)
                                    sendstyleChartsNetTask(regionId: self.appcallRegionId)
                                    self.appcallRegionId = 0
                                    break
                                }
                                i = i+1
                            }
                        }
                        self.appcallRegionId = 0
                    }
                }
                if let fashionStyleChartsList = task.result?.fashionStyleChartsList {
                    styleChartsDataArray = fashionStyleChartsList
                }
                collectionView.reloadData()
            }
        }
    }
    
    func netTaskDidFail(_ task: MONetTask!) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(400)) {
            self.failedCount+=1
            if (self.failedCount < 4) {
                self.sendstyleChartsNetTask(regionId: 0)
            }
        }
    }
}

extension DJFashionChallengeStyleCharts: DJStyleChartsBarScrollViewDelegate {
    func scrollMenuView(scrollMenuView: DJStyleChartsBarScrollView, clickedButtonAtIndex index: NSInteger) {
        let model : DJRegionsModel =  regionDataArray[index]
        DJStatisticsLogic.instance().addParamFireBaseDILog(.D_StyleCharts_area, String(model.regionsId), model.name ?? "")
        sendstyleChartsNetTask(regionId: model.regionsId)
    }
}

extension DJFashionChallengeStyleCharts : UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let model : DJStyleChartsStreetSnaps = styleChartsDataArray[indexPath.row]
        DJStatisticsLogic.instance().addParamFireBaseDILog(.D_StyleCharts_area_streetsnap, String(self.currentRegionId), String(model.snapId))
        DJRNBridgeUtil.shareInstance.gotoLookBookStreetSnapRNVC(moudleName: RN_FAVOURITE_LOOKS, streetId: String(model.snapId))
    }
}

extension DJFashionChallengeStyleCharts : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return styleChartsDataArray.count;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DJStyleChartsCollectionViewCell", for: indexPath) as! DJStyleChartsCollectionViewCell
        let model : DJStyleChartsStreetSnaps = styleChartsDataArray[indexPath.row]
        cell.cellSetDataWithModel(fashionchallengeModel: model, index: indexPath.row)
        cell.isFirstCell = true
        return cell
    }
}

extension DJFashionChallengeStyleCharts : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: 266)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 0, left: 23, bottom: 0, right: 23)
    }
}

