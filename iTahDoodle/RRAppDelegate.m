//
//  RRAppDelegate.m
//  iTahDoodle
//
//  Created by Arun Agrawal on 27/10/13.
//  Copyright (c) 2013 Arun Agrawal. All rights reserved.
//

#import "RRAppDelegate.h"

NSString *docPath()
{
    NSArray *pathList = NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory,
                                                            NSUserDomainMask, YES);
    return [[pathList objectAtIndex:0] stringByAppendingPathComponent:@"data.td"];
    
}

@implementation RRAppDelegate

#pragma Table view management

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [tasks count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *c = [taskTable dequeueReusableCellWithIdentifier:@"Cell"];
    
    if (!c) {
        c = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    
    NSString *item = [tasks objectAtIndex:[indexPath row]];
    [[c textLabel] setText:item];
    
    return c;
}


#pragma Application delegate callbacks

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    NSArray *plist = [NSArray arrayWithContentsOfFile:docPath()];
    
    if (plist) {
        tasks = [plist mutableCopy];
        
    }else {
        tasks = [[NSMutableArray alloc] init];
    }
    
    if ([tasks count] == 0) {
        [tasks addObject:@"Walk the dogs"];
        [tasks addObject:@"Walk the dogs 2"];
        [tasks addObject:@"Walk the dogs 3"];
        
    }
        
    CGRect tableFrame = CGRectMake(0, 80, 320, 380);
    CGRect fieldFrame = CGRectMake(20, 40, 200, 31);
    CGRect buttonFrame = CGRectMake(228, 40, 72, 31);
    
    taskTable = [[UITableView alloc] initWithFrame:tableFrame
                                             style:UITableViewStylePlain];
    
    [taskTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    [taskTable setDataSource:self];
    
    taskField = [[UITextField alloc] initWithFrame:fieldFrame];
    
    [taskField setBorderStyle:UITextBorderStyleRoundedRect];
    [taskField setPlaceholder:@"Type a task, tap insert"];
    
    insertButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [insertButton setFrame:buttonFrame];
    
    
    [insertButton addTarget:self
                     action:@selector(addTask:)
           forControlEvents:UIControlEventTouchUpInside];
    
    [insertButton setTitle:@"Insert" forState:UIControlStateNormal];
  
    // This line things make working with iOS7
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    [[self window] addSubview:taskTable];
    [[self window] addSubview:taskField];
    [[self window] addSubview:insertButton];
    
    [[self window] setBackgroundColor:[UIColor whiteColor]];
    [[self window] makeKeyAndVisible];
    
    return YES;
}

- (void)addTask:(id)sender
{
    NSString *t = [taskField text];
    
    if ([t isEqualToString:@""]) {
        return;
    }
    
    [tasks addObject:t];
    [taskTable reloadData];
    [taskField setText:@""];
    [taskField resignFirstResponder];
    
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    [tasks writeToFile:docPath() atomically:YES];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    [tasks writeToFile:docPath() atomically:YES];
}

@end
