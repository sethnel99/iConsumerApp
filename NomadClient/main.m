//
//  main.m
//  NomadClient
//
//  Created by Farley User on 2/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AppDelegate.h"
#import "Parse/Parse.h"

int main(int argc, char *argv[])
{
    [Parse setApplicationId:@"FoX2hKFWtiUIWgt2mioFIJvwdwgy461XAS7n367S" 
                  clientKey:@"EU6d1ccuc3rUiW09IXqnLGF8XNngazVCWZDvSfC1"];
    
    @autoreleasepool {
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
