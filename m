Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.7
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793260980;
	b=faGtyOEN6hIbnXmiqOJfoielLlkedGvh6F1BeiGVAZHYAS35VTesmM+4j+xcTH9mKNSN
	 rRDDFwaI4InHJDPjUhko9OI5s9r+sGCoqL9cu9cHfb1x/D+9wNaNhb1kESRBwkuXJfQwD
	 UzwMW46OQB9/o1i8oqvYxbIB+609zKEdXrQJTloOFTnipsl2YzxZWOSs1wk8mTNvCuS1p
	 7gXggFh8G+7r+yzMSKQxmf0kcbIlyqXF1VYo4jjznhlHxi/dYSv1shuC1uQ76Xy0CX117
	 lJPsaqbEjB/hHHZcz/hbtaXCFxbG4qZAj1iqC0f02YhzYxwgpcjjly9ue7tNmfXHKCw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793260980;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:MIME-Version:Date:Content-Type:
	 Content-Transfer-Encoding:From:Message-ID:TLS-Required:Subject:To:Cc:
	 In-Reply-To:References;
	bh=1rbj7wvVXNmL3PUyISA9geKh98Ts8W387b6f/PyNAOk=;
	b=JWd28OOlMIfqJ4grm+9m5vID0wMCDmmc4TD6+qTYKu9G9TifP19KLFWJuce7MoeYmtGl
	 HvdF7RK12ms7mhKhFMPGfOOMV1sWzHZTPccFe9cYBlpRWRsKpeUR7/iH1vFAvGitkT9US
	 HEviZaB1fs+oA/IxQvU9zW0Ln1DZ82dd1rzoPaa7XeWWS5DnQzoaxKW3buIq+zomNI8Ue
	 ZFCQboAHmgF/UYA326J5cqIkmsXTLifvdlejAKwoF9EVCr2xSEj3WBluFVh7C0bs7yAU8
	 kiA5xcplz4eRfCv6m3eluDU9QzmXskOsFGSxdUaBQ/0/h7U4mUmCvURSp4iDJ9FFkWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=cIOSm7V+;
	arc=none smtp.remote-ip=91.218.175.7
Received: from mta0.migadu.com (out-7.mta0.migadu.com [91.218.175.7])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA70606A31D
	for <mptcp@lists.linux.dev>; Thu, 29 Oct 2026 08:02:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9AA70606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=cIOSm7V+
X-Envelope-To: mptcp@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=67ftyRJklHTQSw6DhAS9t+f5zCKnUSz0olqnnN5c9Vc=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793260976; v=1; x=1793865776;
 b=cIOSm7V+HxkiIdKtUBihXexWqWQrGQziq/PxoVmZ8SGH1jddZfI1huVqVX4MID9b8deuSIWf
 bDvId86P389vmcsUdpiM9+ik0Pyt+WcVmTHM77D4J9LI+RnyfjgxnFW0TFMuClDtN+kev5oEpbL
 iiYiAha0xkFJjpcmeIDUBAlk=
X-Envelope-To: mptcp@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id 91043d89a12ae494;
	Thu, 29 Oct 2026 08:02:56 +0000
X-Mizu-Trace-ID: 91043d89a12ae494
X-Migadu-Flow: FLOW_OUT
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Date: Thu, 29 Oct 2026 08:02:52 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
From: gang.yan@linux.dev
Message-ID: <71116e2870aa207609ef8606d6f087cd21757e1a@linux.dev>
TLS-Required: No
Subject: Re: [PATCH mptcp-net v3] mptcp: protect listener backlog reads in
 diagnostics
To: "Cen Zhang" <zzzccc427@gmail.com>, matttbe@kernel.org,
 martineau@kernel.org
Cc: geliang@kernel.org, mptcp@lists.linux.dev, edumazet@kernel.org,
 baijiaju1990@gmail.com, jjzuming@gmail.com, zzzccc427@gmail.com
In-Reply-To: <pm-mptcp-objects-candidate-0066-v6-36c93fb39222b9c59043@gmail.com>
References: <pm-mptcp-objects-candidate-0066-v6-36c93fb39222b9c59043@gmail.com>

