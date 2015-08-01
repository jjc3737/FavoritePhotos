//
//  ImageCollectionViewCell.m
//  FavoritePhotos
//
//  Created by Jaehee Chung on 7/30/15.
//  Copyright (c) 2015 Jaehee Chung. All rights reserved.
//

#import "ImageCollectionViewCell.h"

@implementation ImageCollectionViewCell
- (IBAction)starButtonPressed:(UIButton *)sender {
    
    UIImage *image = [self.delegate imageCollectionViewCell:self];
//    [self.delegate deleteImageCollectionViewCell:self];
    [sender setImage:image forState:UIControlStateNormal];
}

@end
