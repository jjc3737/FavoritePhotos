//
//  Favorites.m
//  FavoritePhotos
//
//  Created by Jaehee Chung on 7/31/15.
//  Copyright (c) 2015 Jaehee Chung. All rights reserved.
//

#import "Favorites.h"

@interface Favorites ()

@property NSMutableArray *datas;

@end

@implementation Favorites


-(void) saveWithImages:(NSMutableArray *)images {
    self.datas = [NSMutableArray new];
    for (Image *image in images) {
        NSData *data = UIImageJPEGRepresentation(image.photo, 0.0);
        [self.datas addObject:data];
    }

    [self.datas writeToURL:[[NSFileManager defaultManager] URLInDocumentsDirectoryForFileName:@"favoritePhotos.plist"]  atomically:YES];
}

-(NSMutableArray *)loadImageObjects{
        [self.datas writeToURL:[[NSFileManager defaultManager] URLInDocumentsDirectoryForFileName:@"favoritePhotos.plist"]  atomically:YES];
    return nil;
}
@end
