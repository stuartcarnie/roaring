#include "arch.h"
#include <stdint.h>
#include <memory.h>

static int popcount(uint64_t x) {
  int v = 0;
  while(x != 0) {
    x &= x - 1;
    v++;
  }
  return v;
}

void FULL_NAME(popcnt_slice)(uint64_t * src, size_t len, uint64_t *res) {
    uint64_t *end = (src+len);
    int c = 0;
    while (src < end) {
        c += popcount(*src);
        ++src;
    }
    *res = c;
}

void FULL_NAME(popcnt_mask_slice)(uint64_t * restrict src, uint64_t * restrict mask, size_t len, uint64_t *res) {
    int c = 0;
    for (int p = 0; p < len; p++) {
        c += popcount(src[p] & ~mask[p]);
    }
    *res = c;
}

void FULL_NAME(popcnt_and_slice)(uint64_t * restrict src, uint64_t * restrict mask, size_t len, uint64_t *res) {
    int c = 0;
    for (int p = 0; p < len; p++) {
        c += popcount(src[p] & mask[p]);
    }
    *res = c;
}

void FULL_NAME(popcnt_or_slice)(uint64_t * restrict src, uint64_t * restrict mask, size_t len, uint64_t *res) {
    int c = 0;
    for (int p = 0; p < len; p++) {
        c += popcount(src[p] | mask[p]);
    }
    *res = c;
}

void FULL_NAME(popcnt_xor_slice)(uint64_t * restrict src, uint64_t * restrict mask, size_t len, uint64_t *res) {
    int c = 0;
    for (int p = 0; p < len; p++) {
        c += popcount(src[p] ^ mask[p]);
    }
    *res = c;
}
