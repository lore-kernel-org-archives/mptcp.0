Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F334B3515C0;
	Wed, 30 Sep 2026 03:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790740211; cv=none; b=m+Aknc68ZvqGv0736v2JxMqzPJQIeryQkuV3UvAy5oMHR8WFk0hT8Q7xVH29MsNxOCHJO+Qzm8QusYm944cwyboqs+mJvapuRsPQwpZUmycv+dDWyukLpHHKC1zjXmQ7EQn7eprpAWp2YTREFCXyE8uMBe2g/yiTfgZuKBH0Rus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790740211; c=relaxed/simple;
	bh=Bf+DsAW5nTvc9GPk9imvQwx9+H7YFzV78ffJrc0GbrY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JYOEWB9bAxlPGk93VAfycPlMsVw6tRbMn900G7vJEMUkAq+yniD2pEWZpRWelvwtGG+ROxQ93jhdeFBCbwIL9B9sBj832XcFG5OI54vL+kge5dzZ+3yf9Im/QulCP1fy5O6X0Bn5bF0Z8qopYokBbvuOUtyc++/JrHJk1cdxn1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gRS4MPcU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gRS4MPcU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C59151F000FF;
	Wed, 30 Sep 2026 03:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790740209;
	bh=YIbSyCiOLeEUjjfXA44UKdojHNTuWRGoF01Fd+gF+Vo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=gRS4MPcUabeFuR3C9i4klfpgJNpppqfTNOI3ByEj403YUelxdvjP8tP0FOlqhr9uM
	 WFP4K8EdWYl6ZEXDEuec5SjtWPc14c4aRw7FBtJuApwzfJtGTV4M4AkM4oyTvHlTc/
	 dozFazcACAuj8EotbA4zjvUc/q3OGkD3QeBy+f27NcjnZgXPYytHVUeM681jYWQAha
	 MiDV9hyjl9LQJfLeD7SUBThIzKsRBzo6EyWASE2wMTRjYJDKnxejhJNDWhOXNQ30Ci
	 qjC0NOhtS9+dFLjqVZeRamKemrT/esFnuwh2tHI1aFxkjEsliRYqjnZSEZueXblqNj
	 44/OyrH/LspvQ==
Message-ID: <07eee1c8cebf02f346b46ba55164f6dfc5f36e91.camel@kernel.org>
Subject: Re: [PATCH 3/6] landlock: Add MPTCP bind and connect access rights
From: Geliang Tang <geliang@kernel.org>
To: =?ISO-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>
Cc: =?ISO-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>, 
 =?ISO-8859-1?Q?Micka=EBl_Sala=FCn?=	 <mic@digikod.net>, Matthieu Baerts
 <matttbe@kernel.org>, Mat Martineau	 <martineau@kernel.org>, Mikhail Ivanov
 <ivanov.mikhail1@huawei-partners.com>, 	mptcp@lists.linux.dev,
 netdev@vger.kernel.org, 	linux-security-module@vger.kernel.org
Date: Wed, 30 Sep 2026 11:50:02 +0800
In-Reply-To: <arPhu-qFxCgmfk87@google.com>
References: <20260830201650.67050-1-gnoack3000@gmail.com>
	 <20260830201650.67050-4-gnoack3000@gmail.com>
	 <c0bf0918bd97105ee50f1436e6ff729e84cedf03.camel@kernel.org>
	 <a5a2f4353d0c2a1b1f86ebf466838f5ef3de27ce.camel@kernel.org>
	 <arPhu-qFxCgmfk87@google.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.2-9 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Günther,

