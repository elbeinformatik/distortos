/**
 * \file
 * \brief Linker script for ST,32F769IDISCOVERY board with ST,STM32F769NI chip:
 * - 2.0 MiB of flash at 0x8000000 (VMA 0x200000);
 * - 16.0 KiB of itcm at 0x0;
 * - 512.0 KiB of sram at 0x20000000;
 * - 4.0 KiB of bkpsram at 0x40024000;
 *
 * \author Copyright (C) 2014-2017 Kamil Szczygiel http://www.distortec.com http://www.freddiechopin.info
 *
 * \par License
 * This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not
 * distributed with this file, You can obtain one at http://mozilla.org/MPL/2.0/.
 *
 * \warning
 * Automatically generated file - do not edit!
 */

#include "distortos/distortosConfiguration.h"

SEARCH_DIR(.);
OUTPUT_FORMAT("elf32-littlearm", "elf32-bigarm", "elf32-littlearm");
OUTPUT_ARCH(arm);

/*---------------------------------------------------------------------------------------------------------------------+
| stacks sizes
+---------------------------------------------------------------------------------------------------------------------*/

PROVIDE(__main_stack_size =
		ALIGN(CONFIG_ARCHITECTURE_ARMV6_M_ARMV7_M_MAIN_STACK_SIZE, CONFIG_ARCHITECTURE_STACK_ALIGNMENT));

PROVIDE(__process_stack_size = ALIGN(CONFIG_MAIN_THREAD_STACK_SIZE, CONFIG_ARCHITECTURE_STACK_ALIGNMENT) +
		ALIGN(CONFIG_STACK_GUARD_SIZE, CONFIG_ARCHITECTURE_STACK_ALIGNMENT));

/*---------------------------------------------------------------------------------------------------------------------+
| available memories
+---------------------------------------------------------------------------------------------------------------------*/

MEMORY
{
	flash : org = 0x8000000, len = 2097152
	flashVma : org = 0x200000, len = 2097152
	itcm : org = 0x0, len = 16384
	sram : org = 0x20000000, len = 524288
	bkpsram : org = 0x40024000, len = 4096
}

PROVIDE(__flash_start = ORIGIN(flash));
PROVIDE(__flash_size = LENGTH(flash));
PROVIDE(__flash_end = ORIGIN(flash) + LENGTH(flash));

PROVIDE(__itcm_start = ORIGIN(itcm));
PROVIDE(__itcm_size = LENGTH(itcm));
PROVIDE(__itcm_end = ORIGIN(itcm) + LENGTH(itcm));
HIDDEN(__itcm_limit_low = ORIGIN(itcm));
HIDDEN(__itcm_limit_high = ORIGIN(itcm) + LENGTH(itcm));

PROVIDE(__sram_start = ORIGIN(sram));
PROVIDE(__sram_size = LENGTH(sram));
PROVIDE(__sram_end = ORIGIN(sram) + LENGTH(sram));
HIDDEN(__sram_limit_low = ORIGIN(sram));
HIDDEN(__sram_limit_high = ORIGIN(sram) + LENGTH(sram));

PROVIDE(__bkpsram_start = ORIGIN(bkpsram));
PROVIDE(__bkpsram_size = LENGTH(bkpsram));
PROVIDE(__bkpsram_end = ORIGIN(bkpsram) + LENGTH(bkpsram));
HIDDEN(__bkpsram_limit_low = ORIGIN(bkpsram));
HIDDEN(__bkpsram_limit_high = ORIGIN(bkpsram) + LENGTH(bkpsram));

/*---------------------------------------------------------------------------------------------------------------------+
| entry point
+---------------------------------------------------------------------------------------------------------------------*/

ENTRY(Reset_Handler);

/*---------------------------------------------------------------------------------------------------------------------+
| put data in sections
+---------------------------------------------------------------------------------------------------------------------*/

