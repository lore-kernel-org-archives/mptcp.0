Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793873602;
	b=ZGVj3vxoG8IWredu4z7+/o3O7gzaiQdz2Ujf+nBBQxuXbZGU+9iDazjUeHnYqaiUs8zJ
	 WcyNtHjM0atDSfgBhjPSNG+LFGigLroNxlXC4huZoMQxyPdb1CddivPCHEOJntnd1l7mX
	 gK4tgkcYqAfK45sxSLn3mBoPM/FDSRy8lEMorm44o1N8Qf6gDsH4J0MhI8DKN4MAyK9Z0
	 OB6Olx90g9V+r/1zuji4NpdF5cywT3nTGE88lw7fbVyNashxByACmz1o2ShYdft22/RNO
	 oNvU9/FaNh+MrKrc4LPm+09mGnFg57TRIr6ZlB755SOz/wh4C2ownUXAbzqEjql26ng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793873602;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=G8iyKKbBaIp6Kgr/PWIrGteHhZQWaRvUjRYiseE5tFY=;
	b=Ae4ZQ6xAJqQge9Kzf/G4bxV4rvKc53VaKDj82qffPrEfxv5eAJl44JIFKGPjbGyP6jnO
	 Ld07V4U/FealTYdPD2bs5gh2k7vCTqkXpUypPogjLWB71RFiRCUNdWP8UInyCU2zCHR3M
	 g8QG722mkMyQhnRRX/XsJkptT24ozMd+wKMWSxN1QMf6OHrNXp8aFhirJLDTrDH8vSC4r
	 g/EVidzXfrFP9hu1PDF7VT0eI26Op2bRKJ2EUI/kepEhNoXH2V/6CMG8vLS6ouocOQntC
	 DclIunHglvmTLoYHWMFSrNgSfoXY5PGHhZFLVv2WgDufeeKJ8UHJ3o1xO4hweAKxPLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VMeiIKzs;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C011606EE9E
	for <mptcp@lists.linux.dev>; Thu,  5 Nov 2026 10:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VMeiIKzs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C7741F000C1;
	Thu,  5 Nov 2026 10:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793873601;
	bh=G8iyKKbBaIp6Kgr/PWIrGteHhZQWaRvUjRYiseE5tFY=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=VMeiIKzsbdBbtk3yK45UUibjH4VkpZ6BErvGZ+0rCJS0r7OHo5PAXu/rDGtk/Efip
	 h0K0WrjgPV+wvkXWBD2SYiUgEBYKo3A1r+tS4jJAEJslIC4Dza1m4c5IeJROUS/bi7
	 GYc+R74tc6CsHOe/3TwEgn1bpMMCgjZlCLfy7WW1bAsJZ8UEdBQDkXSjBNbFDLAZfm
	 Iz5/K+iu2Nrv7m3dZkeHSbt2G7CG0xxFGe3FwCT3sqNZtNNPwXCUUfnORn9RgEl9F7
	 D/PoCR4nckeImnpEk1wBfUeA4Vaj3gkgv4v5cej3CyfO9Tu7Kc0IgaDNZHkUP59ECk
	 BZCqpnNYZU2kg==
Message-ID: <sashiko-outbox-198824@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-next v21 7/9] mptcp: remove CB offset field
Reply-To: sashiko-reviews@lists.linux.dev
To: "Geliang Tang" <geliang@kernel.org>, mptcp@lists.linux.dev
In-Reply-To: <c458572345b51e9de3dd7731c9ee6437a230a146.1793870710.git.tanggeliang@kylinos.cn>
References: <cover.1793870710.git.tanggeliang@kylinos.cn>
 <c458572345b51e9de3dd7731c9ee6437a230a146.1793870710.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 10:13:20 +0000
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
- [Critical] mptcp: kernel BUG in mptcp_init_skb() when pulling nonlinear s=
kb
- [High] mptcp: 32-bit sequence wrap bug in mptcp_init_skb() boundary check
--

commit 1950bbe60e98f6cc91ceb0674f4d63a6b8018ce9
Author: Paolo Abeni <pabeni@redhat.com>

mptcp: remove CB offset field

This commit removes the offset field from struct mptcp_skb_cb and replaces =
it
with a new copied_seq field in struct mptcp_sock to track bytes already
consumed inside each skb. It also adds a mapping boundary check in
mptcp_init_skb() to strip already-consumed prefix bytes belonging to a
previous DSS mapping via skb_pull().

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index dd612e9b2b262..0666bbfdf2cb8 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c

[ ... ]

