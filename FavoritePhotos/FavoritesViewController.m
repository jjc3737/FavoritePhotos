//
//  FavoritesViewController.m
//  FavoritePhotos
//
//  Created by Jaehee Chung on 7/31/15.
//  Copyright (c) 2015 Jaehee Chung. All rights reserved.
//

#import "FavoritesViewController.h"

@interface FavoritesViewController ()
@property NSMutableArray *kindOfLikedPhotos;

@end

@implementation FavoritesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.kindOfLikedPhotos = [NSMutableArray new];
    [self load];
}

#pragma mark - Save & Load
-(void) save {
    
    [self.kindOfLikedPhotos writeToURL:[self pListURL] atomically:YES];
}

-(void) load {
    
    self.kindOfLikedPhotos = [NSMutableArray arrayWithContentsOfURL:[self pListURL]];
    [self.collectionView reloadData];
}

-(NSURL *)pListURL {
    
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask].firstObject URLByAppendingPathComponent:@"favoritePhotos.plist"];
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

-(void)deleteImageCollectionViewCell:(ImageCollectionViewCell *)imageCollectionViewCell {
    NSIndexPath *indexPath = [self.collectionView indexPathForCell:imageCollectionViewCell];
    Image *image = self.kindOfLikedPhotos[indexPath.item];
    
    if (image.isFavorited) {
        image.isFavorited = NO;
        
        [self.kindOfLikedPhotos removeObject:image];
        [self save];
        
        [self.collectionView reloadData];
    }
}
@end
