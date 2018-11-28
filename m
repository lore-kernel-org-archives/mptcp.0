Content-Type: multipart/mixed; boundary="===============0619981337211910206=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] New skb extension proposal on netdev
Date: Wed, 28 Nov 2018 13:13:12 +0100
Message-ID: <20181128121312.lja2xqlqmpi4hmbn@breakpoint.cc>
In-Reply-To: 20181127175714.GP3611@MacBook-Pro-19.local
X-Status: 
X-Keywords:                  
X-UID: 844

--===============0619981337211910206==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Christoph Paasch <cpaasch(a)apple.com> wrote:
> On 26/11/18 - 16:49:54, Mat Martineau wrote:
> > =

> > Florian posted a skb extension patch set on netdev today and I wanted to
> > have folks here take a look:
> > =

> > https://marc.info/?l=3Dlinux-netdev&m=3D154323251731893&w=3D2
> > =

> > So far, I really like how it solves the problem of making extension spa=
ce
> > available to multiple layers.
> > =

> > To give more context for the netdev discussion (and to see if others wa=
nt to
> > add to it):
> > =

> > =

> > The MPTCP control block in our upstream proposal branch looks like this:

Which branch is that?

Its not
https://github.com/multipath-tcp/mptcp_net-next.git master
and can't see that skb_cb in mptcp_trunk either (plus, that branch
appears dated...).

> > struct mptcp_skb_cb {
> >         u64             data_ack;
> > =

> >         /* DSS mapping */
> >         u64             data_seq;
> >         u32             subflow_seq;
> >         u16             dll;
> >         __sum16         checksum;
> >         u8              use_map:1,
> >                         dsn64:1,
> >                         use_checksum:1,
> >                         data_fin:1,
> >                         use_ack:1,
> >                         ack64:1,
> >                         __unused:2;
> > };
> > =

> > This is the content of the MPTCP DSS option that needs to propagate from
> > the TCP headers to the MPTCP upper layer (and vice versa). The DSS mapp=
ing
> > is used to establish where a part of the TCP sequence space belongs in =
the
> > 64-bit MPTCP sequence space. This can be included in any data packet, or
> > as little as once per 2^16 bytes of data.

I see, thanks.
So I guess there is no way to assemble this directly within mptcp (tx
side) and have tcp stack leave it alone, or have skbs get passed up to
mptcp on rx so DSS mapping can be done there?

tx+rx distinction is important, as Erics suggestion (fclone cb_ext)
won't work for rx side, and a new 'extended_shinfo' will likely not fly
for rx part either.

> > uninitialized area in sk_buff. Neither of these handled the issue of sh=
aring
> > the extension bytes, which Florian's patch does. Sharing that space mak=
es it
> > usable for other purposes (sp, nf_bridge, kTLS).

Yes, although I did not have other in-tree users in mind except sp/ipsec
and nf_bridge.  As for new users, there isn't anything I see other than
possible use by MPTCP.  I recall a wifi developer telling me that
skb->cb is already very small, so maybe they would have another use
case, but I am not aware of anything at this time.

> Florian, would kTLS also be a possible candidate for this? Because, it is
> doing upcalls from skb->sk to get the tls-context and TLS-records (see
> mlx5e_tls_handle_tx_skb()).

I don't know enough about (k)TLS to give a good answer.
Basically the extension-idea is a good fit when all of the following are tr=
ue:

1. Data is related to the skb/packet aggregate
2. Data can (should, must) be freed when the skb is free'd
3. Data is to be carried both on RX and TX side
4. Data is not going to be relevant for most in-tree users (udp, tcp,
   forwarding workloads, ...)
5. Data is small.  Right now the extension proposal allows an
   accumulated size of 2k worth of extension data, and we have to assume
   worst-case (i.e. "nf_bridged mptcp packet traversing ipsec tunnel", so
   all extensions are in use on same skb.

   Right now there is plenty of space left though and the proposal
   uses BUILD_BUG_ON to assert that accumulated size doesn't cross the allo=
wed
   thresh.

6. There are no fancy action(s) needed on clone/free.

I looked at secpath, it will need to get/put the xfrm states that it
has pointers to from the 'secpath' struct.

This isn't a show stopper for converting skb->sp to the extension
infrastructure, as all of the XFRM helpers needed are always builtin,
but it does prohibit calls to functions that reside in a kernel module.

> TLS-records are very similar to what MPTCP's DSS-mapping needs, which is
> basically mapping every byte in the TCP-subflow's sequence space to a
> sequence number at the MPTCP-level (in rough terms that's what TLS records
> do as well).

AFAICS the upcall to fetch sk upper layer protocol data for ktls will
also need to access data taht doesn't map to the skb, such as the crypto
context, so it seems to me that this can/should remain in the socket
context.

> Let's discuss on Thursday!

Yep, I will attend this call, we can discuss this there.

I wanted to avoid a disussion of MPTCP requirements on netdev at this
stage and only focus on ipsec/bridge and this extension proposal, but
it would definitely not hurt to have agreement on MPTCP requirements
wrt. interaction with rest-of-network-stack.

--===============0619981337211910206==--
