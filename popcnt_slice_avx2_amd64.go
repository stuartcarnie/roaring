// +build !noasm

package roaring

import "unsafe"

//go:noescape
func _popcnt_slice_avx2(src, len, res unsafe.Pointer)

func popcnt_slice_avx2(s []uint64) (res uint64) {
	if len(s) == 0 {
		return 0
	}
	_popcnt_slice_avx2(unsafe.Pointer(&s[0]), unsafe.Pointer(uintptr(len(s))), unsafe.Pointer(&res))
	return res
}

//go:noescape
func _popcnt_mask_slice_avx2(src, mask, len, res unsafe.Pointer)

func popcnt_mask_slice_avx2(s, m []uint64) (res uint64) {
	if len(s) == 0 {
		return 0
	}
	_popcnt_mask_slice_avx2(unsafe.Pointer(&s[0]), unsafe.Pointer(&m[0]), unsafe.Pointer(uintptr(len(s))), unsafe.Pointer(&res))
	return res
}

//go:noescape
func _popcnt_and_slice_avx2(src, mask, len, res unsafe.Pointer)

func popcnt_and_slice_avx2(s, m []uint64) (res uint64) {
	if len(s) == 0 {
		return 0
	}
	_popcnt_and_slice_avx2(unsafe.Pointer(&s[0]), unsafe.Pointer(&m[0]), unsafe.Pointer(uintptr(len(s))), unsafe.Pointer(&res))
	return res
}

//go:noescape
func _popcnt_or_slice_avx2(src, mask, len, res unsafe.Pointer)

func popcnt_or_slice_avx2(s, m []uint64) (res uint64) {
	if len(s) == 0 {
		return 0
	}
	_popcnt_or_slice_avx2(unsafe.Pointer(&s[0]), unsafe.Pointer(&m[0]), unsafe.Pointer(uintptr(len(s))), unsafe.Pointer(&res))
	return res
}

//go:noescape
func _popcnt_xor_slice_avx2(src, mask, len, res unsafe.Pointer)

func popcnt_xor_slice_avx2(s, m []uint64) (res uint64) {
	if len(s) == 0 {
		return 0
	}
	_popcnt_xor_slice_avx2(unsafe.Pointer(&s[0]), unsafe.Pointer(&m[0]), unsafe.Pointer(uintptr(len(s))), unsafe.Pointer(&res))
	return res
}
