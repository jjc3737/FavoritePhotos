//
//  PhotosViewController.m
//  FavoritePhotos
//
//  Created by Jaehee Chung on 7/30/15.
//  Copyright (c) 2015 Jaehee Chung. All rights reserved.
//

#import "PhotosViewController.h"
#import "Image.h"
#import "NSFileManager+Documents.h"
#import "Favorites.h"

@interface PhotosViewController () 


@property Model *model;
@property Favorites *favorites;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property NSMutableArray *images;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIButton *starButton;

@end

@implementation PhotosViewController


#pragma mark - VC and Life-cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initModelAndSetUpDefault];
    [self initializeThings];
}


-(void)initializeThings {
       self.favorites = [Favorites new];
}


-(void)initModelAndSetUpDefault {
    self.model = [Model new];
    self.model.delegate = self;
    [self.model fetchDataWithParameter:@"San Francisco"];
}


#pragma mark - CollectionViewCell Delegate

-(UIImage *)imageCollectionViewCell:(ImageCollectionViewCell *)imageCollectionViewCell {
    
    NSIndexPath *indexPath = [self.collectionView indexPathForCell:imageCollectionViewCell];
    Image *image = self.images[indexPath.item];
    
    if (image.isFavorited) {
        image.isFavorited = NO;

        [self.favorites savedRemovedFavoriteImage:image];
        return [UIImage imageNamed:@"star"];
    } else {
        image.isFavorited = YES;

        [self.favorites saveWithImage:image];
        return [UIImage imageNamed:@"star-filled"];
    }
}



#pragma mark - Collection View Delegate

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    cell.delegate = self;
    
    Image *image = self.images [indexPath.item];
    if (image.isFavorited) {
        cell.starImageView.imageView.image = [UIImage imageNamed:@"star-filled"];
    } else {
        cell.starImageView.imageView.image = [UIImage imageNamed:@"star"];
    }
    cell.cellImageView.image = image.photo;
    
    return cell;
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.images.count; 
}


-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(self.view.frame.size.width, self.view.frame.size.width);
}


#pragma mark - Model Delegate Method


-(void)Model:(Model *)model images:(NSMutableArray *)images {
    self.images = [images copy];
    

    //THing to do here: load the image Object array from Favorites. Iterate through them and match with list of self.images and see if any of the images are in this list. IF SO, then that ImageObject.isFavorited = YES;

    [self checkFavoritesArray];


    
    [self.collectionView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:YES];

}


#pragma mark - searchBar Delegate 

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [self.searchBar resignFirstResponder];
    [self.model fetchDataWithParameter:searchBar.text];
    
    //We would need to check here as well! To see if any of the new images are favorited

    [self checkFavoritesArray];


    [self.collectionView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:YES];
    
}


- (void)checkFavoritesArray {
    NSArray *favorites = [self.favorites loadImageObjects];

    for (Image *i in favorites) {
        NSString *idFavorited = i.idNumber;
        for (int j = 0; j < self.images.count; j++) {
            NSString *idOfCurrentImage = [self.images[j] idNumber];
            if ([idOfCurrentImage isEqualToString:idFavorited]) {
                [self.images[j] setIsFavorited:YES];
            }
        }
    }
}

@end




