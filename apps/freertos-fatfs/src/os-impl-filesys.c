/*
 * Copyright 2021 Patrick Paul
 * SPDX-License-Identifier: MIT-0
 */

#include <string.h>
#include <unistd.h>
#include <sys/types.h>
#include "common_types.h"
#include "osapi.h"
#include "osapi-os-core.h"
#include "osapi-os-filesys.h"
#include "os-shared-globaldefs.h"
#include "os-freertos.h"

// freertos-plus-fat
#include "portable/common/ff_ramdisk.h"
#include "include/ff_stdio.h"
#include "include/ff_headers.h"

// mission files embedded in binary via targets.cmake
extern const char STARTUP_SCR_DATA[];
extern const unsigned long STARTUP_SCR_SIZE;

// defines
#define RAMDISK_SECTOR_SIZE 512
#define RAMDISK_SECTORS 400  // each sector is 512 bytes per ff_ramdisk.h
#define RAMDISK_CACHE_SIZE 2048  // must be multiple of sector size, and at least twice as big

// ramdisk -- ephemeral, will be initialized empty in FF_RAMDiskInit
FF_Disk_t pxDiskRAM;
uint8_t rambuffer[RAMDISK_SECTORS * RAMDISK_SECTOR_SIZE];

// work in progress
int32 OS_FreeRTOS_FileSysAPI_Impl_Init(void){
    // verify cache size is multiple and at least twice as a big as sector size
    configASSERT( (RAMDISK_CACHE_SIZE % RAMDISK_SECTOR_SIZE) == 0 );
    configASSERT( (RAMDISK_CACHE_SIZE >= (2 * RAMDISK_SECTOR_SIZE)) );

    // impl detail: FF_RAMDiskInit zero-initializes and formats new partition
    // and mounts at "/cf" parameter
    pxDiskRAM = *FF_RAMDiskInit(
        "/cf",
        (uint8_t *) rambuffer,
        RAMDISK_SECTORS,
        RAMDISK_CACHE_SIZE
    );
    configASSERT(&pxDiskRAM);

    // name the volume
    sprintf(
        pxDiskRAM.pxIOManager->xPartition.pcVolumeLabel,
        "ramdisk1"
    );

    FF_RAMDiskShowPartition(&pxDiskRAM);

    return OS_SUCCESS;
}

int32 devel_breakpoint(void){
    return OS_SUCCESS;
}

// @FIXME not implemented and returning OS_SUCCESS
int32 OS_FileAPI_Init(void){
    return devel_breakpoint();
}
int32 OS_FileSysAPI_Init(void){
    return devel_breakpoint();
}
int32 OS_DirAPI_Init(void){
    return devel_breakpoint();
}
int32 OS_FreeRTOS_DirAPI_Impl_Init(void){
    return devel_breakpoint();
}
int32 OS_mkfs(char *address, const char *devname, const char *volname, size_t blocksize, osal_blockcount_t numblocks){
    return devel_breakpoint();
}
int32 OS_initfs(char *address, const char *devname, const char *volname, size_t blocksize, osal_blockcount_t numblocks){
    return devel_breakpoint();
}
int32 OS_mount(const char *devname, const char *mountpoint){
    return devel_breakpoint();
}
int32 OS_rmfs(const char *devname){
    return devel_breakpoint();
}
int32 OS_unmount(const char *mountpoint){
    return devel_breakpoint();
}

// @FIXME not implemented and returning OS_ERROR
int32 OS_DirectoryClose(osal_id_t dir_id){
    return -1;
}
int32 OS_OpenCreate(osal_id_t *filedes, const char *path, int32 flags, int32 access){
    return -1;
}
int32 OS_close(osal_id_t filedes){
    return -1;
}
int32 OS_fsBlocksFree(const char *name){
    return -1;
}
int32 OS_lseek(osal_id_t filedes, int32 offset, uint32 whence){
    return -1;
}
int32 OS_read(osal_id_t filedes, void *buffer, size_t nbytes){
    return -1;
}
int32 OS_remove(const char *path){
    return -1;
}
int32 OS_stat(const char *path, os_fstat_t *filestats){
    return -1;
}
int32 OS_write(osal_id_t filedes, const void *buffer, size_t nbytes){
    return -1;
}