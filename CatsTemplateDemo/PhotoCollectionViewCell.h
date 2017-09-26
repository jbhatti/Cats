//
//  PhotoCollectionViewCell.h
//  CatsTemplateDemo
//
//  Created by Jaison Bhatti on 2017-09-25.
//  Copyright © 2017 Occasionally Cogent. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FlickrPhoto;

@interface PhotoCollectionViewCell : UICollectionViewCell

@property (nonatomic) FlickrPhoto* flickrPhoto;

//-(void)setFlickrPhoto:(FlickrPhoto *)flickrPhoto;

@end
