//
//  Recipe.h
//  RecipeBook
//
//  Created by vignesh on 30/08/16.
//  Copyright © 2016 vignesh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Recipe : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *detail;
@property (nonatomic, strong) NSString *imageFile;
@property (nonatomic, strong) NSArray *ingredients;
@property (nonatomic, strong) NSString *prepTime;
@end
