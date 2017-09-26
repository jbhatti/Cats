    //
//  ViewController.m
//  CatsTemplateDemo
//
//  Created by James Cash on 25-09-17.
//  Copyright © 2017 Occasionally Cogent. All rights reserved.
//

#import "ViewController.h"
#import "FlickrAPI.h"
#import "PhotoCollectionViewCell.h"

@interface ViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (nonatomic,strong) NSArray *catPhotos;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

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
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [self.collectionView reloadData];
        }];
        
        NSLog(@"Loaded photo results");
    }];
    NSLog(@"View did load finished");
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.catPhotos.count;
}


// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    [cell setFlickrPhoto:self.catPhotos[indexPath.row]];
    return cell;
}




@end
