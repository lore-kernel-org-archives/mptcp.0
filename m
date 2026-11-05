Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793873809;
	b=brgfduwvVw2xgnjbV8uuEvBpfoNjRHXQEF5SXrnKJbkWzbhLNumx0Q3svHA1dGoIeelf
	 uiWTjZvZk13RI+oxDlW1ow/FmkjZc4WZ7SM4k82M8Knf8Zk9qOdE9Emwe0qAV8qMDZP/d
	 nHjQ9tDy/fQIvCMHnDKSv2imKT4CcNs8fSsjhVeLcAzZwRd2TFnL15Hswo0XZT/gYqvhB
	 NZ081yMRzkLUO6rTTI9TbMwWOksyWqmpOnG7vNS8eKK/qBOqo9mmZ0/2e/V6Ez3lrLfzB
	 /o3FxTWxLUju34ybqBv9oLNPoSyr9L9txNFJrkMpgakEm5EFRpISDNTWLEOcNLkSO+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793873809;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Re/RrD2TZo/NGCvOQX6nwgw8EcPBTcCZOHC9JQezutY=;
	b=SAuqlS+LkDF+lNxPbkJLBN6LWZegRKUplcJ661eji78FDubl8Z51jOdnUBuj+vy4Po9c
	 dETJR9hygm/O4quKAFGsr43st/FmkRzEdK59roCUHskt0u0yhZmQOkH8P5TxsOXMfK+eA
	 BaVXtGNIfqB7FGJhLFm6zYfxH2Rt75sydRWH2p+7VdP7l1fMmhfO5KO2ss2Jh8tW+1pvN
	 jbaW10QuVxzZ4MM/fPIWGVwslDDi06HsPwMDhhO40hErMsNFZ/3cfS2PBUy0pLWZQ7Rpr
	 rqhcrjbP+el6S3/HixFX8jfjVuCup24cU8tyGrTOAiLAAgUG5DaM8MEXarUVQdFolXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="j8p/1saQ";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAAD7606A31B
	for <mptcp@lists.linux.dev>; Thu,  5 Nov 2026 10:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j8p/1saQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 254E21F000C1;
	Thu,  5 Nov 2026 10:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793873808;
	bh=Re/RrD2TZo/NGCvOQX6nwgw8EcPBTcCZOHC9JQezutY=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=j8p/1saQbt6TjeW+u9JOpzwiy0Vy+c/rGQm+4MvXvSYm/NYusbwb/rFhg2ufqvuBP
	 WoWtgLB722N3jMbjupC3Epmp0kzQ9DVn24jbT830y6RkHF2rddxqMnETtLjrlUI0mG
	 yh+L8GvHJucEnNAInaLpfG+DqJDM5R2etj389VW/VoGdy3I0kh+j21DB+D/+ZIfTUp
	 NrXK2wISRdt3ihg9Mz2NaKHXyvwanhZHQ/tbiCLJcmeyQRpXs6xGIJIgL8AdC4FYNu
	 2p6tVQcG6CpITZn0uTQRGZbxJ2u7QCFJ7DxhD8svRi9ncuzI40HunT2m7KWlUrjP73
	 ylks9HBDKuktw==
Message-ID: <sashiko-outbox-198832@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-next v21 8/9] mptcp: sync mptcp skb cb layout with
 tcp one
Reply-To: sashiko-reviews@lists.linux.dev
To: "Geliang Tang" <geliang@kernel.org>, mptcp@lists.linux.dev
In-Reply-To: <d32bc6dca481d024c23d92e2ef2e51de4eca523c.1793870710.git.tanggeliang@kylinos.cn>
References: <cover.1793870710.git.tanggeliang@kylinos.cn>
 <d32bc6dca481d024c23d92e2ef2e51de4eca523c.1793870710.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 10:16:47 +0000
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
- [Critical] mptcp: skb_pull() BUG() on nonlinear skb and bad offset in mpt=
cp_init_skb()
- [High] mptcp: wrap-unsafe mapping boundary check in mptcp_init_skb()
--

commit 9d35387c93b4a664b7d58d9f115a8985e1df6730
Author: Paolo Abeni <pabeni@redhat.com>

mptcp: sync mptcp skb cb layout with tcp one

This commit updates struct mptcp_skb_cb to use 32-bit map_seq and end_seq
fields aligned with struct tcp_skb_cb, while adding a 64-bit map_seq64 field
for window validation and coalescing checks.

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 0666bbfdf2cb8..705b28219883f 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c

[ ... ]

> @@ -437,11 +446,13 @@ static void mptcp_init_skb(struct sock *ssk, struct=
 sk_buff *skb, int offset)
> =20
>  	/* the skb map_seq accounts for the skb offset:
>  	 * mptcp_subflow_get_mapped_dsn() is based on the current tp->copied_seq
> -	 * value
> +	 * value; note that end seq number is only available in 32bits format.
>  	 */
> -	MPTCP_SKB_CB(skb)->map_seq =3D mptcp_subflow_get_mapped_dsn(subflow) -
> -				     offset;
> +	MPTCP_SKB_CB(skb)->map_seq64 =3D mptcp_subflow_get_mapped_dsn(subflow) -
> +				       offset;
> +	MPTCP_SKB_CB(skb)->map_seq =3D (u32)MPTCP_SKB_CB(skb)->map_seq64;
>  	MPTCP_SKB_CB(skb)->end_seq =3D MPTCP_SKB_CB(skb)->map_seq + skb->len;

