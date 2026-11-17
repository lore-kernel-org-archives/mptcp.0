Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794955274;
	b=BvGQGPHVtxDRg5Lg3mz8LcsrvwT3Js8EXFe5PajgaHpJxi76niLNLFJiNASJNHzff9M/
	 QHrevDon+8+3zmar2ecVCyWJb0KXauos7Vv5HNhVaSvixAS1NTe73byAtu5qCP6VBeoyI
	 rlHzBHP7wysuOwCHZBbvoWtbgTI8kalsASetZLO+6m5CO8reQNJIkHOq/SX4N0buD6dCi
	 larGo0JjUIhBGRuY3gaT8CpwNvhKTtXlPoINb0qUYXD0ZwMauQMpQIzgecvO+VdSopkYf
	 mzuY7VwbsWrzkJbnsJpfl98jrZ/Mgm3F7NQn7yqpv6ZRKK2Ep6j6WqSI7g3BOHQ40Mg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794955274;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=DVYT6NSp+8PVbjH+SsWl89hYXDuVZKdhDgPwoyIq8zo=;
	b=Igx740CdOlbNEHPcX2PolYH392J+L6LuhZn/oOKTOb44Gle48xu7tXDrQcHlgrgha4mk
	 Cju3yqhO9J4BdbpyWdHk5C7hdI+DAzz8SQFkExX04jxZGYc2tEVKMile061z9RYfCYFgF
	 /HOPMjGFik12SRkofB8SzZ8okinxbAvygp/w78G8UvrY357DBauiTMBw3gRrtAwduKwGu
	 jmJdlFq35Qqg/2M1QVh+L6YkiItlz5PiYezhamjC24mn0pKvfdC3zp6a8E7DAYXS3rSO9
	 QeFZ75fpNVyWR1FlXIRnUKVcGe5YFRzQ0GrLwKaB4y1dk82479e7V3nyJd7sWsRQ5/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PUGaNFzj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C76606A31C
	for <mptcp@lists.linux.dev>; Tue, 17 Nov 2026 22:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PUGaNFzj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2729B1F000CC;
	Tue, 17 Nov 2026 22:41:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794955274;
	bh=DVYT6NSp+8PVbjH+SsWl89hYXDuVZKdhDgPwoyIq8zo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=PUGaNFzjtrogO5bT9BUGe5IWbdQoJVxIiUqCERWtpad9u6yOTSEPFgeak24GthOjf
	 Ms/sc6Zomx3AWn1HkK/Ccojr9VhRr33oVi1nzyhkI5WmWlBKMR/q3/mJ9/t9PgnXvE
	 8hUW8G9Tztc+V7p33FOxmTHldQtMXSNUeLIb5aT7JMTHm7M7iXw7MbsyF8vE8BBWAz
	 3/EuRcZBsJWxpr5iYxRWOG7OVUBTivfV1trl2LLDmwq8atQw2Gazap5H54J3SS5Ndh
	 hJgVu2kDwHTW84eVu5Du4Uwwi2at+Om6gZmFzGnXB/SJli6GkmG2aUUxMCC/yYkRrI
	 udpwsE7yzNDxw==
Subject: Re: [PATCH mptcp-next v28 09/11] mptcp: drop data after DATA_FIN
 before skb init
From: netdev-bot+sashiko@kernel.org
To: geliang@kernel.org
Cc: mptcp@lists.linux.dev, kuba@kernel.org
Date: Tue, 17 Nov 2026 22:41:13 +0000
Message-ID: <179495527373.3133.7304844081942280548@kernel.org>
In-Reply-To: <0b6321dafceaf638b198d43b6918ed87a58cf5f1.1794810809.git.tanggeliang@kylinos.cn>
References: <0b6321dafceaf638b198d43b6918ed87a58cf5f1.1794810809.git.tanggeliang@kylinos.cn>
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

Thank you for your contribution! Sashiko AI review found 7 potential
issue(s) to consider.

Critical: 1 · High: 2 · Medium: 3 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Critical] In __mptcp_move_skbs_from_subflow() (net/mptcp/protocol.c),
  the else branch now also runs when len > 0 && data_fin.
- [High] mptcp_seq_after_data_fin() goes into its fin_seq comparison
  whenever `sk->sk_shutdown & RCV_SHUTDOWN` is set.
- [High] The fix does not close the bug class its commit message claims
  to close: data at or after DATA_FIN still reaching the msk receive…
