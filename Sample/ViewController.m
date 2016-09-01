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
#import "XMLReader.h"
#import "Book.h"
#import "AFNetworking.h"
#import "AFURLConnectionOperation.h"
#import "AFHTTPRequestOperation.h"
#import "AFHTTPClient.h"
#import "ZipArchive.h"

@interface ViewController () <NSXMLParserDelegate>
{
   
    NSMutableArray *bookArray;
    Book *bookObj;
    SQLiteManager *sqldb;
    NSDictionary *xmlDictionary;
    NSString *_databasePath;
    ZipManager *zipManagerObj;
}


-(void)parseXml;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    zipManagerObj = [[ZipManager alloc] init];}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//     *****xml read in NSLog*****
- (IBAction)xmlRead:(id)sender {
NSError *err;
NSString *strHomepath = [[NSBundle mainBundle]pathForResource:@"New" ofType:@"xml"];
NSString *strXML = [NSString stringWithContentsOfFile:strHomepath encoding:NSUTF8StringEncoding error:&err];
xmlDictionary = [XMLReader dictionaryForXMLString:strXML error:&err];
NSLog(@"xml Dictionary :%@",xmlDictionary);

// *****Array List*****
    NSArray *arrList = @[@"Vignesh"];
    for (int i = 0; i < 10; i++){
    NSLog(@"%@ ",arrList);
    }
    
    NSMutableArray *array =[[NSMutableArray alloc]init];
    array = [NSMutableArray arrayWithObjects:@"Vicky", nil];
    for (int i= 0; i<10; i++) {
    NSLog(@"%@",array);
    }
    
   
    NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:@"Vignesh",@"Prabhu",@"Kumar",@"Vijay", nil];
    NSArray *arr = [dict allKeys];
    NSArray *valueArr = [dict allValues];
    for (int i=0; i<10; i++) {
    NSLog(@"%@",arr);
    NSLog(@"%@",valueArr);
    }
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]initWithObjectsAndKeys:@"Praveen",@"Kannan",@"M.P",@"Kishore", nil];
    NSArray *keyArray = [dic allKeys];
    NSArray *valueArray = [dic allValues];
    for (int i=0; i <10; i++) {
    NSLog(@"%@",keyArray);
    NSLog(@"%@",valueArray);
    }
    
}


-(void)parseXml
{
 
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:@"http://demo.tremorvideo.com/proddev/vast/vast_wrapper_linear_1.xml"]];
    NSMutableURLRequest *request = [httpClient requestWithMethod:@"GET"
                                                            path:@"http://demo.tremorvideo.com/proddev/vast/vast_wrapper_linear_1.xml"
                                                      parameters:nil];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [httpClient registerHTTPOperationClass:[AFHTTPRequestOperation class]];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        // Print the response body in text
        NSString *strValue = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSError *err;
        xmlDictionary = [XMLReader dictionaryForXMLString:strValue error:&err];
        
        [self DBInsert:[[[[[[[[[xmlDictionary valueForKey:@"VAST"]  valueForKey:@"Ad"] valueForKey:@"Wrapper"] valueForKey:@"Creatives"] valueForKey:@"Creative"] valueForKey:@"Linear"] valueForKey:@"TrackingEvents"] objectAtIndex:0] objectForKey:@"Tracking"]];
                NSData *serialzedData=[NSJSONSerialization dataWithJSONObject:xmlDictionary options:0 error:nil];
        
        NSString *saveJson = [[NSString alloc] initWithBytes:[serialzedData bytes] length:[serialzedData length] encoding:NSUTF8StringEncoding];
                [self writeJsonToFile:saveJson];
                    NSLog(@"Read JSON File : %@",[self readJsonFromFile]);
        
        

        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    [operation start];
    // Save into correct location
}


-(void)DBInsert:(NSArray *)arrValue{
    NSLog(@"arr ::%@",arrValue);
    [self createDatabaseIfNeeded];
    
    if([_db open]){
        [_db executeUpdate:@"create table if not exists Events(eventName text, eventURL text)"];
        [_db close];
    }
    
    BOOL updaetStatus = NO;
    BOOL insertStatus = NO;
    for (NSDictionary *dic in arrValue) {
        if([self findEvent:dic]){
            updaetStatus = [self updateEvent:dic];
            NSLog(@"updaet Status : %d",updaetStatus);
        }else{
            insertStatus = [self insertEvent:dic];
            NSLog(@"insert Status : %d",insertStatus);
        }
    }
    
    
    
    
}