> @@ -415,19 +414,34 @@ static void mptcp_data_queue_ofo(struct mptcp_sock =
*msk, struct sk_buff *skb)
>  	skb_set_owner_r(skb, sk);
>  }
> =20
> -static void mptcp_init_skb(struct sock *ssk, struct sk_buff *skb, int of=
fset,
> -			   int copy_len)
> +static void mptcp_init_skb(struct sock *ssk, struct sk_buff *skb, int of=
fset)
>  {
>  	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(ssk);
>  	bool has_rxtstamp =3D TCP_SKB_CB(skb)->has_rxtstamp;
> =20
> +	/* Detect mapping boundary: skb spans multiple mappings */
> +	if (unlikely(offset > 0 &&
> +		     TCP_SKB_CB(skb)->seq - subflow->ssn_offset <
> +		     subflow->map_subflow_seq)) {

[Severity: High]
As reported by Sashiko on v20 [1], should this comparison use before()
instead of raw unsigned < for 32-bit modular relative subflow sequence
numbers, matching validate_mapping() in net/mptcp/subflow.c?

net/mptcp/subflow.c:validate_mapping() {
	u32 ssn =3D tcp_sk(ssk)->copied_seq - subflow->ssn_offset;

	if (unlikely(before(ssn, subflow->map_subflow_seq))) {
		...
}

TCP_SKB_CB(skb)->seq, subflow->ssn_offset, and subflow->map_subflow_seq are
all u32 values. Using unsigned < causes regressions in two scenarios:

First, on passive TFO subflows, mptcp_fastopen_subflow_synack_set_params()
in net/mptcp/fastopen.c advances subflow->ssn_offset past the TFO SYN data:

	tp->copied_seq +=3D skb->len;
	subflow->ssn_offset +=3D skb->len;

If a peer sends an overlapping segment starting in the TFO SYN data range
where TCP_SKB_CB(skb)->seq < subflow->ssn_offset < TCP_SKB_CB(skb)->end_seq,
or when relative subflow sequence numbers wrap around 2^32 across two
mappings, TCP_SKB_CB(skb)->seq - subflow->ssn_offset wraps near U32_MAX whi=
le
subflow->map_subflow_seq is small. The unsigned < check evaluates to false,
leaving the old prefix bytes in skb and setting MPTCP_SKB_CB(skb)->map_seq =
to
mptcp_subflow_get_mapped_dsn(subflow) - offset, which corrupts the receive
stream.

Second, if a single DSS mapping starts near U32_MAX and wraps past 0, an skb
within that same mapping whose relative sequence number has wrapped past 0
with offset > 0 will satisfy unsigned < against subflow->map_subflow_seq and
falsely trigger the boundary branch.

> +		pr_debug("spans mappings seq=3D%u map_subflow_seq=3D%u offset=3D%d ssn=
_offset=3D%u\n",
> +			 TCP_SKB_CB(skb)->seq, subflow->map_subflow_seq,
> +			 offset, subflow->ssn_offset);
> +
> +		/* prefix bytes belong to old mapping, remove them and start
> +		 * from current mapping
> +		 */
> +		WARN_ON_ONCE(offset >=3D skb->len);
> +		skb_pull(skb, offset);
> +		offset =3D 0;
> +	}

[Severity: Critical]
Can calling skb_pull(skb, offset) in __mptcp_move_skbs_from_subflow() ->
mptcp_init_skb() trigger a kernel BUG() when the subflow receive skb is
non-linear?

When TCP queues incoming segments onto ssk->sk_receive_queue in
tcp_data_queue(), the TCP header has already been pulled via __skb_pull().
For non-linear skbs where payload bytes reside in skb_shinfo(skb)->frags[]
(such as packets sent by mptcp_sendmsg_frag() over loopback or veth, GRO
packets, page_pool RX packets, or segments coalesced via tcp_try_coalesce()=
),
skb_headlen(skb) is 0 or smaller than offset.

Calling skb_pull() invokes __skb_pull() in include/linux/skbuff.h:

static inline void *__skb_pull(struct sk_buff *skb, unsigned int len)
{
	skb->len -=3D len;
	if (unlikely(skb->len < skb->data_len)) {
#if defined(CONFIG_DEBUG_NET)
		skb->len +=3D len;
		pr_err("__skb_pull(len=3D%u)\n", len);
		skb_dump(KERN_ERR, skb, false);
#endif
		BUG();
	}
	return skb->data +=3D len;
}

When offset > skb_headlen(skb), skb->len becomes smaller than skb->data_len
and __skb_pull() hits BUG(). Would pskb_pull() or __pskb_pull_tail() be
needed here, or can the offset be handled without pulling paged data?

[1] https://lore.kernel.org/r/866f86ad2ea894fc21af7546ed0cf6f8b9d816de.1793=
695518.git.tanggeliang@kylinos.cn

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1793870710.gi=
t.tanggeliang@kylinos.cn?part=3D7
