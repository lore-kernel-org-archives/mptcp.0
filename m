Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AABB22DECA8
	for <mptcp@lists.linux.dev>; Tue,  1 Sep 2026 06:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788245643; cv=none; b=cCahLoULaQVd9kyubEJZWejMAok+zkS+JoBUOQ9wstWANHcXyrwhU1ZwlB7kjoVWqPvCvgae15gEDUsdouQpsjj56bddbqgx/BpM02NVZA77jfZXY0uOwZdmNPqaWvzawxI34HaO49C4oLlx6nI5YXahT+wCvOzW4fPx8NmR3xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788245643; c=relaxed/simple;
	bh=FY+AoZnvYMc6VVD2AlRn+cFqLHmBYnKNtJAADe8FNUc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cnECoB4+Bcsfb3aX9O3SlwdWv31tb4B/f6dMNrl1N3+MnZPrktd/0vshRaY1H4qO5v2wTRx6gwy43k3gYV0ctWKdlRauAuBgjA1ZpYOxoLw3qGvuAXcwdIhom9Q/4HiynRuA2c4NBcfYLQrDLzDvFKiG5qJA+V32gjNq/0vkVeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bS/XoXbS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bS/XoXbS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86CBE1F000E9;
	Tue,  1 Sep 2026 06:54:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788245640;
	bh=J0dAFjDrDXHkmw9iBDX35gJbC2HcD6iBNbI8mOoyxxI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bS/XoXbSNzrlLe0bwscFhRpDZYc9jkxXjpViJItw7/ahki9PIJHGaBIv9wJ7d0XRR
	 4y/I/19bT7Qv9MyAc/tkklvBeRJXT+kpY9WQNwRoCKoRGewYwsBdBfbc8axaTKqSYZ
	 U9zOUf5x02WAbdJEDQ7nLctijMfjJYtBbEYe5GZEG9JMkDLnJ7MslS3XPO3qoKYU5c
	 qiPLbRrV1Th6NWi8MpbqsyvVY6nZEzuG+3Z60Ce5gMPorhAUzUt3eQWgSn43Gba/z4
	 hiTVXd3uYQZCfuRfRdOPS3YtN6gKg84Du8eFEgpxF7yXodrnLdcB4VgzP4YmGdmyGD
	 RIE/A5dvwJjPw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-net] mptcp: fix skb_ext leak in fallback mode
Reply-To: sashiko-reviews@lists.linux.dev
To: "Geliang Tang" <geliang@kernel.org>
Cc: mptcp@lists.linux.dev
In-Reply-To: <70a7e7e05337faa0547c3759e5d9829763f2bcc5.1788244452.git.tanggeliang@kylinos.cn>
References: <70a7e7e05337faa0547c3759e5d9829763f2bcc5.1788244452.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 06:54:00 +0000
Message-Id: <20260901065400.86CBE1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Critical] Skipping SKB extension allocation in fallback mode leads to gu=
aranteed NULL pointer dereferences in `mptcp_update_data_checksum()` (if ch=
ecksums are enabled) and `trace_mptcp_sendmsg_frag()`.
- [High] Bypassing SKB extension allocation in fallback mode breaks TCP SKB=
 coalescing, forcing a new SKB allocation for every data fragment.
- [High] A concurrent transition to fallback mode during `mptcp_sendmsg_fra=
g` leaves the SKB MPTCP extension uninitialized, leading to a kernel memory=
 info leak via tracepoints and TCP options.
--

commit 927a3dc5473de2a265a72f67b6be56f765573a1c
Author: Geliang Tang <geliang@kernel.org>
mptcp: fix skb_ext leak in fallback mode

This commit attempts to fix an SKB extension leak when operating in fallback
mode by short-circuiting the SKB_EXT_MPTCP allocation for transmitted skbs.=
 It
