//
//  RRAppDelegate.h
//  iTahDoodle
//
//  Created by Arun Agrawal on 27/10/13.
//  Copyright (c) 2013 Arun Agrawal. All rights reserved.
//

#import <UIKit/UIKit.h>

NSString *docPath(void);

@interface RRAppDelegate : UIResponder <UIApplicationDelegate>

{
    UITableView *taskTable;
    UITextField *taskField;
    UIButton    *insertButton;
    
    NSMutableArray *tasks;
    
}

- (void)addTask:(id)sender;

@property (strong, nonatomic) UIWindow *window;

@end
