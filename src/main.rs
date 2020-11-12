#![no_std]
#![no_main]
#![feature(naked_functions, alloc_error_handler)]

// ----- Panic Handler -----

use core::panic::PanicInfo;

#[panic_handler]
fn panic(_info: &PanicInfo) -> ! {
    loop {}
}

// ----- Allocator -----
extern crate alloc;
use linked_list_allocator::LockedHeap;
use core::alloc::Layout;

#[global_allocator]
static ALLOCATOR: LockedHeap = LockedHeap::empty();

#[alloc_error_handler]
fn on_alloc_error(_layout: Layout) -> ! {
    loop {}
}

// ----- Main Code -----

#[no_mangle]
#[naked]
pub unsafe extern "C" fn _start() -> ! {
    ALLOCATOR.lock().init(0xC0, 0x100);
    loop {}
}