>=20
>=20mptcp_diag_get_info() reports the accept queue of a listening MPTCP
> socket by reading msk->first. The token based dump and the exact token
> query only hold a reference on the MPTCP socket, which pins neither the
> first subflow nor the listener hash bucket, and __mptcp_close_ssk()
> drops the last reference on the first subflow before clearing
> msk->first.
>=20
>=20An application can disconnect a connected MPTCP socket with AF_UNSPEC=
,
> which removes the token but retains the first subflow, listen on it
> again and close it. A dump that obtained the MPTCP socket before the
> disconnect then reads the backlog of a freed TCP listener:
>=20
>=20 Token diagnostic Application
>  mptcp_token_iter_next()
>  retain MPTCP socket
>  connect(AF_UNSPEC)
>  remove token, retain first
>  listen()
>  reuse first
>  mptcp_diag_get_info()
>  observe TCP_LISTEN
>  lsk =3D msk->first
>  close()
>  mptcp_destroy()
>  __mptcp_close_ssk()
>  release first
>  read lsk->sk_ack_backlog
>=20
>=20The report below was decoded with scripts/decode_stacktrace.sh agains=
t
> the 7.2.0-rc5 based test kernel that produced it, with the line numbers
> mapped to this tree; only the relevant frames are kept:
>=20
>=20 BUG: KASAN: slab-use-after-free in mptcp_diag_get_info (net/mptcp/mp=
tcp_diag.c:209)
>  Read of size 4 at addr ffff888111763818 by task python3/499
>=20
>=20 Call Trace:
>  mptcp_diag_get_info (net/mptcp/mptcp_diag.c:209)
>  inet_sk_diag_fill (net/ipv4/inet_diag.c:330)
>  mptcp_diag_dump (net/mptcp/mptcp_diag.c:23 net/mptcp/mptcp_diag.c:177)
>  __inet_diag_dump (net/ipv4/inet_diag.c:823)
>  netlink_dump (net/netlink/af_netlink.c:2355)
>=20
>=20 Allocated by task 497:
>  sk_alloc (net/core/sock.c:2337)
>  inet_create (net/ipv4/af_inet.c:333)
>  __sock_create (net/socket.c:1679)
>  mptcp_subflow_create_socket (net/mptcp/subflow.c:1836)
>  __mptcp_nmpc_sk (net/mptcp/protocol.c:111 net/mptcp/protocol.c:143)
>  mptcp_setsockopt (net/mptcp/sockopt.c:313 net/mptcp/sockopt.c:916)
>=20
>=20 Freed by task 0:
>  slab_free_after_rcu_debug (mm/slub.c:6571)
>  rcu_core (kernel/rcu/tree.c:2919)
>=20
>=20 Second to last potentially related work creation:
>  __call_rcu_common.constprop.0 (kernel/rcu/tree.c:3287)
>  sk_destruct (net/core/sock.c:2446)
>  __sk_free (net/core/sock.c:2459)
>  sk_free (net/core/sock.c:2470)
>  __mptcp_close_ssk (include/net/sock.h:2024 net/mptcp/protocol.c:2723)
>  mptcp_destroy_common (net/mptcp/protocol.c:3581)
>  mptcp_destroy (net/mptcp/protocol.c:3817)
>  __mptcp_destroy_sock (net/mptcp/protocol.c:3423)
>  __mptcp_close (net/mptcp/protocol.c:3525)
>  mptcp_close (net/mptcp/protocol.c:3540)
>  inet_release (net/ipv4/af_inet.c:442)
>=20
>=20The first subflow is a TCP socket: TCP listeners carry SOCK_RCU_FREE
> and tcp_prot/tcpv6_prot sockets live in SLAB_TYPESAFE_BY_RCU caches, so
> reading the two backlog counters under rcu_read_lock() is safe, and a
> stale value is acceptable for diagnostics. mptcp_diag_dump_listeners()
> already runs the formatter inside an RCU read-side section; only the
> token dump and mptcp_diag_dump_one() reach it without one. Take
> rcu_read_lock() around the msk->first snapshot and the backlog reads.
>=20
>=20That alone does not cover the token dump: __mptcp_close_ssk() clears
> msk->first only after dropping its reference on the first subflow, so a
> dump that enters its read-side section once the grace period has ended
> can still load the pointer to the freed listener. Clear msk->first
> before dropping the reference, as mptcp_sk_clone_init() already does on
> its error path.
>=20
>=20Fixes: 4fa39b701ce9 ("mptcp: listen diag dump support")
> Suggested-by: Eric Dumazet <edumazet@kernel.org>
> Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
> Assisted-by: LLM

