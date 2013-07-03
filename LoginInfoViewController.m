//
//  LoginInfoViewController.m
//  loginUsernamePassword
//
//  Created by Weerachai on 12/10/55 BE.
//  Copyright (c) 2555 Weerachai. All rights reserved.
//

#import "LoginInfoViewController.h"

@interface LoginInfoViewController ()

@end

@implementation LoginInfoViewController

@synthesize receivedData;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //sMemberID=1
    NSMutableString *post = [NSString stringWithFormat:@"sMemberID=%@",[self.sMemberID description]];
    
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
    
    NSURL *url = [NSURL URLWithString:@"http://www.thaicreate.com/url/getUserByMemberID.php"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                     cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                     timeoutInterval:10.0];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
  [request setHTTPBody:postData];
    
    NSURLConnection *theConnection=[[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    
    
    if (theConnection) {
        self.receivedData = [[NSMutableData data] retain];
    } else {
		UIAlertView *connectFailMessage = [[UIAlertView alloc] initWithTitle:@"NSURLConnection " message:@"Failed in viewDidLoad"  delegate: self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
		[connectFailMessage show];
		[connectFailMessage release];
    }
    
}


- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [receivedData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [receivedData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    
    [connection release];
    [receivedData release];
    
    // inform the user
    UIAlertView *didFailWithErrorMessage = [[UIAlertView alloc] initWithTitle: @"NSURLConnection " message: @"didFailWithError"  delegate: self cancelButtonTitle: @"Ok" otherButtonTitles: nil];
    [didFailWithErrorMessage show];
    [didFailWithErrorMessage release];
	
    //inform the user
    NSLog(@"Connection failed! Error - %@", [error localizedDescription]);
    
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    // Return Status E.g : { "MemberID":"1", "Username":"weerachai", "Password":"weerachai@1" , "Name":"Weerachai Nukitram" , "Email":", "Password":"Login Successfully" " , "Tel":"0819876107" }
    
    if(receivedData)
    {
        //NSLog(@"%@",receivedData);
        
        //NSString *dataString = [[NSString alloc] initWithData:receivedData encoding:NSASCIIStringEncoding];
        //NSLog(@"%@",dataString);
        
        id jsonObjects = [NSJSONSerialization JSONObjectWithData:receivedData options:NSJSONReadingMutableContainers error:nil];
        
        // value in key name
        NSString *strMemberID = [jsonObjects objectForKey:@"MemberID"];
        NSString *strUsername = [jsonObjects objectForKey:@"Username"];
        NSString *strPassword = [jsonObjects objectForKey:@"Password"];
        NSString *strName = [jsonObjects objectForKey:@"Name"];
        NSString *strTel = [jsonObjects objectForKey:@"Tel"];
        NSString *strEmail = [jsonObjects objectForKey:@"Email"];
        NSLog(@"MemberID = %@",strMemberID);
        NSLog(@"Username = %@",strUsername);
        NSLog(@"Password = %@",strPassword);
        NSLog(@"Name = %@",strName);
        NSLog(@"Tel = %@",strTel);
        NSLog(@"Email = %@",strEmail);
        
        lblMemberID.text = strMemberID;
        lblUsername.text = strUsername;
        lblPassword.text = strPassword;
        lblName.text = strName;
        lblTel.text = strTel;
        lblEmail.text = strEmail;
        
    }
    
    // release the connection, and the data object
    [connection release];
    [receivedData release];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [lblMemberID release];
    [lblPassword release];
    [lblUsername release];
    [lblPassword release];
    [lblName release];
    [lblTel release];
    [lblEmail release];
    [super dealloc];
}
@end
