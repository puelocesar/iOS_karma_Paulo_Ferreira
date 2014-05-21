//
//  KCBluetoothCentral.h
//  Karma Counter
//
//  Created by Paulo Cesar Ferreira on 14/05/14.
//
//

#import <Foundation/Foundation.h>
#import "KCBluetoothPeripheral.h"
#import "KCAvatarData.h"

@protocol KCBluetoothCentralDelegate <NSObject>
- (void)registeredNewPeripheral: (KCAvatarData*) data;
@end

@interface KCBluetoothCentral : NSObject <CBCentralManagerDelegate, CBPeripheralDelegate>

@property (nonatomic, weak) id <KCBluetoothCentralDelegate> delegate;
@property (nonatomic, strong) NSMutableDictionary* peripherals;

- (void)sendKarmaWithPeripheral: (CBPeripheral*) peripheral;

@end
