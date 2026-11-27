Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795785199;
	b=41lrOxVSRgnMN/ypk8D0eR3CPL/QvPG8aQ1j8AVSxUExfaxs/jXpio8cDGhRkI3HY/fp
	 0bMmShPYmdvIc9gmQPNOGbA/mgCWtv8kbXD0Rl8bMycoTVkEWmZPeNPRr8S9V5LF+CFGA
	 /S8BfqOVIK8+eILv9Q4kTvrQLeXxd1So+BuTvd9IAghKdFnNSgkd++u9tDdwQc+yZiG60
	 WWTlsDRkaktPckXXv/oTpx3G9wJuZJRA7GHbrVoA16CzwEfSTGxLrvnvCm3l/REaYhbvZ
	 7AyoMMAgULJrIamjGwLP+ue4xi9vqdVQEjuSAF/Kyk0/9tVDix/F++W1BkfMyBcEheA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795785199;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=g2ayjCBk9rr4jD33Bj9bTqXct/YhXyr7TuJkA2zWSgk=;
	b=YDmaXFAZ04me3ZtTBpU5fhlKRwPphxT6sVyJ2+l9oYIIO/0f5+nDWfXNKFk61qO3gAWU
	 anuKDOdzSxmQ6mWJD6UQmWDqyn/oRSh/toHiBJOekPNiI7Wh+SZXmk5Ty59i46BY3Iedm
	 AWAD8jJC3pDvB9p5jfbMEKwys85bB3WINAq/d8w3GVFEhcr+fNqJyH6CgWrb+N+Ki6ob+
	 6dSEQZ+XKY3mR9sQf5C6BVh/Y2PpyTihPbOfDZgN8i8WjIp8zcyInzTWuyhxZ5aMeDVt+
	 Ydy0/31ADB0ITJ9bgG0n3oFSd+gk8m3ypNet7K7BWioeJuOSx4Eq5H5cwUluFV/6oCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j4cLnBJK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7131606A31C
	for <mptcp@lists.linux.dev>; Fri, 27 Nov 2026 13:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j4cLnBJK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0BE81F000C1;
	Fri, 27 Nov 2026 13:13:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795785199;
	bh=g2ayjCBk9rr4jD33Bj9bTqXct/YhXyr7TuJkA2zWSgk=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=j4cLnBJKzS9cDK3/A2DTnlN90X5r0DfsT6c3cIZTZdaqd5kv4OXvPoRRUspCA7W1M
	 DreTIjv9CcW1oDpKGcg00crquDNsQm8gliBAfVwOPT4anH5VVPqURQ/LmEADO8xsom
	 yvIH10te4RxGsv6DSHo1sXc6s1stAO2ZD2vJ2z9ogBNFQbtaPlo0bemanhtBCtDhuM
	 VpPloJgN5ELQSDO6dGbvkqxBRmSxhSguj1y/bsSJhK4EBL3DQbpdX+hbOsbpB2Zl8t
	 +wZDvOLND3mWknGqtkTkSIk5jU5mqEYLZkthGLT3llZMJFt4KB6DsYcj0wbJd9GwFk
	 MlpzbkGycGcqQ==
Message-ID: <sashiko-outbox-237474@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-next v11 3/7] mptcp: add MSG_ZEROCOPY support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Geliang Tang" <geliang@kernel.org>, mptcp@lists.linux.dev
In-Reply-To: <3d7cbfa8e9f5a84f1a8d830ba671f4ce0f450a1e.1795783388.git.tanggeliang@kylinos.cn>
References: <cover.1795783388.git.tanggeliang@kylinos.cn>
 <3d7cbfa8e9f5a84f1a8d830ba671f4ce0f450a1e.1795783388.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 27 Nov 2026 13:13:18 +0000
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 4 potential
issues to consider:
- [High] mptcp: untracked user page on non-SG subflow skb in
  mptcp_sendmsg_frag()
- [Medium] mptcp: broken fastopen zerocopy handling in mptcp_sendmsg()
- [Medium] mptcp: unbalanced tcp_wmem_schedule() for zerocopy in
  mptcp_sendmsg_frag()
- [Medium] mptcp: broken zcopy coalescing via skb_can_coalesce() in
  mptcp_sendmsg_frag()
--

commit 3ce08c733a49cce9f3069eefc44768187f8af9ea
Author: Geliang Tang <geliang@kernel.org>

mptcp: add MSG_ZEROCOPY support

