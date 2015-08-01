//
//  FavoritesViewController.m
//  FavoritePhotos
//
//  Created by Jaehee Chung on 7/31/15.
//  Copyright (c) 2015 Jaehee Chung. All rights reserved.
//

#import "FavoritesViewController.h"
#import "Favorites.h"



@interface FavoritesViewController ()


@property NSMutableArray *kindOfLikedPhotos;
@property Favorites *favorites;

@end



@implementation FavoritesViewController


#pragma mark - VC and Life-cycle 

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self loadFromDirectory];
}


-(void)loadFromDirectory {
    self.kindOfLikedPhotos = [NSMutableArray new];
    self.favorites = [Favorites new];
    self.kindOfLikedPhotos = [self.favorites loadImageObjects];
    [self.collectionView reloadData];
}


#pragma mark - Collection View Delegate

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    cell.delegate = self;
    
    Image *image = self.kindOfLikedPhotos [indexPath.item];
    if (image.isFavorited) {
        cell.starImageView.imageView.image = [UIImage imageNamed:@"star-filled"];
    } else {
        cell.starImageView.imageView.image = [UIImage imageNamed:@"star"];
    }
    cell.cellImageView.image = image.photo;
    
    return cell;
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.kindOfLikedPhotos.count;
}


-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(self.view.frame.size.width, self.view.frame.size.width);
}



#pragma mark - ImageCollectionViewCell Delegate

-(UIImage *)imageCollectionViewCell:(ImageCollectionViewCell *)imageCollectionViewCell {
    NSIndexPath *indexPath = [self.collectionView indexPathForCell:imageCollectionViewCell];
    Image *image = self.kindOfLikedPhotos[indexPath.item];
    image.isFavorited = NO;
    [self.kindOfLikedPhotos removeObject:image];
    [self.collectionView reloadData];
    [self.favorites saveWithImages:self.kindOfLikedPhotos];
    
    return image.photo;
    
}



@end