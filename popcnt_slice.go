package roaring

var (
	popcntSliceImpl     func(s []uint64) uint64
	popcntMaskSliceImpl func(s, m []uint64) uint64
	popcntAndSliceImpl  func(s, m []uint64) uint64
	popcntOrSliceImpl   func(s, m []uint64) uint64
	popcntXorSliceImpl  func(s, m []uint64) uint64
)

func popcntSlice(s []uint64) uint64 {
	return popcntSliceImpl(s)
}

func popcntMaskSlice(s, m []uint64) uint64 {
	return popcntMaskSliceImpl(s, m)
}

func popcntAndSlice(s, m []uint64) uint64 {
	return popcntAndSliceImpl(s, m)
}

func popcntOrSlice(s, m []uint64) uint64 {
	return popcntOrSliceImpl(s, m)
}

func popcntXorSlice(s, m []uint64) uint64 {
	return popcntXorSliceImpl(s, m)
}

func popcntSliceGo(s []uint64) uint64 {
	cnt := uint64(0)
	for _, x := range s {
		cnt += popcount(x)
	}
	return cnt
}

func popcntMaskSliceGo(s, m []uint64) uint64 {
	cnt := uint64(0)
	for i := range s {
		cnt += popcount(s[i] &^ m[i])
	}
	return cnt
}

func popcntAndSliceGo(s, m []uint64) uint64 {
	cnt := uint64(0)
	for i := range s {
		cnt += popcount(s[i] & m[i])
	}
	return cnt
}

func popcntOrSliceGo(s, m []uint64) uint64 {
	cnt := uint64(0)
	for i := range s {
		cnt += popcount(s[i] | m[i])
	}
	return cnt
}

func popcntXorSliceGo(s, m []uint64) uint64 {
	cnt := uint64(0)
	for i := range s {
		cnt += popcount(s[i] ^ m[i])
	}
	return cnt
}
