//
//  SHKiller.m
//  Killer
//
//  Created by Guilherme Rambo on 14/02/16.
//  Copyright © 2016 Guilherme Rambo. All rights reserved.
//

#import "SHKiller.h"

@implementation SHKiller

- (BOOL)killProcessNamed:(NSString *__nonnull)processName
{
    NSTask *task = [[NSTask alloc] init];
    task.launchPath = @"/usr/bin/killall";
    task.arguments = @[@"-HUP", processName];
    task.standardError = [NSPipe pipe];
    task.standardOutput = [NSPipe pipe];
    [task launch];
    [task waitUntilExit];

    return (task.terminationStatus == 0);
}

@end
