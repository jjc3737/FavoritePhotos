//
//  NSFileManager+Documents.h
//  FavoritePhotos
//
//  Created by Jaehee Chung on 7/31/15.
//  Copyright (c) 2015 Jaehee Chung. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSFileManager (Documents)

-(NSURL *)URLInDocumentsDirectoryForFileName: (NSString *)fileName;

@end
