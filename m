Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794573971;
	b=J13TucVE0bbKuSMA7V7vdCjnfSo29lMzJpK/8NoClzOGoU+MUVIwXv7UKQgXOYjXokTw
	 gOyJUwynJxBKGnt6Xa6fyswWyKydpiVWAg8aF6qEhKVm8ocmHmj15nMgKZa9FmZoVU9Ra
	 gwK7k3Vwc/6+W/hFOvu2WNcfiHPefdnvo1lxjETkzjADYPjIf0jTp4vdF1IKNACcChJ4M
	 fjgoKdp8iJoh8REXj7/+Z/FU0V3YzQMmu5GJkxjeaqBFz+rdThymqaCYJl3Dh869Pxa7g
	 X7rdQ42RUnjchNllSNOY9DAuFRscfD/WVD0RzxiP8tTzK7ZwRcT5pCGbzg5qkWaxE1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794573971;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=4nqWdqHCfxOMp9mxgkaKiVFe2SFwaO+vyP0Q56SK6rs=;
	b=PFRMM3hDJf2FcHoNAG3s5Aq7kGNOCICbQ/hVHq+pldbq3VAvsgLwiBtaiew4ZBZPQogX
	 b+Dw1QBkANYnunVvLayFuM1KUdsom721Y+KkLQswHV6/BMquzCCLk4aIGLkIMh7v9IHxS
	 bVvDtbsOkbVpGOgpXnNp95Y7OOOPJRjtEM4sww2DtkneYLkgKi2/l/7P8LbyCiXcNl7Gc
	 spO0D5I0NTF/AAKWZ4EMzpAzHZa5mlNa+pI86I/IGPIto7fuoJoFi1YA8ti1X2zef+Ibh
	 EW/nPvSMpqX4EdoWv/h++PoRkcLrrIBztfJhNW5VKHZ6SPN3Jiu+SWimd3zznTMvfbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CGtF0XIK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6103A606A32D
	for <mptcp@lists.linux.dev>; Fri, 13 Nov 2026 12:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CGtF0XIK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 155751F000C5;
	Fri, 13 Nov 2026 12:46:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794573971;
	bh=4nqWdqHCfxOMp9mxgkaKiVFe2SFwaO+vyP0Q56SK6rs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CGtF0XIKDlmVKJuueCX6CFKfSb0zAHpODGwZup0qBqKVomfQzDz41QWO0JUsSM8es
	 WjpiScEnSffAyvM4DmvsAxaagT5z2kKP/MQByTVFTTCNgjF8PsKn6XIvnMyOBgfzXj
	 mWQPKg9Tk9IMH0b4o+5gNJgnmIfvzom0u5n4fqvbG/wPv5RRBScCBxl5HYabZ8L0T5
	 jp5449sLiEA/BAb3cPPAuagekKWDRPK8Am0Q00dMmRukSsiLZmd+n80z75Gtz+ihZi
	 KSNvZgz6Uqv9v/W0uuMtCLDVCEdyfVEqdIDINYF4F7jnIrlvRXhEnV+d2g/8Y9IgaK
	 eoV0O8n7miuIg==
Message-ID: <sashiko-outbox-212784@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net 2/2] net: core: take the reuseport migration
 reference with acquire ordering
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hang Nan" <2122295973@qq.com>
Cc: mptcp@lists.linux.dev
In-Reply-To: <tencent_AE3D481F5F51E98E657317C2F664C4FA4F08@qq.com>
References: <20261112124547.193812-1-2122295973@qq.com>
 <tencent_AE3D481F5F51E98E657317C2F664C4FA4F08@qq.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 12:46:10 +0000
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
- [Low] net: invalid acquire rationale and Fixes tag in
  reuseport_migrate_sock()
--

commit 7417b1ab930b0d5e78b0d25b1f59ad89404b15b1
Author: Hang Nan <2122295973@qq.com>

> net: core: take the reuseport migration reference with acquire ordering
>
> reuseport_migrate_sock() returns a listener with a reference held, and
> every caller immediately reads that listener: tcp_v4_rcv() and
> tcp_v6_rcv() pass it to tcp_filter() and tcp_check_req(), and the
> request-socket paths clone its state.  A listener removed from the
> reuseport group concurrently with that lookup must not be observed in a
> half-torn-down state after the reference was successfully taken.
>
> refcount_inc_not_zero() lost its acquire ordering in the refcount_t
> consolidation (fb041bb7c0a9), so these subsequent reads are not ordered
> against the reference acquisition.  Use
> refcount_inc_not_zero_acquire(), as was done for the established-socket
> lookups, inet_twsk_purge() and bpf_sk_assign() in 5b5d8f351dd9.
>
> No behaviour change on strongly ordered architectures.
>
> Fixes: fb041bb7c0a9 ("locking/refcount: Consolidate implementations of re=
fcount_t")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hang Nan <2122295973@qq.com>
> ---
> diff --git a/net/core/sock_reuseport.c b/net/core/sock_reuseport.c
> index b9e5648fa4c51..56230aa55a3e2 100644
> --- a/net/core/sock_reuseport.c
> +++ b/net/core/sock_reuseport.c
> @@ -667,7 +667,8 @@ struct sock *reuseport_migrate_sock(struct sock *sk,
>  	if (!nsk)
>  		nsk =3D reuseport_select_sock_by_hash(reuse, hash, socks);
>
> -	if (IS_ERR_OR_NULL(nsk) || unlikely(!refcount_inc_not_zero(&nsk->sk_ref=
cnt))) {
> +	if (IS_ERR_OR_NULL(nsk) ||
> +	    unlikely(!refcount_inc_not_zero_acquire(&nsk->sk_refcnt))) {
>  		nsk =3D NULL;
>  		goto failure;
>  	}

[Severity: Low]
Does acquire ordering on nsk->sk_refcnt actually prevent callers of
reuseport_migrate_sock() from observing a closing listener?

In __tcp_close(), listener teardown (tcp_set_state(sk, TCP_CLOSE) and
inet_csk_listen_stop()) runs while sk->sk_refcnt is still non-zero, before
tcp_close() drops the final reference with sock_put(sk).  An acquire barrier
on sk_refcnt only orders the caller's subsequent loads after the increment;
it does not synchronize with __tcp_close() and cannot prevent observing a
half-torn-down listener, which is instead handled under rskq_lock in
inet_csk_reqsk_queue_add().

Unlike the SLAB_TYPESAFE_BY_RCU lookups updated in 5b5d8f351dd9 ("net:
restore refcount ordering for lockless socket access"),
reuseport_migrate_sock() does no post-increment re-validation of nsk, and
sk_destruct() always defers destruction via call_rcu() when SOCK_RCU_FREE or
sk_reuseport_cb is set.  Also, reuseport_migrate_sock() was introduced in
1cd62c21572c ("tcp: Add reuseport_migrate_sock() to select a new listener."=
),
after fb041bb7c0a9 ("locking/refcount: Consolidate implementations of
refcount_t").

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/tencent_28A2BD1631F=
E531992E91753BA6419FFC506@qq.com?part=3D2
