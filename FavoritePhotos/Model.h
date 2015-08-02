//
//  Model.h
//  FavoritePhotos
//
//  Created by Jaehee Chung on 7/30/15.
//  Copyright (c) 2015 Jaehee Chung. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@protocol ModelDelegate;

@interface Model : NSObject


@property (weak,nonatomic) id <ModelDelegate> delegate;


-(void)fetchDataWithParameter: (NSString *)parameter searchType: (NSString *)searchType;


@end

@protocol ModelDelegate <NSObject>

-(void)Model:(Model *)model images:(NSMutableArray *)images;


@end
