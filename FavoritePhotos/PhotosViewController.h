//
//  PhotosViewController.h
//  FavoritePhotos
//
//  Created by Jaehee Chung on 7/30/15.
//  Copyright (c) 2015 Jaehee Chung. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Model.h"
#import "ImageCollectionViewCell.h"
#import "Favorites.h"

@interface PhotosViewController : UIViewController <ModelDelegate, UISearchBarDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, ImageCollectionViewCellDelegate>

@property Model *model;

@end
