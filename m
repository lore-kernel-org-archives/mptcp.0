Content-Type: multipart/mixed; boundary="===============2497312001047741499=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next v7 02/11] sock: Make sk_protocol a 16-bit
 value
Date: Thu, 09 Jan 2020 22:25:28 +0100
Message-ID: <20200109212528.GF795@breakpoint.cc>
In-Reply-To: 20200109.110514.747612850299504416.davem@davemloft.net
X-Status: 
X-Keywords:                  
X-UID: 3338

--===============2497312001047741499==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

David Miller <davem(a)davemloft.net> wrote:
> From: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
> Date: Thu,  9 Jan 2020 07:59:15 -0800
> =

> > Match the 16-bit width of skbuff->protocol. Fills an 8-bit hole so
> > sizeof(struct sock) does not change.
> > =

> > Also take care of BPF field access for sk_type/sk_protocol. Both of them
> > are now outside the bitfield, so we can use load instructions without
> > further shifting/masking.
> > =

> > v5 -> v6:
> >  - update eBPF accessors, too (Intel's kbuild test robot)
> > v2 -> v3:
> >  - keep 'sk_type' 2 bytes aligned (Eric)
> > v1 -> v2:
> >  - preserve sk_pacing_shift as bit field (Eric)
> > =

> > Cc: Alexei Starovoitov <ast(a)kernel.org>
> > Cc: Daniel Borkmann <daniel(a)iogearbox.net>
> > Cc: bpf(a)vger.kernel.org
> > Co-developed-by: Paolo Abeni <pabeni(a)redhat.com>
> > Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> > Co-developed-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
> > Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
> > Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
> =

> This is worrisome for me.
> =

> We have lots of places that now are going to be assigning  sk->sk_protocol
> into a u8 somewhere else.  A lot of them are ok because limits are enforc=
ed
> in various places, but for example:
> =

> net/ipv6/udp.c:	fl6.flowi6_proto =3D sk->sk_protocol;
> net/l2tp/l2tp_ip6.c:	fl6.flowi6_proto =3D sk->sk_protocol;
> =

> net/ipv6/inet6_connection_sock.c:	fl6->flowi6_proto =3D sk->sk_protocol;
> =

> net/ipv6/af_inet6.c:		fl6.flowi6_proto =3D sk->sk_protocol;
> net/ipv6/datagram.c:	fl6->flowi6_proto =3D sk->sk_protocol;
> =

> This is one just one small example situation, where flowi6_proto is a u8.

There are parts in the stack (e.g. in setsockopt code paths) that test
sk->sk_protocol vs. IPPROTO_TCP, then call tcp specific code under the sane
assumption that sk is a tcp_sock struct.

With 8bit sk_protocol, mptcp_sock structs (which is what kernel gets via
file descriptor number) would be treated as a tcp socket, because
"IPPROTO_MPTCP & 0xff" yields IPPROTO_TCP.

Changing IPPROTO_MPTCP to a value <=3D 255 could lead to conflicts with
real inet protocols in the future, so we can't redefine it to a 8bit
value.

If we keep sk_protocol as 8bit field, we will need to make sure that all
places testing sk_protocol =3D=3D IPPROTO_TCP gain an additional sanity che=
ck
to tell tcp and mptcp sockets apart.  Moreover, any further changes to
kernel code would need same extra test, so this is a non-starter to me.

Alternatively we could change the first member of mptcp_sk struct from
inet_connection_sock to a full tcp_sock struct.  Thats roughly 1k increase
of mptcp_sock struct to ~ 3744 bytes, but then we would not have to
worry about mptcp sockets ending up in tcp code paths.

If you think such a size increase is ok I could give that solution a shot
and see what other problems with 8bit sk_protocol might remain.

Mat reported /sys/kernel/debug/tracing/trace lists mptcp sockets as
IPPROTO_TCP in the '8 bit sk_protocol' case, but if thats the only issue
this might have a smaller/acceptable "avoidance fix".
--===============2497312001047741499==--