Hi Cen

According to [1], the Assisted-by tag is not required here.

> ---
> Changes in v3:
> - Clear msk->first in __mptcp_close_ssk() before dropping the reference=
 on
>  the first subflow: the RCU read-side section only protects a pointer t=
hat
>  is cleared before the subflow can be released (Sashiko review).
> - Rebase on the export-net branch of mptcp_net-next and remap the decod=
ed
>  line numbers to it; send to the MPTCP list only, as Gang Yan and Matth=
ieu
>  Baerts suggested.
>=20
>=20Changes in v2:
> - Take rcu_read_lock() around the first subflow reads instead of the MP=
TCP
>  data lock plus an owner check, as suggested by Eric Dumazet; this avoi=
ds
>  the new msk slock -> listener hash lock nesting and keeps ss reporting=
 the
>  accept queue while the socket is owned.
> - Decode the stack trace with scripts/decode_stacktrace.sh, map the lin=
e
>  numbers to this tree and keep only the relevant frames.
>=20
>=20Link to v1: https://lore.kernel.org/r/pm-mptcp-objects-candidate-0066=
-v3-73df72b7a543d4cada0e@gmail.com
> Link to v2: https://lore.kernel.org/r/pm-mptcp-objects-candidate-0066-v=
5-4d1b83d62fcde2d57e8d@gmail.com
>=20
>=20 net/mptcp/mptcp_diag.c | 5 ++++-
>  net/mptcp/protocol.c | 7 +++++--
>  2 files changed, 9 insertions(+), 3 deletions(-)
>=20
>=20diff --git a/net/mptcp/mptcp_diag.c b/net/mptcp/mptcp_diag.c
> index 136c2d05c0ee..28a42eee6651 100644
> --- a/net/mptcp/mptcp_diag.c
> +++ b/net/mptcp/mptcp_diag.c
> @@ -200,8 +200,10 @@ static void mptcp_diag_get_info(struct sock *sk, s=
truct inet_diag_msg *r,
>  r->idiag_wqueue =3D sk_wmem_alloc_get(sk);
>=20=20
>=20 if (inet_sk_state_load(sk) =3D=3D TCP_LISTEN) {
> - struct sock *lsk =3D READ_ONCE(msk->first);
> + struct sock *lsk;
>=20=20
>=20+ rcu_read_lock();
> + lsk =3D READ_ONCE(msk->first);
>  if (lsk) {
>  /* override with settings from tcp listener,
>  * so Send-Q will show accept queue.
> @@ -209,6 +211,7 @@ static void mptcp_diag_get_info(struct sock *sk, st=
ruct inet_diag_msg *r,
>  r->idiag_rqueue =3D READ_ONCE(lsk->sk_ack_backlog);
>  r->idiag_wqueue =3D READ_ONCE(lsk->sk_max_ack_backlog);
>  }
> + rcu_read_unlock();
>  }
>=20=20
>=20 if (!info)
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 4335eb8f9f2d..efc6d4db5bbc 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -2720,11 +2720,14 @@ static void __mptcp_close_ssk(struct sock *sk, =
struct sock *ssk,
>  __mptcp_subflow_error_report(sk, ssk);
>  release_sock(ssk);
>=20=20
>=20- sock_put(ssk);
> -
> + /* the diag code reads msk->first under RCU only: clear it before
> + * dropping the reference that keeps the subflow alive
> + */

This comment doesn't seem necessary. I'd suggest dropping it.

Otherwise LGTM.

Reviewed-by: Gang Yan <gang.yan@linux.dev>


[1] https://lore.kernel.org/lkml/87o6cww7c1.fsf@trenco.lwn.net/
>  if (ssk =3D=3D msk->first)
>  WRITE_ONCE(msk->first, NULL);
>=20=20
>=20+ sock_put(ssk);
> +
>  out:
>  __mptcp_sync_sndbuf(sk);
>  if (need_push)
> --=20


>=202.43.0
>
