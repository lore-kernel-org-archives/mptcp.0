Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795415558;
	b=jNWNb6yNI1PnOoagsxQ2hVaEr2BW2JH9CyPNmCDTUH4tl/sUGBytom9lOQcnzfiaDefn
	 tIIhY2d8xq2YlRZ6vgMU6IZ1jq1niPch86UAVKNDx3y1ljkV7HeFIwQrBBwTtgqqxEFEu
	 s5w0y6LLzaB7ubzW/PjPPL1OZrp5pCLSvCcTa0Pr3qlkFDkJ0lV1o3xTNSO6Kgbm2QxFI
	 NMGSvktzv0z+VMf+5+xqDV8GWOOIvVB/5VzaCML9uuGLfWJ+kO+NpfoaBBZYRey3xP/Ew
	 mrBTRDy/KtAZhcdSPI283/H2NdVlDR0H1H5WlkIwdkfuaEaT5Vz5VlR05HglR/IpAYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795415558;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=VzY3U7gEdzDudhwCpQD7cEMGU3f3VMmAmk80arDj3KE=;
	b=t7U5sRoW6vKqd1DgQT4rxTcwLvyFeTrI8jGpQpggqTU67HTEJKHeuJ/bdWD7MJy8EdIc
	 BPYgx6t1X44bNsdSvc1cwnKVSSK+EhNYNXys/ufcIRAt8bteobXWESObTQAJulsML1yoa
	 iAB5gwVqjGRIMn6iIWisms7ZTSMzognQq4thNtAVbrFIPbdcS4iK00zQJphQY/oSG1u4E
	 ApKEwbPN+2GFukYORIyqi/nSxabxM2c8zbko5bwZ/iLIM0B5S4Is0A1FjeYKi12btA7U8
	 WXt5C/pdp8w0oshOVzmuBGoRYKM3C+5QpT0R33JDJ+skaCOZmFTbuxQv+PVnq1YzkGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cvimQaHk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97CA606A31A
	for <mptcp@lists.linux.dev>; Mon, 23 Nov 2026 06:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cvimQaHk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74C731F000D4;
	Mon, 23 Nov 2026 06:32:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795415558;
	bh=VzY3U7gEdzDudhwCpQD7cEMGU3f3VMmAmk80arDj3KE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=cvimQaHkXfpj+UFzJRnvKLJJ6wLRlezMWlQKuTLt2jZP668o/cUuLJKo6mwgucFdJ
	 rSX9LxznYJcA/NEuMJtO7wmpzepQxa/PaLIGwhX7Bky29M1H6HlsRLOvEbVl+W5mLD
	 5j14+SlAgKeF+pnxWTf8EyJthiU1GKy/1+D2WDhtMbqQB5Wzn8sgrmdZ5CUw9hZnF2
	 yQzfss+Dr2z6xkXiJ2ZHwv63rlFRqnSFdv0SSUIUD4Q7P5mt/e5fKpI5jzV97xRkF1
	 RyqchNjf/zRs8bfgJu2ZkS1iLRRb25BfW56w+mPCr5NI3JANHlbAJIRINfy/gQCO0F
	 LiZZiE/ARO10A==
Subject: Re: [PATCH mptcp-net v2 46/62] mptcp: reclaim forward memory after
 coalescing skbs
From: netdev-bot+sashiko@kernel.org
To: matttbe@kernel.org
Cc: mptcp@lists.linux.dev, kuba@kernel.org
Date: Mon, 23 Nov 2026 06:32:38 +0000
Message-ID: <179541555805.3133.14980539036871480031@kernel.org>
In-Reply-To: <20261121-mptcp-cmason-fixes-v2-46-00327fd1de1f@kernel.org>
References: <20261121-mptcp-cmason-fixes-v2-46-00327fd1de1f@kernel.org>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] This is a comment problem only.

--

mptcp: reclaim forward memory after coalescing skbs

The patch adds sk_mem_reclaim() calls in mptcp_try_coalesce() after the
merged skb is freed, and in mptcp_data_queue_ofo() after the skb is
queued. This returns the sk_forward_alloc that is left over from
mptcp_borrow_fwdmem(), which would otherwise build up when small
segments are coalesced or condensed.

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index d90e6a5cc9fff..adae675227dff 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -197,6 +197,9 @@ static bool mptcp_try_coalesce(struct sock *sk, struct sk_buff *to,
>  	sk_mem_charge(sk, delta);
>  	kfree_skb_partial(from, fragstolen);
>  
> +	/* release what is left of the borrowed 'from' truesize */
> +	sk_mem_reclaim(sk);
> +

[Severity: Low]
This isn't a bug, but mptcp_try_coalesce() now has two comments that
describe different ownership models for the 'from' skb. Each one is
wrong for some of the callers.

A few lines above the new code, the older comment says:

	/* note the fwd memory can reach a negative value after accounting
	 * for the delta, but the later skb free will restore a non
	 * negative one
	 */

That only holds when 'from' has the sock_rfree destructor.

In __mptcp_move_skb(), and in mptcp_data_queue_ofo() via
mptcp_ooo_try_coalesce(), 'from' is borrowed through
mptcp_borrow_fwdmem() and has no destructor. skb_try_coalesce() keeps
delta <= from->truesize, so sk_forward_alloc does not go negative here.
kfree_skb_partial() also gives nothing back. That missing release is
the reason this patch adds the reclaim.

The new comment does not fit the third caller. __mptcp_ofo_queue()
calls:

	if (!tail || !mptcp_ooo_try_coalesce(msk, tail, skb)) {

with an out-of-order skb that mptcp_data_queue_ofo() already owns via
skb_set_owner_r(). For that skb, kfree_skb_partial() runs
sock_rfree()->sk_mem_uncharge(), which already reclaims. Nothing
borrowed is left, and the new sk_mem_reclaim() has no effect.

Could the older comment be updated, and the new one reworded to cover
both the borrowed and the owned cases? As written, a reader who trusts
the older comment might drop the new reclaim as redundant. That would
bring back the sk_forward_alloc buildup on the borrowed paths.

>  	return true;
>  }
>  

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261121-mptcp-cmason-fixes-v2-0-00327fd1de1f%40kernel.org
