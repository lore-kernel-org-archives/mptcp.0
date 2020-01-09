Content-Type: multipart/mixed; boundary="===============7921693248686348742=="
MIME-Version: 1.0
From: David Miller <davem at davemloft.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next v7 02/11] sock: Make sk_protocol a 16-bit
 value
Date: Thu, 09 Jan 2020 11:05:14 -0800
Message-ID: <20200109.110514.747612850299504416.davem@davemloft.net>
In-Reply-To: 20200109155924.30122-3-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 3336

--===============7921693248686348742==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
Date: Thu,  9 Jan 2020 07:59:15 -0800

> Match the 16-bit width of skbuff->protocol. Fills an 8-bit hole so
> sizeof(struct sock) does not change.
> =

> Also take care of BPF field access for sk_type/sk_protocol. Both of them
> are now outside the bitfield, so we can use load instructions without
> further shifting/masking.
> =

> v5 -> v6:
>  - update eBPF accessors, too (Intel's kbuild test robot)
> v2 -> v3:
>  - keep 'sk_type' 2 bytes aligned (Eric)
> v1 -> v2:
>  - preserve sk_pacing_shift as bit field (Eric)
> =

> Cc: Alexei Starovoitov <ast(a)kernel.org>
> Cc: Daniel Borkmann <daniel(a)iogearbox.net>
> Cc: bpf(a)vger.kernel.org
> Co-developed-by: Paolo Abeni <pabeni(a)redhat.com>
> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> Co-developed-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
> Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
> Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>

This is worrisome for me.

We have lots of places that now are going to be assigning  sk->sk_protocol
into a u8 somewhere else.  A lot of them are ok because limits are enforced
in various places, but for example:

net/ipv6/udp.c:	fl6.flowi6_proto =3D sk->sk_protocol;
net/l2tp/l2tp_ip6.c:	fl6.flowi6_proto =3D sk->sk_protocol;

net/ipv6/inet6_connection_sock.c:	fl6->flowi6_proto =3D sk->sk_protocol;

net/ipv6/af_inet6.c:		fl6.flowi6_proto =3D sk->sk_protocol;
net/ipv6/datagram.c:	fl6->flowi6_proto =3D sk->sk_protocol;

This is one just one small example situation, where flowi6_proto is a u8.
--===============7921693248686348742==--
