Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8310649BD6D
	for <mptcp@lists.linux.dev>; Thu,  1 Oct 2026 21:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790889131; cv=none; b=holBrJrZ/Svk7DjqM7GHb3Ek7dRto3OWI/MTTjpU/88FfTwa56U1U9VOkfevaixtW16229WZojbEJDDldPUvLGxyjTYYdb51PxvT9kJHzG8cf40ZrXqjvy0kU7KY1TOAyDRCX3l1GSmOns7RUFbo16i83BdDF2jdRWJIxpiKFlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790889131; c=relaxed/simple;
	bh=ua2VS5gA8xW3sXQZyLlp9TfAunIyjdHb8XQTSXplqBQ=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=a7oqGCOZ+Gl7DwXV5BTZiNvNYPpEgoyGNedH9Ls/DJ3dLuoilGAY1fZHvoYjc1CJLO7UOe+3NGZjnmECVuZ8PsVRVivLJgNz8TE7zYkfyhqdiLpYf4IKLh5LcoCXxdLQiaHm+dvZAKi/8AABBHr9ui7z+sG1MzqPbNRjK/RlB8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=So1T/Oo9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="So1T/Oo9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0A0E1F00898;
	Thu,  1 Oct 2026 21:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790889130;
	bh=/vMW7nG5lVfOwwVDfc9nvmlZrwuwMZp0bnyCt+wqRjU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=So1T/Oo99cm2vvNy+2/ZE8XSNxWCRQuLB8HK0No11QDVctPwHRwt7ee7N6gXZ04Wg
	 3KYI0MbrLi9ShnxrSj+0sqbowvotzAhVDG8DOyeQeHHh49XEYZFxKyIG0XWPrDSvV0
	 S9C31lA1NjRKSizqS02cBhdUpfzz6KpxHrNpmIgwbxmGsCHXBYj2AyAXfbXI/sxSFR
	 Ep9EzylylVDdyuRsr6FC4OaqQ4NyWCljmFUNGA3kUwr6Ft6RP2OpwsrbJNJWC42Mqu
	 e5tO1v6kV9I1/6w8bYb/horUi2U8p63O5IbAUF7MlwHH6TvbXOhvwn3Kf+4Mz0on+E
	 IbINXmXaS3Yhw==
Subject:
 Re: [PATCH mptcp-next v14 04/11] mptcp: sync mptcp skb cb layout with tcp one
From: netdev-bot+sashiko@kernel.org
To: geliang@kernel.org
Cc:
 mptcp@lists.linux.dev, pabeni@redhat.com, yangang@kylinos.cn, kuba@kernel.org
Date: Thu, 01 Oct 2026 21:12:09 +0000
Message-ID: <179088912938.3135.4160706130140135060@kernel.org>
In-Reply-To: =?utf-8?q?=3C4c7fd9c53905068b446d76dd27b22c82d20c7a1f=2E1790734?=
 =?utf-8?q?083=2Egit=2Etanggeliang=40kylinos=2Ecn=3E?=
References: =?utf-8?q?=3C4c7fd9c53905068b446d76dd27b22c82d20c7a1f=2E17907340?=
 =?utf-8?q?83=2Egit=2Etanggeliang=40kylinos=2Ecn=3E?=
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The receive-window admission check in mptcp_data_queue_ofo()
  (net/mptcp/protocol.c) does not prove what the commit message says it…

--

mptcp: sync mptcp skb cb layout with tcp one

This commit shrinks the MPTCP skb cb map_seq and end_seq fields to 32 bits
so they overlap the matching tcp_skb_cb fields. A 64-bit map_seq64 copy is
kept alongside them. Most receive-side and OFO queue comparisons now use
32-bit serial arithmetic, which relies on the receive window check. The
commit also adds build-time checks for the cb layout.

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 845fcca361fa0..a4a21717867fe 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c

[ ... ]