SECTIONS
{
	.text :
	{
		PROVIDE(__text_start = .);

		/* sub-section: .vectors */

		PROVIDE(__vectors_start = .);

		KEEP(*(.coreVectors));
		KEEP(*(.chipVectors));

		PROVIDE(__vectors_end = .);

		/* end of sub-section: .vectors */

		*(.text.unlikely .text.*_unlikely .text.unlikely.*);
		*(.text.exit .text.exit.*);
		*(.text.startup .text.startup.*);
		*(.text.hot .text.hot.*);
		*(.text .stub .text.* .gnu.linkonce.t.*);
		*(.gnu.warning);
		*(.glue_7t);
		*(.glue_7);
		*(.vfp11_veneer);
		*(.v4_bx);
		*(.rodata .rodata.* .gnu.linkonce.r.*);
		*(.ARM.extab* .gnu.linkonce.armextab.*);
		*(.eh_frame_hdr);
		*(.eh_frame_entry .eh_frame_entry.*);
		KEEP(*(.eh_frame));
		*(.eh_frame.*);
		*(.gcc_except_table .gcc_except_table.*);
		*(.gnu_extab*);

		/* sub-section: data_array */

		. = ALIGN(4);
		PROVIDE(__data_array_start = .);

		LONG(LOADADDR(.data)); LONG(ADDR(.data)); LONG(ADDR(.data) + SIZEOF(.data));
		LONG(LOADADDR(.itcm.data)); LONG(ADDR(.itcm.data)); LONG(ADDR(.itcm.data) + SIZEOF(.itcm.data));
		LONG(LOADADDR(.sram.data)); LONG(ADDR(.sram.data)); LONG(ADDR(.sram.data) + SIZEOF(.sram.data));
		LONG(LOADADDR(.bkpsram.data)); LONG(ADDR(.bkpsram.data)); LONG(ADDR(.bkpsram.data) + SIZEOF(.bkpsram.data));

		. = ALIGN(4);
		PROVIDE(__data_array_end = .);

		/* end of sub-section: data_array */

		/* sub-section: bss_array */

		. = ALIGN(4);
		PROVIDE(__bss_array_start = .);

		LONG(0); LONG(ADDR(.bss)); LONG(ADDR(.bss) + SIZEOF(.bss));
		LONG(0xed419f25); LONG(ADDR(.main_stack)); LONG(ADDR(.main_stack) + SIZEOF(.main_stack));
		LONG(0xed419f25); LONG(ADDR(.process_stack)); LONG(ADDR(.process_stack) + SIZEOF(.process_stack));
		LONG(0); LONG(ADDR(.itcm.bss)); LONG(ADDR(.itcm.bss) + SIZEOF(.itcm.bss));
		LONG(0); LONG(ADDR(.sram.bss)); LONG(ADDR(.sram.bss) + SIZEOF(.sram.bss));
		LONG(0); LONG(ADDR(.bkpsram.bss)); LONG(ADDR(.bkpsram.bss) + SIZEOF(.bkpsram.bss));

		. = ALIGN(4);
		PROVIDE(__bss_array_end = .);

		/* end of sub-section: bss_array */

		/* sub-sections: init, preinit_array, init_array and fini_array */

		KEEP(*(SORT_NONE(.init)));

		PROVIDE(__preinit_array_start = .);

		KEEP(*(.preinit_array));

		PROVIDE(__preinit_array_end = .);

		PROVIDE(__init_array_start = .);

		KEEP(*(SORT_BY_INIT_PRIORITY(.init_array.*)));
		KEEP(*(.init_array));

		PROVIDE(__init_array_end = .);

		KEEP(*(SORT_NONE(.fini)));

#if CONFIG_STATIC_DESTRUCTORS_ENABLE == 1

		PROVIDE(__fini_array_start = .);

		KEEP(*(SORT_BY_INIT_PRIORITY(.fini_array.*)));
		KEEP(*(.fini_array));

		PROVIDE(__fini_array_end = .);

#endif	/* CONFIG_STATIC_DESTRUCTORS_ENABLE == 1 */

		/* end of sub-sections: init, preinit_array, init_array and fini_array */

		PROVIDE(__text_end = .);
	} > flashVma AT > flash

	.ARM.exidx :
	{
		PROVIDE(__exidx_start = .);

		*(.ARM.exidx* .gnu.linkonce.armexidx.*);	/* index entries for section unwinding */

		PROVIDE(__exidx_end = .);
	} > flashVma AT > flash

	.main_stack :
	{
		. = ALIGN(8);
		PROVIDE(__main_stack_start = .);

		. += __main_stack_size;

		. = ALIGN(8);
		PROVIDE(__main_stack_end = .);
		HIDDEN(__sram_limit_low = .);
	} > sram AT > sram

	.bss :
	{
		PROVIDE(__bss_start = .);

		*(.bss .bss.* .gnu.linkonce.b.*);
		*(COMMON);

		PROVIDE(__bss_end = .);
		HIDDEN(__sram_limit_low = .);
	} > sram AT > sram

	.data :
	{
		PROVIDE(__data_init_start = LOADADDR(.data));
		PROVIDE(__data_start = .);

		*(.data .data.* .gnu.linkonce.d.*);

		PROVIDE(__data_end = .);
		HIDDEN(__sram_limit_low = .);
	} > sram AT > flash

	.noinit (NOLOAD) :
	{
		PROVIDE(__noinit_start = .);

		*(.noinit);

		PROVIDE(__noinit_end = .);
		HIDDEN(__sram_limit_low = .);
	} > sram AT > sram

	.itcm.bss :
	{
		PROVIDE(__itcm_bss_start = .);

		*(.itcm.bss);

		PROVIDE(__itcm_bss_end = .);
		HIDDEN(__itcm_limit_low = .);
	} > itcm AT > itcm

	.itcm.data :
	{
		PROVIDE(__itcm_data_init_start = LOADADDR(.itcm.data));
		PROVIDE(__itcm_data_start = .);

		*(.itcm.data);

		PROVIDE(__itcm_data_end = .);
		HIDDEN(__itcm_limit_low = .);
	} > itcm AT > flash

	.itcm.noinit (NOLOAD) :
	{
		PROVIDE(__itcm_noinit_start = .);

		*(.itcm.noinit);

		PROVIDE(__itcm_noinit_end = .);
		HIDDEN(__itcm_limit_low = .);
	} > itcm AT > itcm

	.sram.bss :
	{
		PROVIDE(__sram_bss_start = .);

		*(.sram.bss);

		PROVIDE(__sram_bss_end = .);
		HIDDEN(__sram_limit_low = .);
	} > sram AT > sram

	.sram.data :
	{
		PROVIDE(__sram_data_init_start = LOADADDR(.sram.data));
		PROVIDE(__sram_data_start = .);

		*(.sram.data);

		PROVIDE(__sram_data_end = .);
		HIDDEN(__sram_limit_low = .);
	} > sram AT > flash

	.sram.noinit (NOLOAD) :
	{
		PROVIDE(__sram_noinit_start = .);

		*(.sram.noinit);

		PROVIDE(__sram_noinit_end = .);
		HIDDEN(__sram_limit_low = .);
	} > sram AT > sram

	.bkpsram.bss :
	{
		PROVIDE(__bkpsram_bss_start = .);

		*(.bkpsram.bss);

		PROVIDE(__bkpsram_bss_end = .);
		HIDDEN(__bkpsram_limit_low = .);
	} > bkpsram AT > bkpsram

	.bkpsram.data :
	{
		PROVIDE(__bkpsram_data_init_start = LOADADDR(.bkpsram.data));
		PROVIDE(__bkpsram_data_start = .);

		*(.bkpsram.data);

		PROVIDE(__bkpsram_data_end = .);
		HIDDEN(__bkpsram_limit_low = .);
	} > bkpsram AT > flash

	.bkpsram.noinit (NOLOAD) :
	{
		PROVIDE(__bkpsram_noinit_start = .);

		*(.bkpsram.noinit);

		PROVIDE(__bkpsram_noinit_end = .);
		HIDDEN(__bkpsram_limit_low = .);
	} > bkpsram AT > bkpsram

	PROVIDE(__process_stack_end = __sram_end / 8 * 8);
	PROVIDE(__process_stack_start = (__process_stack_end - __process_stack_size) / 8 * 8);

	.process_stack __process_stack_start : AT(__process_stack_start)
	{
		HIDDEN(__sram_limit_high = .);

		. += __process_stack_size;
	}

	PROVIDE(__heap_start = ALIGN(__sram_limit_low, 8));
	PROVIDE(__heap_end = __sram_limit_high / 8 * 8);

	/* Stabs debugging sections. */
	.stab 0 : { *(.stab); }
	.stabstr 0 : { *(.stabstr); }
	.stab.excl 0 : { *(.stab.excl); }
	.stab.exclstr 0 : { *(.stab.exclstr); }
	.stab.index 0 : { *(.stab.index); }
	.stab.indexstr 0 : { *(.stab.indexstr); }
	.comment 0 : { *(.comment); }
	/* DWARF debug sections. */
	/* Symbols in the DWARF debugging sections are relative to the beginning of the section so we begin them at 0. */
	/* DWARF 1 */
	.debug 0 : { *(.debug); }
	.line 0 : { *(.line); }
	/* GNU DWARF 1 extensions */
	.debug_srcinfo 0 : { *(.debug_srcinfo); }
	.debug_sfnames 0 : { *(.debug_sfnames); }
	/* DWARF 1.1 and DWARF 2 */
	.debug_aranges 0 : { *(.debug_aranges); }
	.debug_pubnames 0 : { *(.debug_pubnames); }
	/* DWARF 2 */
	.debug_info 0 : { *(.debug_info .gnu.linkonce.wi.*); }
	.debug_abbrev 0 : { *(.debug_abbrev); }
	.debug_line 0 : { *(.debug_line .debug_line.* .debug_line_end); }
	.debug_frame 0 : { *(.debug_frame); }
	.debug_str 0 : { *(.debug_str); }
	.debug_loc 0 : { *(.debug_loc); }
	.debug_macinfo 0 : { *(.debug_macinfo); }
	/* SGI/MIPS DWARF 2 extensions */
	.debug_weaknames 0 : { *(.debug_weaknames); }
	.debug_funcnames 0 : { *(.debug_funcnames); }
	.debug_typenames 0 : { *(.debug_typenames); }
	.debug_varnames 0 : { *(.debug_varnames); }
	/* DWARF 3 */
	.debug_pubtypes 0 : { *(.debug_pubtypes); }
	.debug_ranges 0 : { *(.debug_ranges); }
	/* DWARF Extension. */
	.debug_macro 0 : { *(.debug_macro); }
	.debug_addr 0 : { *(.debug_addr); }
	.ARM.attributes 0 : { KEEP(*(.ARM.attributes)); KEEP(*(.gnu.attributes)); }
	.note.gnu.arm.ident	0 : { KEEP(*(.note.gnu.arm.ident)); }
	/DISCARD/ : { *(.note.GNU-stack); *(.gnu_debuglink); *(.gnu.lto_*); }
}

PROVIDE(__text_size = SIZEOF(.text));
PROVIDE(__exidx_size = SIZEOF(.ARM.exidx));
PROVIDE(__bss_size = SIZEOF(.bss));
PROVIDE(__data_size = SIZEOF(.data));
PROVIDE(__noinit_size = SIZEOF(.noinit));
PROVIDE(__itcm_bss_size = SIZEOF(.itcm.bss));
PROVIDE(__itcm_data_size = SIZEOF(.itcm.data));
PROVIDE(__itcm_noinit_size = SIZEOF(.itcm.noinit));
PROVIDE(__sram_bss_size = SIZEOF(.sram.bss));
PROVIDE(__sram_data_size = SIZEOF(.sram.data));
PROVIDE(__sram_noinit_size = SIZEOF(.sram.noinit));
PROVIDE(__bkpsram_bss_size = SIZEOF(.bkpsram.bss));
PROVIDE(__bkpsram_data_size = SIZEOF(.bkpsram.data));
PROVIDE(__bkpsram_noinit_size = SIZEOF(.bkpsram.noinit));

PROVIDE(__bss_start__ = __bss_start);
PROVIDE(__bss_end__ = __bss_end);
