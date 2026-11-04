Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793788839;
	b=AN5u97DfyasUqu/R0/MJwtS5W4rt3zQvRc1bURvSgSAyBaXAbPxEICzFMOyaXB+wXx6M
	 WALY83Xm6jg6Ke4259I3/zY5bHXBxr+HL+bfWPv3+nPJSzoyE9JfJ0IRXByf56TwKnrSF
	 sg9tPtKDD6FCDj+KtLJQ7FrtwGZjwzVxauStGB4+AEQ5ObErFQGbmILyQ6PRRk35HRm1c
	 gNbK/rtXKkWca9cQTvWP2gL+7D5kAK1ad3F40Jo+BbQoIyOwv4jZDi8Jx3gC1ZND9QAIo
	 5oswQzDVVZSppfOm06eCR/d1RG2nMfXnb1FSqnZtnni+QWQjb0wc4lvn8eoALbHRQcQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793788839;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Ck8VypfKwhGzxES7dzxPe8wJIspLo1GpOopw33TGXmE=;
	b=FKzdrlM5aLPmw0WI0+H3vBav6m7ZxONL9HNnf8837FSJwK/7mHNdQ1kiX4c768d5op9G
	 MV1BG+AiSqn/uPsbAe4JDeNZcS1B+rle8soBYjj43+VmB9NlFmFEpXIgXofDqzTkiB/Pg
	 l/1aPcICuHjgDup0hBvCVQgNF9Mxd1rfWaPjR421jWVt3itQq8Cbj/4+93ZUiapBElKRH
	 iHS7h5V77ECUROHkBIZF0TcqnGY3+yTeJl9c+/mQZs8CotezcJR5z+yO9ICyOAdOu2Asj
	 7U1Kg3yJLJqchsHNmGZ5yzTrVF+KpuCuezhoKWuY6ElaVjgmfRdh9z3NE23NBWo4m6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="a/HLTCfB";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20487606A331
	for <mptcp@lists.linux.dev>; Wed,  4 Nov 2026 10:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a/HLTCfB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D6CF1F00919;
	Wed,  4 Nov 2026 10:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793788838;
	bh=Ck8VypfKwhGzxES7dzxPe8wJIspLo1GpOopw33TGXmE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=a/HLTCfBvQaQ0cao1illOkdDLnxe3Se5kw1EMSgWV2GOrHquWbSOdPfXqRqO9UmYf
	 jn3HyoAS2pzLCgUr1ti3LdMgF8vyQ+Sh9lrcgFMgirE0teAVJKreEF/HKPbV+xEcC3
	 2BICqcm303ZGy8MwNWhIkFnnh6P8ZbEL1oANdEu9Cy4dUxvmVPuTFl4fC6q34p+v8X
	 qZf8WZ5xsW+bVZSAeZ4HtybxvBiWUVYbL/5nHhts8OaHKyWjg7IUsuT8gXbsmgzdTU
	 NzpQSrWX14p5HoCSFb8wD8ljg8aotjHcuHvrt1HUkrxkOpDsNxlr9cSjVK7qjXsQd4
	 xP/ocik98HWAw==
Message-ID: <sashiko-outbox-197107@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v3] tcp: prevent cross-family skb processing after
 disconnect
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zhiyu Zhang" <zhiyuzhang999@gmail.com>
Cc: mptcp@lists.linux.dev
In-Reply-To: <20261103103633.2707416-1-zhiyuzhang999@gmail.com>
References: <20261103103633.2707416-1-zhiyuzhang999@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 10:40:38 +0000
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] tcp: stale IPv6 skb processed on v4-mapped socket in tcp_v6_do=
_rcv()
- [Critical] tcp: rtable/rt6_info type confusion in tcp_v4_do_rcv() after r=
econnect
--

commit b8863396ea09db4835f451ceb38563e379ce7144
Author: Eric Dumazet <edumazet@kernel.org>

tcp: prevent cross-family skb processing after disconnect

This commit adds tcp_v6_disconnect() to restore IPv6 socket handlers when
disconnecting a v4-mapped IPv6 socket, routes MPTCP subflow disconnects
through sk_prot->disconnect, and drops non-IPv4 packets in tcp_v4_do_rcv().

Link: https://lore.kernel.org/netdev/CALf2hKvp0NPVLwr=3Da3+jUHtPohxbra8gox+=
aYAfWathJnn-J+Q@mail.gmail.com/

> diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
> index a7f9242f1e429..8fa6564d2b602 100644
> --- a/net/ipv4/tcp_ipv4.c
> +++ b/net/ipv4/tcp_ipv4.c
> @@ -1836,6 +1836,11 @@ int tcp_v4_do_rcv(struct sock *sk, struct sk_buff =
*skb)
>  {
>  	enum skb_drop_reason reason;
> =20
> +	if (unlikely(skb->protocol !=3D htons(ETH_P_IP))) {
> +		reason =3D SKB_DROP_REASON_INVALID_PROTO;
> +		goto err_discard;
> +	}
> +

[Severity: Critical]
Does this check in tcp_v4_do_rcv() still miss the non-backlogged path when a
socket reconnects from native IPv6 to a v4-mapped address?

In tcp_v6_rcv(), if the user thread completes connect(AF_UNSPEC), reconnects
to a v4-mapped address, and finishes release_sock(sk) before tcp_v6_rcv()
acquires bh_lock_sock_nested(sk), sock_owned_by_user(sk) will be false:

net/ipv6/tcp_ipv6.c:tcp_v6_rcv() {
	...
	bh_lock_sock_nested(sk);
	tcp_segs_in(tcp_sk(sk), skb);
	ret =3D 0;
	if (!sock_owned_by_user(sk)) {
		ret =3D tcp_v6_do_rcv(sk, skb);
	} else {
		drop_reason =3D tcp_add_backlog(sk, skb);
	...
}

Instead of going through sk->sk_backlog_rcv (tcp_v4_do_rcv), tcp_v6_rcv()
calls tcp_v6_do_rcv(sk, skb) directly. Because tcp_v6_do_rcv() only redirec=
ts
ETH_P_IP packets and does not verify whether sk was switched to v4-mapped m=
ode
(sk->sk_backlog_rcv =3D=3D tcp_v4_do_rcv), it processes the stale ETH_P_IPV=
6 skb
while icsk->icsk_af_ops is ipv6_mapped.

When sk is in TCP_ESTABLISHED (or reaches tcp_finish_connect() in
TCP_SYN_SENT), tcp_rcv_established() then runs before sequence validation:

net/ipv4/tcp_input.c:tcp_rcv_established() {
	...
	if (unlikely(!rcu_access_pointer(sk->sk_rx_dst)))
		inet_csk(sk)->icsk_af_ops->sk_rx_dst_set(sk, skb);
	...
}

This invokes inet_sk_rx_dst_set() on the IPv6 skb and caches its rt6_info in
sk->sk_rx_dst of the v4-mapped socket, which tcp_v4_early_demux() can then
attach to subsequent IPv4 packets. Should tcp_v6_do_rcv() also reject
non-ETH_P_IP packets when sk->sk_backlog_rcv =3D=3D tcp_v4_do_rcv?

> diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
> index e006a30360eae..a93410aab66e6 100644
> --- a/net/ipv6/tcp_ipv6.c
> +++ b/net/ipv6/tcp_ipv6.c
[ ... ]
> @@ -2093,6 +2099,19 @@ static int tcp_v6_init_sock(struct sock *sk)
>  	return 0;
>  }
> =20
> +static int tcp_v6_disconnect(struct sock *sk, int flags)
> +{
> +	int ret =3D tcp_disconnect(sk, flags);
> +
> +	/* A socket used for a v4-mapped connection must not keep IPv4
> +	 * handlers when it is reused for listen() or a native IPv6 connect().
> +	 */
> +	if (sk->sk_backlog_rcv =3D=3D tcp_v4_do_rcv)
> +		tcp_v6_restore_af_ops(sk);
> +
> +	return ret;
> +}

[Severity: Critical]
With tcp_v6_disconnect() restoring icsk->icsk_af_ops to ipv6_specific and
sk->sk_backlog_rcv to tcp_v6_do_rcv, can a racing IPv4 packet cause
rtable/rt6_info type confusion when the socket is reconnected to a native I=
Pv6
peer?

If tcp_v4_rcv() looks up a v4-mapped AF_INET6 socket via __inet_lookup_skb()
and the socket is disconnected and reconnected to a native IPv6 address bef=
ore
bh_lock_sock_nested(sk), the in-flight ETH_P_IP skb still reaches
tcp_v4_do_rcv(sk, skb) either directly from tcp_v4_rcv() when
!sock_owned_by_user(sk), or from release_sock() via tcp_v6_do_rcv():

net/ipv6/tcp_ipv6.c:tcp_v6_do_rcv() {
	...
	if (skb->protocol =3D=3D htons(ETH_P_IP))
		return tcp_v4_do_rcv(sk, skb);
	...
}

In tcp_v4_do_rcv(), skb->protocol !=3D htons(ETH_P_IP) passes because the p=
acket
is IPv4, while sk is now a native IPv6 socket with icsk->icsk_af_ops set to
ipv6_specific. When tcp_rcv_established() (or tcp_finish_connect()) calls
icsk->icsk_af_ops->sk_rx_dst_set(sk, skb), it invokes inet6_sk_rx_dst_set()=
 on
an IPv4 rtable:

net/ipv6/tcp_ipv6.c:inet6_sk_rx_dst_set() {
	struct dst_entry *dst =3D skb_dst(skb);

	if (dst && dst_hold_safe(dst)) {
		rcu_assign_pointer(sk->sk_rx_dst, dst);
		sk->sk_rx_dst_ifindex =3D skb->skb_iif;
		sk->sk_rx_dst_cookie =3D rt6_get_cookie(dst_rt6_info(dst));
	}
}

Can this cast the IPv4 rtable to rt6_info in rt6_get_cookie() (dereferencing
rt->from if the overlapping sernum bytes are zero) and cache an IPv4 rtable=
 in
sk->sk_rx_dst of the native IPv6 socket?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103103633.2707=
416-1-zhiyuzhang999@gmail.com?part=3D1
