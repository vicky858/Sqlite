//
//  ViewController.h
//  Sample
//
//  Created by vignesh on 8/11/16.
//  Copyright © 2016 vignesh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SQLiteManager.h"
#import "FMDatabase.h"
#import "ZipManager.h"
@interface ViewController :UIViewController<UITextViewDelegate,UITableViewDataSource,NSXMLParserDelegate>

@property (strong, nonatomic,nullable)  FMDatabase *db;
@property (weak, nonatomic,nullable) IBOutlet UIButton *btn;
@property (nonatomic, strong, null_resettable) UITableView *tableView;
- (IBAction)btnAction:(id)sender;
- (IBAction)xmlRead:(id)sender;
-(void)saveBooks;
@end

