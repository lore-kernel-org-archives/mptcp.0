Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795755856;
	b=HSO+sh/jicOhjQnvQrBRkhlTM1t8Yuq6RExubn9Kwk5ntOMt7C/3Wmcu/TwwZHufa0mv
	 pkDnYr857iKxOrXkchTWq+EuA73QOjujxRonf4I2EFDI6CEJO41rDh7Hzf6KQmu+c1sZc
	 xlFbjedsBmeNFeOSYaxI6qlm6rTj5XV/VyatJdnDfnHtzt8so/nPKk67QD9vlDJid0Pqx
	 KJdyr1DNUW/pr5lHqUEcxeMVFvz2oPWRdI6kztQcUuOogrTVQ1Kwdi8faaZZBy7TjWL0G
	 +w506mGtNo0DFlqhcqIE+VbzZqgR4AhbgPRtvkLK2+4dz/toUqZb4TCXHHbbnireUtg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795755856;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=0ffDPINStj4lRiqTeo4LPdwyN7du01bykKSuY2RBzs8=;
	b=wkmmoNpAJrMqHVJKu6ddSdlt2SGeEBMSFvRWbwvaMQ4Xpl9/6gZpz7auFjOBFLDX+Adn
	 O9P419pkwfBxiBLTAO2XjgxcNzQSx5lvK8Oj00npxj7jZ0d79s0iVrilRTN2IkaaQelPa
	 76MNVs5XD9YUukPvBXPFfZOPopOjX9GboReK+qsxlLgslNGo1g8sw2bJ/AXnPMvHcps7G
	 cDOqlrPuLpxs1ELIjVMG0BeTI4qhsK8pfCfRnlUw7cYxF6DxjtWdF+qpUqxyAxXnFzI21
	 etA0XbWHtQWhp3WPoJ4uIPHkGXvOdrL6rPtxIcs2DKnyWe2Kk/3XfwKrHOrwLwlGV6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SL7OdpbK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73360606A31C
	for <mptcp@lists.linux.dev>; Fri, 27 Nov 2026 05:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SL7OdpbK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB0601F00893;
	Fri, 27 Nov 2026 05:04:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795755856;
	bh=0ffDPINStj4lRiqTeo4LPdwyN7du01bykKSuY2RBzs8=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=SL7OdpbKRij7XdxvxlJwAWZmq8gLs3s13OLVMnaIuQ5vtTOsVsv+kvJRM+6DOp3yw
	 zdbP/+5iQEDoSlo36AX3S95xiBC3KxTPVuY4peVRNTJwA9p1JLzqJrM6EgzFyl50t/
	 ckB/NAHQd+NklQxaaW16ihFH8BY7oyfJnbr1XbfbX58fD5gSITNz8tpnU/LU9rt3pY
	 luE8wVI5uwEWD9Rcca59ectiQSpJKmFkEWMxjYlVqazOoai2wkPpBtGoW1DZN2D2Zy
	 MDW7iwzVq1TiUohpzizmn9+FVSWzMkE6IpV/ML/3FibxB2yvD3vhOPNfgWsADUl0lA
	 ZHcgxNFJ+cH9g==
Message-ID: <sashiko-outbox-236633@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-next v10 3/7] mptcp: add MSG_ZEROCOPY support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Geliang Tang" <geliang@kernel.org>, mptcp@lists.linux.dev
In-Reply-To: <73d24deb26196f8a9ee7060d93c117a7ce5bd265.1795753727.git.tanggeliang@kylinos.cn>
References: <cover.1795753727.git.tanggeliang@kylinos.cn>
 <73d24deb26196f8a9ee7060d93c117a7ce5bd265.1795753727.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 27 Nov 2026 05:04:15 +0000
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [High] mptcp: broken non-SG zerocopy fallback in mptcp_sendmsg_frag()
- [Medium] mptcp: incomplete fastopen zerocopy handling in
  mptcp_sendmsg()
--

commit c58f22d48411d595b383144989fbe0b88bbec032
Author: Geliang Tang <geliang@kernel.org>

mptcp: add MSG_ZEROCOPY support

This commit adds MSG_ZEROCOPY support for MPTCP sockets by pinning user
pages into mptcp_data_frag structures and tracking ubuf_info_msgzc
references across the MPTCP retransmission queue and subflow skbs.

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 504d0b196d84b..d29ecdb05beb9 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c

[ ... ]

