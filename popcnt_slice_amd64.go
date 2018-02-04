// +build !noasm

package roaring

import "github.com/RoaringBitmap/roaring/internal/cpu"

func init() {
	if cpu.X86.HasAVX2 {
		popcntSliceImpl = popcnt_slice_avx2
		popcntMaskSliceImpl = popcnt_mask_slice_avx2
		popcntAndSliceImpl = popcnt_and_slice_avx2
		popcntOrSliceImpl = popcnt_or_slice_avx2
		popcntXorSliceImpl = popcnt_xor_slice_avx2
	} else if cpu.X86.HasSSE42 {
		popcntSliceImpl = popcnt_slice_sse4
		popcntMaskSliceImpl = popcnt_mask_slice_sse4
		popcntAndSliceImpl = popcnt_and_slice_sse4
		popcntOrSliceImpl = popcnt_or_slice_sse4
		popcntXorSliceImpl = popcnt_xor_slice_sse4
	} else {
		popcntSliceImpl = popcntSliceGo
		popcntMaskSliceImpl = popcntMaskSliceGo
		popcntAndSliceImpl = popcntAndSliceGo
		popcntOrSliceImpl = popcntOrSliceGo
		popcntXorSliceImpl = popcntXorSliceGo
	}
}
