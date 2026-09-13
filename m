Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A343D367B84
	for <mptcp@lists.linux.dev>; Sun, 13 Sep 2026 10:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789296412; cv=none; b=QHpmvTHdvPNbd/GEpXc/uiVy7hb2j+HpB294n0AHyBL/h5FC9IU8fme2Lpqg4Kb23cBLVmtdcRzFIzW3q5jw6UvEZcOjS7K9PlqcJpr/J2E0xkhbMpJgS4OuOrNibftnbFoleP1TyzMT1Z9zCueWSrhwTltZfwy88qYNgphKhW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789296412; c=relaxed/simple;
	bh=etMtHQPmwiEsix5qIeiF94VUAOjRaegswSQWbRp66pQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=M3ve4yp9GApC0ahh76tPCErEsThFgvs6rlBIR/C4ZCc2spvc5cIja1YRaNx8WMqyhpRYDeBEihfqW/Ms3gi9jH+Hys0/zHPPGzkAeL3GdQFTOC9NcudhEmjOIukQRt2WM1JLYy54a9j92X03evnCKIvklIyhUxRAzvF8BR/JnQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TZhSwJ4T; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TZhSwJ4T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6888B1F000FF;
	Sun, 13 Sep 2026 10:46:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789296411;
	bh=kEJiShPuUEZf7AyeGhVoWEvAzfD8myYGgbJkusw74Hg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TZhSwJ4TLd27mAujffst3RJPE6yJewI9RfaPShXikOAwlcEQDYhSNB7sjC6TxONoD
	 XCNiDZ0carQ7Ml4b1mWJKKYNaZKgp7NMf1ohnVv45ltGgzCLUJypUzSCKje9AgfdkW
	 TvvKoI19F74QOsE/+gx5RdcSQewCujxaXcsEOiVcTo1E1IZ/oBm/6WTquXdEm9RqvJ
	 ypmmS1/x4G2m7HuWzlxNSoFvKGaDC5MmaYRYlQgnTPhD3WCUlh97z+IYp7EHx4nGjS
	 8S1p54kKN+j7YCdfR6Wn0oULiJh5T96RtLRLhupociAkpnydmGyVu46jYcXUHs8Hwv
	 JMUSsasg4Yr2Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-next v5 06/16] mptcp: implement
 psock_update_sk_prot for sockmap
Reply-To: sashiko-reviews@lists.linux.dev
To: "Geliang Tang" <geliang@kernel.org>
Cc: mptcp@lists.linux.dev
In-Reply-To: <39ae7a2bebed6f38d02356c7e288a21a70bdd07f.1789294365.git.tanggeliang@kylinos.cn>
References: <cover.1789294365.git.tanggeliang@kylinos.cn>
 <39ae7a2bebed6f38d02356c7e288a21a70bdd07f.1789294365.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 13 Sep 2026 10:46:50 +0000
Message-Id: <20260913104651.6888B1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] Dereferencing `sk->sk_socket` unconditionally in `tcp_bpf_push=
` causes a kernel panic if the redirect target socket is concurrently orpha=
ned.
- [High] Consuming packets via BPF on MPTCP sockets stalls the connection b=
ecause the receive window is not updated in `tcp_eat_skb`.
--

commit d29dc722a5294658d21912dd69a9ad5d23908e6f
Author: Geliang Tang <geliang@kernel.org>

mptcp: implement psock_update_sk_prot for sockmap

This patch adds basic MPTCP support for BPF sockmap by implementing the
psock_update_sk_prot callback (mptcp_bpf_update_proto).

Link: https://lore.kernel.org/oe-kbuild-all/202512261144.DxrvwMS3-lkp@intel=
.com/
Link: https://github.com/multipath-tcp/mptcp_net-next/issues/521

> diff --git a/include/net/tcp.h b/include/net/tcp.h
> index 14baee01c74bd..d9c0214328e3f 100644
> --- a/include/net/tcp.h
> +++ b/include/net/tcp.h
> @@ -2873,6 +2873,11 @@ static inline void tcp_eat_skb(struct sock *sk, st=
ruct sk_buff *skb)

[Severity: High]
Does consuming packets via BPF on MPTCP sockets stall the connection here?

When an MPTCP socket has an sk_skb stream verdict program attached, the
sockmap layer processes ingress data. When the program returns SK_DROP or
SK_REDIRECT, the SKB is consumed and sk_psock_verdict_apply() calls
tcp_eat_skb() to advance the receive window.

However, tcp_eat_skb() checks sk_is_tcp(sk) and returns immediately for
MPTCP sockets:

	if (!skb || !skb->len || !sk_is_tcp(sk))
		return;

Unlike TCP's tcp_read_skb(), the MPTCP equivalent mptcp_read_skb() does
not independently update the receive window or msk->bytes_consumed.

Since no MPTCP-specific cleanup equivalent to tcp_eat_skb() is invoked, the
consumed packets are never accounted for, stalling the MPTCP connection
permanently.

This appears to be reachable when userspace utilizes BPF sockmap stream
verdict programs with MPTCP sockets, and doesn't seem to be resolved in any
subsequent patch.

>  int tcp_bpf_sendmsg_redir(struct sock *sk, bool ingress,
>  			  struct sk_msg *msg, u32 bytes, int flags);

[ ... ]

> diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
> index d5fcf3ce4861a..e006131696e96 100644
> --- a/net/ipv4/tcp_bpf.c
> +++ b/net/ipv4/tcp_bpf.c
> @@ -119,7 +119,7 @@ static int tcp_bpf_push(struct sock *sk, struct sk_ms=
g *msg, u32 apply_bytes,
> =20
>  		bvec_set_page(&bvec, page, size, off);
>  		iov_iter_bvec(&msghdr.msg_iter, ITER_SOURCE, &bvec, 1, size);
> -		ret =3D tcp_sendmsg_locked(sk, &msghdr, size);
> +		ret =3D sk->sk_socket->ops->sendmsg_locked(sk, &msghdr, size);

[Severity: Critical]
Can this unconditionally dereference sk->sk_socket and cause a panic if the
redirect target socket is concurrently orphaned?

A BPF program using bpf_msg_redirect_map() selects a target socket. If the
target socket is concurrently closed, tcp_close() or mptcp_close() will
acquire the socket lock and call sock_orphan(), which sets
sk->sk_socket =3D NULL.

The redirect thread could execute:

tcp_bpf_sendmsg_redir()
   sk_psock_get(sk)
   lock_sock(sk)

Once the close path drops the lock, the redirect thread acquires it and
calls tcp_bpf_push(). The code attempts to call
sk->sk_socket->ops->sendmsg_locked(), but sk->sk_socket is now NULL.

This is reachable by an unprivileged user loading a BPF program and
triggering concurrent socket closure. It appears this bug was introduced by
replacing the safe direct call to tcp_sendmsg_locked() with
sk->sk_socket->ops->sendmsg_locked(), and does not seem to be resolved in
any subsequent patch in the series.

>  		if (ret <=3D 0)
>  			return ret;
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789294365.gi=
t.tanggeliang@kylinos.cn?part=3D6
