//
//  ViewController.m
//  loginUsernamePassword
//
//  Created by Weerachai on 12/10/55 BE.
//  Copyright (c) 2555 Weerachai. All rights reserved.
//

#import "ViewController.h"
#import "LoginInfoViewController.h"

@interface ViewController ()
{
    UIAlertView *loading;
}

@end

@implementation ViewController

@synthesize receivedData;

- (void)viewDidLoad
{
    [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)btnLogin:(id)sender {
    
    // Show Progress Loading...
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    loading = [[UIAlertView alloc] initWithTitle:@"" message:@"Login Checking..." delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
    UIActivityIndicatorView *progress= [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(125, 50, 30, 30)];
    progress.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
    [loading addSubview:progress];
    [progress startAnimating];
    [progress release];
    [loading show];
    

    //sUsername=weerachai&sPassword=weerachai@1"
    NSMutableString *post = [NSString stringWithFormat:@"sUsername=%@&sPassword=%@",[txtUsername text],[txtPassword text]];
    
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
    
    NSURL *url = [NSURL URLWithString:@"http://www.thaicreate.com/url/checkLogin.php"];
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
    sleep(3);
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
    // Hide Progress
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [loading dismissWithClickedButtonIndex:0 animated:YES];
    
    // Return Status E.g : { "Status":"1", "MemberID":"1", "Message":"Login Successfully" }
    // 0 = Error
    // 1 = Completed
    
    if(receivedData)
    {
        //NSLog(@"%@",receivedData);
        
        //NSString *dataString = [[NSString alloc] initWithData:receivedData encoding:NSASCIIStringEncoding];
        //NSLog(@"%@",dataString);
        
        id jsonObjects = [NSJSONSerialization JSONObjectWithData:receivedData options:NSJSONReadingMutableContainers error:nil];
        
        // value in key name
        NSString *strStatus = [jsonObjects objectForKey:@"Status"];
        NSString *strMemberID = [jsonObjects objectForKey:@"MemberID"];
        NSString *strMessage = [jsonObjects objectForKey:@"Message"];
        NSLog(@"Status = %@",strStatus);
        NSLog(@"MemberID = %@",strMemberID);
        NSLog(@"Message = %@",strMessage);
        
        // Login Completed
        if( [strStatus isEqualToString:@"1"] ){
            /*
            UIAlertView *completed =[[UIAlertView alloc]
                                     initWithTitle:@"<img src="/images/bbcode/smile.gif?v=1001" align="absmiddle"> Completed!"
                                     message:strMessage delegate:self
                                     cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [completed show];
             */
            
            
            LoginInfoViewController *viewInfo = [[[LoginInfoViewController alloc] initWithNibName:nil bundle:nil] autorelease];
            viewInfo.sMemberID = strMemberID;
            [self presentViewController:viewInfo animated:NO completion:NULL];
            
        }
        else // Login Failed
        {
            UIAlertView *error =[[UIAlertView alloc]
                                 initWithTitle:@":( Error!"
                                 message:strMessage delegate:self
                                 cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [error show];
        }
        
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
    [txtUsername release];
    [txtPassword release];
    [super dealloc];
}

@end
