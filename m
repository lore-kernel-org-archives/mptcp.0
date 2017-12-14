Content-Type: multipart/mixed; boundary="===============8060859299362335201=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [RFC v3 00/15] TCP Extra-option framework for TCP-MD5 and
 SMC
Date: Wed, 13 Dec 2017 16:33:16 -0800
Message-ID: <20171214003316.GD64966@da0602a-dhcp135.apple.com>
In-Reply-To: alpine.OSX.2.21.1712130819490.22293@sjweber-mobl.amr.corp.intel.com
X-Status: 
X-Keywords:                  
X-UID: 257

--===============8060859299362335201==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 13/12/17 - 08:30:19, Mat Martineau wrote:
> =

> On Tue, 12 Dec 2017, Christoph Paasch wrote:
> =

> > On 12/12/17 - 15:35:09, Mat Martineau wrote:
> > > =

> > > On Mon, 11 Dec 2017, Christoph Paasch wrote:
> > > =

> > > > 3rd version of the set.
> > > > =

> > > > Now, fully tested and bugs fixed.
> > > > =

> > > > There are a two rather big changes (most of it is commented on in t=
he notes):
> > > > =

> > > > * Made the tcp_option_list and RCU-protected hlist. We need RCU-pro=
tection
> > > >  because listener sockets are lockless nowadays.
> > > =

> > > I'll pay attention to this as I go through the patches. Do we need to
> > > support modification of the option list while the socket is handling
> > > packets? If we require that the extra option list is not changed after
> > > connect()/listen(), that might simplify the implementation (and ensur=
e that
> > > the option list is unchanged between the prepare and write calls for
> > > outgoing packets).
> > > =

> > > The current TCP_MD5 implementation has a comment for tcp_md5_do_add()=
 saying
> > > it _can_ be called on a newly created socket, but I don't see anything
> > > _requiring_ the TCP_MD5SIG socket option to be used before
> > > connect()/listen() - so maybe we're stuck with allowing modifications=
 to
> > > tcp_option_list so the TCP_MD5SIG option behaves just like before.
> > =

> > Yes, as far as I can see, one can change the MD5-keys in the middle of a
> > connection.
> =

> If the extra option list was read-only after connect()/listen(), that wou=
ld
> still allow for keys to change mid-connection. Once the option list conta=
ins
> the MD5 hooks, those hooks can utilize whatever keys are currently
> configured.
> =

> The problem would be if the connection was started without TCP_MD5, then
> TCP_MD5 was enabled after packets had been exchanged. A read-only extra
> option list at that phase of the connection would be a problem. I'm not s=
ure
> "start a connection without MD5 and then switch it on" is a use case for
> TCP_MD5, but it seems to be allowed by the current implementation so we'd
> have to keep that behavior.

I will add a test for this scenario as well, where I start without MD5 and
then add it. As well as changing keys halfway through.


Thanks,
Christoph

> =

> =

> Mat
> =

> =

> > > > * Previously, in tcp_v4_send_reset, we would lookup the MD5-signatu=
re and
> > > >  if there was one, go look for the listening-socket (if sk =3D=3D N=
ULL) to see
> > > >  if there is an MD5-key.
> > > >  Nowadays, we can't do this anymore because extra-options are only =
parsed when
> > > >  we actually have a socket. However, this shouldn't have an impact =
as far as
> > > >  I can see. Because, if there is a listening-socket, __inet_lookup_=
skb will
> > > >  match on it and when we then send a RST when coming from tcp_rcv_s=
tate_process
> > > >  we have the pointer to the listening socket.
> > > >  The only scenario wherer tcp_v4_send_reset() gets called with a NU=
LL sk is
> > > >  when coming straight from tcp_v4_rcv.
> > > =

> > > This looks ok - that last scenario only happens when there is no sock=
et of
> > > any kind to match up with the packet, so there's nothing for TCP_MD5 =
to do.
> > =

> > Cool!
> > =

> > Btw., I talked with Alexei about the framework as well, because at FB t=
hey
> > are planning to do BPF-based extensions for TCP-options. He was interes=
ted to
> > see if our framework suits their use-case, so that they can hook their =
BPF
> > into it.
> > =

> > =

> > Thanks,
> > Christoph
> > =

> > > =

> > > Mat
> > > =

> > > =

> > > > =

> > > > =

> > > > If there are no major comments, I would like to go to netdev as a n=
ext step.
> > > > =

> > > > Christoph Paasch (14):
> > > >  tcp md5sig: Use skb's saddr when replying to an incoming segment
> > > >  tcp: Write options after the header has been fully done
> > > >  tcp: Pass sock and skb to tcp_options_write
> > > >  tcp: Allow tcp_fast_parse_options to drop segments
> > > >  tcp: Make smc_parse_options return 1 on success
> > > >  tcp_smc: Make SMC use TCP extra-option framework
> > > >  tcp_md5: Don't pass along md5-key
> > > >  tcp_md5: Detect key inside tcp_v4_send_ack instead of passing it a=
s an
> > > >    argument
> > > >  tcp_md5: Detect key inside tcp_v6_send_response instead of passing=
 it
> > > >    as an argument
> > > >  tcp_md5: Check for TCP_MD5 after TCP Timestamps in
> > > >    tcp_established_options
> > > >  tcp_md5: Move TCP-MD5 code out of TCP itself
> > > >  tcp_md5: Use tcp_extra_options in output path
> > > >  tcp_md5: Cleanup TCP-code
> > > >  tcp_md5: Use TCP extra-options on the input path
> > > > =

> > > > Mat Martineau (1):
> > > >  tcp: Register handlers for extra TCP options
> > > > =

> > > > drivers/infiniband/hw/cxgb4/cm.c |    2 +-
> > > > include/linux/inet_diag.h        |    1 +
> > > > include/linux/tcp.h              |   43 +-
> > > > include/linux/tcp_md5.h          |   39 ++
> > > > include/net/inet_sock.h          |    3 +-
> > > > include/net/tcp.h                |  209 +++---
> > > > net/ipv4/Makefile                |    1 +
> > > > net/ipv4/syncookies.c            |    6 +-
> > > > net/ipv4/tcp.c                   |  399 +++++++++---
> > > > net/ipv4/tcp_diag.c              |   81 +--
> > > > net/ipv4/tcp_input.c             |  140 ++--
> > > > net/ipv4/tcp_ipv4.c              |  545 ++--------------
> > > > net/ipv4/tcp_md5.c               | 1340 +++++++++++++++++++++++++++=
+++++++++++
> > > > net/ipv4/tcp_minisocks.c         |   75 +--
> > > > net/ipv4/tcp_output.c            |  179 +----
> > > > net/ipv6/syncookies.c            |    6 +-
> > > > net/ipv6/tcp_ipv6.c              |  382 +----------
> > > > net/smc/af_smc.c                 |  175 ++++-
> > > > 18 files changed, 2181 insertions(+), 1445 deletions(-)
> > > > create mode 100644 include/linux/tcp_md5.h
> > > > create mode 100644 net/ipv4/tcp_md5.c
> > > > =

> > > > --
> > > > 2.15.0
> > > > =

> > > > =

> > > =

> > > --
> > > Mat Martineau
> > > Intel OTC
> > =

> =

> --
> Mat Martineau
> Intel OTC

--===============8060859299362335201==--
