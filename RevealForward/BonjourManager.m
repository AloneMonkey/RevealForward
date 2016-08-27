//
//  BonjourManager.m
//  RevealForward
//
//  Created by monkey on 16/8/26.
//
//

#import "BonjourManager.h"

@interface BonjourManager()<NSNetServiceBrowserDelegate,NSNetServiceDelegate>

@property (nonatomic, strong) NSNetServiceBrowser* netBrower;

@property (nonatomic, strong) NSMutableDictionary* services;

@property (nonatomic, strong) NSString* hostName;

@end

@implementation BonjourManager

+(instancetype)sharedManager{
    static dispatch_once_t onceToken = 0;
    static BonjourManager *sharedObject = nil;
    dispatch_once(&onceToken, ^{
        sharedObject = [[BonjourManager alloc] init];
    });
    
    return sharedObject;
}

-(instancetype)init{
    self = [super init];
    if(self){
        _netBrower = [NSNetServiceBrowser new];
        _netBrower.delegate = self;
        
        _services = [NSMutableDictionary dictionary];
    }
    
    return self;
}

-(void)start{
    [_netBrower searchForServicesOfType:@"_reveal._tcp" inDomain:@"local"];
}

#pragma mark - NSNetServiceBrowserDelegate

-(void)netServiceBrowser:(NSNetServiceBrowser *)browser didNotSearch:(NSDictionary<NSString *,NSNumber *> *)errorDict{
    NSLog(@"<RevealForward>: Search Bonjour Service Failed!");
}

-(void)netServiceBrowser:(NSNetServiceBrowser *)browser didFindService:(NSNetService *)service moreComing:(BOOL)moreComing{
    Bonjour *bonjour = [Bonjour new];
    bonjour.service = service;
    _services[service.name] = bonjour;
    
    service.delegate = self;
    [service startMonitoring];
    [service resolveWithTimeout:5.0];
}

-(void)netServiceBrowser:(NSNetServiceBrowser *)browser didRemoveService:(NSNetService *)service moreComing:(BOOL)moreComing{
    if([_services.allKeys containsObject:service.name]){
        [_services removeObjectForKey:service.name];
    }
}

#pragma mark - NSNetServiceDelegate

-(void)netServiceDidResolveAddress:(NSNetService *)sender{
    if([_services.allKeys containsObject:sender.name]){
        Bonjour* bonjour = _services[sender.name];
        [bonjour setIp:[BonjourUtils queryIPAddressByHost:sender.hostName]];
        [bonjour output];
    }
}

-(void)netService:(NSNetService *)sender didUpdateTXTRecordData:(NSData *)data{
    if([_services.allKeys containsObject:sender.name]){
        Bonjour* bonjour = _services[sender.name];
        [bonjour setTxtRecord:[NSNetService dictionaryFromTXTRecordData:data]];
        [bonjour output];
    }
}

@end
