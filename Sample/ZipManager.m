//
//  ZipManager.m
//  ZipArchive_Demo
//
//  Created by vignesh on 8/5/16.
//  Copyright © 2016 vignesh. All rights reserved.
//

#import "ZipManager.h"

@implementation ZipManager


- (NSString*) createZipArchiveWithFiles:(NSArray*)files andPassword:(NSString*)password
{
    
    NSString *docsDir;
    NSArray *dirPaths;
    // Get the documents directory
    dirPaths = NSSearchPathForDirectoriesInDomains
    (NSDocumentDirectory, NSUserDomainMask, YES);
    docsDir = dirPaths[0];
    // Build the path to the database file
    NSString *zipPath = [[NSString alloc] initWithString:
                         [docsDir stringByAppendingPathComponent: @"Sample.zip"]];
    
    ZipArchive* zip = [[ZipArchive alloc] init];
    
    BOOL ok = NO;
    
    if (password && password.length > 0) {
        ok = [zip CreateZipFile2:zipPath Password:password];
    } else {
        ok = [zip CreateZipFile2:zipPath];
    }
    
    for (NSString* file in files) {
        ok = [zip addFileToZip:file newname:[file lastPathComponent]];
    }
    ok = [zip CloseZipFile2];
    if(ok){
        return @"Zip Success...";
    }
    return @"Zip Failed!";
}

- (NSString*) unZipArchiveWithPassword:(NSString*)password
{
    NSString *docsDir;
    NSArray *dirPaths;
    // Get the documents directory
    dirPaths = NSSearchPathForDirectoriesInDomains
    (NSDocumentDirectory, NSUserDomainMask, YES);
    docsDir = dirPaths[0];
    // Build the path to the database file
    NSString *zipPath = [[NSString alloc] initWithString:
                         [docsDir stringByAppendingPathComponent: @"Sample.zip"]];
    
    NSString *outputDir = [[NSString alloc] initWithString:
                           [docsDir stringByAppendingPathComponent: @"Sample"]];
    
    // unzip password zip
    NSUInteger count = 0;
    NSFileManager* fm = [NSFileManager defaultManager];
    ZipArchive* zip = [[ZipArchive alloc] init];
    [zip UnzipOpenFile:zipPath Password:password];
    NSArray* contents = [zip getZipFileContents];
    BOOL ok = NO;
    if(contents && contents.count > 0){
        
        ok = [zip UnzipFileTo:outputDir overWrite:YES];
    }
    
    
    //TO get the unziped files
    NSDirectoryEnumerator* dirEnum = [fm enumeratorAtPath:outputDir];
    NSString* file;
    NSError* error = nil;
    while ((file = [dirEnum nextObject])) {
        count += 1;
        NSString* fullPath = [outputDir stringByAppendingPathComponent:file];
        NSLog(@"File Path : %@",fullPath);
        NSDictionary* attrs = [fm attributesOfItemAtPath:fullPath error:&error];
        NSLog(@"File Type : %@ File Size : %llu",[attrs fileType],[attrs fileSize]);
    }
    
    
    if(ok){
        return @"Un Zip Success...";
    }
    return @"Un Zip Failed!";
    
}

@end
