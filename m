Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794844692;
	b=Ij+/Sk/xkYLeyjV3WBiPNdkbmaHgMZrUtLnKbLBwyvQJ7IP2RB3pLxe6ug3xShWoADYQ
	 oN2/GsHcXsIZ5j6X6wYd3a1mXmmdImjb1SvD/crmO0nQ0u5peqhuotaE7B90NePXE9QeE
	 P8m9JWzMfhW3c0qx3S7NDYXfMbMrdw8tFjQqEcxrlIe+TMqd+pSzyT10DjmoAQItnzwDA
	 mkZYxPgNzO7Z76gevaV42Xt71rbt2hFhcfU4MBn7Hns3tGnwT6W6tc8JG2CmCH20G60PJ
	 1ujKQUb3v2NHiZfhgfTqUVIJGcLcD3bKqCX86oEpfa/pfrUaZKLjXdfWaNReBjQaewQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794844692;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=XfQsVmpol6CZkxbTIJqfmqO/hjX8YRToeaIL4bg6tfs=;
	b=wnWbPRrYFc6goQdaQT+G59eQBtcrAlWShwEayzwY7fKJU3oP2aGGl/q6VYLg2nYmgElO
	 2zQe43klZGtxWtZrwTdWkwSJcSnOBDnyBA2rG6r1lMz8J/8rz5BbUoZI7ZIN2pkxe2jvB
	 lSQPHGuTvPVvPISGdPFzl9H0s/VJjLe03j7woNPDpa1CvIBHMiFyFMBSzq2vvT3O3q2Lx
	 HZIqxaOeVXXT8+QZJW9u9+Q3gYbKa2RvmUZh3mY9edfNbGYYbq88GxjuoYu/HyrB8UvIm
	 oFHOVB7hBwOOK2BKM0FMy0HjT5/T641p8abAm+tBwueRY7y9VRcqqA9aufeHCnDthNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aS+1iLih;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F399606A31C
	for <mptcp@lists.linux.dev>; Mon, 16 Nov 2026 15:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aS+1iLih
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 445921F000CA;
	Mon, 16 Nov 2026 15:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794844692;
	bh=XfQsVmpol6CZkxbTIJqfmqO/hjX8YRToeaIL4bg6tfs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aS+1iLihEw9TCfyjqFKNlvsYIZja8cSZWnKVG6BBlEFpc0E7+lWLf9WIRzkxkq1li
	 FCvWv9cDh+eu79QWrUjcEY+F7vGiQ0ASmhZI+savV43AFVgQzyB3Ih141rIkD69b4E
	 Md+siDlMhuo+EsmbPGX9ZzhAjVePxSV6LcmvusV95Q1BxzjsAgkQggMYfMj7A8mCc2
	 7etEnIbaYGzhAx/Z8iCciLwgTqGXq1RKyADvXpzQ5g2imSkebIFNTQkGcGnnhVl2tQ
	 HBiJaxejpEJcdaY168StNQMLllQP871YwSdFE4Wjw4B2pFA0KNdi1YJaXNOuj5AUDK
	 yuLEFci47X3GA==
Message-ID: <sashiko-outbox-217329@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v4 3/3] net: mptcp: verify the token slot in
 mptcp_token_iter_next()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hang Nan" <2122295973@qq.com>
Cc: mptcp@lists.linux.dev
In-Reply-To: <tencent_647B95315D18DBA311A33E8120517E1DA60A@qq.com>
References: <20261115155747.178858-1-2122295973@qq.com>
 <tencent_647B95315D18DBA311A33E8120517E1DA60A@qq.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 15:58:11 +0000
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] net: mptcp: mptcp_token_iter_next() can return unhashed clone
  from mptcp_sk_clone_init()
--

commit 360d7517d4f418ef6ade9477ae90312992cd23fa
Author: Hang Nan <2122295973@qq.com>

net: mptcp: verify the token slot in mptcp_token_iter_next()

This commit re-reads msk->token after taking a socket reference in
mptcp_token_iter_next() and drops the socket if the token is zero or no
longer hashes to the current slot.

> diff --git a/net/mptcp/token.c b/net/mptcp/token.c
> index 8a603fc8dc059..48470d6e751d6 100644
> --- a/net/mptcp/token.c
> +++ b/net/mptcp/token.c
> @@ -355,6 +355,7 @@ struct mptcp_sock *mptcp_token_iter_next(const struct=
 net *net, long *s_slot,
>  	struct mptcp_sock *ret =3D NULL;
>  	struct hlist_nulls_node *pos;
>  	int slot, num =3D 0;
> +	u32 token;
> =20
>  	for (slot =3D *s_slot; slot <=3D token_mask; *s_num =3D 0, slot++) {
>  		struct token_bucket *bucket =3D &token_hash[slot];
> @@ -377,7 +378,9 @@ struct mptcp_sock *mptcp_token_iter_next(const struct=
 net *net, long *s_slot,
>  			if (!refcount_inc_not_zero_acquire(&sk->sk_refcnt))
>  				continue;
> =20
> -			if (!net_eq(sock_net(sk), net)) {
> +			token =3D READ_ONCE(mptcp_sk(sk)->token);
> +			if (!token || (token & token_mask) !=3D slot ||
> +			    !net_eq(sock_net(sk), net)) {
>  				sock_put(sk);
>  				continue;
>  			}

[Severity: Medium]
Can mptcp_token_iter_next() still return an unhashed mptcp_sock while
mptcp_sk_clone_init() is initializing or tearing it down?

If a freed mptcp_sock from token_hash[slot] is reused via
SLAB_TYPESAFE_BY_RCU by mptcp_sk_clone_init() in the same netns for a
passive connection whose subflow_req->token hashes to the same slot,
sk_clone_lock() sets sk_refcnt to 2 and mptcp_sk_clone_init() writes
msk->token before the clone is fully initialized or hashed:

CPU0                                  CPU1
mptcp_token_iter_next()               /* sk freed from token_hash[slot] */
  sk_nulls_for_each_rcu(sk, ...)
                                      mptcp_sk_clone_init()
                                        nsk =3D sk_clone_lock() /* reuses s=
k */
                                        WRITE_ONCE(msk->token,
                                                   subflow_req->token)
  refcount_inc_not_zero_acquire()
  token =3D READ_ONCE(msk->token)
  /* token !=3D 0 && same slot/net */
  return msk;  <-- unhashed clone
                                        mptcp_init_sched()
                                        ...
                                        mptcp_token_accept()

Callers such as mptcp_diag_dump() can then access nsk before
mptcp_init_sched(), sock_reset_flag(nsk, SOCK_RCU_FREE),
security_inet_csk_clone() and mptcp_copy_inaddrs() have executed.  In
addition, if mptcp_token_accept() fails, mptcp_sk_clone_destroy() calls
inet_csk_destroy_sock() -> mptcp_destroy() -> mptcp_destroy_common() ->
mptcp_token_destroy(), which returns early when sk_unhashed() is true
without clearing msk->token to 0, allowing a concurrent iterator to take a
reference during unlocked teardown.

Checking sk_unhashed(sk) after taking the reference (or setting msk->token
inside mptcp_token_accept() under bucket->lock as mptcp_token_new_connect()
does) would avoid returning an unhashed clone.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/tencent_D0DCF4B132B=
20B70FB5AE2D9272AA4AEAF07@qq.com?part=3D3
