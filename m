Content-Type: multipart/mixed; boundary="===============7149035959305012898=="
MIME-Version: 1.0
From: Peter Krystad <peter.krystad at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH 5/6] mptcp: Export low-level routines for IPv6
Date: Tue, 05 Nov 2019 15:36:17 -0800
Message-ID: <56f4ce8172a30a2d20d6d6cd781442667ac967ab.camel@linux.intel.com>
In-Reply-To: 3b89f10dd6a661921b1757a1b2d5346f29ba398c.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 2409

--===============7149035959305012898==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 2019-10-31 at 09:26 +0100, Paolo Abeni wrote:
> Hi,
> =

> On Wed, 2019-10-30 at 16:38 -0700, Peter Krystad wrote:
> > @@ -1111,7 +1111,8 @@ static void tcp_v6_restore_cb(struct sk_buff *skb)
> >  		sizeof(struct inet6_skb_parm));
> >  }
> >  =

> > -static struct sock *tcp_v6_syn_recv_sock(const struct sock *sk, struct=
 sk_buff *skb,
> > +static struct sock *tcp_v6_syn_recv_sock(const struct sock *sk,
> > +					 struct sk_buff *skb,
> >  					 struct request_sock *req,
> >  					 struct dst_entry *dst,
> >  					 struct request_sock *req_unhash,
> =

> Minor nit: it looks like this chunk is not needed ?

It seemed like since I was in the neighborhood I would fix this over-80 char
line. If that's not appropriate we can drop this chunk.

Peter.


> Cheers,
> =

> Paolo
>=20

--===============7149035959305012898==--
