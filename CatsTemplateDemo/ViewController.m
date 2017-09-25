//
//  ViewController.m
//  CatsTemplateDemo
//
//  Created by James Cash on 25-09-17.
//  Copyright © 2017 Occasionally Cogent. All rights reserved.
//

#import "ViewController.h"
#import "FlickrAPI.h"

@interface ViewController ()
@property (nonatomic,strong) NSArray *catPhotos;
@property (nonatomic,weak) IBOutlet UIImageView *imageView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // what we want to do is this
    //    self.catPhotos = [FlickrAPI searchFor:@"cats"];
    // but the search process happens in the background asynchronously so we can't
    // so one way of dealing with this is moving the return type to a block parameter
    // so we pass in a block that gets the "return value" and does what we would like
    // to do with the return value
    // (another/older way would be to make this class the delegate of the api object
    // and have a delegate method that would get the results (but that would mean
    // we couldn't just use a class method, would actually need to alloc&init a FlickrAPI object
    [FlickrAPI searchFor:@"cats" complete:^(NSArray<FlickrPhoto *> *results) {
        self.catPhotos = results;
        NSLog(@"Loaded photo results");
            }];
    NSLog(@"View did load finished");

    // this would go somewhere else, for after photos have loaded
    FlickrPhoto *catPhoto = self.catPhotos.firstObject;
    if (catPhoto.image) {
        self.imageView.image = catPhoto.image;
    } else {
        [FlickrAPI
         loadImageForPhoto:catPhoto
         complete:^(UIImage *result) {
             catPhoto.image = result;
             [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                 self.imageView.image = result;
             }];
         }];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
