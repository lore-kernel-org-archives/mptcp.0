Content-Type: multipart/mixed; boundary="===============8146030637314436751=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v2 5/6] mptcp: Export low-level routines for IPv6
Date: Wed, 06 Nov 2019 11:09:26 +0100
Message-ID: <4845aa6c240b819fca29f52ac82ad3b1a2a681e5.camel@redhat.com>
In-Reply-To: 6c2c57ca-b1de-a8c7-54bc-eeddba222f0f@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 2424

--===============8146030637314436751==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, 2019-11-06 at 10:37 +0100, Matthieu Baerts wrote:
> Hi Paolo,
> =

> On 06/11/2019 10:03, Paolo Abeni wrote:
> > On Tue, 2019-11-05 at 20:41 -0800, Peter Krystad wrote:
> > > @@ -1111,7 +1111,8 @@ static void tcp_v6_restore_cb(struct sk_buff *s=
kb)
> > >   		sizeof(struct inet6_skb_parm));
> > >   }
> > >   =

> > > -static struct sock *tcp_v6_syn_recv_sock(const struct sock *sk, stru=
ct sk_buff *skb,
> > > +static struct sock *tcp_v6_syn_recv_sock(const struct sock *sk,
> > > +					 struct sk_buff *skb,
> > >   					 struct request_sock *req,
> > >   					 struct dst_entry *dst,
> > >   					 struct request_sock *req_unhash,
> > =

> > Minor nit: it looks like this chunk is not needed[1].
> =

> Peter replied this in the previous version of the patch:
> =

>  > It seemed like since I was in the neighborhood I would fix this
>  > over-80 char line. If that's not appropriate we can drop this chunk.

whoops, I missed that, sorry! And thank you for the head-up!

> I guess we should not modify the style of non MPTCP code. Then better to =

> drop this change, right?

Yes, exactly. The above change should be in a separate, non mptcp-
related patch.

Cheers,

Paolo

--===============8146030637314436751==--