-(BOOL)findEvent:(NSDictionary*)obj{
    
    [_db open];
    FMResultSet *results = [_db executeQuery:@"SELECT * FROM Events where eventName= ?;",[obj objectForKey:@"@event"]];
    
    if([results next]) {
        [_db close];
        return YES;
    }
    [_db close];
    return NO;
}

-(BOOL)updateEvent:(NSDictionary*)obj{
    
    [_db open];
    return [_db executeUpdate:@"UPDATE Events set eventName= ?, eventURL=? where eventName= ?;", [obj objectForKey:@"@event"], [obj objectForKey:@"text"], [obj objectForKey:@"@event"]];
}

-(BOOL)insertEvent:(NSDictionary*)obj{
    [_db open];
    return [_db executeUpdate:@"INSERT INTO Events (eventName, eventURL) VALUES (?,?);", [obj objectForKey:@"@event"], [obj objectForKey:@"text"]];
}



- (IBAction)btnAction:(id)sender {
    [self parseXml];
}

- (void)writeJsonToFile:(NSString*)aString {
    
    // Build the path, and create if needed.
    NSString* filePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString* fileName = @"events.json";
    
    NSString* fileAtPath = [filePath stringByAppendingPathComponent:fileName];
   
    

    if (![[NSFileManager defaultManager] fileExistsAtPath:fileAtPath]) {
        [[NSFileManager defaultManager] createFileAtPath:fileAtPath contents:nil attributes:nil];
    }
    
    // The main act...
    [[aString dataUsingEncoding:NSUTF8StringEncoding] writeToFile:fileAtPath atomically:NO];
}

- (NSString*)readJsonFromFile {
    
    // Build the path...
    NSString* filePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString* fileName = @"events.json";
    
       NSString* fileAtPath = [filePath stringByAppendingPathComponent:fileName];
    
    // The main act...
    return [[NSString alloc] initWithData:[NSData dataWithContentsOfFile:fileAtPath] encoding:NSUTF8StringEncoding];
}

