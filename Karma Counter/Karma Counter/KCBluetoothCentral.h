//
//  KCBluetoothCentral.h
//  Karma Counter
//
//  Created by Paulo Cesar Ferreira on 14/05/14.
//
//

#import <Foundation/Foundation.h>
#import "KCBluetoothPeripheral.h"

@interface KCBluetoothCentral : NSObject <CBCentralManagerDelegate, CBPeripheralDelegate>

//TODO: select the peripheral that will receive
- (void)send_karma;

@end
