Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794955272;
	b=cuia679aOUG9T9x5Kh1hvTZIe99adNy23In21a5VTkfvOCdjgALTgg2/cbUkToElsFaz
	 EOJQaWElTAH3ImQ1pszfTwq2uoutbCUUKxWrBGbNhwgjCZqPvotox2++l7ClRwn3rPZSo
	 VHXrb7pZHxbociL2QynISedkNsBOVTQzzdP7iXeyZ7vCUkQDkHal3AXy6ymo5vxpmyey4
	 FnntO06qo7rBQufMDiIgLz8T69X0fpEL70ACwH3lcrjgIVg3jjBcCeDJW45V2kn5K3NLo
	 wA/F4PL2lzDBC8YKQ7YrOZHcAYohJaPIcke+0w6xXiDxRw0nbzoKiBZ8t3fr0GBYHTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794955272;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=lVJxOLKddUnyqhch9nznUYi4uJQEBdD9MX5+sMfekkA=;
	b=elz7fHw+LYM2r14klV/DpYGv8aKu/DcrN9K8g2dtDtwyfMrRSiuUNzldmNdRwclzyV2f
	 Xz1iIhvGhmdnCqSSho7ToidP8ccLxV9bh5qodcKTqTaTbYJ+eKMxGt05Fk//5I2I5fWB+
	 X1HSFwHUcmAYfBLl6wLIT6r7EKbayFgJnGfMTHFNVyTEvOR4/9bqoB+LLSTNTgjkv/0wm
	 2TCJJvasScrl9lP5mOe9T8pORSQJVu3mtMxfTTTkP4Q5APDsad0AMUjVNaTyQ8y+PYAuz
	 498pRVqX+m3yNiVTR/c3BButFrHDhwIKwZYbQ1lksF5tZx4BkaPbGzPfjmrG8guV3hA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="nw0/TtTe";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 147C2606A31C
	for <mptcp@lists.linux.dev>; Tue, 17 Nov 2026 22:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nw0/TtTe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B994B1F000C4;
	Tue, 17 Nov 2026 22:41:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794955271;
	bh=lVJxOLKddUnyqhch9nznUYi4uJQEBdD9MX5+sMfekkA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=nw0/TtTeeuEZFTThMEyINhfOY+zJvH81LitdcynsXkp08ZUEAhPkdsFW9xznThRkL
	 bx21RZr+eytza+fQ6USMa4u4dEN2B6IRFHQnwvZtS7gwcMIaYr2jPZpPTcBSUXjM2K
	 8YPOvAXU7J085yezLhjdv0WKL7DVQMdmortojT038pMIIsmj9yaDUPryZP9aKsB0vJ
	 xfoyPwuePEezv/6mmzlKXTRFyj0E3Tds1FZYPMPabHqjxucXr4IzbLBb2hJMSHAUvi
	 BSpWyppxJtfXCh3GaBIduWTtZpccuOj/gLEMcUaHyp3mtGS1Hqbz/rUt7q84Qt9YnW
	 8sbtX81WFuO6g==
Subject:
 Re: [PATCH mptcp-next v28 06/11] mptcp: add flags field to mptcp_skb_cb
From: netdev-bot+sashiko@kernel.org
To: geliang@kernel.org
Cc: mptcp@lists.linux.dev, kuba@kernel.org
Date: Tue, 17 Nov 2026 22:41:11 +0000
Message-ID: <179495527130.3133.4607719757932776867@kernel.org>
In-Reply-To: <f31e23f95b08c864e69ad13f1d794795b24ead1a.1794810809.git.tanggeliang@kylinos.cn>
References: <f31e23f95b08c864e69ad13f1d794795b24ead1a.1794810809.git.tanggeliang@kylinos.cn>
X-sashiko-severity: Critical
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

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 1 · High: 0 · Medium: 0 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Critical] In net/mptcp/protocol.c, __mptcp_try_coalesce() used to
  refuse coalescing when `MPTCP_SKB_CB(from)->offset` was non-zero.
- [Low] The commit message says MPTCP_SKB_CB_F_OFFSET marks "skbs with a
  non-zero offset".

--

mptcp: add flags field to mptcp_skb_cb

This commit adds a flags field to struct mptcp_skb_cb and a
MPTCP_SKB_CB_F_OFFSET flag. mptcp_init_skb() sets the flag when the skb
has a non-zero offset. __mptcp_try_coalesce() now tests this flag on both
skbs instead of testing from->offset directly, as preparation for removing
the offset field later in the series.