This commit adds MSG_ZEROCOPY support to MPTCP by pinning user pages into
mptcp_data_frag structures and tracking completion across both the MPTCP
retransmission queue and subflow skbs.

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 504d0b196d84b..864967702b2c3 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
[ ... ]
> @@ -1488,6 +1500,13 @@ static int mptcp_sendmsg_frag(struct sock *sk, str=
uct sock *ssk,
>  			goto alloc_skb;
>  		}
> =20
> +		if (skb_zcopy_pure(skb) !=3D !!dfrag->ubuf ||
> +		    (dfrag->ubuf && skb_zcopy(skb) &&
> +		     skb_zcopy(skb) !=3D dfrag->ubuf)) {
> +			tcp_mark_push(tp, skb);
> +			goto alloc_skb;
> +		}
> +
>  		i =3D skb_shinfo(skb)->nr_frags;
>  		can_coalesce =3D skb_can_coalesce(skb, i, dfrag->page, offset);
>  		if (!can_coalesce && i >=3D READ_ONCE(net_hotdata.sysctl_max_skb_frags=
)) {

[Severity: Medium]
Does skb_can_coalesce() always return false when reusing a zerocopy
subflow skb?

skb_can_coalesce() calls skb_can_coalesce_netmem(), which rejects any skb
where skb_zcopy(skb) is set:

include/linux/skbuff.h:skb_can_coalesce_netmem() {
	if (skb_zcopy(skb))
		return false;
    ...
}

Because skb_zcopy_set() is called when the first fragment is attached to
the skb, every subsequent slice of the same dfrag page appended to that
skb takes the !can_coalesce path, consuming an extra frag slot and page
reference while adding another full PAGE_SIZE to skb->truesize and
ssk->sk_wmem_queued.

> @@ -1542,13 +1561,24 @@ static int mptcp_sendmsg_frag(struct sock *sk, st=
ruct sock *ssk,
>  	} else {
>  		get_page(dfrag->page);
>  		skb_fill_page_desc(skb, i, dfrag->page, offset, copy);
> +
> +		if (dfrag->ubuf && !skb_zcopy(skb) &&
> +		    ssk->sk_route_caps & NETIF_F_SG) {
> +			skb_zcopy_set(skb, dfrag->ubuf, NULL);
> +			skb_shinfo(skb)->flags |=3D SKBFL_PURE_ZEROCOPY;
> +			zc =3D true;
> +		}
>  	}

[Severity: High]
When a subflow route lacks NETIF_F_SG, does this attach the pinned user
page dfrag->page to skb without taking a reference on dfrag->ubuf?

With skb_zcopy(skb) left NULL, the subflow skb holds no ubuf reference.
Once dfrag_clear() drops the MPTCP-level reference (for example, after
another subflow acknowledges the data or after TCP fallback), ubuf->refcnt
reaches 0 while skb still holds and transmits dfrag->page.  That triggers
a premature SO_EE_ORIGIN_ZEROCOPY completion notification and unaccounted
pinned pages while the kernel is still reading from the user page.
Leaving skb_zcopy(skb) unset also bypasses skb_orphan_frags_rx() and
skb_orphan_frags() page copying on loopback or clone paths, and causes
skb_zcopy_pure(skb) !=3D !!dfrag->ubuf to force a new skb allocation on
every subsequent zerocopy fragment.

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

[Severity: Medium]
Does skipping sk_mem_charge() when zc is true leave the memory scheduled
earlier in mptcp_sendmsg_frag() by tcp_wmem_schedule(ssk, copy)
unconsumed in ssk->sk_forward_alloc?

For SKBFL_PURE_ZEROCOPY skbs, tcp_wmem_free_skb() only uncharges the skb
header truesize, which __mptcp_alloc_tx_skb() already scheduled and
charged.  Calling tcp_wmem_schedule(ssk, copy) without a matching
sk_mem_charge(ssk, copy) inflates ssk->sk_forward_alloc and protocol
memory accounting, and can cause pure zerocopy sends to fail with -ENOMEM
under memory pressure.  In tcp_sendmsg_locked(), tcp_wmem_schedule() is
only called when !skb_zcopy_pure(skb).

[ ... ]

> @@ -2048,27 +2079,117 @@ static void mptcp_rps_record_subflows(const stru=
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
> +		ret =3D mptcp_sendmsg_fastopen(sk, msg, len, &copied_syn,
> +					     zc ? ubuf : NULL);
>  		copied +=3D copied_syn;
>  		if (ret =3D=3D -EINPROGRESS && copied_syn > 0)
>  			goto out;

[Severity: Medium]
Does clearing zc before passing zc ? ubuf : NULL to
mptcp_sendmsg_fastopen() cause ubuf to complete before the data is
acknowledged?

When MSG_FASTOPEN is set, zc is set to false, so mptcp_sendmsg_fastopen()
receives NULL instead of ubuf, and any remaining bytes queued by the send
loop also use non-zerocopy dfrags without taking a reference on ubuf.
When mptcp_sendmsg() reaches out: and calls net_zcopy_put(ubuf), the sole
reference drops and fires the completion notification immediately while
the SYN and any post-SYN data are still in flight.

Conversely, when DEFER_CONNECT (TCP_FASTOPEN_CONNECT) is used without
MSG_FASTOPEN in msg->msg_flags, zc and uarg_to_msgzc(ubuf)->zerocopy
remain 1 even though tcp_send_syn_data() copies the SYN payload into a
kernel buffer without clearing uarg_to_msgzc(ubuf)->zerocopy, so
completion is reported without SO_EE_CODE_ZEROCOPY_COPIED.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1795783388.gi=
t.tanggeliang@kylinos.cn?part=3D3
