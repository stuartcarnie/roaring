package roaring

import (
	"fmt"
	"testing"
)

func benchmarkPopcountSliceN(b *testing.B, n int) {
	s := getRandomUint64Set(n)

	b.SetBytes(int64(n * 8))
	b.ResetTimer()

	for i := 0; i < b.N; i++ {
		popcntSlice(s)
	}
}

func BenchmarkPopcountSlice(b *testing.B) {
	runs := []struct {
		n int
	}{
		{64},
		{128},
		{256},
		{512},
		{1024},
	}

	for _, run := range runs {
		b.Run(fmt.Sprintf("size_%d", run.n), func(b *testing.B) {
			benchmarkPopcountSliceN(b, run.n)
		})
	}
}

func benchmarkPopcountMaskSliceN(b *testing.B, n int) {
	s := getRandomUint64Set(n)
	m := getRandomUint64Set(n)

	b.SetBytes(int64(n * 8))
	b.ResetTimer()

	for i := 0; i < b.N; i++ {
		popcntMaskSlice(s, m)
	}
}

func BenchmarkPopcountMaskSlice(b *testing.B) {
	runs := []struct {
		n int
	}{
		{64},
		{128},
		{256},
		{512},
		{1024},
	}

	for _, run := range runs {
		b.Run(fmt.Sprintf("size_%d", run.n), func(b *testing.B) {
			benchmarkPopcountMaskSliceN(b, run.n)
		})
	}
}

func benchmarkPopcountAndSliceN(b *testing.B, n int) {
	s := getRandomUint64Set(n)
	m := getRandomUint64Set(n)

	b.SetBytes(int64(n * 8))
	b.ResetTimer()

	for i := 0; i < b.N; i++ {
		popcntAndSlice(s, m)
	}
}

func BenchmarkPopcountAndSlice(b *testing.B) {
	runs := []struct {
		n int
	}{
		{64},
		{128},
		{256},
		{512},
		{1024},
	}

	for _, run := range runs {
		b.Run(fmt.Sprintf("size_%d", run.n), func(b *testing.B) {
			benchmarkPopcountAndSliceN(b, run.n)
		})
	}
}

func benchmarkPopcountOrSliceN(b *testing.B, n int) {
	s := getRandomUint64Set(n)
	m := getRandomUint64Set(n)

	b.SetBytes(int64(n * 8))
	b.ResetTimer()

	for i := 0; i < b.N; i++ {
		popcntOrSlice(s, m)
	}
}

func BenchmarkPopcountOrSlice(b *testing.B) {
	runs := []struct {
		n int
	}{
		{64},
		{128},
		{256},
		{512},
		{1024},
	}

	for _, run := range runs {
		b.Run(fmt.Sprintf("size_%d", run.n), func(b *testing.B) {
			benchmarkPopcountOrSliceN(b, run.n)
		})
	}
}

func benchmarkPopcountXorSliceN(b *testing.B, n int) {
	s := getRandomUint64Set(n)
	m := getRandomUint64Set(n)

	b.SetBytes(int64(n * 8))
	b.ResetTimer()

	for i := 0; i < b.N; i++ {
		popcntXorSlice(s, m)
	}
}

func BenchmarkPopcountXorSlice(b *testing.B) {
	runs := []struct {
		n int
	}{
		{64},
		{128},
		{256},
		{512},
		{1024},
	}

	for _, run := range runs {
		b.Run(fmt.Sprintf("size_%d", run.n), func(b *testing.B) {
			benchmarkPopcountXorSliceN(b, run.n)
		})
	}
}
