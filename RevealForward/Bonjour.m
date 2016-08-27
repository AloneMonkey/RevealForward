//
//  Bonjour.m
//  RevealForward
//
//  Created by monkey on 16/8/26.
//
//

#import "Bonjour.h"

static BOOL done = NO;

@implementation Bonjour{
    
}

- (NSString *)formatedTxtRecord {
    NSMutableString *mutableString = [NSMutableString string];
    [_txtRecord enumerateKeysAndObjectsUsingBlock:^(NSString *key, NSData *obj, BOOL * __nonnull stop) {
        NSString *value = [[NSString alloc] initWithData:obj encoding:NSUTF8StringEncoding];
        [mutableString appendFormat:@" \"%@=%@\"", key, value];
    }];
    return mutableString;
}

-(void)output{
    if(!done && _service.hostName.length > 0 && _service.port > 0 && _ip.length > 0 && _txtRecord.count > 0 ){
        done = YES;
        NSLog(@"\n--------------------Bonjour Run:--------------------\ndns-sd -P %@ _reveal._tcp local %@ %@ %@ %@\n----------------------------------------------------", _service.name, @(_service.port), _ip, _ip, [self formatedTxtRecord]);
    }
}

@end
