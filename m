Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795415555;
	b=tnjl19FG501AWTrTqrluOjT7Mkv25110bJuwxe460KUVVlL72+azo27DxJrXSx1Wrzl3
	 Ht4UXdQelcgqu1AvDufctcK+BVxz9f/Yu1gL3U0m8AnmhOBie91U3MZrECuBTVC43JDmU
	 RBZScoPyVD0pSXdmU8NxqkTZolwFQiVCFtrrQd4NCN4AF1/QV8WLZYPhTdxYLjb6/NkAE
	 JjMCW2s6ncFpsrqv2zaJxaixiKYaKd/gC7gnHsAAn3BxIYg0wphUTLoggQeDhqEe5oaFH
	 bDdmkH14CWZ75dKsG4YpOusrzmH3JXwtt1V4S6rc9xqIxbIo1l3xwUsRx15zbmyO8CQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795415555;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=rcz9FiQg7TdbYrSK2DxbpPuSlBg7VN9x4AsPSrOXpw4=;
	b=TFucKX+1r9p5XUSN9NMe9jGorXjazgr+PHAwANoZb+6PKsMPtkT7EmzeLiY2BHPkNBO8
	 jOLTAYfmwgPN/UVEzXqKTqlPlmNIViHfNhEL9cFErpoT4jFvyT44GFvWuWEUSLKQy/01d
	 urMjfwbTgduiBoDEMJRO/L7GXIfvTNqbfk0OcvoWjbNPCWEy4q5HAw62iAWV+fscSDTie
	 Fxchl7WDO6ixaUTMRedsKTn3KIDJgM37+kydqj8lm23X2NgIrevtQ0XkjSbJHrOPHqLnV
	 Qd3FHJT/ScqWBrgoas4ihaHnTd/oH5o7EBjVgA+9HkPxKu3tKzRA+ih52+D7osjB5AQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Jmu0OybS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D990606A31A
	for <mptcp@lists.linux.dev>; Mon, 23 Nov 2026 06:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Jmu0OybS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB9901F000CA;
	Mon, 23 Nov 2026 06:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795415554;
	bh=rcz9FiQg7TdbYrSK2DxbpPuSlBg7VN9x4AsPSrOXpw4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Jmu0OybSNsfH19P6mCXGI5pxGYQXp9MWMpdT8aF0IqjHgm3uFAAzdopwmocUVRe2e
	 TXJxBImtfJTlkNrVgIRSq7O50MfHWZlehuo95lYcpiazABrG7QABte0wGjdopkRljz
	 B2XRyjNu0ANfYWWDn9SSOzuiVs+F/F28Y+y4Xw2HqjrgbInaEM48JQrf0fmGt7SVmJ
	 q/UKd5XSYu26oL8MYYH5ttspCs71g+8VDIKC/ReJcfpcR7kn+JN5+IrOfgM4v0h1xx
	 oQFltKc6q28qMZSVnIokU3VrtIFV4d3MQTMW7oAjNBLS0qnAV19GYW2kVTXDiASLFN
	 HP1OXz6lDhDoQ==
Subject: Re: [PATCH mptcp-net v2 38/62] mptcp: send the infinite map in a
 single segment
From: netdev-bot+sashiko@kernel.org
To: matttbe@kernel.org
Cc: mptcp@lists.linux.dev, kuba@kernel.org
Date: Mon, 23 Nov 2026 06:32:34 +0000
Message-ID: <179541555434.3133.14142600677566167518@kernel.org>
In-Reply-To: <20261121-mptcp-cmason-fixes-v2-38-00327fd1de1f@kernel.org>
References: <20261121-mptcp-cmason-fixes-v2-38-00327fd1de1f@kernel.org>
X-sashiko-severity: High
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The fix holds only while the subflow MSS never drops below the
  pre-fallback MSS.

--

mptcp: send the infinite map in a single segment

This commit caps the skb that carries the MPTCP infinite mapping at one
MSS in mptcp_sendmsg_frag(), using the MSS computed before the fallback.
Before this change, the skb could be sized with the pre-fallback size
goal. After the fallback, its segments still carried a DSS option and
could exceed the MTU, which stalled the transfer.

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index d16269d27b1da..e2fb81f52df2e 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -1483,6 +1483,12 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
>  	info->mss_now = tcp_send_mss(ssk, &info->size_goal, info->flags);
>  	copy = info->size_goal;
>  
> +	/* After the fallback, the MSS no longer includes the DSS option of the
> +	 * infinite mapping: send it in a single segment.
> +	 */
> +	if (unlikely(mptcp_subflow_ctx(ssk)->send_infinite_map))
> +		copy = info->mss_now;

[Severity: High]

Does this keep the infinite mapping in a single segment only while the
subflow MSS stays at or above the pre-fallback info->mss_now?

Right after this skb is queued, mptcp_update_infinite_map() clears the
flag:

	mptcp_subflow_ctx(ssk)->send_infinite_map = 0;

After that, MSS computations call mptcp_established_options() with
skb == NULL, and it reserves no option space:

	if (unlikely(__mptcp_check_fallback(msk) && !mptcp_check_infinite_map(skb)))
		return 0;

The queued skb still has mpext->infinite_map = 1, though. It is still
sent with a DSS option, about 28 bytes with ack64.

The PMTU can drop while this skb is unsent or unacked. One example is an
ICMP Frag-Needed for this very segment, which can be the first full-size
segment when MP_FAIL arrives before any data. In that case, would the
retransmission path split the skb with an MSS that has no room for the
DSS?

tcp_v4_mtu_reduced()
  tcp_sync_mss()
  tcp_simple_retransmit()
...
__tcp_retransmit_skb()
  cur_mss = tcp_current_mss(sk);   /* no DSS room after the fallback */
  tcp_fragment(sk, TCP_FRAG_IN_RTX_QUEUE, skb, len, cur_mss, GFP_ATOMIC)
    mptcp_skb_ext_copy(buff, skb); /* infinite_map copied to each piece */

tso_fragment() copies the extension in the same way. Each piece is then
cur_mss plus the DSS option, which is larger than the new PMTU.

With DF set, ip_fragment() drops the piece. The local ICMP carries the
same MTU, so icsk_pmtu_cookie is not lowered.

Would every RTO retransmission be rebuilt the same way, so that the
connection stalls until tcp_retries2 is reached?

A smaller overshoot also looks possible when TCP timestamps are not
negotiated. The skb is sized for the DSS option without SACK. If SACK
blocks appear later, the post-fallback MSS reserves room only for the
SACK blocks. The DSS option plus SACK blocks could then put the segment
4 to 12 bytes over the MTU.

The later patch "mptcp: keep room for infinite map after fallback"
reserves DSS space only while send_infinite_map is set. That is before
this skb is created, so the gap seems to remain at the end of the series.

Would it be more robust to keep the DSS space reserved in the MSS
calculation (skb == NULL) until the infinite-map skb has been acked? That
would also make this cap unnecessary.

>  	skb = tcp_write_queue_tail(ssk);
>  	if (skb && copy > skb->len) {
>  		/* Limit the write to the size available in the

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261121-mptcp-cmason-fixes-v2-0-00327fd1de1f%40kernel.org