> @@ -1530,25 +1552,42 @@ static int mptcp_sendmsg_frag(struct sock *sk, st=
ruct sock *ssk,
>  	copy =3D min_t(size_t, copy, info->limit - info->sent);
> =20
>  	/* like TCP, allow some progress up to tcp_wmem[0] */
> -	avail =3D tcp_wmem_schedule(ssk, copy);
> -	if (avail <=3D 0) {
> +	if (!dfrag->ubuf) {
> +		avail =3D tcp_wmem_schedule(ssk, copy);
> +		copy =3D avail > 0 ? avail : 0;
> +	}
> +
> +	if (!copy) {
>  		tcp_remove_empty_skb(ssk);
>  		return -ENOMEM;
>  	}
> -	copy =3D avail;
> =20
>  	if (can_coalesce) {
>  		skb_frag_size_add(&skb_shinfo(skb)->frags[i - 1], copy);
>  	} else {
>  		get_page(dfrag->page);
>  		skb_fill_page_desc(skb, i, dfrag->page, offset, copy);
> +
> +		if (dfrag->ubuf && !skb_zcopy(skb)) {
> +			if (ssk->sk_route_caps & NETIF_F_SG) {
> +				skb_zcopy_set(skb, dfrag->ubuf, NULL);
> +				skb_shinfo(skb)->flags |=3D SKBFL_PURE_ZEROCOPY;
> +				zc =3D true;
> +			} else {
> +				uarg_to_msgzc(dfrag->ubuf)->zerocopy =3D 0;
> +			}
> +		}
>  	}
> =20
> +	if (!zc)
> +		zc =3D skb_zcopy_pure(skb);
> +
>  	skb->len +=3D copy;
>  	skb->data_len +=3D copy;
> -	skb->truesize +=3D copy;
> -	sk_wmem_queued_add(ssk, copy);
> -	sk_mem_charge(ssk, copy);
> +	skb->truesize +=3D zc ? PAGE_SIZE : copy;
> +	sk_wmem_queued_add(ssk, zc ? PAGE_SIZE : copy);
> +	if (!zc)
> +		sk_mem_charge(ssk, copy);

[Severity: High]
Does the non-NETIF_F_SG fallback corrupt ssk->sk_forward_alloc and leave
the pinned user page attached to skb without a dfrag->ubuf reference?

When dfrag->ubuf is set and ssk->sk_route_caps lacks NETIF_F_SG,
tcp_wmem_schedule() is skipped, but zc remains false and sk_mem_charge()
charges unscheduled bytes against ssk->sk_forward_alloc; freeing skb in
tcp_wmem_free_skb() then uncharges and reclaims memory that was never
scheduled.

In addition, dfrag->page is already a pinned user page attached via
skb_fill_page_desc(), so skipping skb_zcopy_set() leaves skb holding the
user page without a dfrag->ubuf reference or SKBFL_ZEROCOPY_FRAG, allowing
dfrag_clear() to complete the zerocopy notification while skb is still in
flight.

[ ... ]

> @@ -2048,27 +2088,116 @@ static void mptcp_rps_record_subflows(const stru=
ct mptcp_sock *msk)

[ ... ]

>  	if (unlikely(inet_test_bit(DEFER_CONNECT, sk) ||
>  		     msg->msg_flags & MSG_FASTOPEN)) {
>  		int copied_syn =3D 0;
> =20
> -		ret =3D mptcp_sendmsg_fastopen(sk, msg, len, &copied_syn);
> +		if (zc && (msg->msg_flags & MSG_FASTOPEN)) {
> +			uarg_to_msgzc(ubuf)->zerocopy =3D 0;
> +			zc =3D false;
> +		}
> +
> +		ret =3D mptcp_sendmsg_fastopen(sk, msg, len, &copied_syn, ubuf);
>  		copied +=3D copied_syn;
>  		if (ret =3D=3D -EINPROGRESS && copied_syn > 0)
>  			goto out;

[Severity: Medium]
Can fastopen with MSG_ZEROCOPY complete ubuf prematurely or omit
SO_EE_CODE_ZEROCOPY_COPIED?

When MSG_FASTOPEN clears zc on a blocking send that has data remaining
after the SYN (or when no TFO cookie is cached and copied_syn is 0), the
send loop queues the remaining payload via the regular copy path without
taking a ubuf reference, so net_zcopy_put(ubuf) at out: fires the
completion notification before that data is acknowledged.

Also, when fastopen is entered via DEFER_CONNECT (TCP_FASTOPEN_CONNECT)
without MSG_FASTOPEN in msg->msg_flags, uarg_to_msgzc(ubuf)->zerocopy is
not cleared even though tcp_send_syn_data() copies the SYN payload into a
page_frag and attaches ubuf via skb_zcopy_set().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1795753727.gi=
t.tanggeliang@kylinos.cn?part=3D3
