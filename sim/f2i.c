#include <stdio.h>
#include <stdint.h>

typedef union {
  uint32_t u;
  int i;
  float f;
} UIF;

uint32_t f2i(uint32_t a) {
  UIF geta, b;
  geta.u = (a & 0x80000000) | 0x3f000000;
  b.u = a;
  b.i = (int)(b.f + geta.f);
  return b.u;
}