//- (void)parserDidStartDocument:(NSXMLParser *)parser{
//    // sent when the parser begins parsing of the document.
//    NSLog(@"------------------------");
//    NSLog(@"parser - Start Document");
//    NSLog(@"------------------------");
//    
//    bookArray = nil;
//    bookArray = [[NSMutableArray alloc] init];
//}
//
//
//- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict
//{
//           //in this method does not enter
//        NSLog(@"------------------------");
//        NSLog(@"StartElement : %@",elementName);
//        NSLog(@"------------------------");
//    
//    
//        if ([elementName isEqualToString:@"VAST"])
//        {
//            bookObj = [[Book alloc] init];
//        }
// 
//        if ([elementName isEqualToString:@"event"])
//        {
//            NSString *name=[attributeDict objectForKey:@"creativeView"];
//            NSLog(@" %@", name);
//            [bookObj setBookID:name];
//        }
//        if ([elementName isEqualToString:@"event"])
//        {
//            NSString *name=[attributeDict objectForKey:@"unmute"];
//            NSLog(@" %@", name);
//            [bookObj setAuthor:name];
//        }
//        if ([elementName isEqualToString:@"event"])
//        {
//            NSString *name=[attributeDict objectForKey:@"pause"];
//            NSLog(@" %@", name);
//            [bookObj setTitle:name];
//        }
//        if ([elementName isEqualToString:@"event"])
//        {
//            NSString *name=[attributeDict objectForKey:@"text"];
//            NSLog(@" %@", name);
//            [bookObj setGenre:name];
//        }
//        if ([elementName isEqualToString:@"event"])
//        {
//            NSString *name=[attributeDict objectForKey:@"text"];
//            NSLog(@" %@", name);
//            [bookObj setPrice:name];
//        }
//        if ([elementName isEqualToString:@"event"])
//        {
//            NSString *name=[attributeDict objectForKey:@"text"];
//            NSLog(@" %@", name);
//            [bookObj setPubDate:name];
//        }
//        
//        if ([elementName isEqualToString:@"event"])
//        {
//            NSString *name=[attributeDict objectForKey:@"text"];
//            NSLog(@" %@", name);
//            [bookObj setBookDesc:name];
//        }
//    
//        if ([elementName isEqualToString:@"event"])
//        {
//            NSString *name=[attributeDict objectForKey:@"text"];
//            NSLog(@" %@", name);
//            [bookObj setBookDesc:name];
//        }
//    
//        if ([elementName isEqualToString:@"event"])
//        {
//            NSString *name=[attributeDict objectForKey:@"text"];
//            NSLog(@" %@", name);
//            [bookObj setBookDesc:name];
//        }
//    
//        if ([elementName isEqualToString:@"event"])
//        {
//            NSString *name=[attributeDict objectForKey:@"text"];
//            NSLog(@" %@", name);
//            [bookObj setBookDesc:name];
//        }
//    
//        if ([elementName isEqualToString:@"event"])
//        {
//            NSString *name=[attributeDict objectForKey:@"text"];
//            NSLog(@" %@", name);
//            [bookObj setBookDesc:name];
//        }
//
//}
//
//- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(nullable NSString *)namespaceURI qualifiedName:(nullable NSString *)qName{
//    
//    NSLog(@"************************");
//    NSLog(@"End Element : %@",elementName);
//    NSLog(@"************************");
//    
//    if ([elementName isEqualToString:@"root"])
//    {
//        [bookArray addObject:bookObj];
//        bookObj = nil;
//    }
//}
//
//- (void)parserDidEndDocument:(NSXMLParser *)parser{
//// sent when the parser has completed parsing. If this is encountered, the parse was successful.
//    NSLog(@"------------------------");
//    NSLog(@"parser - End Document");
//    NSLog(@"------------------------");
//    
//    NSLog(@"Book List : %@",bookArray);
//    [self saveBooks];
//}
//
//- (IBAction)btnAction:(id)sender {
//    [self parseXml];
//}
//
//
//-(BOOL)findBook:(Book*)obj{
//    
//    [_db open];
//    FMResultSet *results = [_db executeQuery:@"SELECT * FROM Books where id= ?;",obj.bookID];
//
//    if([results next]) {
//        [_db close];
//        return YES;
//    }
//    [_db close];
//    return NO;
//}
//
//-(BOOL)updateBook:(Book*)obj{
//    
//    [_db open];
//    return [_db executeUpdate:@"UPDATE Books set id= ?, author=?, title=?, genre=?, price=?, publish_date=?, description=? where id= ?;", obj.bookID, obj.author, obj.title, obj.genre, obj.price, obj.pubDate, obj.bookDesc, obj.bookID];
//}
//
//-(BOOL)insertBook:(Book*)obj{
//   [_db open];
//    return [_db executeUpdate:@"INSERT INTO Books (id, author, title, genre, price, publish_date, description) VALUES (?,?,?,?,?,?,?);", obj.bookID, obj.author, obj.title, obj.genre, obj.price, obj.pubDate, obj.bookDesc];
//}
//
//-(BOOL)deleteBook:(Book*)obj{
//    [_db open];
//    return [_db executeUpdate:@"DELETE FROM Books WHERE id = ?", obj.bookID];
//}
//
//-(void)saveBooks{
//    
//    NSLog(@"------------------------");
//    NSLog(@"SQLite DB Insert / Update");
//    NSLog(@"------------------------");
//
//    
//    [self createDatabaseIfNeeded];
//    
//    BOOL updaetStatus = NO;
//    BOOL insertStatus = NO;
//    for (Book *obj in bookArray) {
//        if([self findBook:obj]){
//            updaetStatus = [self updateBook:obj];
//            NSLog(@"updaetStatus : %d",updaetStatus);
//        }else{
//            insertStatus = [self insertBook:obj];
//            NSLog(@"insertStatus : %d",insertStatus);
//        }
//    }
//
//    
//    NSLog(@"**************************************");
//    NSLog(@"**************************************");
//    NSLog(@"        SQLite DB Get Books           ");
//    NSLog(@"**************************************");
//    NSLog(@"**************************************");
//    
//    FMResultSet *results = [_db executeQuery:@"SELECT * FROM Books"];
//    NSMutableArray *savedBooks = [[NSMutableArray alloc] init];
//    while([results next]) {
//        Book *obj	= [[Book alloc] init];
//        obj.bookID = [results stringForColumn:@"id"];
//        obj.author = [results stringForColumn:@"author"];
//        obj.title = [results stringForColumn:@"title"];
//        obj.genre = [results stringForColumn:@"genre"];
//        obj.price = [results stringForColumn:@"price"];
//        obj.pubDate = [results stringForColumn:@"publish_date"];
//        obj.bookDesc = [results stringForColumn:@"description"];
//        [savedBooks addObject:obj];
//        NSLog(@"BOOK ID : %@, Book Title : %@",obj.bookID, obj.title);
//    }
//    
//    NSLog(@"No.of Books Count : %lu",(unsigned long)[savedBooks count]);
//    [_db close];
//    
//    /*
//    NSLog(@"**************************************");
//    NSLog(@"**************************************");
//    NSLog(@"SQLite DB Delete Books");
//    NSLog(@"**************************************");
//    NSLog(@"**************************************");
//    
//    for (Book *obj in bookArray) {
//            BOOL deleteStatus = [self deleteBook:obj];
//            NSLog(@"deleteStatus : %d",deleteStatus);
//    }
//    [_db close];
//     */
//}

