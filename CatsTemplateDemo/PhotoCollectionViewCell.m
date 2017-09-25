//
//  PhotoCollectionViewCell.m
//  CatsTemplateDemo
//
//  Created by Jaison Bhatti on 2017-09-25.
//  Copyright © 2017 Occasionally Cogent. All rights reserved.
//

#import "PhotoCollectionViewCell.h"
#import "FlickrPhoto.h"
#import "FlickrAPI.h"

@interface PhotoCollectionViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *labelView;

@end

@implementation PhotoCollectionViewCell

-(void)setFlickrPhoto:(FlickrPhoto *)flickrPhoto {
    _flickrPhoto = flickrPhoto;
    
        if (flickrPhoto.image) {
            self.imageView.image = flickrPhoto.image;
            self.labelView.text = flickrPhoto.title;
        } else {
            [FlickrAPI
             loadImageForPhoto:flickrPhoto
             complete:^(UIImage *result) {
                 flickrPhoto.image = result;
                 self.labelView.text = flickrPhoto.title;
                 [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                     self.imageView.image = result;
                     self.labelView.text = flickrPhoto.title;
                 }];
             }];
        }
}


@end