> @@ -301,15 +303,19 @@ static void mptcp_data_queue_ofo(struct mptcp_sock *msk, struct sk_buff *skb)
>  {
>  	struct sock *sk = (struct sock *)msk;
>  	struct rb_node **p, *parent;
> -	u64 seq, end_seq, max_seq;
> +	u64 end_seq, max_seq;
>  	struct sk_buff *skb1;
> +	u32 seq;
>  
>  	seq = MPTCP_SKB_CB(skb)->map_seq;
> -	end_seq = MPTCP_SKB_CB(skb)->end_seq;
> +	end_seq = MPTCP_SKB_CB(skb)->map_seq64 + skb->len;
>  	max_seq = atomic64_read(&msk->rcv_wnd_sent);
>  
> -	pr_debug("msk=%p seq=%llx limit=%llx empty=%d\n", msk, seq, max_seq,
> +	pr_debug("msk=%p seq=%x limit=%llx empty=%d\n", msk, seq, max_seq,
>  		 RB_EMPTY_ROOT(&msk->out_of_order_queue));
> +	/* Use the full sequence space to perform the admission checks, to
> +	 * protect vs possible wrap-arounds.
> +	 */
>  	if (after64(end_seq, max_seq)) {

[Severity: Medium]
The commit message says:

  after validating the incoming skb vs the current receive window,
  we can safely use 32 bits for MPTCP-level sequence number.

Is this check in mptcp_data_queue_ofo() enough to make the 32-bit cb
fields safe? It only tests the 64-bit end of the mapping. It never checks
that map_seq64 itself falls inside [ack_seq, rcv_wnd_sent].

Because this is signed serial arithmetic, a mapping can start just under
2^63 ahead of ack_seq and be longer than the remaining msk window. Its end
wraps around and compares as before max_seq, so the check passes.

For example, take ack_seq = A and rcv_wnd_sent = A + 1024, with a DSS
mapping that has dsn64=1, map_seq64 = A + 2^63 - 1 and skb->len = 2048:

  mptcp_expand_seq() returns the 64-bit DSN unchanged
  subflow_check_data_avail() keeps the skb, as before64(map_seq64, A)
    is false
  __mptcp_move_skb() calls mptcp_data_queue_ofo(), as
    after64(map_seq64, A) is true
  after64(end_seq, max_seq) is false, as
    (s64)((A + 1024) - (A + 2^63 + 2047)) is positive
  the cb ends up with map_seq = (u32)A - 1 and end_seq = (u32)A + 2047

The new 32-bit tests in __mptcp_ofo_queue() then do not stop at this skb:

	if (after(MPTCP_SKB_CB(skb)->map_seq, ack_seq))
		break;
	...
	if (unlikely(!after(MPTCP_SKB_CB(skb)->end_seq, ack_seq))) {

Here map_seq is just behind ack_seq and end_seq is just past it. The skb is
handled as a partial overlap and queued on sk_receive_queue, and ack_seq
and bytes_received both grow by 2047.

Would recvmsg() then return bytes the peer sent at DSN A + 2^63 as stream
bytes [A, A + 2047)? Those DSNs would be DATA_ACKed, and the real data for
that range would later be dropped as DUPDATA.

Before this patch, __mptcp_ofo_queue() used after64() on the 64-bit
map_seq. Such an skb stayed in the OFO queue and was never delivered.

The trigger needs skb->len > rcv_wnd_sent - ack_seq, and that looks
reachable:

  Each subflow's TCP window is relative to its own rcv_nxt, which does not
  move when the msk ack_seq advances through data from other subflows.

  tcp_sequence() accepts a segment that extends past the window when the
  subflow receive queue is empty.

  The in-sequence path in __mptcp_move_skb() does no window check, so
  ack_seq can even move past rcv_wnd_sent.

Should the start of the mapping also be checked before the 32-bit fields
are relied on? One option is after64(MPTCP_SKB_CB(skb)->map_seq64,
max_seq). Another is an unsigned range check such as:

	if (end_seq - msk->ack_seq > max_seq - msk->ack_seq)

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1790734083.git.tanggeliang%40kylinos.cn
