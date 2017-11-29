Content-Type: multipart/mixed; boundary="===============5708064647992018567=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH v2 00/25] TCP Extra-option framework for TCP-MD5
 and SMC
Date: Wed, 29 Nov 2017 12:56:17 -0800
Message-ID: <20171129205617.GV94116@Chimay.local>
In-Reply-To: alpine.OSX.2.21.1711281706590.17380@ddombrow-mobl1.amr.corp.intel.com
X-Status: 
X-Keywords:                  
X-UID: 222

--===============5708064647992018567==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Oh, and one more thing.

tcp_extra_options_* is quite long, and function-names are really long,
bringing us often close to the 80-char "limit".

What do you think of abbreviating it to "tcp_eo" or "teo" or something like
that?


Christoph

On 28/11/17 - 17:15:54, Mat Martineau wrote:
> =

> Christoph -
> =

> On Mon, 27 Nov 2017, Christoph Paasch wrote:
> =

> > Finally, the second version of this patch-set.
> > =

> > At netdev I talked about this with Eric, and he is looking forward to s=
ee
> > TCP-MD5 get out of the hot TCP data-path. He was planning to avoid TCP-=
MD5
> > with static jump-labels and also move TCP-MD5 in a separate file.
> =

> Good to hear that he's interested.
> =

> > =

> > =

> > There are quite a few changes in this new set. I extended much more the
> > extra-option framework. Making the list on a per-socket basis in the
> > request-socket, tcp-socket and time-wait-socket. This eliminates the ne=
ed
> > for RCU-locking. See patch "tcp_extra_options: Make extra-option list p=
er-socket"
> > =

> > I also added callbacks for response_write/prepare that can be called fr=
om the
> > tcp_v4_send_ack/rst, and v6 counterparts. This is needed because in the=
se
> > code-paths the skb and sk have entirely different semantics.
> > =

> > Finally, in the input-path I added a check-callback and a post-process =
callback.
> > =

> > This is needed because after parsing the option in tcp_parse_options() =
we also
> > need to act on them. The actions can be either before any other checks =
(e.g.,
> > as is the case for TCP_MD5, because we want to drop segments) or after =
the
> > validity checks (e.g., as is needed for SMC).
> > =

> > And I also opted SMC into the new framework.
> > =

> > And, I made the TCP-MD5 input code-path use the framework.
> =

> All of these seem like the right way to go. Nice to have two users of the
> framework already.
> =

> > =

> > =

> > There are still a few things that I need to double-check, notably
> > sk_nocaps_add() in TCP_MD5.
> > =

> > And, I need to test ;-)
> =

> Yeah, that testing :)
> =

> > =

> > But I would like to have some early feedback already - especially on th=
e patches
> > prefixed with "tcp_extra_options". If they look good, I can merge them =
into Mat's
> > patch, which will simplify my patch-juggling.
> =

> I have a few comments, but no major structural changes. I'll reply to the
> individual patches where needed.
> =

> > I want to get this patch-set out to netdev as an RFC as quickly as poss=
ible, so
> > that we can make some progress.
> =

> Agreed!
> =

> Mat
> =

> =

> > =

> > =

> > Christoph Paasch (24):
> >  tcp: Write options after the header has been fully done
> >  tcp: Pass sock to tcp_options_write instead of tcp_sock
> >  tcp: Pass skb in tcp_options_write
> >  tcp: Allow tcp_fast_parse_options to drop segments
> >  tcp: Make smc_parse_options return 1 on success
> >  tcp_md5: Don't pass along md5-key
> >  tcp_md5: Detect key inside tcp_v4_send_ack instead of passing it as an
> >    argument
> >  tcp_md5: Detect key inside tcp_v6_send_response instead of passing it
> >    as an argument
> >  tcp_extra_options: Extend tcp_extra_options_write
> >  tcp_extra_options: Make extra-option list per-socket
> >  tcp_extra_options: Export module fixes
> >  tcp_extra_options: Add response_prepare callback
> >  tcp_extra_options: Check static branch before _parse
> >  tcp_extra_options: Skip fast-path when extra-options are present
> >  tcp_extra_options: Pass sk to tcp_parse_options instead of tp
> >  tcp_extra_options: Add check-callback right after parsing the option
> >  tcp_extra_options: Allow to parse experimental options
> >  tcp_extra_options: Add post_process callback
> >  tcp_smc: Make SMC use TCP extra-option framework
> >  tcp_md5: Check for TCP_MD5 after TCP Timestamps in
> >    tcp_established_options
> >  tcp_md5: Move TCP-MD5 code out of TCP itself
> >  tcp_md5: Use tcp_extra_options in output path
> >  tcp_md5: Cleanup TCP-code
> >  tcp_md5: Use TCP extra-options on the input path
> > =

> > Mat Martineau (1):
> >  tcp: Register handlers for extra TCP options
> > =

> > drivers/infiniband/hw/cxgb4/cm.c |    2 +-
> > include/linux/inet_diag.h        |    1 +
> > include/linux/tcp.h              |   41 +-
> > include/linux/tcp_md5.h          |   38 ++
> > include/net/inet_sock.h          |    3 +-
> > include/net/tcp.h                |  216 ++++---
> > net/ipv4/Makefile                |    1 +
> > net/ipv4/syncookies.c            |    6 +-
> > net/ipv4/tcp.c                   |  372 ++++++++---
> > net/ipv4/tcp_diag.c              |   81 +--
> > net/ipv4/tcp_input.c             |  134 ++--
> > net/ipv4/tcp_ipv4.c              |  553 ++--------------
> > net/ipv4/tcp_md5.c               | 1317 +++++++++++++++++++++++++++++++=
+++++++
> > net/ipv4/tcp_minisocks.c         |   76 +--
> > net/ipv4/tcp_output.c            |  183 +-----
> > net/ipv6/syncookies.c            |    6 +-
> > net/ipv6/tcp_ipv6.c              |  386 ++---------
> > net/smc/af_smc.c                 |  170 ++++-
> > 18 files changed, 2148 insertions(+), 1438 deletions(-)
> > create mode 100644 include/linux/tcp_md5.h
> > create mode 100644 net/ipv4/tcp_md5.c
> > =

> > -- =

> > 2.15.0
> > =

> > =

> =

> --
> Mat Martineau
> Intel OTC

--===============5708064647992018567==--
