//
//  Model.m
//  FavoritePhotos
//
//  Created by Jaehee Chung on 7/30/15.
//  Copyright (c) 2015 Jaehee Chung. All rights reserved.
//

#import "Model.h"
#import "Image.h"

@implementation Model 


-(void)fetchDataWithParameter: (NSString *)parameter {
    
    NSString *parameterWithOutSpaces = [parameter stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.instagram.com/v1/tags/%@/media/recent?access_token=269327096.f764bd0.b1491edd0bcf478883567100cf87449b", parameterWithOutSpaces]];

    [[[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSDictionary *firstResults = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        NSArray *dataArray = firstResults[@"data"];
        [self makeImagesWithArray:dataArray];
        
    }]resume];
}


-(void)makeImagesWithArray: (NSArray *)dataArray {

    NSMutableArray *images = [NSMutableArray new];
    int i = 0;
    
    for (NSDictionary *dataDictionaries in dataArray) {
        if (i == 10) {
            break;
        }
        Image *starImage = [Image new];
        starImage.isFavorited = NO;
        starImage.idNumber = dataDictionaries[@"id"];
        if (!(dataDictionaries[@"location"] == (id)[NSNull null])) {
            NSDictionary *locationDictionary = dataDictionaries[@"location"];
            double latitude =  [locationDictionary[@"latitude"]doubleValue];
            double longitude = [locationDictionary[@"longitude"]doubleValue];
            starImage.latitudeAndLongitude = [NSArray arrayWithObjects:[NSNumber numberWithDouble:latitude ], [NSNumber numberWithDouble:longitude], nil];
        }

        NSDictionary *imageDictionary = dataDictionaries[@"images"];
        NSDictionary *standardResolution = imageDictionary[@"low_resolution"];
        NSURL *url = [NSURL URLWithString:standardResolution[@"url"]];
        starImage.photo = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
        [images  addObject:starImage];
        i++;
        
    }

    [self.delegate Model:self images:images];
}







@end
