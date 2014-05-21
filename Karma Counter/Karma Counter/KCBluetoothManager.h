//
//  KCBluetoothManager.h
//  Karma Counter
//
//  Created by Paulo Cesar Ferreira on 14/05/14.
//
//

#import <Foundation/Foundation.h>
#import "KCBluetoothCentral.h"

@interface KCBluetoothManager : NSObject

- (void)sendKarmaWithPeripheral: (CBPeripheral*) peripheral;

- (void)setPeripheralDelegate: (id <KCBluetoothPeripheralDelegate>) delegate andName: (NSString *) name;

- (void) setRegisteredDevicesDelegate: (id <KCBluetoothCentralDelegate>) delegate;

@end
