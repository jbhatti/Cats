//
//  FlickrAPI.h
//  CatsTemplateDemo
//
//  Created by James Cash on 25-09-17.
//  Copyright © 2017 Occasionally Cogent. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FlickrPhoto.h"

@interface FlickrAPI : NSObject

// + (NSArray*)searchFor:(NSString*)query;
+ (void)searchForCats:(void (^)(NSArray<FlickrPhoto *> *))complete;

// + (UIImage*)loadImageForPhoto:(FlickrPhoto*)photo;
+ (void)loadImageForPhoto:(FlickrPhoto*)photo
                 complete:(void(^)(UIImage* result))complete;

@end
