// IWLS benchmark module "cc" printed on Wed May 29 16:07:19 2002
module cc(a, b, c, d, e, f, g, h, i, j, k, l, m, o, p, q, r, s, t, u, v, w, \x , y, z, a0, b0, c0, d0, e0, f0, g0, h0, i0, j0, k0, l0, m0, n0, o0, p0);
input
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
  o,
  p,
  q,
  r,
  s,
  t,
  u,
  v;
output
  k0,
  l0,
  m0,
  n0,
  o0,
  p0,
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
wire
  \[13] ,
  l1,
  \[14] ,
  \[15] ,
  \[16] ,
  \[17] ,
  \[18] ,
  \[19] ,
  \[0] ,
  \[1] ,
  \[2] ,
  \[3] ,
  \[4] ,
  \[20] ,
  \[21] ,
  \[22] ,
  \[10] ,
  \[9] ,
  \[12] ;
assign
  k0 = \[14] ,
  \[13]  = (p & (m & ~b)) | ((\[21]  & p) | \[3] ),
  l0 = \[15] ,
  l1 = \[22]  | q,
  \[14]  = (\[22]  & (q & m)) | (\[20]  & c),
  m0 = \[16] ,
  \[15]  = (\[21]  & (r & ~p)) | (\[20]  & d),
  n0 = \[17] ,
  \[16]  = (\[21]  & s) | (\[20]  & e),
  o0 = \[18] ,
  \[17]  = (\[21]  & t) | (\[20]  & f),
  p0 = \[19] ,
  \[18]  = (\[21]  & u) | (\[20]  & g),
  \[19]  = (\[21]  & v) | (\[20]  & h),
  w = \[0] ,
  \x  = \[1] ,
  y = \[2] ,
  z = \[3] ,
  \[0]  = l & v,
  a0 = \[4] ,
  \[1]  = ~\[22]  & (q & ~p),
  b0 = u,
  \[2]  = (p & (m & ~l)) | (\[20]  & ~l),
  c0 = q,
  \[3]  = \[1]  & m,
  d0 = s,
  \[4]  = ~t,
  e0 = r,
  f0 = \[9] ,
  \[20]  = ~l1 & m,
  g0 = \[10] ,
  \[21]  = l1 & m,
  h0 = p,
  \[22]  = ~k | ~i,
  \[10]  = ~\[9] ,
  i0 = \[12] ,
  \[9]  = i & j,
  j0 = \[13] ,
  \[12]  = (\[21]  & o) | (\[20]  & a);
endmodule

