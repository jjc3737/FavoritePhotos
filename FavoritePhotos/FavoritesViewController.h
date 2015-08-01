//
//  FavoritesViewController.h
//  FavoritePhotos
//
//  Created by Jaehee Chung on 7/31/15.
//  Copyright (c) 2015 Jaehee Chung. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhotosViewController.h"
#import "Image.h"
#import "ImageCollectionViewCell.h"

@interface FavoritesViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, ImageCollectionViewCellDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property Model *model;


@end
