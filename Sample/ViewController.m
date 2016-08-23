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


@interface ViewController () <NSXMLParserDelegate>
{
   
    NSMutableArray *bookArray;
    Book *bookObj;
    SQLiteManager *sqldb;
    NSDictionary *xmlDictionary;
}


-(void)parseXml;

@end

@implementation ViewController 

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//     *****xml read in NSLog*****
- (IBAction)xmlRead:(id)sender {
NSError *err;
NSString *strHomepath = [[NSBundle mainBundle]pathForResource:@"Read" ofType:@"xml"];
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
    
    NSURL *url=[[NSBundle mainBundle]URLForResource:@"Books" withExtension:@"xml"];
    NSXMLParser *xmlparse=[[NSXMLParser alloc]initWithContentsOfURL:url];
    NSLog(@"the parser file is: %@",xmlparse);
    [xmlparse setDelegate:self];
    [xmlparse setShouldResolveExternalEntities:NO];
    [xmlparse parse];
}


- (void)parserDidStartDocument:(NSXMLParser *)parser{
    // sent when the parser begins parsing of the document.
    NSLog(@"------------------------");
    NSLog(@"parser - Start Document");
    NSLog(@"------------------------");
    
    bookArray = nil;
    bookArray = [[NSMutableArray alloc] init];
}


- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict
{
           //in this method does not enter
        NSLog(@"------------------------");
        NSLog(@"StartElement : %@",elementName);
        NSLog(@"------------------------");
    
    
        if ([elementName isEqualToString:@"root"])
        {
            bookObj = [[Book alloc] init];
        }
 
        if ([elementName isEqualToString:@"book"])
        {
            NSString *name=[attributeDict objectForKey:@"id"];
            NSLog(@" %@", name);
            [bookObj setBookID:name];
        }
        if ([elementName isEqualToString:@"author"])
        {
            NSString *name=[attributeDict objectForKey:@"name"];
            NSLog(@" %@", name);
            [bookObj setAuthor:name];
        }
        if ([elementName isEqualToString:@"title"])
        {
            NSString *name=[attributeDict objectForKey:@"title"];
            NSLog(@" %@", name);
            [bookObj setTitle:name];
        }
        if ([elementName isEqualToString:@"genre"])
        {
            NSString *name=[attributeDict objectForKey:@"genre"];
            NSLog(@" %@", name);
            [bookObj setGenre:name];
        }
        if ([elementName isEqualToString:@"price"])
        {
            NSString *name=[attributeDict objectForKey:@"price"];
            NSLog(@" %@", name);
            [bookObj setPrice:name];
        }
        if ([elementName isEqualToString:@"publish_date"])
        {
            NSString *name=[attributeDict objectForKey:@"publish"];
            NSLog(@" %@", name);
            [bookObj setPubDate:name];
        }
        
        if ([elementName isEqualToString:@"description"])
        {
            NSString *name=[attributeDict objectForKey:@"desc"];
            NSLog(@" %@", name);
            [bookObj setBookDesc:name];
        }

}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(nullable NSString *)namespaceURI qualifiedName:(nullable NSString *)qName{
    
    NSLog(@"************************");
    NSLog(@"End Element : %@",elementName);
    NSLog(@"************************");
    
    if ([elementName isEqualToString:@"root"])
    {
        [bookArray addObject:bookObj];
        bookObj = nil;
    }
}

- (void)parserDidEndDocument:(NSXMLParser *)parser{
// sent when the parser has completed parsing. If this is encountered, the parse was successful.
    NSLog(@"------------------------");
    NSLog(@"parser - End Document");
    NSLog(@"------------------------");
    
    NSLog(@"Book List : %@",bookArray);
    [self saveBooks];
}

- (IBAction)btnAction:(id)sender {
    [self parseXml];
}


-(BOOL)findBook:(Book*)obj{
    
    [_db open];
    FMResultSet *results = [_db executeQuery:@"SELECT * FROM Books where id= ?;",obj.bookID];

    if([results next]) {
        [_db close];
        return YES;
    }
    [_db close];
    return NO;
}

-(BOOL)updateBook:(Book*)obj{
    
    [_db open];
    return [_db executeUpdate:@"UPDATE Books set id= ?, author=?, title=?, genre=?, price=?, publish_date=?, description=? where id= ?;", obj.bookID, obj.author, obj.title, obj.genre, obj.price, obj.pubDate, obj.bookDesc, obj.bookID];
}

-(BOOL)insertBook:(Book*)obj{
   [_db open];
    return [_db executeUpdate:@"INSERT INTO Books (id, author, title, genre, price, publish_date, description) VALUES (?,?,?,?,?,?,?);", obj.bookID, obj.author, obj.title, obj.genre, obj.price, obj.pubDate, obj.bookDesc];
}

-(BOOL)deleteBook:(Book*)obj{
    [_db open];
    return [_db executeUpdate:@"DELETE FROM Books WHERE id = ?", obj.bookID];
}

-(void)saveBooks{
    
    NSLog(@"------------------------");
    NSLog(@"SQLite DB Insert / Update");
    NSLog(@"------------------------");

    
    [self createDatabaseIfNeeded];
    
    BOOL updaetStatus = NO;
    BOOL insertStatus = NO;
    for (Book *obj in bookArray) {
        if([self findBook:obj]){
            updaetStatus = [self updateBook:obj];
            NSLog(@"updaetStatus : %d",updaetStatus);
        }else{
            insertStatus = [self insertBook:obj];
            NSLog(@"insertStatus : %d",insertStatus);
        }
    }

    
    NSLog(@"**************************************");
    NSLog(@"**************************************");
    NSLog(@"        SQLite DB Get Books           ");
    NSLog(@"**************************************");
    NSLog(@"**************************************");
    
    FMResultSet *results = [_db executeQuery:@"SELECT * FROM Books"];
    NSMutableArray *savedBooks = [[NSMutableArray alloc] init];
    while([results next]) {
        Book *obj	= [[Book alloc] init];
        obj.bookID = [results stringForColumn:@"id"];
        obj.author = [results stringForColumn:@"author"];
        obj.title = [results stringForColumn:@"title"];
        obj.genre = [results stringForColumn:@"genre"];
        obj.price = [results stringForColumn:@"price"];
        obj.pubDate = [results stringForColumn:@"publish_date"];
        obj.bookDesc = [results stringForColumn:@"description"];
        [savedBooks addObject:obj];
        NSLog(@"BOOK ID : %@, Book Title : %@",obj.bookID, obj.title);
    }
    
    NSLog(@"No.of Books Count : %lu",(unsigned long)[savedBooks count]);
    [_db close];
    
    /*
    NSLog(@"**************************************");
    NSLog(@"**************************************");
    NSLog(@"SQLite DB Delete Books");
    NSLog(@"**************************************");
    NSLog(@"**************************************");
    
    for (Book *obj in bookArray) {
            BOOL deleteStatus = [self deleteBook:obj];
            NSLog(@"deleteStatus : %d",deleteStatus);
    }
    [_db close];
     */
}

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
