Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794006430;
	b=qfXkjWQZ1rDZAAy1HuuR56t+h9kzuLcN0MW9b1WAWilPeEQ3IRYUm2m4vlUC5FVYhjsy
	 bKozjtTnfejPmd2xwfcKNnlVVNezpwL3FA/SDXXD3hsH+6MD4xxyiqMMjGu++qSMtdgIQ
	 WuQHoK+Ek0ziSiOHPc5msgpxCjYiXBOxR/K1FZ/nhdQprxcu3UHGcYhWm7E9iniarJ/l0
	 O+LhkbIi4qffEU/yNlGkcBzvB6U8sSi6grL/gyJCg4gNi82k6KYPMB6CA6Vwih5qRZtDs
	 hwjGUWOQ09jB3ATRkXFgJlCk270oiVGH0jVN54O3/qgBjFXeKUG1emLPVh4KWGH73+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794006430;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=YNtraGlb4E4P1TdiGJHsf0RRWoDvY6MC3n2dB8TFvLw=;
	b=fF2KMKVx+FF07fJ7320CUY5tKmZDELK/Gxh6Lk4ysqQVunphPk7fw/IMTWI+sM5dtpak
	 o7DgOI8kBUK74pFu0agziEwrvHtSLCk2Y/HjpFPo0P6BTX6Gec1ZphFUaGB6KEdNDYyh3
	 YeuVz6WaHK1s5DYAR51kheLMXKp5MOMPr0rWXv64hvV4vb/REHtrJmP1OGh5fmfCm3GVk
	 kqXhsz1qqEI/h1jcb/ghd7+qasrD5vJN4O42g/KN7mz0GrDsYMcX2F/IpexAG5Cs6ejEa
	 ZQWBeGy63HzNXeevuDntNpcGNdIpCUruzHVmMTK+0AzargFeAJ+2SSn5lPm0a78YmGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="KUIlK/RR";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B175A606A326
	for <mptcp@lists.linux.dev>; Fri,  6 Nov 2026 23:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KUIlK/RR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F01D61F0089F;
	Fri,  6 Nov 2026 23:07:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794006429;
	bh=YNtraGlb4E4P1TdiGJHsf0RRWoDvY6MC3n2dB8TFvLw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=KUIlK/RRPZK4K10ShOoTHwMLqMGpsjFqUBdAEnT5iVEsNvKqtQwXCu2ZO29r+UnmG
	 EKLffV3dJhPJ9vSULixM3wBijDdRROeqgsm2+13oqaNPUO5gBdypB4K/Bgiqa420cv
	 C5dLzXO37bGGhYsJfiiJg4t/ii90gGiF16HY1o14Xa2MKtOM6C5SRaJzD/FjsOCghm
	 TQxkXlJuP1uLmks3jFWT9dPDigEP5l2ooI05VMZBZAypkz+TJjkDInJ6hsdBjt7XZw
	 hqfBCCJpCfMbNBZpVCxsydCMWQ72pn5h7BTqgflY4fZ5sZbeifhEjNd4pxJU7Vw1rg
	 oJTErlUor8I2w==
Subject: Re: [PATCH mptcp-next v21 7/9] mptcp: remove CB offset field
From: netdev-bot+sashiko@kernel.org
To: geliang@kernel.org
Cc: mptcp@lists.linux.dev, tanggeliang@kylinos.cn, pabeni@redhat.com,
 kuba@kernel.org
Date: Fri, 06 Nov 2026 23:07:08 +0000
Message-ID: <179400642850.488855.16129919879232060741@kernel.org>
In-Reply-To: <c458572345b51e9de3dd7731c9ee6437a230a146.1793870710.git.tanggeliang@kylinos.cn>
References: <c458572345b51e9de3dd7731c9ee6437a230a146.1793870710.git.tanggeliang@kylinos.cn>
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

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 1 · High: 0 · Medium: 2 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Critical] A remote peer can crash the receiver: mptcp_init_skb()
  (net/mptcp/protocol.c) calls skb_pull() on a possibly non-linear…
- [Medium] The new boundary check in mptcp_init_skb() compares subflow-
  relative 32-bit sequence numbers with a plain unsigned '<', which is…
- [Medium] The commit message describes a change this commit does not
  make.

--

mptcp: remove CB offset field

This patch drops the per-skb offset field from the MPTCP skb control
block. It tracks consumed receive bytes with a new msk->copied_seq field,
the way TCP does. mptcp_init_skb() now computes map_seq as the mapped DSN
minus the offset, and uses skb_pull() to remove prefix bytes when an skb
spans multiple DSS mappings.

> mptcp_inq_hint() now uses mptcp_data_avail() which computes
> bytes_received - bytes_consumed, avoiding the previous ack_seq - map_seq
> computation that could overflow when map_seq was a dummy negative value.
>
> Overall this simplifies a bit the __mptcp_recvmsg_mskq(), mptcp_inq_hint()
> and the __mptcp_move_skb() code and will also make possible the next
> patch.

[Severity: Medium]
Is this paragraph still accurate? The diff doesn't touch mptcp_inq_hint().
At the parent commit ("mptcp: drop the cant_coalesce CB field") it already
reads:

