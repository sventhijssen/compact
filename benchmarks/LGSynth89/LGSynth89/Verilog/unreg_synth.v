// IWLS benchmark module "unreg" printed on Wed May 29 16:25:18 2002
module unreg(a, b, c, d, e, f, g, h, i, j, k, l, m, n, o, p, q, s, t, u, v, w, \x , y, z, a0, b0, c0, d0, e0, f0, g0, h0, i0, j0, k0, l0, m0, n0, o0, p0, q0, r0, s0, t0, u0, v0, w0, x0, y0, z0, a1);
input
  k0,
  a,
  b,
  c,
  d,
  e,
  f,
  g,
  h,
  i,
  j,
  k,
  l,
  m,
  n,
  o,
  p,
  q,
  s,
  t,
  u,
  v,
  w,
  \x ,
  y,
  z,
  a0,
  b0,
  c0,
  d0,
  e0,
  f0,
  g0,
  h0,
  i0,
  j0;
output
  l0,
  m0,
  n0,
  o0,
  p0,
  q0,
  r0,
  s0,
  a1,
  t0,
  u0,
  v0,
  w0,
  x0,
  y0,
  z0;
wire
  \[13] ,
  \[14] ,
  \[15] ,
  \[16] ,
  \[17] ,
  \[18] ,
  \[0] ,
  \[1] ,
  \[2] ,
  \[3] ,
  \[4] ,
  \[5] ,
  \[6] ,
  \[7] ,
  \[8] ,
  \[10] ,
  \[9] ,
  \[11] ,
  \[12] ;
assign
  \[13]  = (\[18]  & ~j0) | ((\[17]  & o) | (~i0 & ~u)),
  l0 = \[0] ,
  \[14]  = (\[18]  & ~k0) | ((\[17]  & n) | (~j0 & ~u)),
  m0 = \[1] ,
  \[15]  = (\[18]  & ~d0) | ((\[17]  & m) | (~k0 & ~u)),
  n0 = \[2] ,
  \[16]  = u & ~s,
  o0 = \[3] ,
  \[17]  = \[16]  & ~t,
  p0 = \[4] ,
  \[18]  = \[16]  & t,
  q0 = \[5] ,
  r0 = \[6] ,
  s0 = \[7] ,
  \[0]  = (\[18]  & ~w) | ((\[17]  & d) | (~v & ~u)),
  a1 = \[15] ,
  t0 = \[8] ,
  \[1]  = (\[18]  & ~\x ) | ((\[17]  & c) | (~w & ~u)),
  u0 = \[9] ,
  \[2]  = (\[18]  & ~y) | ((\[17]  & b) | (~\x  & ~u)),
  v0 = \[10] ,
  \[3]  = (\[18]  & q) | ((\[17]  & a) | (~y & ~u)),
  w0 = \[11] ,
  \[4]  = (\[18]  & ~a0) | ((\[17]  & h) | (~z & ~u)),
  x0 = \[12] ,
  \[5]  = (\[18]  & ~b0) | ((\[17]  & g) | (~a0 & ~u)),
  y0 = \[13] ,
  \[6]  = (\[18]  & ~c0) | ((\[17]  & f) | (~b0 & ~u)),
  z0 = \[14] ,
  \[7]  = (\[18]  & ~v) | ((\[17]  & e) | (~c0 & ~u)),
  \[8]  = (\[18]  & ~e0) | ((\[17]  & l) | (~d0 & ~u)),
  \[10]  = (\[18]  & ~g0) | ((\[17]  & j) | (~f0 & ~u)),
  \[9]  = (\[18]  & ~f0) | ((\[17]  & k) | (~e0 & ~u)),
  \[11]  = (\[18]  & ~z) | ((\[17]  & i) | (~g0 & ~u)),
  \[12]  = (\[18]  & ~i0) | ((\[17]  & p) | (~h0 & ~u));
endmodule

