//
//  FlickrPhoto.h
//  CatsTemplateDemo
//
//  Created by James Cash on 25-09-17.
//  Copyright © 2017 Occasionally Cogent. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FlickrPhoto : NSObject

@property (nonatomic,strong) NSString* flickrId;
@property (nonatomic,strong) NSString* owner;
@property (nonatomic,strong) NSString* secret;
@property (nonatomic,strong) NSString* server;
@property (nonatomic,assign) NSInteger farm;
@property (nonatomic,strong) NSString* title;
@property (nonatomic,strong) UIImage* image;

- (instancetype)initWithInfo:(NSDictionary<NSString*,id>*)info;

- (NSURL*)url;

@end
