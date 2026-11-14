Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794617041;
	b=MlJcLl7zOYjuKkCNHT1I9TT+FL0hyw7+T64QXCjYWaeIawYsZe3nEB20j0wqVuTm67J1
	 LtsMO2JeUiTbgYN1P2QHYh9xu8QdjG9a7sjyMARL3z4T2uyAD+Te+1BC13fHArRDz6O2H
	 2Fh2v30qNZkaP+KoS+tuLQS791qXZH6sZ7qbVc2po7qqpK42t2c0oSop2NDONIPd+QBeP
	 MhJikrsofnlUBnQINAQMF46RWgpEjBqEuOWa/qykult/k0zybLz2gNNWmXM370IHBG+Mo
	 b8d0NabYLRZ9pSx0AW/WIyvb1t953k08576489yhayq+99J4A2Pd2JioqOCYYIOxy1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794617041;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=H4mY5ZRs2JHdPhUTbfpC1mkZGXB3v407FL9a8i/myIQ=;
	b=gxgv2QXktzCeDYDTg7Fr4V3PHjs4AjYYbaXVf3PbC8JqsjAJ3FF/TNAbZyaTeUZXDHrE
	 yH2jebDoK8hdugdhBszuJjn/Qd5WmeH5dbNCWA/jaJj7zsce5YQ+ELCL/moehVdxERQuO
	 lcK3pAyQbUCLbNq4jfJEv/IK6szyxGUwSahZbgCy1yecZgT5JbVL6kEwovD+ARg85ZKBD
	 gvwjcHYyB4Luj19C4Vwv98j39BsiX8IZgG63otOsj65UGuBdQ4HUtVMkoXjJYl6+OhtE9
	 6C5ILY3kWMxQCkdXEg2OkVZPDxZ9NBc3oC8iJUziCRDvo1hORo5JyjRSedmocjqUSmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CBLmSI4E;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8BA1606A333
	for <mptcp@lists.linux.dev>; Sat, 14 Nov 2026 00:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CBLmSI4E
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62B311F000C5;
	Sat, 14 Nov 2026 00:44:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794617040;
	bh=H4mY5ZRs2JHdPhUTbfpC1mkZGXB3v407FL9a8i/myIQ=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=CBLmSI4EHbzo843qRZXNiqnXAQQ3LanKanIAhpnIxz/qQ4YvUP7TKjyjWR+M9Ke2+
	 nYY8zhwgOd/kkJRt9s2d40duY+v6s6b5Ge1NI78ndR7joBjZVhUhvhwiErgHf9vHAc
	 cx+CbRwwl9uOia4bR5+zffgk+wqDAjOf6R7y1VrwuMCZ8ThQH8g7yAEJzDAABPAyXi
	 KZi5fr7oiSncHLC9wWXkQKNi4Kt5fJqf3kLDjjO3LgX4huAPGQjl5oudvR+/ocUCEu
	 9AZ02SWa+561VEMmdR8UTu+pOM94c4S+ul4s08oWSYkibJIRuwaDdThM9g78H8ZYKm
	 D4BYQolnEFfCw==
Message-ID: <sashiko-outbox-213944@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-net 27/34] tcp: do not pass a BPF reqsk to an
 MPTCP listener
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWF0dGhpZXUgQmFlcnRzIChOR0kwKQ==?= <matttbe@kernel.org>, "MPTCP
 Linux" <mptcp@lists.linux.dev>
In-Reply-To: <20261113-mptcp-cmason-fixes-v1-27-9205b77e9a2f@kernel.org>
References: <20261113-mptcp-cmason-fixes-v1-0-9205b77e9a2f@kernel.org>
 <20261113-mptcp-cmason-fixes-v1-27-9205b77e9a2f@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 00:43:59 +0000
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found no new issues
in this patch, but noticed 1 related pre-existing issue it does not
introduce:
- [Medium] tcp: uninitialized AccECN bitfields in
  cookie_tcp_reqsk_init() [1]
--

commit 60c8cb4a139f552e38c9eee24fcc2376af54953b
Author: Chris Mason <mason@kernel.org>

tcp: do not pass a BPF reqsk to an MPTCP listener

This commit rejects MPTCP listeners in cookie_bpf_check() so a plain TCP
request socket allocated by bpf_sk_assign_tcp_reqsk() is not passed to
mptcp_subflow_init_cookie_req() when SO_REUSEPORT selects an MPTCP listener.

> diff --git a/net/ipv4/syncookies.c b/net/ipv4/syncookies.c
> index 4e0ff3b820627..8433c856a7d8e 100644
> --- a/net/ipv4/syncookies.c
> +++ b/net/ipv4/syncookies.c
> @@ -308,7 +308,8 @@ struct request_sock *cookie_bpf_check(struct sock *sk=
, struct sk_buff *skb)
>  	skb->sk =3D NULL;
>  	skb->destructor =3D NULL;
> =20
> -	if (cookie_tcp_reqsk_init(sk, skb, req)) {
> +	/* reuseport can pick an MPTCP listener: req is too small for it */
> +	if (sk_is_mptcp(sk) || cookie_tcp_reqsk_init(sk, skb, req)) {
>  		reqsk_free(req);
>  		req =3D NULL;
>  	}

[Severity: Medium]
This problem wasn't introduced by this patch, but does
cookie_tcp_reqsk_init() [1] leave the saw_accecn_opt,
accecn_fail_mode, syn_ect_rcv, and syn_ect_snt bitfields of struct
tcp_request_sock uninitialized?

When ECN is enabled and the third ACK negotiates AccECN so cookie_v4_check()
or cookie_v6_check() sets treq->accecn_ok, tcp_ecn_openreq_child() copies
those uninitialized slab bits into the child struct tcp_sock, corrupting the
connection's initial AccECN state and exposing the uninitialized bits to
userspace via TCP_INFO in tcpi_accecn_fail_mode and tcpi_accecn_opt_seen.

[1] https://sashiko.dev/#/bug/linux-ed19fae6-fc32-4f5d-a0ad-dc03d9ce058f

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113-mptcp-cmas=
on-fixes-v1-0-9205b77e9a2f@kernel.org?part=3D27
