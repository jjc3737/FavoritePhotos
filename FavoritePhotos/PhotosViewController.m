//
//  PhotosViewController.m
//  FavoritePhotos
//
//  Created by Jaehee Chung on 7/30/15.
//  Copyright (c) 2015 Jaehee Chung. All rights reserved.
//

#import "PhotosViewController.h"
#import "ImageCollectionViewCell.h"

@interface PhotosViewController ()

@property NSMutableArray *imageURLS;
@property Model *model;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property NSMutableArray *images;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation PhotosViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initModelAndSetUpDefault];
    
}

-(void)initModelAndSetUpDefault {
    self.model = [Model new];
    self.model.delegate = self;
    [self.model fetchDataWithParameter:@"San Francisco"];
}

#pragma mark - setUpImages

-(void)setUpImages {

    self.images = [[NSMutableArray alloc] init];
    
    for (NSString *url in self.imageURLS) {
        UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:url]]];
        [self.images addObject:image];
    }
    
    
}

#pragma mark - Collection View Delegate

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    cell.cellImageView.image = self.images[indexPath.item];
    return cell;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.images.count; 
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(self.view.frame.size.width, self.view.frame.size.width);
}


#pragma mark - Model Delegate Method

-(void)Model:(Model *)model imageURLS:(NSMutableArray *)imageURLS {
    self.imageURLS = [imageURLS copy];
    
    [self setUpImages];
    [self.collectionView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:YES];

}


#pragma mark - searchBar Delegate 

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [self.model fetchDataWithParameter:searchBar.text];
    
    
    
    //reload the imageView
}

@end
