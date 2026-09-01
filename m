Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E6F839021C
	for <mptcp@lists.linux.dev>; Tue,  1 Sep 2026 09:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788254129; cv=none; b=RXuSFAnjE2tWTqj3wPzTAJ31WUt+opn8XelSoffWew4aEBeSTjZheE+ZxsS2PP3XutAFm5+FrVz2otzaEA6ZL62FixzO2cqzgjYStH0B7yEDJso851YWIGfCQ9iX5VYHWMYaJnlA65VW3jNtuxA9EZhEz2jHNdJeOXxclE6KK3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788254129; c=relaxed/simple;
	bh=uy1pTSnHLGtADZkVrFCq6g6Y0OA7K0/06ImzEIt+R2U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dOnUQk6jZeUMeNR62LExWWIFadipqHqBGyP5vTgnvR5Xy2ob07XtY7ejf1dBc/gdfqYfov3Afaaw5XeiQC8LCxHBUKpFVlcIK7SYyNdRRTDhjpqUowK9KoG3VJSegJDSi3CMy6wZVqS80T0qB8QVg12VgUj3DZ/2uel2mBbpIqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nz6dQWXj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nz6dQWXj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05C091F00A3D;
	Tue,  1 Sep 2026 09:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788254128;
	bh=uo2J3ylZ8mytqyu2Bm++/QKYhu/dKwleoHSlsl9WW2o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Nz6dQWXjHMWc3UVSGehWiE8kD1KE1EBw/LtRP1wYBRbcjyom1g8IQQA4trkhV6qFr
	 Rs9W+Ryfcu5ZsqhOnNvYCS91xYi5k1V/PWE3+kiPgxmAnAfJlymtv3Krr4LhjViqOk
	 ZBoNT/ayXn2DyHyibHPoVRMJwqkmvhSGBOBsuIbOcfwu3AhfBY3vQL+VdM3/QeXAHw
	 JXUzbUu5b0OQMSVZY3Hr2n6ty13gXnqNnqrszBS5uCamJq1Oy88622RAqkE2fyHpHQ
	 2xYbobcMFzUWuHDLXwkzTp828dubguspmI/lILRxszIbLFL2+ntkVqIcxhd9dzLORk
	 6y2eaTWxCOPEA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-net v2] mptcp: fix skb_ext leak in fallback mode
Reply-To: sashiko-reviews@lists.linux.dev
To: "Geliang Tang" <geliang@kernel.org>
Cc: mptcp@lists.linux.dev
In-Reply-To: <b67dec47d321886d45fdd2bca1c303314fcdb229.1788252583.git.tanggeliang@kylinos.cn>
References: <b67dec47d321886d45fdd2bca1c303314fcdb229.1788252583.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 09:15:27 +0000
Message-Id: <20260901091528.05C091F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] A TOCTOU (Time-Of-Check to Time-Of-Use) race condition between cac=
hed fallback state and a dynamic check during SKB allocation leads to a det=
erministic NULL pointer dereference.
- [High] Unconditional dereference of `mpext` in `mptcp_sendmsg_frag()` aft=
er improperly allowing coalescing into SKBs without MPTCP extensions on non=
-fallback sockets.
--

commit 5ed318da20af8ceeb8c86c1e52fb150843792bb6
Author: Geliang Tang <geliang@kernel.org>

mptcp: fix skb_ext leak in fallback mode

This patch short-circuits __mptcp_add_ext() in fallback mode to avoid
allocating SKB_EXT_MPTCP and skips DSS bookkeeping in mptcp_sendmsg_frag().
It also allows coalescing into extension-less SKBs.

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 0098e28309318..2e92b24c157bb 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -1121,10 +1121,13 @@ static bool mptcp_skb_can_collapse_to(u64 write_s=
eq,
>  	if (!tcp_skb_can_collapse_to(skb))
>  		return false;
> =20
> +	if (!mpext)
> +		return true;
> +

[Severity: High]
Does this change mistakenly allow coalescing into extension-less SKBs on
non-fallback sockets?

If an extension-less SKB legitimately exists at the tail of the subflow wri=
te
queue (e.g., a SYN-data SKB created by standard TCP Fast Open) and the
connection is not in fallback mode (fb =3D=3D false):

mptcp_sendmsg_frag() would see mptcp_skb_can_collapse_to() return true, set
reuse_skb =3D true, and append data.

Because fb is false, the safe fallback routing block is bypassed. Execution
would fall through to the reuse_skb block, where it unconditionally executes
mpext->data_len +=3D copy on a NULL mpext pointer.

Could this trigger a NULL pointer dereference?

[ ... ]
> @@ -1324,7 +1327,8 @@ static struct sk_buff *__mptcp_do_alloc_tx_skb(stru=
ct sock *sk, gfp_t gfp)
> =20
>  	skb =3D alloc_skb_fclone(MAX_TCP_HEADER, gfp);
>  	if (likely(skb)) {
> -		if (likely(__mptcp_add_ext(skb, gfp))) {
> +		if (unlikely(__mptcp_check_fallback(mptcp_sk(sk))) ||
> +		    likely(__mptcp_add_ext(skb, gfp))) {
>  			skb_reserve(skb, MAX_TCP_HEADER);

[Severity: High]
Can a race condition occur between the cached fallback state and this dynam=
ic
check?

mptcp_sendmsg_frag() caches the fallback state locally:

	bool fb =3D __mptcp_check_fallback(msk);

If an incoming packet concurrently triggers fallback and sets
MPTCP_FALLBACK_DONE locklessly via test_and_set_bit(), the dynamic check he=
re
in __mptcp_do_alloc_tx_skb() will observe the new state (true). It will then
omit the SKB extension allocation, leaving mpext as NULL.

Back in mptcp_sendmsg_frag(), because the cached fb is still false, the new=
ly
added fallback block is skipped:

	if (unlikely(fb)) {
		if (mpext)
			skb_ext_del(skb, SKB_EXT_MPTCP);
		goto fallback;
	}

Execution will then fall through and unconditionally dereference the NULL m=
pext
pointer (e.g., at memset(mpext, 0, sizeof(*mpext))).

Could this lead to a deterministic NULL pointer dereference?

[ ... ]
> @@ -1501,6 +1510,15 @@ static int mptcp_sendmsg_frag(struct sock *sk, str=
uct sock *ssk,
>  	TCP_SKB_CB(skb)->end_seq +=3D copy;
>  	tcp_skb_pcount_set(skb, 0);
> =20
> +	/* in fallback mode, skip DSS bookkeeping and free the extension
> +	 * if allocated
> +	 */
> +	if (unlikely(fb)) {
> +		if (mpext)
> +			skb_ext_del(skb, SKB_EXT_MPTCP);
> +		goto fallback;
> +	}
> +
>  	/* on skb reuse we just need to update the DSS len */
>  	if (reuse_skb) {
>  		TCP_SKB_CB(skb)->tcp_flags &=3D ~TCPHDR_PSH;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/b67dec47d321886d45f=
dd2bca1c303314fcdb229.1788252583.git.tanggeliang@kylinos.cn?part=3D1
