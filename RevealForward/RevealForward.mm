//
//  RevealForward.mm
//  RevealForward
//
//  Created by monkey on 16/8/26.
//  Copyright (c) 2016年 __MyCompanyName__. All rights reserved.
//

#import "BonjourManager.h"

static __attribute__((constructor))
void RevealForardInit(){
    [[BonjourManager sharedManager] start];
}
