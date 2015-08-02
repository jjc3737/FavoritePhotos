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



@property Favorites *favorites;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property NSMutableArray *images;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIButton *starButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *searchShareButtonLabel;
@property BOOL isSearchingHash;

@end

@implementation PhotosViewController


#pragma mark - VC and Life-cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initModelAndSetUpDefault];
    [self initializeThings];
   
}

-(void)viewWillAppear:(BOOL)animated {
    [self checkFavoritesArray];
    [self.collectionView reloadData];
      self.searchShareButtonLabel.enabled = NO;
    
}


-(void)initializeThings {
       self.favorites = [Favorites new];
}


-(void)initModelAndSetUpDefault {
    self.isSearchingHash = YES;
    self.model = [Model new];
    self.model.delegate = self;
    [self.model fetchDataWithParameter:@"San Francisco" searchType:@"hash"];
}


#pragma mark - CollectionViewCell Delegate

-(UIImage *)imageCollectionViewCell:(ImageCollectionViewCell *)imageCollectionViewCell {
    
    NSIndexPath *indexPath = [self.collectionView indexPathForCell:imageCollectionViewCell];
    Image *image = self.images[indexPath.item];
    
    if (image.isFavorited) {
        image.isFavorited = NO;

        self.searchShareButtonLabel.enabled = NO;
        [self.favorites savedRemovedFavoriteImage:image];
        return [UIImage imageNamed:@"star"];
    } else {
        image.isFavorited = YES;

         self.searchShareButtonLabel.enabled = YES;
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
    
    [self checkFavoritesArray];

    [self.collectionView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:YES];

}


#pragma mark - searchBar Delegate 

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [self.searchBar resignFirstResponder];
    
    if (self.isSearchingHash) {
        [self.model fetchDataWithParameter:searchBar.text searchType:@"hash"];
    } else {
        [self.model fetchDataWithParameter:searchBar.text searchType:@"users"];
    }
    
    //We would need to check here as well! To see if any of the new images are favorited

    [self checkFavoritesArray];


    [self.collectionView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:YES];
    
}


- (void)checkFavoritesArray {
    NSArray *favorites = [self.favorites loadImageObjects];
    
    
    for (Image *image in self.images) {
        NSString *idOfCurrentImage = image.idNumber;
        BOOL isInFavorites = NO;
        for (Image *i in favorites) {
            NSString *idFavorited = i.idNumber;
            if ([idFavorited isEqualToString:idOfCurrentImage]) {
                image.isFavorited = YES;
                isInFavorites = YES;
            }
        }
        if (!isInFavorites) {
            image.isFavorited = NO;
        }
    }

}

#pragma mark - Share Button

- (IBAction)searchShareButtonPressed:(UIBarButtonItem *)sender {
    
    NSArray *arrayOfCells = [self.collectionView visibleCells];
    ImageCollectionViewCell *cellOfInterest = arrayOfCells.firstObject;
    
    NSIndexPath *indexPath = [self.collectionView indexPathForCell:cellOfInterest];
    Image *image = self.images[indexPath.item];
    
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


- (IBAction)hashtagsOrUsers:(UISegmentedControl *)sender {
    
    if (sender.selectedSegmentIndex == 0) {
        self.isSearchingHash = YES;
    } else {
        self.isSearchingHash = NO;
    }
}


@end




