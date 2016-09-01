//
//  Book.h
//  Sample
//
//  Created by vignesh on 17/08/16.
//  Copyright © 2016 vignesh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Book : NSObject

@property(nonatomic, strong) NSString *creativeView;
@property(nonatomic, strong) NSString *start;
@property(nonatomic, strong) NSString *midpoint;
@property(nonatomic, strong) NSString *title;
@property(nonatomic, strong) NSString *genre;
@property(nonatomic, strong) NSString *price;
@property(nonatomic, strong) NSString *pubDate;

@end