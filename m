Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD6245695
	for <mptcp@lists.linux.dev>; Thu, 27 Nov 2025 00:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764201980; cv=none; b=PX5qA84AFXt+YUlucXBaQ32WFZb5zziPpHyXSK105qGsG+UcjjLwbR1NZDUgU34LUlcQYOu5P9Yy03+7FxivlVEa9TNVo5b5ZLt/PMiDZ4z9O44kIIEB7DRERsoA1AGGarvnXhE6PQUZWFKxGNFWg7rWT/fDP88pITsQRxR5Hdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764201980; c=relaxed/simple;
	bh=7yJRwwKoUeeLDTRUXjfboEvhjMBc+kVn5oBbokn3K3E=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Ft9ToO0KrDIUkNfwhVceqW5W3D9hzHUmj7GXS+/BXhXcEYavy3r+DHXo/wt/ybBFFG2rSz1bwHuSUf2UQ4ZZE/F/qlcBnCHFdROnJA+7aEYxczcBoV86UHNHZ2T4gaZVituJCiaf41PAsH9rCiXdxFP7cRMXA2aVHu7nziqcvGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VN+BG6wb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VN+BG6wb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59ACAC4CEF7;
	Thu, 27 Nov 2025 00:06:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764201980;
	bh=7yJRwwKoUeeLDTRUXjfboEvhjMBc+kVn5oBbokn3K3E=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=VN+BG6wbmwZxIMuSc+9SyE8+9eNtlu5z45sdNe3CS2YAMeJTbTwNRYYQ8qCDLA1tz
	 glptyuSG5aFY6VBrgUebrs7RkXgxQCFszZpfFO04qHLHY117HXE2MeSgT2gkrLWibH
	 BlukecKdtbax+l2HsxXAImvtTYJMsZbzglVZmXF3aV2t2PkmFzChfsICSCrkxDRlp4
	 3ACHqB2ywBGoScrAZv1zRIGK31kcnLyDKsu4MpgtSGLujryji8T2oLH6x++yhl13xX
	 SyGN+o+0jam34SiFOPZ0hWe8KaaBggjA7/chtGPa4yRpzX5IxF3ieeV7JIRQkF1vRo
	 3FcaKP51yHvAQ==
Date: Wed, 26 Nov 2025 16:06:19 -0800 (PST)
From: Mat Martineau <martineau@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH v7 mptcp-next 2/6] mptcp: do not account for OoO in
 mptcp_rcvbuf_grow()
In-Reply-To: <069348a7ea6d0ee86d1003a89dc343c540efa776.1763625391.git.pabeni@redhat.com>
Message-ID: <31b979ad-7d3e-b99b-cb86-d119b10a393f@kernel.org>
References: <cover.1763625391.git.pabeni@redhat.com> <069348a7ea6d0ee86d1003a89dc343c540efa776.1763625391.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Thu, 20 Nov 2025, Paolo Abeni wrote:

> MPTCP-level OoOs are physiological when multiple subflows are active
> concurrently and will not cause retransmissions nor are caused by
> drops.
>
> Accounting for them in mptcp_rcvbuf_grow() causes the rcvbuf slowly
> drifting towards tcp_rmem[2].
>
> Remove such accounting. Note that subflows will still account for TCP-level
> OoO when the MPTCP-level rcvbuf is propagated.
>
> This also closes a subtle and very unlikely race condition with rcvspace
> init; active sockets with user-space holding the msk-level socket lock,
> could complete such initialization in the receive callback, after that the
> first OoO data reaches the rcvbuf and potentially triggering a divide by
> zero Oops.
>
> Fixes: e118cdc34dd1 ("mptcp: rcvbuf auto-tuning improvement")
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> net/mptcp/protocol.c | 6 ------
> 1 file changed, 6 deletions(-)

Looks good, thanks Paolo:

Reviewed-by: Mat Martineau <martineau@kernel.org>


>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 64f592a7897c..e31ccc4bbb2d 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -226,9 +226,6 @@ static bool mptcp_rcvbuf_grow(struct sock *sk, u32 newval)
> 	do_div(grow, oldval);
> 	rcvwin += grow << 1;
>
> -	if (!RB_EMPTY_ROOT(&msk->out_of_order_queue))
> -		rcvwin += MPTCP_SKB_CB(msk->ooo_last_skb)->end_seq - msk->ack_seq;
> -
> 	cap = READ_ONCE(net->ipv4.sysctl_tcp_rmem[2]);
>
> 	rcvbuf = min_t(u32, mptcp_space_from_win(sk, rcvwin), cap);
> @@ -352,9 +349,6 @@ static void mptcp_data_queue_ofo(struct mptcp_sock *msk, struct sk_buff *skb)
> end:
> 	skb_condense(skb);
> 	skb_set_owner_r(skb, sk);
> -	/* do not grow rcvbuf for not-yet-accepted or orphaned sockets. */
> -	if (sk->sk_socket)
> -		mptcp_rcvbuf_grow(sk, msk->rcvq_space.space);
> }
>
> static void mptcp_init_skb(struct sock *ssk, struct sk_buff *skb, int offset,
> -- 
> 2.51.1
>
>
