//
//  BonjourManager.h
//  RevealForward
//
//  Created by monkey on 16/8/26.
//
//

#import "Bonjour.h"
#import "BonjourUtils.h"
#import <Foundation/Foundation.h>

@interface BonjourManager : NSObject

+ (instancetype)sharedManager;

-(void)start;

@end
