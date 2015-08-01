//
//  NSFileManager+Documents.m
//  FavoritePhotos
//
//  Created by Jaehee Chung on 7/31/15.
//  Copyright (c) 2015 Jaehee Chung. All rights reserved.
//

#import "NSFileManager+Documents.h"

@implementation NSFileManager (Documents)

-(NSURL *)URLInDocumentsDirectoryForFileName: (NSString *)fileName {
    NSURL *url = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask].firstObject URLByAppendingPathComponent:fileName];
    
    return  url;
}


@end
