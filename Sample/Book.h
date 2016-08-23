//
//  Book.h
//  Sample
//
//  Created by vignesh on 17/08/16.
//  Copyright © 2016 vignesh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Book : NSObject

@property(nonatomic, strong) NSString *bookID;
@property(nonatomic, strong) NSString *author;
@property(nonatomic, strong) NSString *bookDesc;
@property(nonatomic, strong) NSString *title;
@property(nonatomic, strong) NSString *genre;
@property(nonatomic, strong) NSString *price;
@property(nonatomic, strong) NSString *pubDate;

@end