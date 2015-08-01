//
//  ImageCollectionViewCell.h
//  FavoritePhotos
//
//  Created by Jaehee Chung on 7/30/15.
//  Copyright (c) 2015 Jaehee Chung. All rights reserved.
//



#import <UIKit/UIKit.h>
@protocol ImageCollectionViewCellDelegate;

@interface ImageCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) id <ImageCollectionViewCellDelegate> delegate;

@property (weak, nonatomic) IBOutlet UIImageView *cellImageView;
@property (weak, nonatomic) IBOutlet UIButton *starImageView;



@end

@protocol ImageCollectionViewCellDelegate <NSObject>

@optional

-(void)deleteImageCollectionViewCell:(ImageCollectionViewCell *)imageCollectionViewCell;
-(UIImage *)imageCollectionViewCell:(ImageCollectionViewCell *)imageCollectionViewCell;


@end


