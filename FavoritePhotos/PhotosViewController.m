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

@interface PhotosViewController () 


@property Model *model;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property NSMutableArray *favoritedImages;
@property NSMutableArray *images;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIButton *starButton;

@end

@implementation PhotosViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initModelAndSetUpDefault];
    self.favoritedImages = [NSMutableArray new];
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
        
        [self.favoritedImages removeObject:image];
        [self save];

        return [UIImage imageNamed:@"star"];
    } else {
        image.isFavorited = YES;
        [self.favoritedImages addObject:image];
        [self save];
        return [UIImage imageNamed:@"star-filled"];
    }
}

#pragma mark - Save & Load

-(void) save {
    
    [self.favoritedImages writeToURL:[[NSFileManager defaultManager] URLInDocumentsDirectoryForFileName:@"favoritePhotos.plist"]  atomically:YES];
}

//-(void) saveImage:(UIImage *)image withFileName:(NSString *)imageName ofType:(NSString *)extension inDirectory:(NSString *)directoryPath {
//    
//    [UIImageJPEGRepresentation(image, 1.0) writeToFile:[directoryPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.%@", imageName, @"jpg"]] options:NSAtomicWrite error:nil];
//    
//    } else {
//        NSLog(@"Image Save Failed\nExtension: (%@) is not recognized, use (PNG/JPG)", extension);
//    }
//}






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
    
    [self.collectionView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:YES];

}


#pragma mark - searchBar Delegate 

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [self.searchBar resignFirstResponder];
    [self.model fetchDataWithParameter:searchBar.text];
    //reload the imageView
}

@end
