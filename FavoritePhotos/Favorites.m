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
@property NSMutableDictionary *idNumbersToCoordinates;

@end

@implementation Favorites


#pragma mark - Constants and Parameters 

NSString *const documentsDirectoryFileName = @"favoritePhotos.plist";

-(void) saveWithImage:(Image *)image {
    
    
    self.idNumbersToCoordinates = [[NSDictionary dictionaryWithContentsOfURL:[[NSFileManager defaultManager] URLInDocumentsDirectoryForFileName:documentsDirectoryFileName]]mutableCopy];
    
    if (self.idNumbersToCoordinates == nil) {
        self.idNumbersToCoordinates = [NSMutableDictionary new];
        [self.idNumbersToCoordinates setObject:image.latitudeAndLongitude forKey:image.idNumber];
        
        //this writes to the directoryPath the images in separate files
        [UIImageJPEGRepresentation(image.photo, 1.0) writeToFile:[self stringPathForImageFile:image.idNumber] options:NSAtomicWrite error:nil];
        // this saves the ids of the images, and images are named idNumber.jpg so it is easy to find.
        [self.idNumbersToCoordinates writeToURL:[[NSFileManager defaultManager] URLInDocumentsDirectoryForFileName:documentsDirectoryFileName]  atomically:YES];
    } else {

        
        [self.idNumbersToCoordinates setObject:image.latitudeAndLongitude forKey:image.idNumber];
        
            //this writes to the directoryPath the images in separate files
        [UIImageJPEGRepresentation(image.photo, 1.0) writeToFile:[self stringPathForImageFile:image.idNumber] options:NSAtomicWrite error:nil];
            // this saves the ids of the images, and images are named idNumber.jpg so it is easy to find.
        [self.idNumbersToCoordinates writeToURL:[[NSFileManager defaultManager] URLInDocumentsDirectoryForFileName:documentsDirectoryFileName]  atomically:YES];
    }
    

}

//have another function where you saveWithDeletingImages: (Image *)image {
-(void)savedRemovedFavoriteImage:(Image *)image {
    self.idNumbersToCoordinates = [[NSDictionary dictionaryWithContentsOfURL:[[NSFileManager defaultManager] URLInDocumentsDirectoryForFileName:documentsDirectoryFileName]]mutableCopy];
    
    [self.idNumbersToCoordinates removeObjectForKey:image.idNumber];


    [[NSFileManager defaultManager] removeItemAtPath:[self stringPathForImageFile:image.idNumber] error:nil];
    [self.idNumbersToCoordinates writeToURL:[[NSFileManager defaultManager] URLInDocumentsDirectoryForFileName:documentsDirectoryFileName]  atomically:YES];
}


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
    
    NSMutableDictionary *idsToCoordinates = [[NSDictionary dictionaryWithContentsOfURL:[[NSFileManager defaultManager] URLInDocumentsDirectoryForFileName:documentsDirectoryFileName]]mutableCopy];
    
    for (NSString *idNumber in idsToCoordinates) {
        Image *image = [Image new];
        image.idNumber = idNumber;
        image.photo = [self loadImage:idNumber];
        image.isFavorited = YES;
        image.latitudeAndLongitude = idsToCoordinates[idNumber];
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








