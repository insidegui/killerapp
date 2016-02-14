//
//  SHKiller.h
//  Killer
//
//  Created by Guilherme Rambo on 14/02/16.
//  Copyright © 2016 Guilherme Rambo. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SHKillerProtocol <NSObject>

- (BOOL)killProcessNamed:(NSString *__nonnull)processName;

@optional
- (BOOL)requestAuthorization;

@end

@interface SHKiller : NSObject <SHKillerProtocol>
@end
