-- Test Users
INSERT INTO "Users" (id, email, "name", role, "createdAt", "updatedAt", "isActive")
VALUES 
  (1, 'parent@test.com', 'Ahmet Yilmaz', 'Parent', NOW(), NOW(), true),
  (2, 'child@test.com', 'Mehmet Yilmaz', 'Child', NOW(), NOW(), true),
  (3, 'parent2@test.com', 'Ayşe Kaya', 'Parent', NOW(), NOW(), true),
  (4, 'child2@test.com', 'Zeynep Kaya', 'Child', NOW(), NOW(), true);

-- Test Devices
INSERT INTO "Devices" (id, "userId", "deviceName", "deviceId", "deviceType", status, "lastSeen", "createdAt", "updatedAt")
VALUES 
  (1, 1, 'Ahmet Telefonu', 'device_001', 'ParentDevice', 'Active', NOW(), NOW(), NOW()),
  (2, 2, 'Mehmet Telefonu', 'device_002', 'ChildDevice', 'Active', NOW(), NOW(), NOW()),
  (3, 3, 'Ayşe Tablet', 'device_003', 'ParentDevice', 'Active', NOW(), NOW(), NOW()),
  (4, 4, 'Zeynep Telefonu', 'device_004', 'ChildDevice', 'Active', NOW(), NOW(), NOW());