[Severity: Critical]
As reported by Sashiko on v20 [1], in mptcp_init_skb():

	/* Detect mapping boundary: skb spans multiple mappings */
	if (unlikely(offset > 0 &&
		     TCP_SKB_CB(skb)->seq - subflow->ssn_offset <
		     subflow->map_subflow_seq)) {
		...
		WARN_ON_ONCE(offset >=3D skb->len);
		skb_pull(skb, offset);
		offset =3D 0;
	}

	MPTCP_SKB_CB(skb)->map_seq64 =3D mptcp_subflow_get_mapped_dsn(subflow) -
				       offset;
	MPTCP_SKB_CB(skb)->map_seq =3D (u32)MPTCP_SKB_CB(skb)->map_seq64;
	MPTCP_SKB_CB(skb)->end_seq =3D MPTCP_SKB_CB(skb)->map_seq + skb->len;

can calling skb_pull(skb, offset) here trigger a BUG() in __skb_pull() when
the incoming subflow skb is non-linear?

In tcp_data_queue(), the TCP header has already been pulled via __skb_pull(=
).
When the TCP payload resides in page fragments (for example, skbs generated=
 by
mptcp_sendmsg_frag() where only MAX_TCP_HEADER linear space is allocated, G=
RO
packets, page_pool buffers, or segments coalesced by tcp_try_coalesce()),
skb_headlen(skb) can be 0 or smaller than offset. Because skb_pull() calls
__skb_pull():

	skb->len -=3D len;
	if (unlikely(skb->len < skb->data_len)) {
		...
		BUG();
	}

pulling offset without pskb_pull() or __pskb_trim_head() reduces skb->len
below skb->data_len and panics the kernel whenever offset > skb_headlen(skb=
).

Additionally, when offset > 0 within a single DSS mapping (so the mapping
boundary branch is not taken), mptcp_init_skb() leaves the [0, offset) pref=
ix
attached and subtracts offset from map_seq64. Since validate_data_csum() on=
ly
validates data starting at tp->copied_seq, if this skb is queued out of ord=
er
in __mptcp_move_skb() -> mptcp_data_queue_ofo():

		if (before(seq, MPTCP_SKB_CB(skb1)->end_seq)) {
			if (!after((u32)end_seq, MPTCP_SKB_CB(skb1)->end_seq)) {
				...
			}
			if (after(seq, MPTCP_SKB_CB(skb1)->map_seq)) {
				...
			} else {
				rb_replace_node(&skb1->rbnode, &skb->rbnode,
						&msk->out_of_order_queue);
				mptcp_drop(sk, skb1);
				MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_DUPDATA);
				goto merge_right;
			}
		}

won't the offset-shifted map_seq cause mptcp_data_queue_ofo() to replace an
already-validated skb1 at mapped_dsn - offset with the unvalidated [0, offs=
et)
prefix, or prevent mptcp_try_coalesce() when skb1 starts earlier?

[Severity: High]
Also in mptcp_init_skb(), the mapping boundary check compares 32-bit relati=
ve
subflow sequence numbers using unsigned <:

	if (unlikely(offset > 0 &&
		     TCP_SKB_CB(skb)->seq - subflow->ssn_offset <
		     subflow->map_subflow_seq)) {

Unlike validate_mapping() in net/mptcp/subflow.c, which uses before():

	u32 ssn =3D tcp_sk(ssk)->copied_seq - subflow->ssn_offset;

	if (unlikely(before(ssn, subflow->map_subflow_seq))) {

what happens when the 32-bit relative subflow sequence number wraps around
2^32 (or when TCP_SKB_CB(skb)->seq precedes subflow->ssn_offset, such as a
segment overlapping TFO SYN data)?

If the skb starts before the wrap in an old mapping (for example,
TCP_SKB_CB(skb)->seq - subflow->ssn_offset =3D=3D 0xfffffe00) and the curre=
nt
mapping starts after the wrap (for example, subflow->map_subflow_seq =3D=3D
0x00000100), unsigned < evaluates to false. Wouldn't mptcp_init_skb() then
skip removing the old mapping's prefix bytes and subtract offset from
mptcp_subflow_get_mapped_dsn(subflow), attributing stale prefix bytes from
the old mapping to the new mapping's DSN range [mapped_dsn - offset,
mapped_dsn)? Conversely, if a single mapping straddles the 2^32 wrap bounda=
ry,
wouldn't an skb starting after the wrap with offset > 0 falsely satisfy
unsigned < and strip valid prefix bytes?

[1] https://lore.kernel.org/r/cf2994ec4440d24183bea5c407c1962270392c32.1793=
695518.git.tanggeliang@kylinos.cn

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1793870710.gi=
t.tanggeliang@kylinos.cn?part=3D8
