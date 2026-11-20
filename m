Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795200115;
	b=QAobyf+w1IjtI1KU2DxyU4jfoQ1KkuvcKVLgPwc3qUe8bytsZI+UW0xP0DVDUkVm0jHt
	 o1Pr6+XZfBuJQZtf2pXFtioY/LeYojrQ1KnJi7BOFdzzpw+88Qm5sezMlXg2X5SDQMTje
	 JXsYrOnQbwWcyBbS5pCfsmrygbc6GBlvlHe6VXtOcyMomAPjNhNpn3eC5XrNv4EFpGaMp
	 vFCn54myUe2VcpYYR190bmfEnroJExVg5LMzooexUMm4QZXDMH9jBxDn10MyxH4D65t/z
	 YLr4+FTRJQMsqGX2Tms9tU6NV+1MEOppo9i/J/eiTWLcsx1TKmhEVQD+qtC4UnI/ybg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795200115;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=9WYJIGMO6UMsOO4DWsh9c9BGKtW19+cg1kSblwmy4fU=;
	b=y7ghKrPyNG2VnRarzHuatTcQJZ0FbFxrQj0PUp5iFvOh1WRPq/DG9XlnudhOcoRpa3Lw
	 ebQHtBF7VNfn13qYwqlIYHo5upjeFixIBBez24BItjzDJXe0CuE3t9v1Nky9v32hxfIUW
	 Sd5Rhz7eq9znsJTGk+hyPtYg2emZOpzDbn2d4o+FJqM9eMnOPmw4t+t2UFfjN3QOdDih9
	 5QaAndIfLJQjFgd5OAeAsmpgWRriQqChOAg5qNtLnxRrgqkPNYz9N+Q4NIwOeEti+7BPX
	 IZu53+EVC1QVCr7CJcIoDL5UD3kKpZFEP5zgIan4H2ed5A65P5DiGNVALqGhbumbD1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FEPI1b6E;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2D160A2623
	for <mptcp@lists.linux.dev>; Fri, 20 Nov 2026 18:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FEPI1b6E
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C4841F000C0;
	Fri, 20 Nov 2026 18:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795200114;
	bh=9WYJIGMO6UMsOO4DWsh9c9BGKtW19+cg1kSblwmy4fU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=FEPI1b6EY3f2aOkzLqT0zzIMAq3p7vHBq8kCGAu54ZPol7i1eUZUPHtk48zLg1wQJ
	 Kk5N0MRYpj4iY5x9b4ncqc1PDH3+v5dhDExQzP/qmL9KrJy0D8FrMCjjhh/4iTAbZi
	 5UrGZ9/LHRZp2K7FlOsoT/L0d/xRoBpAbpepWN5HFkWGO3xFCHNJisOXY7N1ugJhsw
	 3p6FAuF6VsllPkF3Tlw8sFbrn5bS/FqMJWs5bXZ/jZyiG1auddorKZnI+B71E6XBJH
	 Ubo+6uZKaraL5vQU3nOabmCpLMSOfr9dee/uZE96kLXSV+G/M48w4bDOx6JWF9Te9J
	 QGqLYJ0zCS+4w==
Subject:
 Re: [PATCH mptcp-next v29 7/8] mptcp: sync mptcp skb cb layout with tcp one
From: netdev-bot+sashiko@kernel.org
To: geliang@kernel.org
Cc: mptcp@lists.linux.dev, kuba@kernel.org
Date: Fri, 20 Nov 2026 18:41:53 +0000
Message-ID: <179520011363.3133.7044883277405636164@kernel.org>
In-Reply-To: <f53cc2e63e8ae9a8e1d1918b247cd65368ee4b8e.1795063943.git.tanggeliang@kylinos.cn>
References: <f53cc2e63e8ae9a8e1d1918b247cd65368ee4b8e.1795063943.git.tanggeliang@kylinos.cn>
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

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] A remote MPTCP peer can bypass the receive-window check and
  desync the msk receive state.
- [Low] The commit message for "mptcp: sync mptcp skb cb layout with tcp
  one" says what changes but not why.

--

mptcp: sync mptcp skb cb layout with tcp one

This commit changes the MPTCP skb control block so that map_seq, end_seq
and flags line up with the matching fields of struct tcp_skb_cb. It adds a
separate map_seq64 field that holds the full 64-bit DSN, converts most
receive path sequence comparisons to the 32-bit before()/after() helpers,
and adds a build time check for the shared field layout.

> The MPTCP protocol uses a significantly different CB layout WRT TCP, as it
> includes different information and uses 64 bits for the sequence numbers.

[ ... ]

> The receive path now uses 32-bit before()/after() helpers for most sequence
> comparisons, while map_seq64 is used for window validation and coalescing
> checks. __mptcp_try_coalesce() gains a map_seq64 contiguity check to ensure
> skbs are truly adjacent in the 64-bit DSN space.

[Severity: Low]
This isn't a bug, but could the commit message explain why the layout
needs to match the TCP one?

In net/mptcp, every TCP_SKB_CB() access is on subflow or TX skbs, and that
is still true at the end of the series. Nothing in tree reads msk receive
queue skbs through TCP_SKB_CB(). The only hint is in the next patch's
message ("groundwork for the upcoming MPTCP TLS series").

