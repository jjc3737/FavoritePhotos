//
//  Image.h
//  FavoritePhotos
//
//  Created by Jaehee Chung on 7/31/15.
//  Copyright (c) 2015 Jaehee Chung. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Image : NSObject

@property BOOL isFavorited;
@property UIImage *photo;
@property NSString *idNumber;
@property double latititude;
@property double longitude;

@end