-(void)createDatabaseIfNeeded{
    
    BOOL success;
    NSError *error;
    
    //FileManager - Object allows easy access to the File System.
    NSFileManager *FileManager = [NSFileManager defaultManager];
    
    //Get the complete users document directory path.
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    //Get the first path in the array.
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    //Create the complete path to the database file.
    NSString *databasePath = [documentsDirectory stringByAppendingPathComponent:@"Books.sqlite"];
    
    //Check if the file exists or not.
    success = [FileManager fileExistsAtPath:databasePath];
    
    //If the database is present then quit.
    if(success)
    {
        [self OpenDB:databasePath];
        return;
    }
    
    //the database does not exists, so we will copy it to the users document directory]
    NSString *dbPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"Books.sqlite"];
    
    //Copy the database file to the users document directory.
    success = [FileManager copyItemAtPath:dbPath toPath:databasePath error:&error];
    
    //If the above operation is not a success then display a message.
    //Error message can be seen in the debugger's console window.
    if(!success)
        NSAssert1(0, @"Failed to copy the database. Error: %@.", [error localizedDescription]);
    [self OpenDB:databasePath];
}

-(void)OpenDB:(NSString*)strDBPath
{
    if(!_db)
    {
        _db = [[FMDatabase alloc] initWithPath:strDBPath];
        if (![_db open]) {
            //(@"Could not open db.");
            return;
        }
        NSLog(@"FM DB instance ready at path = %@",strDBPath);
    }
}
@end
//    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"https://192.168.5.172/iosDemo/Books.xml"]];
//    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
//
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *path = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"filename"];
//    operation.outputStream = [NSOutputStream outputStreamToFileAtPath:path append:NO];
//
//    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"Successfully downloaded file to %@", path);
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"Error: %@", error);
//    }];
//
//    [operation start];

//
//        AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:@"http://google.com/"]];
//    NSMutableURLRequest *request = [httpClient requestWithMethod:@"GET"
//                                                            path:@"http://google.com/api/pigs/"
//                                                      parameters:nil];
//
//    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
//
//    [httpClient registerHTTPOperationClass:[AFHTTPRequestOperation class]];
//
//    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
//
//        // Print the response body in text
//        NSLog(@"Response: %@", [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]);
//
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"Error: %@", error);
//    }];
//    [operation start];
/*
 NSString *string = [NSString stringWithFormat:@"https://192.168.5.172/iosDemo/Books.xml"];
 NSURL *url = [NSURL URLWithString:string];
 NSURLRequest *request = [NSURLRequest requestWithURL:url];
 
 AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
 operation.responseSerializer = [AFXMLParserResponseSerializer serializer];
 
 [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject)
 {
 
 NSXMLParser *XMLParser = (NSXMLParser *)responseObject;
 [XMLParser setShouldProcessNamespaces:YES];
 
 
 }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
 
 UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error"
 message:[error localizedDescription]
 delegate:nil
 cancelButtonTitle:@"Ok"
 otherButtonTitles:nil];
 [alertView show];
 
 }];
 
 [operation start];
 NSLog(@"the parser file is: %@",request);
 */