static unsigned int mptcp_inq_hint(const struct sock *sk)
{
	const struct mptcp_sock *msk = mptcp_sk(sk);
	u64 hint_val = mptcp_data_avail(msk);

That change came from the earlier "mptcp: fix TFO SIOCINQ overflow in
mptcp_inq_hint" patch in this series, which has its own Fixes: tag. This
text looks left over from before that fix was split out.

The message also leaves out the real dependency. This patch no longer
advances the head skb's map_seq past consumed bytes, so the old
ack_seq - map_seq hint would over-report. That means this patch depends
on the earlier fix.

Could the commit message drop the mptcp_inq_hint() claims and mention
the dependency instead?

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index dd612e9b2b262..0666bbfdf2cb8 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c

[ ... ]

> @@ -415,19 +414,34 @@ static void mptcp_data_queue_ofo(struct mptcp_sock *msk, struct sk_buff *skb)
>  	skb_set_owner_r(skb, sk);
>  }
>  
> -static void mptcp_init_skb(struct sock *ssk, struct sk_buff *skb, int offset,
> -			   int copy_len)
> +static void mptcp_init_skb(struct sock *ssk, struct sk_buff *skb, int offset)
>  {
>  	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
>  	bool has_rxtstamp = TCP_SKB_CB(skb)->has_rxtstamp;
>  
> +	/* Detect mapping boundary: skb spans multiple mappings */
> +	if (unlikely(offset > 0 &&
> +		     TCP_SKB_CB(skb)->seq - subflow->ssn_offset <
> +		     subflow->map_subflow_seq)) {

[Severity: Medium]
Should this comparison use before()? Relative subflow sequence numbers
wrap after 4 GiB on one subflow. validate_mapping() compares the same
fields in a wrap-safe way:

	if (unlikely(before(ssn, subflow->map_subflow_seq))) {

With a plain u32 '<', this check can go wrong in two ways near the wrap
point.

In the first case, the skb starts before the wrap (relative seq
0xFFFFFFF0) and the new mapping starts after it (map_subflow_seq 0x10).
The test is false, so the prefix is kept. map_seq then becomes
mptcp_subflow_get_mapped_dsn() - offset, which gives the old-mapping bytes
DSNs from the current mapping.

If that range is above msk->ack_seq, mptcp_data_queue_ofo() can accept
those bytes for a DSN range that isn't filled yet. They can then reach
userspace in place of the real data.

In the second case, the mapping starts before the wrap and the skb starts
inside it after the wrap. A partially overlapping retransmit from an
honest peer (offset > 0) then wrongly takes the skb_pull() path below.

The condition is the same at the end of the series.

> +		pr_debug("spans mappings seq=%u map_subflow_seq=%u offset=%d ssn_offset=%u\n",
> +			 TCP_SKB_CB(skb)->seq, subflow->map_subflow_seq,
> +			 offset, subflow->ssn_offset);
> +
> +		/* prefix bytes belong to old mapping, remove them and start
> +		 * from current mapping
> +		 */
> +		WARN_ON_ONCE(offset >= skb->len);
> +		skb_pull(skb, offset);

[Severity: Critical]
Can this skb_pull() hit the BUG() in __skb_pull() when the subflow skb is
non-linear?

__mptcp_move_skbs_from_subflow() computes offset as
tp->copied_seq - TCP_SKB_CB(skb)->seq. That is a count of payload bytes
and has no relation to skb_headlen(). skb_pull() only checks
len > skb->len, and then:

include/linux/skbuff.h:__skb_pull() {
	...
	skb->len -= len;
	if (unlikely(skb->len < skb->data_len)) {
	...
		BUG();
	}
	...
}

TCP rx skbs usually carry their payload in page frags. This is true for
loopback, veth, GRO frags, header-split and page-pool drivers, virtio_net
mergeable buffers, and skbs merged by tcp_try_coalesce(). After the TCP
header pull, the linear part holds few or no payload bytes.

The WARN_ON_ONCE() above never fires, because the caller already ensures
offset < skb->len.

It looks like a remote peer could trigger this on an established
connection. The peer sends a segment with seq = rcv_nxt - N and length
N + M, carrying a DSS mapping with subflow_seq = rel(rcv_nxt) and
data_len = M:

tcp_data_queue()
  queues the partial packet untrimmed
get_mapping_status()->validate_mapping()
  accepts the mapping, since ssn == map_subflow_seq
subflow_data_ready()->mptcp_data_ready()->...
  __mptcp_move_skbs_from_subflow()
    mptcp_init_skb(ssk, skb, N)
      skb_pull(skb, N)  <- BUG() in softirq for a paged skb

There is a second way in. mptcp_subflow_discard_data() can leave
copied_seq in the middle of an skb at the end of a duplicate mapping.
The next mapping then starts inside that skb with offset > 0.

The old code never changed the skb boundaries; it kept the prefix in
MPTCP_SKB_CB(skb)->offset. So this regression appears to be new with this
patch. The same code is still there at the end of the series, after
"mptcp: sync mptcp skb cb layout with tcp one".

Switching to pskb_pull() alone may not be enough, since it can fail on
allocation in BH and would need an error path. Would a paged-safe head
trim work here? Another option is to track the prefix without changing
the skb.

> +		offset = 0;
> +	}
> +

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1793870710.git.tanggeliang%40kylinos.cn
