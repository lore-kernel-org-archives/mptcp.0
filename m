Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794800669;
	b=i5FFPMrKBYP7MRUODOP4HksXM1lBqzFGQkdOUf6uNcBdH98i47DC0oGPPzRrby4Ka9fr
	 tHZB+f+0JLuVqqGJBlpFChZdwXd8u7ckHYsVt7gkLu9Xkn6QehwZfHsZVy2rlgvyCcX3X
	 ZB7R6AKOQQhVClB+QFMT3kfDIJVRDvfefvY32BjlGoKbzAqX9NulNejg/wFmmuZmIP5j8
	 QDf0b/lP57UGqXTalyIuEoIqBimclYycg7l8y+tVc7ZWN5fbFpquAJu9ZGZKQPPMkh+lI
	 kpzVoMjd+D3/JudQotvpQOqqbdvCPrdLKf2WQx73rg4Ud1QCrOFcXy1MnJaCRwXVL4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794800669;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=YleWhWcQsi/kCkLrcTdvSovqeJpnkkP+JXNzSt7rzuY=;
	b=HhQsJl9UwH+kKy9ivH+RfB4ASFUM0Y4q2TZqXb2J5dm0go9IMFPTkPARyWJuJWlt8k5f
	 Jfq3+ARvHH52DbCzwMObmjjOJYpC7KzgIQNab7j/4Tsirxc3dBMo+Su6UP29+yl68MIgT
	 lM14kqed1NtjqF1AQQOq86NyGV4qYGauhj4neQBXzS9dogDIPqFLIMP6np192kaeZHzJ/
	 3hVCv86lLhWukioxpsMHShmScsXWgArya8L+uxu/mHuch6xyKmdmNnJ7lx/ugoqjwyNdb
	 VEAFaaB0W1iccI+lYhX03pXtQpTrDwll+c1ZR1LYSm8D/7s2Ips9xJ2SP+9WoLV+Haw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U1KFaxcd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E1E606A31C
	for <mptcp@lists.linux.dev>; Mon, 16 Nov 2026 03:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U1KFaxcd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C03951F000CE;
	Mon, 16 Nov 2026 03:44:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794800668;
	bh=YleWhWcQsi/kCkLrcTdvSovqeJpnkkP+JXNzSt7rzuY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=U1KFaxcdsvgdItjOFmuKeGao6+4oi6P+RqOTyVbzrNLHL1fZHwmotqfaC8EKj9RKP
	 c6TVDqLvqFEytBFykBiwX8CyPvnRQbTfMNzTtRCk8ZeCunHxanzLLsV/X7YtAtDi4X
	 SJ3zaZTKmHo6SOoTejDU8M7l+1eJHWl1/taxDNdN0baUKWBCfljICRCkT3G9jBdBQ6
	 Bho3GYwo7B4/1MOJ5BCdk7udSuvdrxOuJ5WtH4lmueWkPmWjqYD27ddXsGdfeoZMEb
	 5wGetGJDPV2KLTihWIn4logR48MBOnUTVXkvPGwwouk7nJO++3r3LpUKG1oLmCC8Jc
	 Ww2FuVte6R91w==
Subject:
 Re: [PATCH mptcp-next v27 7/8] mptcp: sync mptcp skb cb layout with tcp one
From: netdev-bot+sashiko@kernel.org
To: geliang@kernel.org
Cc: mptcp@lists.linux.dev, kuba@kernel.org
Date: Mon, 16 Nov 2026 03:44:28 +0000
Message-ID: <179480066832.3133.5753040360348134145@kernel.org>
In-Reply-To: <67a345724d8dfd927d8adb63fe851d096da4c8de.1794663678.git.tanggeliang@kylinos.cn>
References: <67a345724d8dfd927d8adb63fe851d096da4c8de.1794663678.git.tanggeliang@kylinos.cn>
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

Thank you for your contribution! Sashiko AI review found 5 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 2 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] mptcp: use of offset-shifted map_seq instead of mptcp_dsn() in
  OoO queue
- [Medium] This patch hides a receive-path bug fix inside what its
  message describes as a CB-layout change.
- [Medium] mptcp: copied_seq offset underflow in recv path for data after
  DATA_FIN
