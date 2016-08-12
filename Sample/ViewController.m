//
//  ViewController.m
//  Sample
//
//  Created by vignesh on 8/11/16.
//  Copyright © 2016 vignesh. All rights reserved.
//

#import "ViewController.h"
#import "SQLiteManager.h"
#import "FMDatabase.h"
#import "XMLWriter.h"


@interface ViewController () <NSXMLParserDelegate>
{
   
    NSMutableArray *arrg;
    
}


-(void)parseXml;

@end

@implementation ViewController 

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self parseXml];
    
    
//    SQLiteManager *sqldb=[[SQLiteManager alloc]init];
//    NSString *sqlQry=[NSString stringWithFormat:@"INSERT INTO xmldetails(eventID,Name,Domain,DoB)VALUES(?,?,?,?)"];
//    [sqldb ExecuteInsertQuery:sqlQry withCollectionOfValues:arrg];
//    [arrg removeAllObjects];
    
    
    
//    BOOL success = [xmlparse parse];
//
//    if(success == YES){
//        
//        NSLog(@"success");
//    }
//    else {
//        
//        NSLog(@" not success"); //is not success, why?
//    }
//   
    // Do any additional setup after loading the view, typically from a nib.
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)parseXml
{
    NSURL *url=[[NSBundle mainBundle]URLForResource:@"Books" withExtension:@"xml"];
    
    NSXMLParser *xmlparse=[[NSXMLParser alloc]initWithContentsOfURL:url];
    NSLog(@"the parser file is: %@",xmlparse);
    [xmlparse setDelegate:self];
    [xmlparse setShouldResolveExternalEntities:NO];
    [xmlparse parse];
}


- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict
{
           //in this method does not enter
    
 
        if ([elementName isEqualToString:@"book"])
        {
            NSString *name=[attributeDict objectForKey:@"id"];
            NSLog(@" %@", name);
        }
        if ([elementName isEqualToString:@"author"])
        {
            NSString *name=[attributeDict objectForKey:@"name"];
            NSLog(@" %@", name);
        }
        if ([elementName isEqualToString:@"title"])
        {
            NSString *name=[attributeDict objectForKey:@"title"];
            NSLog(@" %@", name);
        }
        if ([elementName isEqualToString:@"genre"])
        {
            NSString *name=[attributeDict objectForKey:@"genre"];
            NSLog(@" %@", name);
        }
        if ([elementName isEqualToString:@"price"])
        {
            NSString *name=[attributeDict objectForKey:@"price"];
            NSLog(@" %@", name);
        }
        if ([elementName isEqualToString:@"publish_date"])
        {
            NSString *name=[attributeDict objectForKey:@"publish"];
            NSLog(@" %@", name);
        }
        
        if ([elementName isEqualToString:@"description"])
        {
            NSString *name=[attributeDict objectForKey:@"desc"];
            NSLog(@" %@", name);
        }

      
    
        
        
        
    
    
//
//        if ([elementName isEqualToString:@"book"])
//        {
//            NSString *name=[attributeDict objectForKey:@"id"];
//            NSLog(@" %@", name);
//        }
//        if ([elementName isEqualToString:@"author"])
//        {
//            NSString *name=[attributeDict objectForKey:@"name"];
//            NSLog(@" %@", name);
//        }
//        if ([elementName isEqualToString:@"title"])
//        {
//            NSString *name=[attributeDict objectForKey:@"title"];
//            NSLog(@" %@", name);
//        }
//        if ([elementName isEqualToString:@"genre"])
//        {
//            NSString *name=[attributeDict objectForKey:@"genre"];
//            NSLog(@" %@", name);
//        }
//        if ([elementName isEqualToString:@"price"])
//        {
//            NSString *name=[attributeDict objectForKey:@"price"];
//            NSLog(@" %@", name);
//        }
//        if ([elementName isEqualToString:@"publish_date"])
//        {
//            NSString *name=[attributeDict objectForKey:@"publish"];
//            NSLog(@" %@", name);
//        }
//
//        if ([elementName isEqualToString:@"description"])
//        {
//            NSString *name=[attributeDict objectForKey:@"desc"];
//            NSLog(@" %@", name);
//        }
//    

        
//    NSLog(@"element name:%@",elementName);
//    NSLog(@"%@",[attributeDict objectForKey:@"do"]);
    
//- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
//    if (self.isTitleElement) {
//        NSLog(@"valueforkey title = %@", string);
//        // store value so that it is not overwritten by the next title
//        [self.pageTitles addObject:string];
//    }
//}


}

@end