On Wed, 2026-09-23 at 16:27 +0200, Günther Noack wrote:
> On Wed, Sep 23, 2026 at 01:04:40PM +0800, Geliang Tang wrote:
> > On Mon, 2026-08-31 at 12:09 +0800, Geliang Tang wrote:
> > > On Sun, 2026-08-30 at 22:16 +0200, Günther Noack wrote:
> > > > MPTCP sockets have equivalent bind(2) and connect(2) operations
> > > > as
> > > > TCP
> > > > sockets, but can not currently be restricted with Landlock
> > > > without
> > > > explicit MPTCP access rights.  As MPTCP operates on the same
> > > > TCP
> > > > port
> > > > number space as TCP, this is a gap in Landlock's policies.
> > > > 
> > > > Add access rights for MPTCP bind(2) and connect(2) operations
> > > > and document them in the header.
> > > > 
> > > > Treat TCP Fast Open the same as done for plain TCP in
> > > > commit 33cb713db016 ("landlock: Fix TCP Fast Open connection
> > > > bypass")
> > > > 
> > > > The port numbers used in MPTCP subflows are negotiated by the
> > > > kernel
> > > > and therefore not subject to these access rights.
> > > > 
> > > > Bump the Landlock ABI version to 12.
> > > > 
> > > > Closes: https://github.com/landlock-lsm/linux/issues/54
> > > > Signed-off-by: Günther Noack <gnoack3000@gmail.com>
> > > > ---
> > > >  include/linux/landlock.h                     |  5 +-
> > > >  include/uapi/linux/landlock.h                | 24 +++++++
> > > >  security/landlock/limits.h                   |  2 +-
> > > >  security/landlock/net.c                      | 68
> > > > ++++++++++++++--
> > > > --
> > > > --
> > > >  security/landlock/syscalls.c                 |  2 +-
> > > >  tools/testing/selftests/landlock/base_test.c |  2 +-
> > > >  6 files changed, 79 insertions(+), 24 deletions(-)
> > > > 
> > > > diff --git a/include/linux/landlock.h
> > > > b/include/linux/landlock.h
> > > > index 004cbd0b9298..b04ffc7caa21 100644
> > > > --- a/include/linux/landlock.h
> > > > +++ b/include/linux/landlock.h
> > > > @@ -46,7 +46,10 @@
> > > >  	_LANDLOCK_NAME_ENTRY(LANDLOCK_ACCESS_NET_CONNECT_TCP,
> > > > "connect_tcp"), \
> > > >  	_LANDLOCK_NAME_ENTRY(LANDLOCK_ACCESS_NET_BIND_UDP,
> > > > "bind_udp"), \
> > > >  	_LANDLOCK_NAME_ENTRY(LANDLOCK_ACCESS_NET_CONNECT_SEND_
> > > > UDP,
> > > > \
> > > > -			     "connect_send_udp")
> > > > +			     "connect_send_udp"), \
> > > > +	_LANDLOCK_NAME_ENTRY(LANDLOCK_ACCESS_NET_BIND_MPTCP,
> > > > "bind_mptcp"), \
> > > > +	_LANDLOCK_NAME_ENTRY(LANDLOCK_ACCESS_NET_CONNECT_MPTCP
> > > > , \
> > > > +			     "connect_mptcp")
> > > >  
> > > >  #define _LANDLOCK_SCOPE_NAMES \
> > > >  	_LANDLOCK_NAME_ENTRY(LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCK
> > > > ET,
> > > > \
> > > > diff --git a/include/uapi/linux/landlock.h
> > > > b/include/uapi/linux/landlock.h
> > > > index cceda3b3b961..2a953ba7ce25 100644
> > > > --- a/include/uapi/linux/landlock.h
> > > > +++ b/include/uapi/linux/landlock.h
> > > > @@ -448,6 +448,9 @@ struct landlock_net_port_attr {
> > > >   * - %LANDLOCK_ACCESS_NET_CONNECT_TCP: Connect TCP sockets to
> > > > the
> > > > given
> > > >   *   remote port. Support added in Landlock ABI version 4.
> > > >   *
> > > > + * .. note:: These rights do not apply to MPTCP sockets, which
> > > > have
> > > > their own
> > > > + *   access rights (see below).
> > > > + *
> > > >   * And similarly for UDP port numbers:
> > > >   *
> > > >   * - %LANDLOCK_ACCESS_NET_BIND_UDP: Bind UDP sockets to the
> > > > given
> > > > local
> > > > @@ -474,12 +477,33 @@ struct landlock_net_port_attr {
> > > >   * .. note:: Sending datagrams to an ``AF_UNSPEC`` destination
> > > > address
> > > >   *   family is not supported for IPv6 UDP sockets: you will
> > > > need
> > > > to
> > > > use a
> > > >   *   ``NULL`` address instead.
> > > > + *
> > > > + * MPTCP sockets (created with ``IPPROTO_MPTCP``) use TCP port
> > > > numbers, but
> > > > + * they are controlled by their own access rights:
> > > > + *
> > > > + * - %LANDLOCK_ACCESS_NET_BIND_MPTCP: Bind MPTCP sockets to
> > > > the
> > > > given local
> > > > + *   port. Support added in Landlock ABI version 12.
> > > > + * - %LANDLOCK_ACCESS_NET_CONNECT_MPTCP: Connect MPTCP sockets
> > > > to
> > > > the given
> > > > + *   remote port. Support added in Landlock ABI version 12.
> > > > + *
> > > > + * .. note:: The TCP and the MPTCP access rights are
> > > > independent,
> > > > even though
> > > > + *   they refer to the same port number space. Handling only
> > > > + *   %LANDLOCK_ACCESS_NET_BIND_TCP and
> > > > %LANDLOCK_ACCESS_NET_CONNECT_TCP leaves
> > > > + *   MPTCP sockets unrestricted, and vice versa. A sandbox
> > > > that
> > > > wants to
> > > > + *   control all TCP-based traffic needs to handle both sets.
> > > > + *
> > > > + * .. note:: These MPTCP access rights restrict the ports
> > > > passed
> > > > to
> > > > + *   :manpage:`bind(2)` and :manpage:`connect(2)`. The ports
> > > > used
> > > > in
> > > > MPTCP
> > > > + *   subflows are negotiated in the MPTCP protocol by the
> > > > kernel
> > > > and
> > > > are not
> > > > + *   subject to these restrictions.
> > > >   */
> > > >  /* clang-format off */
> > > >  #define LANDLOCK_ACCESS_NET_BIND_TCP			(1ULL
> > > > <<
> > > > 0)
> > > >  #define
> > > > LANDLOCK_ACCESS_NET_CONNECT_TCP			(1ULL << 1)
> > > >  #define LANDLOCK_ACCESS_NET_BIND_UDP			(1ULL
> > > > <<
> > > > 2)
> > > >  #define LANDLOCK_ACCESS_NET_CONNECT_SEND_UDP		(1ULL
> > > > <<
> > > > 3)
> > > > +#define LANDLOCK_ACCESS_NET_BIND_MPTCP			(1ULL
> > > > <<
> > > > 4)
> > > > +#define LANDLOCK_ACCESS_NET_CONNECT_MPTCP		(1ULL
> > > > <<
> > > > 5)
> > > >  /* clang-format on */
> > > >  
> > > >  /**
> > > > diff --git a/security/landlock/limits.h
> > > > b/security/landlock/limits.h
> > > > index 1a7c5fb8f6fd..d25e056b7ca2 100644
> > > > --- a/security/landlock/limits.h
> > > > +++ b/security/landlock/limits.h
> > > > @@ -23,7 +23,7 @@
> > > >  #define
> > > > LANDLOCK_MASK_ACCESS_FS		((LANDLOCK_LAST_ACCESS_FS <<
> > > > 1) -
> > > > 1)
> > > >  #define
> > > > LANDLOCK_NUM_ACCESS_FS		__const_hweight64(LANDLOCK_MAS
> > > > K_AC
> > > > CESS_FS)
> > > >  
> > > > -#define
> > > > LANDLOCK_LAST_ACCESS_NET	LANDLOCK_ACCESS_NET_CONNECT_SE
> > > > ND_U
> > > > DP
> > > > +#define
> > > > LANDLOCK_LAST_ACCESS_NET	LANDLOCK_ACCESS_NET_CONNECT_MP
> > > > TCP
> > > >  #define
> > > > LANDLOCK_MASK_ACCESS_NET	((LANDLOCK_LAST_ACCESS_NET
> > > > << 1) - 1)
> > > >  #define
> > > > LANDLOCK_NUM_ACCESS_NET		__const_hweight64(LANDLOCK_MAS
> > > > K_AC
> > > > CESS_NET)
> > > >  
> > > > diff --git a/security/landlock/net.c b/security/landlock/net.c
> > > > index 8f2aaac54b33..8541b0c07d64 100644
> > > > --- a/security/landlock/net.c
> > > > +++ b/security/landlock/net.c
> > > > @@ -11,6 +11,7 @@
> > > >  #include <linux/net.h>
> > > >  #include <linux/socket.h>
> > > >  #include <net/ipv6.h>
> > > > +#include <net/mptcp.h>
> > > >  
> > > >  #include "common.h"
> > > >  #include "cred.h"
> > > > @@ -53,6 +54,26 @@ int landlock_append_net_rule(struct
> > > > landlock_ruleset *const ruleset,
> > > >  	return err;
> > > >  }
> > > >  
> > > > +static bool sk_is_mptcp_socket(const struct sock *sk)
> > > > +{
> > > > +	return sk_is_inet(sk) && sk->sk_type == SOCK_STREAM &&
> > > > +	       sk->sk_protocol == IPPROTO_MPTCP;
> > > > +}
> > > 
> > > This helper should be placed in include/net/mptcp.h. I had
> > > already
> > > implemented one in [1], called sk_is_msk(), to differentiate it
> > > from
> > > sk_is_mptcp(). If you have no concerns with my implementation,
> > > please
> > > feel free to pick it up and use it in your series.
> > 
> > Sorry, let me correct myself. I thought about this more carefully,
> > and
> > the ideal place to define sk_is_msk() is in include/net/sock.h,
> > between
> > sk_is_tcp() and sk_is_udp():
> > 
> > static inline bool sk_is_tcp(const struct sock *sk) 
> > {
> >         return sk_is_inet(sk) &&
> >                sk->sk_type == SOCK_STREAM &&
> >                sk->sk_protocol == IPPROTO_TCP;
> > }
> > 
> > static inline bool sk_is_msk(const struct sock *sk) 
> > {
> >         return sk_is_inet(sk) &&
> >                sk->sk_type == SOCK_STREAM &&
> >                sk->sk_protocol == IPPROTO_MPTCP;
> > }
> > 
> > static inline bool sk_is_udp(const struct sock *sk) 
> > {
> >         return sk_is_inet(sk) &&
> >                sk->sk_type == SOCK_DGRAM &&
> >                sk->sk_protocol == IPPROTO_UDP;
> > }
> > 
> > If possible, please fold this code into this patch.
> 
> Thank you for the review, Geliang!
> 
> I'll include something like this in the next review round.
> (We are a bit bottlenecked on doing Landlock code reviews at the
> moment,
> so some delays are unfortunately expected.)
> 
> Small question about the function name sk_is_msk(): Is "msk" the
> right
> name for this?  It seems to be used as abbreviation for "MPTCP" in
> net/mptcp, but it's also used in net/mctp as an abbreviation, and I

Thanks for the heads-up! I hadn't considered that "msk" is also used as
an abbreviation in net/mctp.

> could not find a function name in include/net/mptcp.h which used
> "msk"
> to mean "MPTCP".  Should that say sk_is_mptcp() instead?

However, sk_is_mptcp() is already taken - it's defined in
include/net/mptcp.h and used to check whether a socket is an MPTCP
subflow (tcp_sk(sk)->is_mptcp).


So I'd like to propose the following rename scheme:

- Rename the existing sk_is_mptcp() (subflow check) to ssk_is_mptcp(),
where "ssk" stands for "subflow socket".

- Rename sk_is_msk() (the one I introduced here) to sk_is_mptcp(),
which checks whether the socket is the MPTCP socket itself.

This would give a consistent naming scheme:

  sk_is_mptcp()    - is this the MPTCP socket?
  ssk_is_mptcp()   - is this an MPTCP subflow?
  rsk_is_mptcp()   - is this an MPTCP request subflow?

We'll need to discuss this with the MPTCP maintainers before
proceeding.

Thanks,
-Geliang

> 
> Thanks,
> —Günther