- [Low] The commit message does not say why the MPTCP CB must match
  tcp_skb_cb's layout, and it overstates one change.
- [Low] MPTCP_SKB_CB_F_OFFSET (0x0100, net/mptcp/protocol.h) is the same
  bit as TCPHDR_AE (BIT(8), include/net/tcp.h:1105).

--

mptcp: sync mptcp skb cb layout with tcp one

This commit shrinks the MPTCP skb CB map_seq and end_seq fields to u32. It
also adds a map_seq64 field with the full 64-bit DSN and moves flags so it
lines up with tcp_skb_cb's tcp_flags, with build-time offset checks in
mptcp_proto_init(). Most receive path sequence comparisons now use the
32-bit before()/after() helpers.

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index f4ab3bdd368f2..44f4a680a4bdb 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -167,14 +167,14 @@ static bool __mptcp_try_coalesce(struct sock *sk, struct sk_buff *to,
>  {
>  	int limit = READ_ONCE(sk->sk_rcvbuf);
>  
> -	if (MPTCP_SKB_CB(from)->map_seq != mptcp_end_dsn(to) ||
> +	if (MPTCP_SKB_CB(from)->map_seq64 != mptcp_end_dsn(to) ||
>  	    (MPTCP_SKB_CB(from)->flags | MPTCP_SKB_CB(to)->flags) &
>  	     MPTCP_SKB_CB_F_OFFSET ||

[Severity: Low]
The commit message says:

  "__mptcp_try_coalesce() gains a map_seq64 contiguity check to ensure
  skbs are truly adjacent in the 64-bit DSN space."

Is "gains" accurate here? The removed line shows that the parent commit
already compared a u64 map_seq against mptcp_end_dsn(to). This hunk only
renames the field to map_seq64.

The message also doesn't say why the MPTCP CB has to match the
tcp_skb_cb layout. Nothing in this patch, or in the rest of the series,
reads TCP_SKB_CB() on msk receive queue skbs.

The CHK_CB_FIELD() checks only cover offsets, not meaning. For skbs with
MPTCP_SKB_CB_F_OFFSET set, end_seq is not map_seq + skb->len, which is
different from TCP's end_seq.

Could the commit message describe the intended consumer of this layout
guarantee?

[ ... ]

> @@ -495,8 +498,8 @@ static bool __mptcp_move_skb(struct sock *sk, struct sk_buff *skb)
>  	}
>  
>  	/* Partial packet */
> -	if (after64(MPTCP_SKB_CB(skb)->end_seq, msk->ack_seq)) {
> -		copy_len = mptcp_end_dsn(skb) - msk->ack_seq;
> +	if (after64(mptcp_end_dsn(skb), msk->ack_seq)) {
> +		copy_len = (u32)mptcp_end_dsn(skb) - (u32)msk->ack_seq;
>  		goto insert;
>  	}

[Severity: Medium]
This hunk is more than a width change. It switches the partial packet test
from end_seq to mptcp_end_dsn(). That looks like a fix for a regression
added earlier in this series by "mptcp: remove CB offset field".

In that parent commit, mptcp_init_skb() does:

	MPTCP_SKB_CB(skb)->map_seq = mptcp_subflow_get_mapped_dsn(subflow) -
				     offset;
	MPTCP_SKB_CB(skb)->end_seq = MPTCP_SKB_CB(skb)->map_seq + copy_len;

Its caller, __mptcp_move_skbs_from_subflow(), passes copy_len as
skb->len - offset. So end_seq trails the real end DSN by offset, while
mptcp_end_dsn() returns map_seq + skb->len.

In the parent commit, take an skb with offset=1000, copy_len=100, dsn=5000
and msk->ack_seq=5050. Then end_seq is 4100 and mptcp_end_dsn() is 5100.
after64(4100, 5050) is false, so the skb falls through to "Completely old
data". It is counted as MPTCP_MIB_DUPDATA and dropped, even though
[5050, 5100) is new data.

The subflow has already advanced tp->copied_seq and TCP-acked those bytes.
Doesn't that stall the MPTCP stream until the peer reinjects at the MPTCP
level?

offset > 0 happens with a partially overlapping TCP retransmission. dsn
below ack_seq happens when the same range already arrived on another
subflow, so both are normal in lossy multipath setups.

The final tree after this patch is correct, but the intermediate commit is
not bisect safe. Should this hunk be folded into "mptcp: remove CB offset
field", or at least be called out in this commit message?

[ ... ]

> @@ -4885,11 +4887,23 @@ static int mptcp_napi_poll(struct napi_struct *napi, int budget)
>  	return work_done;
>  }
>  
> +#define CHK_CB_FIELD(mptcp_field, tcp_field)	\
> +	({					\
> +		BUILD_BUG_ON(offsetof(struct mptcp_skb_cb, mptcp_field) !=    \
> +			     offsetof(struct tcp_skb_cb, tcp_field));	      \
> +		BUILD_BUG_ON(offsetofend(struct mptcp_skb_cb, mptcp_field) != \
> +			     offsetofend(struct tcp_skb_cb, tcp_field));      \
> +	})
> +
>  void __init mptcp_proto_init(void)
>  {
>  	struct mptcp_delegated_action *delegated;
>  	int cpu;
>  
> +	CHK_CB_FIELD(map_seq, seq);
> +	CHK_CB_FIELD(end_seq, end_seq);
> +	CHK_CB_FIELD(flags, tcp_flags);

[Severity: Low]
This doesn't look like a bug today, but there is a bit clash in this alias.

net/mptcp/protocol.h has:

	#define MPTCP_SKB_CB_F_OFFSET	0x0100

include/net/tcp.h has:

	#define TCPHDR_AE	BIT(8)

TCPHDR_AE is part of both TCPHDR_FLAGS_MASK and TCPHDR_ACE.

CHK_CB_FIELD(flags, tcp_flags) makes mptcp_skb_cb.flags an intentional
alias of tcp_skb_cb.tcp_flags. mptcp_init_skb() sets MPTCP_SKB_CB_F_OFFSET
whenever offset is non-zero. Any code that later reads
TCP_SKB_CB(skb)->tcp_flags on an msk receive queue skb would then see the
AccECN AE bit set.

No current code reads tcp_flags on msk skbs. Would it make sense to move
MPTCP_SKB_CB_F_OFFSET to a bit outside TCPHDR_FLAGS_MASK, or to document
the overlap?

[ ... ]

> @@ -359,18 +360,18 @@ static void mptcp_data_queue_ofo(struct mptcp_sock *msk, struct sk_buff *skb)
>  	while (*p) {
>  		parent = *p;
>  		skb1 = rb_to_skb(parent);
> -		if (before64(seq, MPTCP_SKB_CB(skb1)->map_seq)) {
> +		if (before(seq, MPTCP_SKB_CB(skb1)->map_seq)) {
>  			p = &parent->rb_left;
>  			continue;
>  		}
> -		if (before64(seq, mptcp_end_dsn(skb1))) {
> -			if (!after64(end_seq, mptcp_end_dsn(skb1))) {
> +		if (before(seq, (u32)mptcp_end_dsn(skb1))) {
> +			if (!after((u32)end_seq, (u32)mptcp_end_dsn(skb1))) {
>  				/* All the bits are present. Drop. */
>  				mptcp_drop(sk, skb);
>  				MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_DUPDATA);
>  				return;
>  			}
> -			if (after64(seq, MPTCP_SKB_CB(skb1)->map_seq)) {
> +			if (after(seq, MPTCP_SKB_CB(skb1)->map_seq)) {
>  				/* partial overlap:
>  				 *     |     skb      |
>  				 *  |     skb1    |

[Severity: High]
mptcp_init_skb() sets map_seq64 to mptcp_subflow_get_mapped_dsn()
minus offset. So whenever MPTCP_SKB_CB_F_OFFSET is set,
MPTCP_SKB_CB(skb)->map_seq is (u32)mptcp_dsn(skb) - offset, not the
first DSN the skb actually carries. The offset prefix is not part of
this mapping. When the skb spans two DSS mappings, it can belong to an
earlier mapping that was already consumed on another subflow.

mptcp_data_queue_ofo() already uses (u32)mptcp_dsn(skb) for the
incoming seq and (u32)mptcp_end_dsn(skb1) for the right edge. The rbtree
walk, however, still compares seq against MPTCP_SKB_CB(skb1)->map_seq
for the left edge. Isn't that comparing two different things?

Take an skb1 in the OoO queue with offset=1000, dsn 6000 and end dsn
6100, so its map_seq is 5000. A new OoO skb carrying [5500, 5600) fails
the left branch test and passes before(seq, end dsn of skb1). Since 5600
is not after 6100, it is dropped as MPTCP_MIB_DUPDATA, but those bytes
are not in skb1.

If the new skb instead carries [5500, 6200), after(seq, map_seq) sends
it into the right subtree of skb1 even though its DSN is lower. Once
msk->ack_seq reaches 5500, __mptcp_ofo_queue() stops at skb1, because
after((u32)mptcp_dsn(skb1), ack_seq) is true. It never reaches the skb
holding 5500. The subflow has already TCP-acked that data, so doesn't
the msk receive side stall here?

mptcp_prune_ofo_queue() has the same problem when it compares
MPTCP_SKB_CB(in_skb)->map_seq with MPTCP_SKB_CB(skb)->map_seq. The stop
condition ends up shifted by the offset of either skb.

The removed lines already used map_seq here, so this probably comes
from "mptcp: remove CB offset field" earlier in the series. Since this
patch rewrites exactly these comparisons, should they use
(u32)mptcp_dsn() on both sides instead?

[ ... ]

> @@ -2212,7 +2214,7 @@ static int __mptcp_recvmsg_mskq(struct sock *sk, struct msghdr *msg,
>  	int copied = 0;
>  
>  	skb_queue_walk_safe(&sk->sk_receive_queue, skb, tmp) {
> -		u64 offset = *seq - MPTCP_SKB_CB(skb)->map_seq;
> +		u32 offset = (u32)(*seq) - MPTCP_SKB_CB(skb)->map_seq;
>  		u32 data_len = skb->len - offset;
>  		u32 count;
>  		int err;

[Severity: Medium]
The commit message justifies the 32-bit offset here by saying that
copied_seq always falls inside or at the edge of the head skb. Does
that still hold after a DATA_FIN?

mptcp_check_data_fin() advances msk->ack_seq by one for the DATA_FIN,
clears msk->rcv_data_fin and sets RCV_SHUTDOWN. It leaves
msk->copied_seq at rcv_data_fin_seq. Neither subflow_check_data_avail()
nor __mptcp_move_skb() rejects a mapping at or beyond the DATA_FIN DSN,
so a peer can send data at rcv_data_fin_seq + 1. That matches
dsn == msk->ack_seq in __mptcp_move_skb(), bumps bytes_received and
ack_seq, and puts the skb on sk_receive_queue with map_seq one past
copied_seq.

The offset here then becomes 0xffffffff, so mptcp_eat_recv_skb() frees
the skb without updating bytes_consumed or copied_seq.
mptcp_recv_skb() does the same. After that, mptcp_data_avail() never
goes back to zero. SIOCINQ reports unread data after EOF, and
__mptcp_close() aborts through mptcp_do_fastclose() instead of closing
cleanly.

It gets worse if that skb starts at rcv_data_fin_seq and
mptcp_init_skb() sees offset == 1 because the first byte was discarded.
Then map_seq equals (u32)copied_seq, and the offset here is 0 instead
of 1. The discarded byte is copied to userspace, and bytes_consumed
ends up one larger than bytes_received, so mptcp_data_avail() wraps to
U64_MAX.

Separately, while rcv_data_fin is set, an in-sequence skb that spans
past rcv_data_fin_seq moves ack_seq beyond it. The
ack_seq == rcv_data_fin_seq test in mptcp_pending_data_fin() then
never matches.

As far as I can tell the old u64 offset wrapped the same way, so part
of this may predate the series. Still, this patch now relies on the
invariant for its safety argument. Should __mptcp_move_skb() drop or
trim data mapped beyond the DATA_FIN DSN, or is there another place
where this is meant to be enforced?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1794663678.git.tanggeliang%40kylinos.cn
