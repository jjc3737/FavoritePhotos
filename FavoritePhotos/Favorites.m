//
//  Favorites.m
//  FavoritePhotos
//
//  Created by Jaehee Chung on 7/31/15.
//  Copyright (c) 2015 Jaehee Chung. All rights reserved.
//

#import "Favorites.h"

@interface Favorites ()

@property NSMutableArray *idNumbers;

@end

@implementation Favorites


#pragma mark - Constants and Parameters 

NSString *const directoryPath = @"favoritedImageJPEGs";
NSString *const documentsDirectoryFileName = @"favoritePhotos.plist";

-(void) saveWithImages:(NSMutableArray *)images {
    self.idNumbers = [NSMutableArray new];
    for (Image *image in images) {
        [self.idNumbers addObject:image.idNumber];
        
        //this writes to the directoryPath the images in separate files
        
        [UIImageJPEGRepresentation(image.photo, 1.0) writeToFile:[directoryPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.%@", image.idNumber, @"jpg"]] options:NSAtomicWrite error:nil];

    }
    
    // this saves the ids of the images, and images are named idNumber.jpg so it is easy to find.

    [self.idNumbers writeToURL:[[NSFileManager defaultManager] URLInDocumentsDirectoryForFileName:documentsDirectoryFileName]  atomically:YES];
}

-(NSMutableArray *)loadImageObjects{
    NSMutableArray *imageObjectArrays = [NSMutableArray new];
    
    NSArray *idNumbers = [NSArray arrayWithContentsOfURL:[[NSFileManager defaultManager] URLInDocumentsDirectoryForFileName:documentsDirectoryFileName]];
    
    for (NSString *idNumber in idNumbers) {
        Image *image = [Image new];
        image.idNumber = idNumber;
        image.photo = [self loadImage:idNumber];
        image.isFavorited = YES;
        [imageObjectArrays addObject:image];
        
    }
    
    return imageObjectArrays;
    
}

-(UIImage *) loadImage:(NSString *)fileName {
    
    UIImage * result = [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/%@.%@", directoryPath, fileName, @"jpg"]];
    
    return result;
}
@end










