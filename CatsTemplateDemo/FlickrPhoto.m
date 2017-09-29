//
//  FlickrPhoto.m
//  CatsTemplateDemo
//
//  Created by James Cash on 25-09-17.
//  Copyright © 2017 Occasionally Cogent. All rights reserved.
//

#import "FlickrPhoto.h"



@interface FlickrPhoto ()<MKAnnotation>

@end

@implementation FlickrPhoto

- (instancetype)initWithInfo:(NSDictionary<NSString *,id> *)info
{
    self = [super init];
    if (self) {
        _flickrId = info[@"id"];
        //_owner = info[@"owner"];
        //_secret = info[@"secret"];
        //_server = info[@"server"];
        _title = info[@"title"];
        //_farm = [info[@"farm"] integerValue];
        _imageUrl = info[@"url_m"];
        _coordinate = CLLocationCoordinate2DMake([info[@"latitude"] doubleValue], [info[@"longitude"] doubleValue]);
        
    }
    return self;
}

- (NSURL *)url
{
    //return self.imageUrl;
    return [NSURL URLWithString:
            [NSString stringWithFormat:@"%@", self.imageUrl]];
    
}

- (void)fetchImageCoordinates {
    
}

@end
