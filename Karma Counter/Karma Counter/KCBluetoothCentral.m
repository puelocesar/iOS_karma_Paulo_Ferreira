//
//  KCBluetoothCentral.m
//  Karma Counter
//
//  Created by Paulo Cesar Ferreira on 14/05/14.
//
//

#import "KCBluetoothCentral.h"

@implementation KCBluetoothCentral

CBCentralManager *centralManager;
CBUUID* karma_service_id;

-(id)init
{
    karma_service_id = [CBUUID UUIDWithString:UUID_SERVICE_STRING];
    centralManager = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
    
    return self;
}

//center part: this will receive the karma
- (void)centralManagerDidUpdateState:(CBCentralManager *)central
{
    [central scanForPeripheralsWithServices:@[karma_service_id] options:nil];
}

//needed to maintain a strong reference to the connected peripheral
CBPeripheral* p;

- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI
{
    p = peripheral;
    [central connectPeripheral:p options:nil];
}

- (void)centralManager:(CBCentralManager *)central
  didConnectPeripheral:(CBPeripheral *)peripheral {
    
    peripheral.delegate = self;
    [peripheral discoverServices:nil];
}

//delegate methods to peripheral
- (void)peripheral:(CBPeripheral *)peripheral
didDiscoverServices:(NSError *)error {
    
    for (CBService *service in peripheral.services) {
        if ([service.UUID isEqual:karma_service_id])
            [peripheral discoverCharacteristics:nil forService:service];
    }
}

CBCharacteristic *karma_characteristic;

- (void)peripheral:(CBPeripheral *)peripheral
didDiscoverCharacteristicsForService:(CBService *)service
             error:(NSError *)error {
    
    for (CBCharacteristic *characteristic in service.characteristics) {
        karma_characteristic = characteristic;
        NSLog(@"characterisc is ok");
    }
}

- (void)send_karma
{
    int i = 1;
    NSData* value = [NSData dataWithBytes:&i length:sizeof(i)];
    
    [p writeValue:value forCharacteristic:karma_characteristic
                      type:CBCharacteristicWriteWithResponse];
}

- (void)peripheral:(CBPeripheral *)peripheral
didWriteValueForCharacteristic:(CBCharacteristic *)characteristic
             error:(NSError *)error {
    
    if (error) {
        NSLog(@"Error writing characteristic value: %@",
              [error debugDescription]);
    }
    else {
        NSLog(@"value wrote with success");
    }
}

@end