The change does have a cost. The DSN is now stored twice, and every writer
has to keep map_seq = (u32)map_seq64 in sync by hand. That happens in
mptcp_init_skb(), __mptcp_sync_rcv_sequence() and
mptcp_fastopen_subflow_synack_set_params(). Several receive path
comparisons also become 32-bit, and their safety depends on the window
bound discussed below.

Also, is the "gains a map_seq64 contiguity check" wording accurate? The
pre-patch __mptcp_try_coalesce() already had the same 64-bit test, because
map_seq was u64:

	if (MPTCP_SKB_CB(from)->map_seq != mptcp_end_dsn(to) ||

This patch only renames the field to map_seq64.

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 1ed232a4e8b4d..707a40850ada5 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c

[ ... ]

> @@ -302,14 +302,15 @@ static void mptcp_data_queue_ofo(struct mptcp_sock *msk, struct sk_buff *skb)
>  {
>  	struct sock *sk = (struct sock *)msk;
>  	struct rb_node **p, *parent;
> -	u64 seq, end_seq, max_seq;
> +	u64 end_seq, max_seq;
>  	struct sk_buff *skb1;
> +	u32 seq;
>  
> -	seq = mptcp_dsn(skb);
> +	seq = (u32)mptcp_dsn(skb);
>  	end_seq = mptcp_end_dsn(skb);
>  	max_seq = atomic64_read(&msk->rcv_wnd_sent);
>  
> -	pr_debug("msk=%p seq=%llx limit=%llx empty=%d\n", msk, seq, max_seq,
> +	pr_debug("msk=%p seq=%x limit=%llx empty=%d\n", msk, seq, max_seq,
>  		 RB_EMPTY_ROOT(&msk->out_of_order_queue));
>  	if (after64(end_seq, max_seq)) {
>  		/* out of window */

[Severity: High]
Now that the code after this point uses 32-bit comparisons, can a remote
peer get past this window check?

The commit message says "For OFO queue skbs, sequence numbers are
validated against rcv_wnd_sent in mptcp_data_queue_ofo()". That
validation is a single signed 64-bit comparison, and it wraps for DSNs
about 2^63 ahead of ack_seq.

The peer controls the DSN. With dsn64=1, get_mapping_status() uses it
unchanged:

net/mptcp/subflow.c:get_mapping_status() {
    ...
	map_seq = mptcp_expand_seq(READ_ONCE(msk->ack_seq), mpext->data_seq, mpext->dsn64);
    ...
}

subflow_check_data_avail() only rejects before64(ack_seq, old_ack), so
there is no upper bound.

Let A = msk->ack_seq, W = rcv_wnd_sent - A, and c = the skb payload
length. Say the peer sends a mapping with DSN = A + 2^63 - k, where
1 <= k < c - W:

__mptcp_move_skb()
  after64(dsn, msk->ack_seq) is true
  -> mptcp_data_queue_ofo()
       (s64)(max_seq - end_seq) == (s64)(2^63 - (c - W - k)) > 0
       so the after64(end_seq, max_seq) drop is skipped
       seq = (u32)mptcp_dsn(skb) == (u32)A - k

2^63 is 0 mod 2^32, so in 32-bit space the skb now looks k bytes behind
ack_seq. __mptcp_ofo_queue() then promotes it:

	if (after((u32)mptcp_dsn(skb), ack_seq))            /* false */
		break;
	...
	if (unlikely(!after((u32)mptcp_end_dsn(skb), ack_seq)))  /* false */
	...
	seq_delta = (u32)mptcp_end_dsn(skb) - ack_seq;      /* c - k */

The skb is appended to sk_receive_queue. It can't coalesce because the
map_seq64 values differ. Both ack_seq and bytes_received advance by c - k.

__mptcp_recvmsg_mskq() then does this, and mptcp_recv_skb() does the same:

	if (unlikely(before64(*seq, MPTCP_SKB_CB(skb)->map_seq64))) {
		*seq = mptcp_end_dsn(skb);
		msk->bytes_consumed += skb->len;

copied_seq jumps to about A + 2^63, and bytes_consumed grows by c, which
is k more than was received.

The next legitimate skb, at DSN A + c - k, then gives
copied_seq - map_seq64 == 2^63. That skb is also skipped and its data is
silently dropped.

After that, bytes_consumed stays k above bytes_received, so
mptcp_data_avail() underflows:

	return READ_ONCE(msk->bytes_received) - READ_ONCE(msk->bytes_consumed);

Wouldn't that cause the following?

- mptcp_epollin_ready() and mptcp_check_readable() report EPOLLIN while
  the receive queue is empty, so poll users busy-loop.
- mptcp_inq_hint() returns INT_MAX for SIOCINQ and TCP_CM_INQ, and the
  bad value also feeds receive-buffer autotuning.
- mptcp_close() takes the fastclose path.

The 32-bit overlap checks later in mptcp_data_queue_ofo(), including the
merge_right loop, can also drop legitimate in-window OFO segments as
DUPDATA.

Before this patch, the after64(mptcp_dsn(skb), msk->ack_seq) test in
__mptcp_ofo_queue() kept such an skb in the OFO tree, so it never reached
the receive queue.

The next patch in the series ("mptcp: defer read_sock cleanup to
mptcp_worker") doesn't touch this code, so the problem seems to remain at
the end of the series.

Could the DSN be bounded in full 64-bit terms before the 32-bit
arithmetic is relied on? For example, the skb could be rejected when the
unsigned distance end_seq - ack_seq is larger than max_seq - ack_seq.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1795063943.git.tanggeliang%40kylinos.cn
