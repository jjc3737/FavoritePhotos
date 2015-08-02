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

}

-(void)viewWillAppear:(BOOL)animated {
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
    cell.cellImageView.image = image.photo;
    cell.starImageView.imageView.image = [UIImage imageNamed:@"star-filled"];
    
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
    
    [self.favorites savedRemovedFavoriteImage:image];
    
    [self.collectionView reloadData];
    
    return [UIImage imageNamed:@"star-filled"];;
    
}

#pragma mark - Sharing

- (IBAction)favoritesSharingButtonPressed:(UIBarButtonItem *)sender {
    
    NSArray *arrayOfCells = [self.collectionView visibleCells];
    ImageCollectionViewCell *cellOfInterest = arrayOfCells.firstObject;
    
    NSIndexPath *indexPath = [self.collectionView indexPathForCell:cellOfInterest];
    Image *image = self.kindOfLikedPhotos[indexPath.item];
    
    NSArray *sharedImage = [NSArray arrayWithObject:image.photo];
    
    UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems: sharedImage applicationActivities:nil];
    
    NSArray *excludeActivities = @[UIActivityTypeAirDrop,
                                   UIActivityTypePrint,
                                   UIActivityTypeAssignToContact,
                                   UIActivityTypeSaveToCameraRoll,
                                   UIActivityTypeAddToReadingList,
                                   UIActivityTypePostToFlickr,
                                   UIActivityTypePostToVimeo];
    
    activityVC.excludedActivityTypes = excludeActivities;
    
    [self presentViewController:activityVC animated:YES completion:nil];
}




@end
