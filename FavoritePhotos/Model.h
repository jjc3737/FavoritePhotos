//
//  Model.h
//  FavoritePhotos
//
//  Created by Jaehee Chung on 7/30/15.
//  Copyright (c) 2015 Jaehee Chung. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ModelDelegate;

@interface Model : NSObject


@property (weak,nonatomic) id <ModelDelegate> delegate;


-(void)fetchDataWithParameter: (NSString *)parameter;


@end

@protocol ModelDelegate <NSObject>

-(void)Model:(Model *)model imageURLS:(NSMutableArray *)imageURLS;


@end
