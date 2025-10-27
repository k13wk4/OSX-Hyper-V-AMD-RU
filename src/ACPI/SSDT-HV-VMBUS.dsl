/** @file
 * Copyright (c)2021-2025, Goldfish64. All rights reserved.
 * SPDX-License-Identifier: BSD-3-Clause
 **/

/*
 * SSDT VMBUS Hyper-V для корректной идентификации узлов ACPI.
 *
 * AppleACPIPlatform требует стандартные значения _HID для корректной генерации
 * EFI пути устройств и не совместим с дефолтными строковыми значениями Hyper-V.
 *
 * Требует следующие ACPI патчи:
 * (1) Base: \_SB.VMOD
 * Comment: _HID to XHID rename (Hyper-V VMOD)
 * Count:1
 * Find:5F484944 (_HID)
 * Replace:58484944 (XHID)
 * TableSignature:44534454 (DSDT)
 * (2) Base: \_SB.VMOD.VMBS
 * Comment: _HID to XHID rename (Hyper-V VMBus)
 * Count:1
 * Find:5F484944 (_HID)
 * Replace:58484944 (XHID)
 * TableSignature:44534454 (DSDT)
 */
DefinitionBlock ("", "SSDT",2, "ACDT", "HVVMBUS",0x00000000)
{
 	External (\_SB.VMOD, DeviceObj)
 	External (\_SB.VMOD.XHID, MethodObj)
 	External (\_SB.VMOD.VMBS, DeviceObj)
 	External (\_SB.VMOD.VMBS.XHID, MethodObj)
 	
 	Scope (\_SB.VMOD)
 	{
 		Method (_HID,0, NotSerialized)
 		{
 			If (_OSI ("Darwin"))
 			{
 				Return (EisaId ("VMD0001"))
 			}
 			
 			Return (\_SB.VMOD.XHID())
 		}
 	}
 	
 	Scope (\_SB.VMOD.VMBS)
 	{
 		Method (_HID,0, NotSerialized)
 		{
 			If (_OSI ("Darwin"))
 			{
 				Return (EisaId ("VBS0001"))
 			}
 			
 			Return (\_SB.VMOD.VMBS.XHID())
 		}
 	}
}