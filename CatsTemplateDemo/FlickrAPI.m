//
//  FlickrAPI.m
//  CatsTemplateDemo
//
//  Created by James Cash on 25-09-17.
//  Copyright © 2017 Occasionally Cogent. All rights reserved.
//

#import "FlickrAPI.h"
#import "Constants.h"
//#import "Secrets.h" // Create this file if you've cloned this repo

@implementation FlickrAPI

+ (void)searchForCats:(void (^)(NSArray<FlickrPhoto *> *))complete
{
    NSURL* queryURL =
    [NSURL URLWithString:
     [NSString stringWithFormat:@"https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=d37eb7252acea4a6c09a0614c1607748&tags=Cats&has_geo=&extras=url_m&format=json&nojsoncallback=1"]];

    NSURLSessionTask *task =
    [[NSURLSession sharedSession]
     dataTaskWithURL:queryURL
     completionHandler:^(NSData* data, NSURLResponse * response, NSError* error) {
         // this is where we get the results
         if (error != nil) {
             NSLog(@"error in url session: %@", error.localizedDescription);
             abort(); // TODO: display an alert or something
         }
         // TODO: check the response code we got; if it's >= 300 something is wrong
         // remember to check status code, we need to cast response to a NSHTTPURLResponse
         if (((NSHTTPURLResponse*)response).statusCode >= 300) {
             NSLog(@"Unexpected http response: %@", response);
             abort(); // TODO: display an alert or something
         }

         NSError *err = nil;
         NSDictionary* result = [NSJSONSerialization JSONObjectWithData:data options:0 error:&err];
         if (err) {
             NSLog(@"Something went wrong parsing JSON: %@", err.localizedDescription);
             abort();
         }

         NSMutableArray<FlickrPhoto*> *catPhotos = [@[] mutableCopy];
         for (NSDictionary *photoInfo in result[@"photos"][@"photo"]) {
             [catPhotos addObject:[[FlickrPhoto alloc] initWithInfo:photoInfo]];
         }
         complete(catPhotos);
         NSLog(@"%@", catPhotos);
     }];

    [task resume];
}


+ (void)loadImageForPhoto:(FlickrPhoto *)photo complete:(void (^)(UIImage *))complete
{
    NSURLSessionTask *task =
    [[NSURLSession sharedSession]
     dataTaskWithURL:photo.url
     completionHandler:^(NSData * data, NSURLResponse *  response, NSError *  error) {
         // this is where we get the results
         if (error) {
             NSLog(@"error in url session: %@", error.localizedDescription);
             abort(); // TODO: display an alert or something
         }
         // TODO: check the response code we got; if it's >= 300 something is wrong
         // remember to check status code, we need to cast response to a NSHTTPURLResponse
         if (((NSHTTPURLResponse*)response).statusCode >= 300) {
             NSLog(@"Unexpected http response: %@", response);
             abort(); // TODO: display an alert or something
         }

         UIImage *image = [UIImage imageWithData:data];
         complete(image);
     }];
    [task resume];
}







- (NSURL *)createURLWithTag:(NSString *)value
{
    NSURLComponents *components = [NSURLComponents componentsWithString:kBaseURL];
    components.query = kQueryItems;
    
    
    NSMutableArray <NSURLQueryItem *>*queryItems = [components.queryItems mutableCopy];
    NSURLQueryItem *tag = [NSURLQueryItem queryItemWithName:@"tag" value:value];
    [queryItems addObject:tag];
    components.queryItems = [queryItems copy];
    
    return components.URL;
}










@end
