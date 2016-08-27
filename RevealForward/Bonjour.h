//
//  Bonjour.h
//  RevealForward
//
//  Created by monkey on 16/8/26.
//
//

#import <Foundation/Foundation.h>

@interface Bonjour : NSObject

@property (nonatomic, strong) NSNetService *service;

@property (nonatomic, strong) NSString *ip;

@property (nonatomic, strong) NSDictionary *txtRecord;

-(void)output;

@end