- [Medium] Bisectability / series ordering.
- [Medium] mptcp_seq_after_data_fin() returns true when the DSN range
  [seq, seq+len) only straddles fin_seq (`!before64(seq + len, fin_seq +…
- [Medium] The explicit `if (offset < skb->len)` guard was replaced by
  `len = skb->len - offset; ... if (len > 0 && !data_fin)` in…
- [Low] The patch adds smp_wmb() in mptcp_update_rcv_data_fin()
  (options.c:1180), and the commit message says the barriers order…

--

mptcp: drop data after DATA_FIN before skb init

This commit adds mptcp_seq_after_data_fin() and calls it from
__mptcp_move_skbs_from_subflow(). Subflow skbs whose DSN range overlaps or
follows the recorded DATA_FIN are now freed before mptcp_init_skb(). It also
adds an smp_wmb()/smp_rmb() pair around rcv_data_fin_seq and rcv_data_fin,
and limits the DSS corruption warning in the drop branch to len == 0.

> After the previous commit, data arriving at or after DATA_FIN must be
> explicitly dropped to prevent state corruption. Without this check, such
> data could cause offset wraparound in __mptcp_recvmsg_mskq(), leading to
> bytes_consumed exceeding bytes_received, mptcp_data_avail() wrapping to
> U64_MAX, SIOCINQ reporting unread data after EOF, and improper connection
> closure.

[Severity: Medium]
Doesn't this leave the previous commit ("mptcp: remove CB offset field")
in a state that breaks bisection?

In that commit, once DATA_FIN has been processed, msk->ack_seq is F + 1
while msk->copied_seq stays at F. __mptcp_move_skb() accepts an skb with
map_seq F + 1 as in sequence. Then __mptcp_recvmsg_mskq() does:

net/mptcp/protocol.c:__mptcp_recvmsg_mskq() {
    ...
		u64 offset = *seq - MPTCP_SKB_CB(skb)->map_seq;
    ...
		if (offset >= skb->len) {
			if (!(flags & MSG_PEEK))
				mptcp_eat_recv_skb(sk, skb);
    ...
}

The offset wraps, and the skb is eaten without bytes_consumed being
updated. A bisect or backport that lands only on the previous commit would
get the peer-triggerable accounting corruption described above.

Could this fix be folded into, or ordered before, the commit that
introduces the problem? Also, this commit does not seem to close the
problem completely; see the comments below about the race and the OFO
queue.

> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index 71579238a951c..425a7fe94e0c4 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -1177,6 +1177,7 @@ bool mptcp_update_rcv_data_fin(struct mptcp_sock *msk, u64 data_fin_seq, bool us
>  
>  	WRITE_ONCE(msk->rcv_data_fin_seq,
>  		   mptcp_expand_seq(READ_ONCE(msk->ack_seq), data_fin_seq, use_64bit));
> +	smp_wmb(); /* ensure rcv_data_fin_seq is visible before rcv_data_fin */
>  	WRITE_ONCE(msk->rcv_data_fin, 1);

[Severity: Low]
This barrier pairs with the new smp_rmb() in mptcp_seq_after_data_fin().
However, mptcp_pending_data_fin() is documented as "can be called with no
lock acquired", and it reads the same pair without a read barrier:

net/mptcp/protocol.c:mptcp_pending_data_fin() {
    ...
	if (READ_ONCE(msk->rcv_data_fin) &&
	    ...
		u64 rcv_data_fin_seq = READ_ONCE(msk->rcv_data_fin_seq);
    ...
}

Should it get a matching smp_rmb() as well?

In mptcp_seq_after_data_fin(), the condition can be true only because of
RCV_SHUTDOWN. In that case the smp_rmb() follows a plain read of
sk->sk_shutdown, and no writer issues a write barrier before setting
RCV_SHUTDOWN. The smp_mb__before_atomic() in mptcp_check_data_fin() comes
after the store. So the "ensure we see the updated rcv_data_fin_seq"
comment doesn't hold on that path.

KCSAN would also report the plain sk->sk_shutdown read, since the writers
use WRITE_ONCE().

>  
>  	return true;
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index ddc98497f0eb0..78ca580c6d9c5 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -811,6 +811,25 @@ static void __mptcp_add_backlog(struct sock *sk,
>  		msk->backlog_unaccounted += delta;
>  }
>  
> +static bool mptcp_seq_after_data_fin(struct mptcp_sock *msk,
> +				     struct sock *ssk, u32 len)
> +{
> +	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
> +	struct sock *sk = (struct sock *)msk;
> +
> +	if (READ_ONCE(msk->rcv_data_fin) || (sk->sk_shutdown & RCV_SHUTDOWN)) {

[Severity: High]
What value does rcv_data_fin_seq have when only RCV_SHUTDOWN is set?

Its only writer is mptcp_update_rcv_data_fin(), which runs only when a
DATA_FIN is received. On a fresh socket it is 0. mptcp_disconnect() clears
rcv_data_fin but leaves rcv_data_fin_seq stale.

RCV_SHUTDOWN can be set without any DATA_FIN:

  - a local shutdown(fd, SHUT_RD) through inet_shutdown(), since
    mptcp_shutdown() ignores RCV_SHUTDOWN
  - mptcp_do_fastclose() and __mptcp_close(), which set SHUTDOWN_MASK

With fin_seq == 0, !before64(seq, 0) is true for every DSN with bit 63
clear. That means on roughly half of all connections, every incoming skb
would be dropped after SHUT_RD.

msk->ack_seq then stops advancing, so the peer gets no DATA_ACK and keeps
retransmitting. Each drop also hits the copied_seq problem described
further below. Before this patch, data received after SHUT_RD was still
queued, as with TCP.

Is the RCV_SHUTDOWN arm intended here? The commit message doesn't mention
it.

[Severity: High]
Does this check fully stop data at or after DATA_FIN from reaching the msk
receive queue, as the commit message describes?

There seem to be two ways around it.

First, mptcp_check_data_fin() runs in process context with the msk owned,
but without the msk data lock:

net/mptcp/protocol.c:mptcp_check_data_fin() {
    ...
		WRITE_ONCE(msk->ack_seq, msk->ack_seq + 1);
		WRITE_ONCE(msk->rcv_data_fin, 0);

		WRITE_ONCE(sk->sk_shutdown, sk->sk_shutdown | RCV_SHUTDOWN);
    ...
}

At the same time, mptcp_data_ready() for another subflow can run in BH,
see that the socket is owned by the user, and call
__mptcp_move_skbs_from_subflow(msk, ssk, false).

Suppose that reader sees rcv_data_fin already cleared but RCV_SHUTDOWN not
yet set. Both checks are false, so an skb at fin_seq + 1 goes to
msk->backlog_list. __mptcp_move_skb() later accepts it as in sequence,
since dsn == ack_seq.

Second, an skb at DSN F + 1 that arrives before the DATA_FIN goes into the
msk OFO queue without this check. After mptcp_check_data_fin() sets
ack_seq = F + 1, the next __mptcp_ofo_queue() call (move_skbs_to_msk()
calls it unconditionally) does:

net/mptcp/protocol.c:__mptcp_ofo_queue() {
    ...
		if (after64(mptcp_dsn(skb), msk->ack_seq))
			break;
    ...
			__skb_queue_tail(&sk->sk_receive_queue, skb);
    ...
}

This moves the F + 1 skb into sk_receive_queue. __mptcp_recvmsg_mskq() then
computes offset = *seq - map_seq as a wrapped u64 and eats the skb without
updating bytes_consumed.

Could a peer still trigger the bytes_received/bytes_consumed corruption
this way, by sending data beyond its DATA_FIN out of order and then one
more segment?

> +		u64 seq = mptcp_subflow_get_mapped_dsn(subflow);
> +		u64 fin_seq;
> +
> +		smp_rmb(); /* ensure we see the updated rcv_data_fin_seq */
> +		fin_seq = READ_ONCE(msk->rcv_data_fin_seq);
> +		if (!before64(seq, fin_seq) ||
> +		    !before64(seq + len, fin_seq + 1))
> +			return true;

[Severity: Medium]
If [seq, seq + len) only straddles fin_seq, this returns true and
__mptcp_move_skbs_from_subflow() frees the whole skb. That includes the
valid bytes in [seq, fin_seq). Should the skb be trimmed at fin_seq
instead?

Within a single DATA_FIN mapping this can't happen, because
get_mapping_status() sets the fin seq to data_seq + data_len - 1.

It can happen when the DATA_FIN comes from a separate data-less DSS, or
from another subflow, and falls inside an existing mapping.

Unless the peer resends those bytes under a different mapping, msk->ack_seq
stays below rcv_data_fin_seq. This check in mptcp_pending_data_fin() then
never matches:

	if (READ_ONCE(msk->ack_seq) == rcv_data_fin_seq) {

so the receive side stalls instead of closing.

The drop also goes through sk_eat_skb() with no drop reason and no MPTCP
MIB counter, unlike other MPTCP receive drops such as MPTCP_MIB_DUPDATA.

> +	}
> +	return false;
> +}
> +
>  static bool __mptcp_move_skbs_from_subflow(struct mptcp_sock *msk,
>  					   struct sock *ssk, bool own_msk)
>  {
> @@ -826,7 +845,8 @@ static bool __mptcp_move_skbs_from_subflow(struct mptcp_sock *msk,
>  		u32 map_remaining, offset;
>  		u32 seq = tp->copied_seq;
>  		struct sk_buff *skb;
> -		bool fin;
> +		bool fin, data_fin;
> +		size_t len;
>  
>  		/* try to move as much data as available */
>  		map_remaining = subflow->map_data_len -
> @@ -850,9 +870,9 @@ static bool __mptcp_move_skbs_from_subflow(struct mptcp_sock *msk,
>  		if (fin)
>  			seq++;
>  
> -		if (offset < skb->len) {
> -			size_t len = skb->len - offset;
> -
> +		len = skb->len - offset;
> +		data_fin = mptcp_seq_after_data_fin(msk, ssk, len);
> +		if (len > 0 && !data_fin) {
>  			mptcp_init_skb(ssk, skb, offset, len);

[Severity: Medium]
Is this equivalent to the removed offset < skb->len check?

skb->len and offset are both u32. When offset > skb->len, the subtraction
wraps to a large value and len > 0 is true.

That wrapped value then goes to mptcp_init_skb(), whose offset and
copy_len parameters are int. The result is a negative copy_len and an skb
with end_seq below map_seq, which is then handed to __mptcp_move_skb() or
the backlog.

mptcp_subflow_discard_data() still guards the same computation with
WARN_ON_ONCE(offset > skb->len). The copied_seq issue below produces
exactly offset > skb->len for later skbs.

If mptcp_seq_after_data_fin() returns false in that state, for example in
the rcv_data_fin/RCV_SHUTDOWN window, can these values reach
mptcp_init_skb()?

The else branch now only reports DSS corruption for len == 0, so this case
would no longer trigger fallback or reset either.

[ ... ]

> @@ -870,7 +890,7 @@ static bool __mptcp_move_skbs_from_subflow(struct mptcp_sock *msk,
>  		} else {
>  			sk_eat_skb(ssk, skb);
>  
> -			if (unlikely(!fin)) {
> +			if (len == 0 && unlikely(!fin)) {
>  				DEBUG_NET_WARN_ON_ONCE(1);
>  				mptcp_dss_corruption(msk, ssk);
>  			}

[Severity: Critical]
When data_fin is true and len > 0, this else branch now frees an skb that
still holds len unread bytes. seq += len only happens in the accept
branch, so the write-back after the if/else:

		WRITE_ONCE(tp->copied_seq, seq);

stores the old copied_seq, or old + 1 if the skb carries a TCP FIN. Doesn't
that leave tp->copied_seq behind TCP_SKB_CB(skb)->seq for every later skb
on this subflow?

mptcp_subflow_discard_data() handles the same situation by advancing
copied_seq by the discarded amount, plus the FIN byte, before calling
sk_eat_skb().

With copied_seq stuck, mptcp_subflow_get_map_offset() stops moving, and
copied_seq - skb->seq wraps for later skbs. One remote sequence that gets
there, with checksums off and two subflows:

  1. the peer sends a data-less DATA_FIN at F on subflow B, which
     mptcp_update_rcv_data_fin() records
  2. the peer sends seg1 of a mapping [S, S+100) with S < F < S+50 on
     subflow A; mptcp_seq_after_data_fin() returns true, seg1 is eaten,
     and copied_seq stays at seg1's seq
  3. the peer sends [S, F) on subflow B; ack_seq reaches F and
     mptcp_check_data_fin() sets ack_seq = F + 1
  4. the peer sends seg2 of the same mapping on subflow A

In step 4, subflow_check_data_avail() sees an identical mapping. The
mapped DSN S is below old_ack, so it calls mptcp_subflow_discard_data():

net/mptcp/subflow.c:mptcp_subflow_discard_data() {
    ...
	offset = tp->copied_seq - TCP_SKB_CB(skb)->seq;
	if (WARN_ON_ONCE(offset > skb->len))
		goto out;
    ...
out:
	if (!before(tcp_sk(ssk)->copied_seq, TCP_SKB_CB(skb)->end_seq))
		sk_eat_skb(ssk, skb);
	if (mptcp_subflow_get_map_offset(subflow) >= subflow->map_data_len)
		subflow->map_valid = 0;
}

Here the offset wraps, nothing is eaten, copied_seq does not move, and
map_valid stays set. subflow_check_data_avail() then continues its for (;;)
loop.

Can that loop spin forever in softirq with the ssk lock held?

The same desync has other effects:

  - a new mapping can see a wrapped skb_consumed in skb_is_fully_mapped()
    and get MAPPING_INVALID, which leads to fallback or a subflow reset
  - tcp_prune_queue()->tcp_collapse() is called with tp->copied_seq as
    start, which could reach BUG_ON(offset < 0) in tcp_collapse()
  - rcv_nxt - copied_seq stays non-zero for good

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1794810809.git.tanggeliang%40kylinos.cn