also skips DSS bookkeeping in mptcp_sendmsg_frag() for fallback sockets.

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 0098e28309318..825c71dc4d92a 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -1324,7 +1324,8 @@ static struct sk_buff *__mptcp_do_alloc_tx_skb(stru=
ct sock *sk, gfp_t gfp)
> =20
>  	skb =3D alloc_skb_fclone(MAX_TCP_HEADER, gfp);
>  	if (likely(skb)) {
> -		if (likely(__mptcp_add_ext(skb, gfp))) {
> +		if (unlikely(__mptcp_check_fallback(mptcp_sk(sk))) ||
> +		    likely(__mptcp_add_ext(skb, gfp))) {

[Severity: High]
Does skipping the SKB extension allocation in fallback mode break TCP SKB
coalescing?

When mptcp_sendmsg_frag() attempts to coalesce data into the tail SKB, it
calls mptcp_skb_can_collapse_to(). This helper requires a valid mpext and
returns false when it is NULL:

net/mptcp/protocol.c:mptcp_skb_can_collapse_to() {
	if (!tcp_skb_can_collapse_to(skb))
		return false;

	return mpext && mpext->data_seq + mpext->data_len =3D=3D data_seq &&
	       !mpext->frozen;
}

If mpext is NULL, it forces a new SKB allocation for every chunk and marks
the previous SKB with eor=3D1 in mptcp_sendmsg_frag(), preventing TCP layer
merging:

net/mptcp/protocol.c:mptcp_sendmsg_frag() {
		mpext =3D mptcp_get_ext(skb);
		if (!mptcp_skb_can_collapse_to(data_seq, skb, mpext)) {
			TCP_SKB_CB(skb)->eor =3D 1;
			tcp_mark_push(tcp_sk(ssk), skb);
			goto alloc_skb;
		}
}

>  			skb_reserve(skb, MAX_TCP_HEADER);
>  			skb->ip_summed =3D CHECKSUM_PARTIAL;
>  			INIT_LIST_HEAD(&skb->tcp_tsorted_anchor);

[ ... ]

> @@ -1501,6 +1502,12 @@ static int mptcp_sendmsg_frag(struct sock *sk, str=
uct sock *ssk,
>  	TCP_SKB_CB(skb)->end_seq +=3D copy;
>  	tcp_skb_pcount_set(skb, 0);
> =20
> +	/* in fallback the msk ext is not allocated; skip DSS bookkeeping
> +	 * entirely and let the subflow behave like a plain TCP socket
> +	 */
> +	if (__mptcp_check_fallback(msk))
> +		goto out;
> +

[Severity: Critical]
Will this lead to a NULL pointer dereference at the out label?

Because the SKB extension is not allocated for fallback sockets, mpext will
evaluate to NULL. Jumping to the out label executes this code:

net/mptcp/protocol.c:mptcp_sendmsg_frag() {
out:
	if (READ_ONCE(msk->csum_enabled))
		mptcp_update_data_checksum(skb, copy);
	if (mptcp_subflow_ctx(ssk)->send_infinite_map)
		mptcp_update_infinite_map(msk, ssk, mpext);
	trace_mptcp_sendmsg_frag(mpext);
	mptcp_subflow_ctx(ssk)->rel_write_seq +=3D copy;
}

mptcp_update_data_checksum() queries the missing extension and
unconditionally accesses it. Furthermore, trace_mptcp_sendmsg_frag() lacks
safety guards and will unconditionally dereference the NULL mpext pointer.

[Severity: High]
Can a concurrent transition to fallback mode leave the SKB extension
uninitialized, leading to an information leak?

The MPTCP_FALLBACK_DONE bit can be set locklessly by __mptcp_try_fallback()
while mptcp_sendmsg_frag() is running.

If this concurrent fallback occurs after mptcp_alloc_tx_skb() (which
allocates the uninitialized extension from skbuff_ext_cache) but before the
__mptcp_check_fallback() check, the code takes the goto out branch.

This skips the memset(mpext, 0, ...) initialization that normally happens
later. trace_mptcp_sendmsg_frag() will then dump the uninitialized memory.
If the uninitialized mpext->infinite_map bit happens to be 1,
mptcp_established_options() will mistakenly encode uninitialized garbage
data into a TCP DSS option.

>  	/* on skb reuse we just need to update the DSS len */
>  	if (reuse_skb) {
>  		TCP_SKB_CB(skb)->tcp_flags &=3D ~TCPHDR_PSH;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/70a7e7e05337faa0547=
c3759e5d9829763f2bcc5.1788244452.git.tanggeliang@kylinos.cn?part=3D1
