Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794459578;
	b=IbGWrFTtfq2ehddlBC/0rwRgQU3OcMzwGp9QOOL+1IknYgE4c3bY2F2ohKiI5fWjlqc7
	 khMh9N6pT8EEXw3JgwM6x0BNB1Fbwypj3uC7F408+7bWeOkTb8bcbPJcafwmoXM2wWNwY
	 wXnXUuVf3v1v/OTHm3Q+DWIiRnYM5fom75ba7E81yfyazvVJSLIYxSRYf6sw1VOzfAe+r
	 yZ7YAF28X9BWXEozXz3SK5PPUZpm1DRkWDVCu4ZViw2/wgnPV2S/P3iyGiKF4mgd/zJdU
	 1rSj8GbeUjWDYjQdkHx6N92facZbqJwA1FxK1nn+XNZmyHTp/CnTWMdFt1hbkSfCnIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794459578;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=wOGZR2m/eV8MGabRLFVuYYPQwF0RucjX32JggI3MOjs=;
	b=XuZgAHlYmSFDquVYMJ8Y0+G+/wLhWxCkoF6rPgJucL1+YfhzdzFTM0tMb0VAbwc1P89c
	 McgkquTb59BVkIW+zuLV442BcprEmqcgK7d7uhuvZFVn5ihCDhSOO1Tx1MH1Gl/yHLl0N
	 2EdErd4+rsugAfl9ZHBQnK/a6fBpadr2DF7Lk8uG7V99Jj8WbJFRxE0AxdrINoi2cLUEC
	 IRu7QENRZq3z3yVQoYzDsiABlRF+iPRab32oWPgXBe36S5+olCgRMs0tufL86dFonF1Xo
	 fTeJzRBr4ONgqLwNCijG0BRL8U/Qpeh9IVWCRQaSkt478xCS9XjHKkCTYHoFeEJJfkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nSoxZcmk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED4A606A323
	for <mptcp@lists.linux.dev>; Thu, 12 Nov 2026 04:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nSoxZcmk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFA891F00A05;
	Thu, 12 Nov 2026 04:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794459577;
	bh=wOGZR2m/eV8MGabRLFVuYYPQwF0RucjX32JggI3MOjs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=nSoxZcmk1s1ZFOAHONohB3gpDbnGqWgZUgdpRvs5E3Nd1uWank71+hM3ma4VJjRsJ
	 k4iz+0BooEvd2++qmhbt5ICrxqp6nBxcF/gcU5IL7IIU1GOvGyB8uCyKoeQtU04Io+
	 wGoR9n+HFo6yl1cw+gG8DHkFtNM1HdazgENdD5QrN3LxaCsVemNYMXg1hQ4RTUbU7H
	 aSJ8drOBgXE8KnjPtktBBzouj13oN4zqQjk+ZbNqDa9eKOShVRLEBFQPX9J5fG2Gw+
	 ryKHrHgAEeaQ8OX1HzzQjpu8dXtJPqap6u5wp3XjWbAdbVtI/9G/swBuV2rInBT/M1
	 VcJnzb55aEJ8A==
Subject: Re: [PATCH mptcp-next v25 5/8] mptcp: drop the cant_coalesce CB field
From: netdev-bot+sashiko@kernel.org
To: geliang@kernel.org
Cc: mptcp@lists.linux.dev, kuba@kernel.org
Date: Thu, 12 Nov 2026 04:59:37 +0000
Message-ID: <179445957722.488855.4899104040151515864@kernel.org>
In-Reply-To: <61e30a5ecaa111377f7dfa573983f89d52af3df9.1794304840.git.tanggeliang@kylinos.cn>
References: <61e30a5ecaa111377f7dfa573983f89d52af3df9.1794304840.git.tanggeliang@kylinos.cn>
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

- [Low] In this commit, __mptcp_sync_rcv_sequence()
  (net/mptcp/protocol.c) rewrites the queued TFO skb's mapping as…

--

mptcp: drop the cant_coalesce CB field

This commit removes the cant_coalesce CB field, which kept the fastopen
skb from being coalesced. Instead, a new __mptcp_sync_rcv_sequence()
rewrites the TFO skb map_seq and end_seq using the IASN once the 3rd ack
arrives. When the msk is owned by user space, the sync is deferred via
MPTCP_SYNC_SEQ.

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 71f5b0209192b..ce0f9c2e6fd1a 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c

[ ... ]

> @@ -438,6 +436,24 @@ static void mptcp_init_skb(struct sock *ssk, struct sk_buff *skb, int offset,
>  	skb_dst_drop(skb);
>  }
>  
> +void __mptcp_sync_rcv_sequence(struct sock *sk)
> +{
> +	struct mptcp_sock *msk = mptcp_sk(sk);
> +	struct sk_buff *skb;
> +
> +	if (likely(!msk->rcvd_dummy_seq))
> +		return;
> +
> +	/* User space can have already received the TFO skb. */
> +	msk->rcvd_dummy_seq = false;
> +	skb = skb_peek_tail(&sk->sk_receive_queue);
> +	if (!skb)
> +		return;
> +
> +	MPTCP_SKB_CB(skb)->map_seq = msk->tfo_iasn - skb->len;
> +	MPTCP_SKB_CB(skb)->end_seq = MPTCP_SKB_CB(skb)->map_seq + skb->len;

[Severity: Low]
Should this take MPTCP_SKB_CB(skb)->offset into account?

mptcp_fastopen_subflow_synack_set_params() queues the TFO skb with
offset = 0 and calls sk->sk_data_ready(). So user space can read part of
the SYN data before subflow_set_remote_key() runs, or before
mptcp_move_skbs() or mptcp_release_cb() handles the deferred
MPTCP_SYNC_SEQ.

A partial read in __mptcp_recvmsg_mskq() advances offset and map_seq
together:

    if (count < data_len) {
        MPTCP_SKB_CB(skb)->offset += count;
        MPTCP_SKB_CB(skb)->map_seq += count;
        break;
    }

After the sync, end_seq is still correct because it equals tfo_iasn.
However, map_seq is now off by offset bytes, and end_seq - map_seq is
skb->len instead of skb->len - offset.

That breaks the invariant kept by mptcp_init_skb() and the partial read
path, where map_seq is the DSN of the byte at offset. Would something
like this be closer?

    MPTCP_SKB_CB(skb)->end_seq = msk->tfo_iasn;
    MPTCP_SKB_CB(skb)->map_seq = msk->tfo_iasn - skb->len +
                                 MPTCP_SKB_CB(skb)->offset;

As far as I can tell, nothing in this commit acts on the wrong value.
__mptcp_try_coalesce() compares from->map_seq against to->end_seq, which
is correct. to->map_seq is only read by the pr_debug() there, and the
read paths use offset instead of map_seq.

Later in the series, "mptcp: remove CB offset field" drops the CB offset
and tracks read progress in msk->copied_seq. There, subflow_set_remote_key()
and the MPTCP_SYNC_SEQ handlers add tfo_iasn to copied_seq, and the
arithmetic gives the right offset after a partial read. So this looks to
be fixed later in the series, but the intermediate state is inconsistent.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1794304840.git.tanggeliang%40kylinos.cn
