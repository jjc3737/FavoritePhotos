//
//  Favorites.h
//  FavoritePhotos
//
//  Created by Jaehee Chung on 7/31/15.
//  Copyright (c) 2015 Jaehee Chung. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSFileManager+Documents.h"
#import "Image.h"

@interface Favorites : NSObject

@property NSMutableArray *savedFavoritedPhotos;


-(void) saveWithImages:(Image *)image;

-(NSMutableArray *)loadImageObjects;

@end
