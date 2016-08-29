//
//  ZipManager.h
//  ZipArchive_Demo
//
//  Created by vignesh on 8/5/16.
//  Copyright © 2016 vignesh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZipArchive.h"

@interface ZipManager : NSObject

- (NSString*) createZipArchiveWithFiles:(NSArray*)files andPassword:(NSString*)password;
- (NSString*) unZipArchiveWithPassword:(NSString*)password;

@end
