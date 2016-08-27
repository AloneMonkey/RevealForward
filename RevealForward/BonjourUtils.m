//
//  BonjourUtils.m
//  RevealForward
//
//  Created by monkey on 16/8/26.
//
//

#import <netdb.h>
#import <ifaddrs.h>
#import <arpa/inet.h>
#import "BonjourUtils.h"

@implementation BonjourUtils

+(NSString *)queryIPAddressByHost:(NSString *)hostName{
    NSString* result = nil;
    
    struct hostent *ipaddr = gethostbyname([hostName UTF8String]);
    char *addr = ipaddr->h_addr_list[0];
    
    if(strlen(addr) >= 4){
        result = [NSString stringWithFormat:@"%u.%u.%u.%u", (unsigned char)addr[0], (unsigned char)addr[1], (unsigned char)addr[2], (unsigned char)addr[3]];
    }
    
    if(result == nil){
        result = [self deviceIPAddress];
    }
    
    return result;
}

+ (NSString*) deviceIPAddress{
    int state = 0;
    NSString *address = @"getIP-Error";
    
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *tmp = NULL;
    
    state = getifaddrs(&interfaces);
    
    if(state == 0){
        tmp = interfaces;
        
        while (tmp != NULL) {
            if(tmp->ifa_addr->sa_family == AF_INET){
                if([[NSString stringWithUTF8String:tmp->ifa_name] isEqualToString:@"en0"]) {
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)tmp->ifa_addr)->sin_addr)];
                }
            }
            tmp = tmp->ifa_next;
        }
    }
    freeifaddrs(interfaces);
    return address;
}

@end