[ ... ]

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 41fc2429d2fed..395bdcd0080c1 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -168,7 +168,8 @@ static bool __mptcp_try_coalesce(struct sock *sk, struct sk_buff *to,
>  	int limit = READ_ONCE(sk->sk_rcvbuf);
>  
>  	if (MPTCP_SKB_CB(from)->map_seq != MPTCP_SKB_CB(to)->end_seq ||
> -	    MPTCP_SKB_CB(from)->offset ||
> +	    (MPTCP_SKB_CB(from)->flags | MPTCP_SKB_CB(to)->flags) &
> +	     MPTCP_SKB_CB_F_OFFSET ||
>  	    ((to->len + from->len) > (limit >> 3)) ||
>  	    !skb_try_coalesce(to, from, fragstolen, delta))
>  		return false;

[Severity: Critical]
Can this coalesce an skb whose prefix the msk has already received?

The flag is only computed in mptcp_init_skb(). The partial packet branch
of __mptcp_move_skb() raises offset after that, leaves flags alone, and
then jumps to the coalesce attempt:

net/mptcp/protocol.c:__mptcp_move_skb() {
    ...
	/* Partial packet */
	if (after64(MPTCP_SKB_CB(skb)->end_seq, msk->ack_seq)) {
		copy_len = MPTCP_SKB_CB(skb)->end_seq - msk->ack_seq;
		MPTCP_SKB_CB(skb)->offset += msk->ack_seq -
					     MPTCP_SKB_CB(skb)->map_seq;
		MPTCP_SKB_CB(skb)->map_seq += msk->ack_seq -
					      MPTCP_SKB_CB(skb)->map_seq;
		goto insert;
	}
    ...
insert:
    ...
		tail = skb_peek_tail(&sk->sk_receive_queue);
		if (tail && mptcp_try_coalesce(sk, tail, skb))
			return true;
    ...
}

At that point from->map_seq equals the old ack_seq, which is also
tail->end_seq, and both flags are 0. Before this patch the from->offset
test refused the merge. Now skb_try_coalesce() appends all from->len bytes
to the tail, already-received prefix included.

__mptcp_recvmsg_mskq() and mptcp_read_sock() copy skb->len - offset bytes
from the tail. Wouldn't userspace then get the overlapping bytes twice in
the middle of the stream? bytes_consumed could also grow past
bytes_received, so mptcp_data_avail() could wrap.

One way to reach this is while the msk is owned by the user. In that case
mptcp_data_ready() puts subflow skbs on the backlog without advancing
msk->ack_seq. The old-data discard in subflow_check_data_avail() then
compares against a stale ack_seq.

Suppose the peer sends DSN [0,1000) on one subflow and [500,1500) on
another, either as a normal reinjection or through a crafted DSS. When the
backlog is spooled, the second skb takes the partial path: offset goes
from 0 to 500, flags stays 0, and the whole skb is coalesced into the
first one.

This looks resolved later in the series by "mptcp: remove CB offset
field". There, the partial path no longer modifies offset or map_seq, and
the from->map_seq != mptcp_end_dsn(to) check rejects the partial skb. The
window is limited to this commit and "mptcp: encapsulate CB DSN field
access with helpers".

Could this commit keep the from->offset test, or set MPTCP_SKB_CB_F_OFFSET
in the partial path? Then a bisect that lands here would not hit the
duplicated data.

> @@ -428,6 +429,7 @@ static void mptcp_init_skb(struct sock *ssk, struct sk_buff *skb, int offset,
>  	MPTCP_SKB_CB(skb)->map_seq = mptcp_subflow_get_mapped_dsn(subflow);
>  	MPTCP_SKB_CB(skb)->end_seq = MPTCP_SKB_CB(skb)->map_seq + copy_len;
>  	MPTCP_SKB_CB(skb)->offset = offset;
> +	MPTCP_SKB_CB(skb)->flags = offset ? MPTCP_SKB_CB_F_OFFSET : 0;
>  	MPTCP_SKB_CB(skb)->has_rxtstamp = has_rxtstamp;

[Severity: Low]
This isn't a bug, but the commit message says:

    Add a flags field to mptcp_skb_cb and define MPTCP_SKB_CB_F_OFFSET to
    mark skbs with a non-zero offset.

At this commit the flag only records whether offset was non-zero when
mptcp_init_skb() ran. Several places still raise MPTCP_SKB_CB(skb)->offset
later without updating flags:

- __mptcp_move_skb(), on the partial packet path
- __mptcp_ofo_queue()
- __mptcp_recvmsg_mskq(), on partial reads
- mptcp_read_sock(), on partial reads

Could the description say that the flag reflects the offset at init time?

Two smaller points. The new to->flags test goes further than the old check,
which only looked at from. It costs a few coalescing opportunities. Also,
the reason for the value TCPHDR_FLAGS_MASK + 1 is only given in the later
"mptcp: sync mptcp skb cb layout with tcp one" patch.

Both points go away once "mptcp: remove CB offset field" removes the offset
field. This is only about the wording of this intermediate commit.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1794810809.git.tanggeliang%40kylinos.cn
