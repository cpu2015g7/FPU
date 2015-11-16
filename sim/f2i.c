#include <stdio.h>
#include <stdint.h>

typedef union {
  uint32_t u;
  int i;
  float f;
} UIF;

uint32_t f2i(uint32_t a) {
  UIF geta, b;
  if ((a & 0x7f800000) == 0x4b000000)
    geta.u = 0;
  else
    geta.u = (a & 0x80000000) | 0x3f000000;
  b.u = a;
  b.i = (int)(b.f + geta.f);
  return b.u;
}
