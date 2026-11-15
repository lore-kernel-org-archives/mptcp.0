Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794748197;
	b=IwCp0P/s/KNROfGyGtaOKPWoXLXDkPkLadtCgr3K2NHEcVMd958C6B0a945N9fQZhnfp
	 yhc+WLcR3xx/N3Mm0jtJSSDdf35m7PrDSeq/aGLDGIXeIlnfGlvg0scGpNqyXkYNzHrCV
	 eSi1mqODPGaAVv+zmBbXGwlQZiFCTZGKfjk/r7tz/AH5jKlWm6nRWjEh74U2CIrl0dEn2
	 Kd2nCh6vITOsu2gSgQbIssmO3wiU1qMMbycbb+2sKQW9OK0j0qs3aKLly5/h1XNo6GUN4
	 jh+aFsJ/4Q9wczvUYgSr/c3Mgkd5Zgf9YV5uhSHYs0CMz/i+9VnZVG4Un+Yi4MOCHJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794748197;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=A6cU/wUQzXorM71velcK/gF2oZrnIJxSKDre9MaWy0I=;
	b=fuKKYqmhwdqAAbPMmjxW8P+id6Ql0FAjnCsKxNg8ZZYDBgMQXrkFiZkIq/cS6MPJMVyx
	 pYVycGXs6sG91zMH3hO8bChvytTDeOVFiMGln3FO9jZ5Ehr13Tq/ciZEpD6Raw/Kunl60
	 XXd2BvA2BuTwrHia/vVnMAaGPzin/dPdkRXZ95zPbRT8d7m5WRVWI8zdlezSbYYqV8cOm
	 AQzwEdz4rGxxaZOFZIy7KubZV9DwcILw/tqGPdJzBY0/DbSvLwUNkfB41PDTXJuuEfyz/
	 hHRvYXxVp8WnAfaE7LQf0zZ/qZGoF88RpFyyBMfpNsSpn6rw+nt41qZ70nmmWUruFVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BGRIUTKz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 692E6606A31D
	for <mptcp@lists.linux.dev>; Sun, 15 Nov 2026 13:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BGRIUTKz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00DF91F000C4;
	Sun, 15 Nov 2026 13:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794748197;
	bh=A6cU/wUQzXorM71velcK/gF2oZrnIJxSKDre9MaWy0I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BGRIUTKzM6T/2r1lWio+ylpU/98ymD+pmEbwnpg88rLmSoy29hSDIQSXaz63SOm8j
	 Yt23ijve3WdvUfNURRgY/yPGlJUQznhm4F+eJiTOa675u+xgav3IKcryv65hc2g8Za
	 llC49Xcvr3/b56SN2PTUaatJYE2WMVirSgWxfWqYzzhZo7MJgodMgUt8mcT/0fFU8p
	 YucODexYqsiHpnn4PoHAbNdbbB3+gmUabffIWuhB3g7dPv9pVdoABRJIl6YRi7TIbj
	 ejAR0pVxXb9JGp3/vnp6Y+lff5XLNQgnfhW+aoWUTtRcqaAG+yasGKEek7aeuAye4L
	 1U0MxUv6dIk7Q==
Message-ID: <sashiko-outbox-215514@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v3 2/4] net: core: take the reuseport migration
 reference with acquire ordering
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hang Nan" <2122295973@qq.com>
Cc: mptcp@lists.linux.dev
In-Reply-To: <tencent_BF4B5FE9E95165CF1734F65EC40D4FEB4808@qq.com>
References: <20261114130927.91839-1-2122295973@qq.com>
 <tencent_BF4B5FE9E95165CF1734F65EC40D4FEB4808@qq.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 15 Nov 2026 13:09:56 +0000
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
- [Low] net: unnecessary refcount_inc_not_zero_acquire() in
  reuseport_migrate_sock()
--

commit 451ae80ccee42826773bf0a6549978307e27e9aa
Author: Hang Nan <2122295973@qq.com>

net: core: take the reuseport migration reference with acquire ordering

This commit switches reuseport_migrate_sock() from refcount_inc_not_zero()
to refcount_inc_not_zero_acquire() when taking a reference on the selected
listener socket.

> diff --git a/net/core/sock_reuseport.c b/net/core/sock_reuseport.c
> index b9e5648fa4c51..56230aa55a3e2 100644
> --- a/net/core/sock_reuseport.c
> +++ b/net/core/sock_reuseport.c
> @@ -667,7 +667,8 @@ struct sock *reuseport_migrate_sock(struct sock *sk,
>  	if (!nsk)
>  		nsk =3D reuseport_select_sock_by_hash(reuse, hash, socks);
> =20
> -	if (IS_ERR_OR_NULL(nsk) || unlikely(!refcount_inc_not_zero(&nsk->sk_ref=
cnt))) {
> +	if (IS_ERR_OR_NULL(nsk) ||
> +	    unlikely(!refcount_inc_not_zero_acquire(&nsk->sk_refcnt))) {
>  		nsk =3D NULL;
>  		goto failure;
>  	}

[Severity: Low]
Is refcount_inc_not_zero_acquire() needed here?

Listener teardown in __tcp_close() and tcp_disconnect() sets sk->sk_state
to TCP_CLOSE and runs inet_csk_listen_stop() while sk->sk_refcnt is still
non-zero, before the final sock_put().  An acquire barrier on
nsk->sk_refcnt only prevents reordering subsequent reads to before the
increment (which would observe older, pre-teardown state rather than
half-torn-down state), and does not serialize against concurrent listener
teardown; callers instead recheck sk->sk_state !=3D TCP_LISTEN under
queue->rskq_lock in inet_csk_reqsk_queue_add().

Unlike the SLAB_TYPESAFE_BY_RCU lookups updated in 5b5d8f351dd9 ("net:
restore refcount ordering for lockless socket access"), sockets in a
reuseport group are freed via call_rcu() in sk_destruct() and cannot be
reallocated during the rcu_read_lock() section in reuseport_migrate_sock(),
nor does reuseport_migrate_sock() perform post-refcount validation checks
that need to be ordered after taking the reference.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/tencent_CCBF2706A4D=
1AFF8F48632FE8B56FB67E207@qq.com?part=3D2
