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

NSString *const documentsDirectoryFileName = @"favoritePhotos.plist";

-(void) saveWithImages:(Image *)image {
    
    self.idNumbers = [[NSArray arrayWithContentsOfURL:[[NSFileManager defaultManager] URLInDocumentsDirectoryForFileName:documentsDirectoryFileName]]mutableCopy];
    
    if (![self.idNumbers containsObject:image.idNumber]) {
        [self.idNumbers addObject:image.idNumber];
            //this writes to the directoryPath the images in separate files
        [UIImageJPEGRepresentation(image.photo, 1.0) writeToFile:[self stringPathForImageFile:image.idNumber] options:NSAtomicWrite error:nil];
            // this saves the ids of the images, and images are named idNumber.jpg so it is easy to find.
        [self.idNumbers writeToURL:[[NSFileManager defaultManager] URLInDocumentsDirectoryForFileName:documentsDirectoryFileName]  atomically:YES];
        }
    
}

//have another function where you saveWithDeletingImages: (Image *)image {


//-(void) saveWithImages:(NSMutableArray *)images {
//
//    self.idNumbers = [[NSArray arrayWithContentsOfURL:[[NSFileManager defaultManager] URLInDocumentsDirectoryForFileName:documentsDirectoryFileName]]mutableCopy];
//
//    for (Image *image in images) {
//        if (![self.idNumbers containsObject:image.idNumber]) {
//            [self.idNumbers addObject:image.idNumber];
//            //this writes to the directoryPath the images in separate files
//            [UIImageJPEGRepresentation(image.photo, 1.0) writeToFile:[self stringPathForImageFile:image.idNumber] options:NSAtomicWrite error:nil];
//              // this saves the ids of the images, and images are named idNumber.jpg so it is easy to find.
//            [self.idNumbers writeToURL:[[NSFileManager defaultManager] URLInDocumentsDirectoryForFileName:documentsDirectoryFileName]  atomically:YES];
//        }
//    }
//}

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


    UIImage * result = [UIImage imageWithContentsOfFile:[self stringPathForImageFile:fileName]];

    return result;
}

-(NSString *)stringPathForImageFile:(NSString *)imageName {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    return [paths.firstObject stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.%@", imageName, @"jpg"]];
}


@end








