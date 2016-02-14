//
//  SHPrivilegedKiller.m
//  Killer
//
//  Created by Guilherme Rambo on 14/02/16.
//  Copyright © 2016 Guilherme Rambo. All rights reserved.
//

#import "SHPrivilegedKiller.h"

@implementation SHPrivilegedKiller
{
    AuthorizationRef _authorization;
}

- (BOOL)requestAuthorization
{
    // Create authorization reference
    OSStatus status;
    
    // AuthorizationCreate and pass NULL as the initial
    // AuthorizationRights set so that the AuthorizationRef gets created
    // successfully, and then later call AuthorizationCopyRights to
    // determine or extend the allowable rights.
    // http://developer.apple.com/qa/qa2001/qa1172.html
    status = AuthorizationCreate(NULL, kAuthorizationEmptyEnvironment, kAuthorizationFlagDefaults, &_authorization);
    if (status != errAuthorizationSuccess)
    {
        NSLog(@"Error Creating Initial Authorization: %d", status);
        return NO;
    }
    
    // kAuthorizationRightExecute == "system.privilege.admin"
    AuthorizationItem right = {kAuthorizationRightExecute, 0, NULL, 0};
    AuthorizationRights rights = {1, &right};
    AuthorizationFlags flags = kAuthorizationFlagDefaults | kAuthorizationFlagInteractionAllowed |
    kAuthorizationFlagPreAuthorize | kAuthorizationFlagExtendRights;
    
    // Call AuthorizationCopyRights to determine or extend the allowable rights.
    status = AuthorizationCopyRights(_authorization, &rights, NULL, flags, NULL);
    if (status != errAuthorizationSuccess)
    {
        NSLog(@"Copy Rights Unsuccessful: %d", status);
        return NO;
    }
    
    return YES;
}

- (BOOL)killProcessNamed:(NSString *__nonnull)processName
{
    OSStatus status;
    
    char *tool = "/usr/bin/killall";
    char *argv[] = {"-HUP", (char *)[processName UTF8String]};
    FILE *pipe = NULL;
    
    status = AuthorizationExecuteWithPrivileges(_authorization, tool, kAuthorizationFlagDefaults, argv, &pipe);
    if (status != errAuthorizationSuccess)
    {
        NSLog(@"Error: %d", status);
        return NO;
    }
    
    return YES;
}

- (void)dealloc
{
    // The only way to guarantee that a credential acquired when you
    // request a right is not shared with other authorization instances is
    // to destroy the credential.  To do so, call the AuthorizationFree
    // function with the flag kAuthorizationFlagDestroyRights.
    // http://developer.apple.com/documentation/Security/Conceptual/authorization_concepts/02authconcepts/chapter_2_section_7.html
    AuthorizationFree(_authorization, kAuthorizationFlagDestroyRights);
}

@end
