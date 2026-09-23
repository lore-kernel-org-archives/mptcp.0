Received: from mail-wr2-f38.google.com (mail-wr2-f38.google.com [74.125.225.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E955293E9
	for <mptcp@lists.linux.dev>; Wed, 23 Sep 2026 14:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790173638; cv=none; b=XV1lB1il4fg1AtTAsE5us5gBW3SXn8Cu1Yn0JAaUJT8tUwd2Rl7SlL2z/eRcBhV6veZOpz+hxg38afDWtqKnHIyyW1HEIvx3Ox4V2c5ZRBQIaheSbubErkbXV4c8b5FGXbgyEPMT6HGc3INviKVAL9NQmx9uUoHP+ddi9LFz+nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790173638; c=relaxed/simple;
	bh=8h06L4zgt0xbnYaqADQB9yddRobQhsv4hVUNTqVY1jo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ugtv81k+b8ebcq4IvQQ0U8oa06FfTTXCBsKy7xb9HrCpt6gmh3Xf7oIc8mBdn/FYRSKPqRwNNXk6uOxQBT8cAsf1Ft034GQlR+aZKmgzjYJo6AIlZEqrujHbxCj9BQqD0n8YsMnsdxPa/zPcLPcZ25X9q4QTAZWWhypVZZb0TQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QdPcRwk/; arc=none smtp.client-ip=74.125.225.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QdPcRwk/"
Received: by mail-wr2-f38.google.com with SMTP id ffacd0b85a97d-482f6350f89so764103f8f.3
        for <mptcp@lists.linux.dev>; Wed, 23 Sep 2026 07:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790173634; x=1790778434; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=PSzGnM9hkcOoFtPupK98ZapwC/NnVGSiD0/uooo0h9E=;
        b=QdPcRwk/wwfIrsR5o6bAQhUt5WGDyQ3EBE8l22bdjgWvor9jwb4otIt3ZElCph0SM+
         iCTmVIO/rEcqNx8ADSUM7Pc0ET87m0PF4nAta5APerXoFTgqhX8cV1Je/2hiHWxkIngx
         C8s/QKX/u9GmdgYlmDkVBb0k/Xpux8ly5AbkSP89zPK/kzwcs4GBIY8TJkAzbnqjVZxG
         Ij0ZeJJI6Oe5O3nE0JcK02p2qfbbgNqBgyvaGIJ8fXbX+C69M2UV/YabiQBjd+3BXoov
         ID+7vWxxNA2bce6oTx+fl62z4wuTYURXvuhZLUIbZHrXduNKOIQ+3I2EA5DQPeq6obLB
         Xodw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790173634; x=1790778434;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=PSzGnM9hkcOoFtPupK98ZapwC/NnVGSiD0/uooo0h9E=;
        b=tXAyhXhdyCT9+WcvJLpE/hqtvLBv0BEFVpSGr8H2urCYhcP/NHRKJbzMy46DM6pY84
         q/NvcugHBZOAk0ZzmhOATaKIRLxyMHZ6a5pjiwN1Gep5mtUx6E24JaZxW/57wjcQK1U+
         bgmsPH92pDvt+iXlk68yx5glc8saBQQBrYTUDW8SWD5bHVZ6acR7GpxfgEEKxe+j4TiA
         UPDURPtZoTMc4Bz5ITGZYrFWJSpRYKVSpxA46wXphDenZwA/ueTDgD6oTb4Th/guKjuV
         LJBoyTlcGw1l6PYwHRMQ8ID2s1wqwbpXLNqPEdA6G3ia4Cp6G4GivCrrj28Su4Z5aIgY
         oULw==
X-Forwarded-Encrypted: i=1; AKwUvBzLR+tK+uF2qIVNJofYfNnC7cmNfWlCANTniKNqG2hqwd8PANdEjpivlYNhxPfwM4VJDKa4og==@lists.linux.dev
X-Gm-Message-State: AFuF++mnDuadigWcftXcyuY4Bg9mhlLZ1NXKVsfhCLi3HMyO9/B+yXHa
	FNuXPLAOiQESbpJ1W5SZkQwLBHHQnpIkWQKW/T5R9HRF+ChIq5cTYCZaZk3G4H2AIA==
X-Gm-Gg: AYBFou3QCRWCdpL3e1QH7Xp3ZKjnVY7pqk46S/Ulfn3+7jUWEFO21klqRAU6HXkDW0V
	ptu+EuK2I1lhinP3eRlFi0GQW/+n8IhUTCCARrAp+Y6ai+3vQaL4BJmD8YmLE+wtui5JaOfRzpY
	UcnlXaz8SBoRkcXlHFSiqHe3GpetoRAT+yTP8w8ZPv1WdtpKaqJqR9QVIBlbwFlxiv8clRxdjn8
	W6gBzUrp1pbY6hBBTgUGSC8H0cT66hxpIOeu+VxAUoktKw7r07MGViP0sSs7yceBNPRZLan/PgZ
	NVH/pCWL7Y4khYY5Mo1qUopnNkndghLexglXkYgf/KhJ2TJnHdLF6oMAvsQpAZphMBNlEgZ4te+
	lq2Lue96Fiu2w6T2b/kOWqqiy4MsUfHAHYxdz60YiHmfjJKoaw9NWqN273jZRBr1m/8DqInJBtx
	BMPgBSbVrkxkJJgcV8xvxKhkV4lfrO8X3WE7qfP4kh6J2HObuq92+nhthDBrTt0HL2jnYiyKj7M
	FwtmrAMgTXECeL1TfBGVfMpWVVAsJo8JUST5Mbi
X-Received: by 2002:a05:600c:8a0a:10b0:49f:df99:ff1a with SMTP id 5b1f17b1804b1-49fdf99ffb9mr29806345e9.17.1790173632836;
        Wed, 23 Sep 2026 07:27:12 -0700 (PDT)
Received: from google.com ([2a00:79e0:288a:8:c20f:9e7a:eeee:1b06])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4886848636asm6964795f8f.6.2026.09.23.07.27.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 07:27:12 -0700 (PDT)
Date: Wed, 23 Sep 2026 16:27:07 +0200
From: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
To: Geliang Tang <geliang@kernel.org>
Cc: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack3000@gmail.com>,
	=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
	Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	mptcp@lists.linux.dev, netdev@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH 3/6] landlock: Add MPTCP bind and connect access rights
Message-ID: <arPhu-qFxCgmfk87@google.com>
References: <20260830201650.67050-1-gnoack3000@gmail.com>
 <20260830201650.67050-4-gnoack3000@gmail.com>
 <c0bf0918bd97105ee50f1436e6ff729e84cedf03.camel@kernel.org>
 <a5a2f4353d0c2a1b1f86ebf466838f5ef3de27ce.camel@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a5a2f4353d0c2a1b1f86ebf466838f5ef3de27ce.camel@kernel.org>

On Wed, Sep 23, 2026 at 01:04:40PM +0800, Geliang Tang wrote:
> On Mon, 2026-08-31 at 12:09 +0800, Geliang Tang wrote:
> > On Sun, 2026-08-30 at 22:16 +0200, Günther Noack wrote:
> > > MPTCP sockets have equivalent bind(2) and connect(2) operations as
> > > TCP
> > > sockets, but can not currently be restricted with Landlock without
> > > explicit MPTCP access rights.  As MPTCP operates on the same TCP
> > > port
> > > number space as TCP, this is a gap in Landlock's policies.
> > > 
> > > Add access rights for MPTCP bind(2) and connect(2) operations
> > > and document them in the header.
> > > 
> > > Treat TCP Fast Open the same as done for plain TCP in
> > > commit 33cb713db016 ("landlock: Fix TCP Fast Open connection
> > > bypass")
> > > 
> > > The port numbers used in MPTCP subflows are negotiated by the
> > > kernel
> > > and therefore not subject to these access rights.
> > > 
> > > Bump the Landlock ABI version to 12.
> > > 
> > > Closes: https://github.com/landlock-lsm/linux/issues/54
> > > Signed-off-by: Günther Noack <gnoack3000@gmail.com>
> > > ---
> > >  include/linux/landlock.h                     |  5 +-
> > >  include/uapi/linux/landlock.h                | 24 +++++++
> > >  security/landlock/limits.h                   |  2 +-
> > >  security/landlock/net.c                      | 68 ++++++++++++++--
> > > --
> > > --
> > >  security/landlock/syscalls.c                 |  2 +-
> > >  tools/testing/selftests/landlock/base_test.c |  2 +-
> > >  6 files changed, 79 insertions(+), 24 deletions(-)
> > > 
> > > diff --git a/include/linux/landlock.h b/include/linux/landlock.h
> > > index 004cbd0b9298..b04ffc7caa21 100644
> > > --- a/include/linux/landlock.h
> > > +++ b/include/linux/landlock.h
> > > @@ -46,7 +46,10 @@
> > >  	_LANDLOCK_NAME_ENTRY(LANDLOCK_ACCESS_NET_CONNECT_TCP,
> > > "connect_tcp"), \
> > >  	_LANDLOCK_NAME_ENTRY(LANDLOCK_ACCESS_NET_BIND_UDP,
> > > "bind_udp"), \
> > >  	_LANDLOCK_NAME_ENTRY(LANDLOCK_ACCESS_NET_CONNECT_SEND_UDP,
> > > \
> > > -			     "connect_send_udp")
> > > +			     "connect_send_udp"), \
> > > +	_LANDLOCK_NAME_ENTRY(LANDLOCK_ACCESS_NET_BIND_MPTCP,
> > > "bind_mptcp"), \
> > > +	_LANDLOCK_NAME_ENTRY(LANDLOCK_ACCESS_NET_CONNECT_MPTCP, \
> > > +			     "connect_mptcp")
> > >  
> > >  #define _LANDLOCK_SCOPE_NAMES \
> > >  	_LANDLOCK_NAME_ENTRY(LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET,
> > > \
> > > diff --git a/include/uapi/linux/landlock.h
> > > b/include/uapi/linux/landlock.h
> > > index cceda3b3b961..2a953ba7ce25 100644
> > > --- a/include/uapi/linux/landlock.h
> > > +++ b/include/uapi/linux/landlock.h
> > > @@ -448,6 +448,9 @@ struct landlock_net_port_attr {
> > >   * - %LANDLOCK_ACCESS_NET_CONNECT_TCP: Connect TCP sockets to the
> > > given
> > >   *   remote port. Support added in Landlock ABI version 4.
> > >   *
> > > + * .. note:: These rights do not apply to MPTCP sockets, which
> > > have
> > > their own
> > > + *   access rights (see below).
> > > + *
> > >   * And similarly for UDP port numbers:
> > >   *
> > >   * - %LANDLOCK_ACCESS_NET_BIND_UDP: Bind UDP sockets to the given
> > > local
> > > @@ -474,12 +477,33 @@ struct landlock_net_port_attr {
> > >   * .. note:: Sending datagrams to an ``AF_UNSPEC`` destination
> > > address
> > >   *   family is not supported for IPv6 UDP sockets: you will need
> > > to
> > > use a
> > >   *   ``NULL`` address instead.
> > > + *
> > > + * MPTCP sockets (created with ``IPPROTO_MPTCP``) use TCP port
> > > numbers, but
> > > + * they are controlled by their own access rights:
> > > + *
> > > + * - %LANDLOCK_ACCESS_NET_BIND_MPTCP: Bind MPTCP sockets to the
> > > given local
> > > + *   port. Support added in Landlock ABI version 12.
> > > + * - %LANDLOCK_ACCESS_NET_CONNECT_MPTCP: Connect MPTCP sockets to
> > > the given
> > > + *   remote port. Support added in Landlock ABI version 12.
> > > + *
> > > + * .. note:: The TCP and the MPTCP access rights are independent,
> > > even though
> > > + *   they refer to the same port number space. Handling only
> > > + *   %LANDLOCK_ACCESS_NET_BIND_TCP and
> > > %LANDLOCK_ACCESS_NET_CONNECT_TCP leaves
> > > + *   MPTCP sockets unrestricted, and vice versa. A sandbox that
> > > wants to
> > > + *   control all TCP-based traffic needs to handle both sets.
> > > + *
> > > + * .. note:: These MPTCP access rights restrict the ports passed
> > > to
> > > + *   :manpage:`bind(2)` and :manpage:`connect(2)`. The ports used
> > > in
> > > MPTCP
> > > + *   subflows are negotiated in the MPTCP protocol by the kernel
> > > and
> > > are not
> > > + *   subject to these restrictions.
> > >   */
> > >  /* clang-format off */
> > >  #define LANDLOCK_ACCESS_NET_BIND_TCP			(1ULL <<
> > > 0)
> > >  #define
> > > LANDLOCK_ACCESS_NET_CONNECT_TCP			(1ULL << 1)
> > >  #define LANDLOCK_ACCESS_NET_BIND_UDP			(1ULL <<
> > > 2)
> > >  #define LANDLOCK_ACCESS_NET_CONNECT_SEND_UDP		(1ULL <<
> > > 3)
> > > +#define LANDLOCK_ACCESS_NET_BIND_MPTCP			(1ULL <<
> > > 4)
> > > +#define LANDLOCK_ACCESS_NET_CONNECT_MPTCP		(1ULL <<
> > > 5)
> > >  /* clang-format on */
> > >  
> > >  /**
> > > diff --git a/security/landlock/limits.h
> > > b/security/landlock/limits.h
> > > index 1a7c5fb8f6fd..d25e056b7ca2 100644
> > > --- a/security/landlock/limits.h
> > > +++ b/security/landlock/limits.h
> > > @@ -23,7 +23,7 @@
> > >  #define
> > > LANDLOCK_MASK_ACCESS_FS		((LANDLOCK_LAST_ACCESS_FS << 1) -
> > > 1)
> > >  #define
> > > LANDLOCK_NUM_ACCESS_FS		__const_hweight64(LANDLOCK_MASK_AC
> > > CESS_FS)
> > >  
> > > -#define
> > > LANDLOCK_LAST_ACCESS_NET	LANDLOCK_ACCESS_NET_CONNECT_SEND_U
> > > DP
> > > +#define
> > > LANDLOCK_LAST_ACCESS_NET	LANDLOCK_ACCESS_NET_CONNECT_MPTCP
> > >  #define LANDLOCK_MASK_ACCESS_NET	((LANDLOCK_LAST_ACCESS_NET
> > > << 1) - 1)
> > >  #define
> > > LANDLOCK_NUM_ACCESS_NET		__const_hweight64(LANDLOCK_MASK_AC
> > > CESS_NET)
> > >  
> > > diff --git a/security/landlock/net.c b/security/landlock/net.c
> > > index 8f2aaac54b33..8541b0c07d64 100644
> > > --- a/security/landlock/net.c
> > > +++ b/security/landlock/net.c
> > > @@ -11,6 +11,7 @@
> > >  #include <linux/net.h>
> > >  #include <linux/socket.h>
> > >  #include <net/ipv6.h>
> > > +#include <net/mptcp.h>
> > >  
> > >  #include "common.h"
> > >  #include "cred.h"
> > > @@ -53,6 +54,26 @@ int landlock_append_net_rule(struct
> > > landlock_ruleset *const ruleset,
> > >  	return err;
> > >  }
> > >  
> > > +static bool sk_is_mptcp_socket(const struct sock *sk)
> > > +{
> > > +	return sk_is_inet(sk) && sk->sk_type == SOCK_STREAM &&
> > > +	       sk->sk_protocol == IPPROTO_MPTCP;
> > > +}
> > 
> > This helper should be placed in include/net/mptcp.h. I had already
> > implemented one in [1], called sk_is_msk(), to differentiate it from
> > sk_is_mptcp(). If you have no concerns with my implementation, please
> > feel free to pick it up and use it in your series.
> 
> Sorry, let me correct myself. I thought about this more carefully, and
> the ideal place to define sk_is_msk() is in include/net/sock.h, between
> sk_is_tcp() and sk_is_udp():
> 
> static inline bool sk_is_tcp(const struct sock *sk) 
> {
>         return sk_is_inet(sk) &&
>                sk->sk_type == SOCK_STREAM &&
>                sk->sk_protocol == IPPROTO_TCP;
> }
> 
> static inline bool sk_is_msk(const struct sock *sk) 
> {
>         return sk_is_inet(sk) &&
>                sk->sk_type == SOCK_STREAM &&
>                sk->sk_protocol == IPPROTO_MPTCP;
> }
> 
> static inline bool sk_is_udp(const struct sock *sk) 
> {
>         return sk_is_inet(sk) &&
>                sk->sk_type == SOCK_DGRAM &&
>                sk->sk_protocol == IPPROTO_UDP;
> }
> 
> If possible, please fold this code into this patch.

Thank you for the review, Geliang!

I'll include something like this in the next review round.
(We are a bit bottlenecked on doing Landlock code reviews at the moment,
so some delays are unfortunately expected.)

Small question about the function name sk_is_msk(): Is "msk" the right
name for this?  It seems to be used as abbreviation for "MPTCP" in
net/mptcp, but it's also used in net/mctp as an abbreviation, and I
could not find a function name in include/net/mptcp.h which used "msk"
to mean "MPTCP".  Should that say sk_is_mptcp() instead?

Thanks,
—Günther
