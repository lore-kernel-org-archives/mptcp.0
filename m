Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793392974;
	b=KLQd0tb54RTwnDQBAJMquiTE15FiGtBPieLu+ImXmojRdOL5QGMr8uI+eoM8n+BzxwO9
	 dsDQ7TThfT4JM5m3UcKLSU//L+WT6uqvTXIYyt0/YnPldGPjLmHrInviEG3cZPwzrzzWz
	 +b0D4FgEHtM8hdi4mMxJ27puI0JWE2EhLf9UkyMnkdr0KVb1KzB7/t+iLUmlfBo8qOtjA
	 eg3XzEVn/8XdLyMtsE/2CVQ0jvN+0vJ6VaWN+twQG61KXjTjD0FMfTx0qQYGavMKiEZg6
	 ERr50vZIptN0Y9GnrMOOOys7zyABCTyVDCLoT/nDIHU8IFaRnM/JE/7LBILo0yiBorw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793392974;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=5V0qi2SOQSfU1tvdiZ3e9dR3FJqjpaActUDXJaYtXts=;
	b=LCxEHjpj5CnJ+m2EriJqdpa0OSSJN/xoboIzHL4s2hyyJAqBrof7vPGZoIIX39tCxHOM
	 nYFO3ee9BnllpnD06exJ74nNoXTc9J9AxEYqYUG0PF11tXXN2Fyaeqtbeu3VIfJC0T1eB
	 p9G2B4+uQTof3gJE5KVtrG2iijrWNFkM6DP0gKyEIu6hy4rDAjrvon47B1HbCntgwikYL
	 bXU0p6/F1aXcDd7zqZp54lMVQqAg2yTUoIRtW/OuXzL8sIkouIpvoLluTR4y6aoQxZHH8
	 skLCnjiJikuMo43stRjh9lDPQ7I0AFFL8HiqifEHUQ0ofq0HTuG0vEzae9CMLo2B4Cw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mqx4n5wc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38165606A31A
	for <mptcp@lists.linux.dev>; Fri, 30 Oct 2026 20:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mqx4n5wc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ED981F000C1;
	Fri, 30 Oct 2026 20:42:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793392973;
	bh=5V0qi2SOQSfU1tvdiZ3e9dR3FJqjpaActUDXJaYtXts=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=mqx4n5wc3mRCrM4CndRW0n6b7B3dRlxUCjLDIuCoEFXUfj/xHnM/bu7pIJ/uNw7mk
	 gkFYBFGkaCb8mX4t+LXwUE3lQLretqxmulp5LidS37ueUAZOQbmFobELo3iW3M1vsy
	 QJ5CxpG542k4llUqdTSN83fNCti8kRGDbtr2pfvCdyRIueCyZp7GdiLBBcXWcPpuSm
	 wFB74e3aL15NLGZh9Ue73SjZuSBgKTKzaDYyXSq1sIxkxrofambCdmCTbqh92XBv9e
	 zvd5tfHxecX9JVb4TEz0rG5kfk7SYjBjTuk46jLXYtuflZp1r6dwzPBLyp3p47/gvf
	 N0KE4e3ja19aQ==
Subject: Re: [PATCH mptcp-next v16 2/4] mptcp: remove CB offset field
From: netdev-bot+sashiko@kernel.org
To: geliang@kernel.org
Cc: mptcp@lists.linux.dev, pabeni@redhat.com, kuba@kernel.org
Date: Fri, 30 Oct 2026 20:42:53 +0000
Message-ID: <179339297301.3132.12245418716971029135@kernel.org>
In-Reply-To: =?utf-8?q?=3Cf046ebeaec309bdefe1046f7df18ce40b2496efd=2E1793255?=
 =?utf-8?q?126=2Egit=2Etanggeliang=40kylinos=2Ecn=3E?=
References: =?utf-8?q?=3Cf046ebeaec309bdefe1046f7df18ce40b2496efd=2E17932551?=
 =?utf-8?q?26=2Egit=2Etanggeliang=40kylinos=2Ecn=3E?=
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

Thank you for your contribution! Sashiko AI review found 8 potential
issue(s) to consider.

Critical: 3 · High: 2 · Medium: 2 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Critical] On the passive (server) TFO path, subflow_set_remote_key()
  overwrites msk->copied_seq: it sets `msk->copied_seq = subflow->iasn;`…
- [Critical] subflow_set_remote_key() now calls
  skb_peek(&sk->sk_receive_queue) on the msk, writes…
- [Critical] mptcp: stream corruption from offset subtraction in
  mptcp_init_skb()
- [High] mptcp_inq_hint() still reports unread bytes as
  READ_ONCE(msk->ack_seq) - MPTCP_SKB_CB(head)->map_seq.
- [High] MSG_PEEK cannot see data beyond the head skb.
- [Medium] The commit message describes three mechanisms that are not in
  the code.
- [Medium] The new skip branch in __mptcp_recvmsg_mskq() (`if (offset >=
  skb->len) { *last = skb; continue; }`) leaves the skb linked and…
- [Low] The commit message says it fixes a user-visible bug: before the
  MPC ACK, the TFO skb's `map_seq = -skb->len` (32-bit negation zero-…

--

mptcp: remove CB offset field

This patch removes the per-skb offset field from the MPTCP skb control
block and tracks read progress in a new msk->copied_seq field, similar to
TCP. It also changes the TFO skb dummy mapping and rebases it on IASN
when the remote key is received.

> socket lock, delegating the synchronization with IASN to the msk release
> CB, when the socket is owned by the user-space at remote key reception
> time. Such synchronization preserves any partial progress (copy) made on
> the TFO packet.

[ ... ]

> Note that the explicit synchronization in __mptcp_move_skb() is needed to
> ensure that the TFO skb in the receive queue got its map_seq synched
> before the next skb lands into the receive queue when spooling the backlog
> at mptcp_release_cb() time, as the release CB synchronization will happen
> later.

[ ... ]

> MPC ACK.  This patch fixes that behaviour through both the -(u64)skb->len
> sign fix and the new ack_seq - copied_seq hint.

[Severity: Medium]
Do these paragraphs match the code?

The message says copied_seq "is always accessed under the msk socket
lock" and that the IASN sync is deferred to the release CB when user
space owns the socket. mptcp_release_cb() has no copied_seq or IASN
handling at all. subflow_set_remote_key() writes msk->copied_seq and the
head skb's map_seq/end_seq directly. It holds only the msk data spinlock
and never checks sock_owned_by_user().

The __mptcp_move_skb() hunk only removes the offset/map_seq trimming on
the partial packet path. No TFO map_seq sync is added there.

mptcp_inq_hint() is not changed by this patch and still computes:

	u64 hint_val = READ_ONCE(msk->ack_seq) - MPTCP_SKB_CB(skb)->map_seq;

The later patches in the series don't seem to add any of these pieces.
Could the commit message describe what the code actually does?

> diff --git a/net/mptcp/fastopen.c b/net/mptcp/fastopen.c
> index f717750906ffa..04b1038b5200d 100644
> --- a/net/mptcp/fastopen.c
> +++ b/net/mptcp/fastopen.c

[ ... ]

> @@ -44,20 +45,23 @@ void mptcp_fastopen_subflow_synack_set_params(struct mptcp_subflow_context *subf
>  	subflow->ssn_offset += skb->len;
>  	has_rxtstamp = TCP_SKB_CB(skb)->has_rxtstamp;
>  
> -	/* Only the sequence delta is relevant */
> -	MPTCP_SKB_CB(skb)->map_seq = -skb->len;
> +	/* The TFO segment data sits before the IASN; before receiving
> +	 * the remote key, IASN is assumed being 0.
> +	 */
> +	MPTCP_SKB_CB(skb)->map_seq = -(u64)skb->len;

[Severity: Low]
This isn't a bug, but this one-line change fixes a user-visible problem.
The old -skb->len was a 32-bit negation zero-extended into the u64
map_seq, so SIOCINQ and TCP_CM_INQ returned INT_MAX on TFO server
sockets before the MPC ACK.

The old line was added by commit 36b122baf6a8 ("mptcp: add
subflow_v(4,6)_send_synack()"). Should this fix be split out with a
Fixes: tag so stable trees pick it up? As it stands, it is mixed into a
refactor that prepares for the next patch.

>  	MPTCP_SKB_CB(skb)->end_seq = 0;
> -	MPTCP_SKB_CB(skb)->offset = 0;
>  	MPTCP_SKB_CB(skb)->has_rxtstamp = has_rxtstamp;
>  	MPTCP_SKB_CB(skb)->cant_coalesce = 1;
>  
>  	mptcp_data_lock(sk);
>  	DEBUG_NET_WARN_ON_ONCE(sock_owned_by_user_nocheck(sk));
>  
> +	msk = mptcp_sk(sk);
> +	msk->copied_seq = MPTCP_SKB_CB(skb)->map_seq;

[ ... ]

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 528a72da646cc..f89ed94b668d9 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c

[ ... ]

> @@ -2195,11 +2186,17 @@ static int __mptcp_recvmsg_mskq(struct sock *sk, struct msghdr *msg,
>  	int copied = 0;
>  
>  	skb_queue_walk_safe(&sk->sk_receive_queue, skb, tmp) {
> -		u32 delta, offset = MPTCP_SKB_CB(skb)->offset;
> +		u32 delta, offset = (u32)msk->copied_seq - MPTCP_SKB_CB(skb)->map_seq;
>  		u32 data_len = skb->len - offset;
>  		u32 count;
>  		int err;
>  
> +		/* Skip skbs that are entirely before copied_seq */
> +		if (offset >= skb->len) {
> +			*last = skb;
> +			continue;
> +		}

[Severity: High]
Can MSG_PEEK still see anything past the head skb?

MSG_PEEK never advances copied_seq. For the second and later skbs,
map_seq is ahead of copied_seq, so the u32 subtraction wraps:

    skb1: map_seq = M, len L1, k bytes read, copied_seq = M + k
    skb2: map_seq = M + L1
    offset = (u32)(M + k - (M + L1)) = 2^32 - (L1 - k) >= skb2->len

As a result, skb2 and every skb after it are skipped with *last = skb.
Before this patch, non-head skbs had a CB offset of 0, so a peek walked
the whole queue. The comment above the check also doesn't fit this case,
because these skbs start after copied_seq.

Now take MSG_PEEK | MSG_WAITALL, or SO_RCVLOWAT larger than the head
skb's unread data. On the next pass of mptcp_recvmsg(), the head skb is
counted as already peeked and every other skb is skipped. It then calls
sk_wait_data(sk, &timeo, last) with last pointing at the queue tail.

Would this block until timeout or a signal even though enough data is
queued? Newly arriving skbs would be skipped the same way.

[Severity: Medium]
This branch leaves the skb linked and charged to the msk receive memory.
mptcp_recv_skb() frees the skb on the same condition:

net/mptcp/protocol.c:mptcp_recv_skb() {
    ...
		offset = (u32)msk->copied_seq - MPTCP_SKB_CB(skb)->map_seq;
		if (offset < skb->len) {
			*off = offset;
			return skb;
		}
		mptcp_eat_recv_skb(sk, skb);
    ...
}

The offset is an unsigned difference, so neither path can tell "already
consumed" apart from "copied_seq is behind map_seq". Suppose copied_seq
and map_seq get out of step, for example through the
subflow_set_remote_key() race described below.

Would the recvmsg path then keep every later skb queued until close,
stalling the connection once rcvbuf fills? And would the read_sock/splice
path silently drop data that was never delivered?

[ ... ]

> @@ -2233,11 +2230,9 @@ static int __mptcp_recvmsg_mskq(struct sock *sk, struct msghdr *msg,
>  
>  		if (!(flags & MSG_PEEK)) {
>  			msk->bytes_consumed += count;
> -			if (count < data_len) {
> -				MPTCP_SKB_CB(skb)->offset += count;
> -				MPTCP_SKB_CB(skb)->map_seq += count;
> +			msk->copied_seq += count;
> +			if (count < data_len)
>  				break;
> -			}

[Severity: High]
Without the map_seq += count, is mptcp_inq_hint() still correct? It is
unchanged and still computes:

net/mptcp/protocol.c:mptcp_inq_hint() {
    ...
		u64 hint_val = READ_ONCE(msk->ack_seq) - MPTCP_SKB_CB(skb)->map_seq;
    ...
}

That formula only worked because partial reads here and in
__mptcp_read_sock() advanced the head skb's map_seq. It also relied on
__mptcp_move_skb() and __mptcp_ofo_queue() trimming map_seq for
overlapping data.

This patch removes all of those updates, and mptcp_init_skb() now sets
map_seq to mapped_dsn - offset. The head skb's map_seq therefore stays at
the skb start, and the hint is too large by copied_seq - head->map_seq.
For example, after reading 1 byte of a 64KB head skb, the hint still
reports 64KB.

This affects SIOCINQ/FIONREAD in mptcp_ioctl() and the TCP_CM_INQ cmsg
in mptcp_recvmsg(). It also affects mptcp_rcv_space_adjust(), which
does:

	copied -= mptcp_inq_hint(sk);

so rcvbuf autotuning would underestimate how much was consumed.

The mptcp_inq selftest in tools/testing/selftests/net/mptcp/mptcp_inq.c
reads one byte and then checks:

	assert((size_t)tcp_inq == (expect_len - 1));

Wouldn't this assert now fail? Should mptcp_inq_hint() be based on
msk->copied_seq instead of the head skb's map_seq?

[ ... ]

> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index 78e886b202585..5e553adb9397e 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -533,6 +533,19 @@ static void subflow_set_remote_key(struct mptcp_sock *msk,
>  	WRITE_ONCE(msk->ack_seq, subflow->iasn);
>  	WRITE_ONCE(msk->can_ack, true);
>  	atomic64_set(&msk->rcv_wnd_sent, subflow->iasn);
> +	msk->copied_seq = subflow->iasn;
> +
> +	if (subflow->is_mptfo) {
> +		struct sock *sk = (struct sock *)msk;
> +		struct sk_buff *skb;
> +
> +		skb = skb_peek(&sk->sk_receive_queue);

[Severity: Critical]
Is it safe to touch the msk receive queue and msk->copied_seq here
without checking whether user space owns the msk?

This runs in softirq when the MPC ACK arrives, holding only the msk data
spinlock:

tcp_v4_rcv()
  ...
    mptcp_incoming_options()
      check_fully_established()
        mptcp_data_lock(msk)
        __mptcp_subflow_fully_established()
          subflow_set_remote_key()
            skb_peek(&sk->sk_receive_queue)
            MPTCP_SKB_CB(skb)->map_seq = ...

Elsewhere, MPTCP only touches sk_receive_queue from BH when the msk is
not owned. For example, __mptcp_move_skbs_from_subflow() falls back to
the backlog when own_msk is false.

A reader in mptcp_recvmsg() or __mptcp_read_sock() owns the msk through
lock_sock(), which does not keep slock held. While it owns the msk, the
reader does msk->copied_seq += count and calls mptcp_eat_recv_skb().
That function unlinks the skb and hands it to skb_attempt_defer_free()
without the data lock.

Can the softirq peek the TFO skb just before the reader unlinks and frees
it, and then write into the freed skb's cb[]?

The reader's plain u64 read-modify-write of copied_seq also races with
the store here. One update can be lost, and on 32-bit the value can
tear. If the reader's stale value wins, copied_seq stays in the pre-IASN
space while map_seq is in the IASN space, and every later
(u32)copied_seq - map_seq offset is wrong. __mptcp_recvmsg_mskq() would
then skip those skbs forever, and mptcp_recv_skb() would eat them
without delivering them.

Before this patch, subflow_set_remote_key() did not touch the msk receive
queue or any state the reader owns.

> +		if (skb) {
> +			MPTCP_SKB_CB(skb)->map_seq = subflow->iasn - skb->len;
> +			MPTCP_SKB_CB(skb)->end_seq = subflow->iasn;
> +			msk->copied_seq -= skb->len;

[Severity: Critical]
Does this discard any partial read of the TFO skb?

mptcp_fastopen_subflow_synack_set_params() queues the TFO skb with
map_seq = copied_seq = -(u64)len and calls sk_data_ready(). The accepted
msk can be read before the MPC ACK arrives, since mptcp_recvmsg() only
rejects TCP_LISTEN.

If the application reads k < len bytes first, __mptcp_recvmsg_mskq()
sets copied_seq to -len + k and leaves the skb queued. When the MPC ACK
arrives:

check_fully_established()
  __mptcp_subflow_fully_established()
    subflow_set_remote_key()
      msk->copied_seq = iasn - len
      MPTCP_SKB_CB(skb)->map_seq = iasn - len

The next read computes offset 0, so bytes [0, k) would reach user space
a second time, and msk->bytes_consumed would count them twice. Before
this patch, the read progress lived in MPTCP_SKB_CB(skb)->offset, which
this path did not touch. The remote client decides when to send the MPC
ACK, so it can reliably open this window.

This also contradicts the commit message's claim that the sync
"preserves any partial progress (copy) made on the TFO packet". Should
this shift the existing value instead, i.e. msk->copied_seq += iasn,
with map_seq/end_seq shifted by the same amount?

[ ... ]

> @@ -426,9 +424,9 @@ static void mptcp_init_skb(struct sock *ssk, struct sk_buff *skb, int offset,
>  	 * mptcp_subflow_get_mapped_dsn() is based on the current tp->copied_seq
>  	 * value
>  	 */
> -	MPTCP_SKB_CB(skb)->map_seq = mptcp_subflow_get_mapped_dsn(subflow);
> -	MPTCP_SKB_CB(skb)->end_seq = MPTCP_SKB_CB(skb)->map_seq + copy_len;
> -	MPTCP_SKB_CB(skb)->offset = offset;
> +	MPTCP_SKB_CB(skb)->map_seq = mptcp_subflow_get_mapped_dsn(subflow) -
> +				     offset;
> +	MPTCP_SKB_CB(skb)->end_seq = MPTCP_SKB_CB(skb)->map_seq + skb->len;
>  	MPTCP_SKB_CB(skb)->has_rxtstamp = has_rxtstamp;
>  	MPTCP_SKB_CB(skb)->cant_coalesce = 0;
>  

[Severity: Critical]
Is it safe to assume the skb bytes before tp->copied_seq belong to the
DSS mapping that is active now?

With D = mptcp_subflow_get_mapped_dsn(subflow), mptcp_init_skb() now
claims the whole skb carries DSN [D - offset, D - offset + skb->len),
prefix included. That only holds if the prefix was covered by the same
mapping. mptcp_subflow_discard_data() can leave tp->copied_seq in the
middle of an skb, and get_mapping_status() accepts an skb that is only
partially covered by the current mapping, with the next mapping
starting inside the same skb. Once the old mapping's tail has been
discarded as duplicate data, the prefix holds bytes from a different
mapping. The skb is still placed as if they were DSN [D - offset, D).
Before this patch map_seq was D, and the CB offset kept the prefix out
of the msk sequence space entirely.

__mptcp_move_skb() then classifies the skb on the shifted map_seq. If
the new mapping is out of order but D - offset <= msk->ack_seq < D, the
skb takes the partial packet path and ack_seq jumps over the missing
[ack_seq, D) range. __mptcp_recvmsg_mskq() then hands the stale prefix
bytes to user space in place of that range. If D - offset is still
after ack_seq, the skb is queued out of order covering
[D - offset, D). mptcp_data_queue_ofo() then drops the genuine
segments for that range as DUPDATA, so the stale bytes are delivered
later instead.

Dropping the MPTCP_SKB_CB(from)->offset test in __mptcp_try_coalesce()
widens this. skb_try_coalesce() appends from starting at byte 0, so any
to skb ending at D - offset now absorbs the stale prefix as DSN
[D - offset, D). That applies to the receive queue, the out-of-order
queue and the backlog list. The old check was what kept an skb with
unconsumed leading bytes from being merged.

The peer controls both the DSS mappings and the segmentation, so this
looks remotely triggerable, and it corrupts the byte stream delivered
to the application. Should mptcp_init_skb() trim the prefix off the skb
so map_seq can stay at the mapped DSN? Or is there another way to keep
the prefix out of the msk sequence space?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1793255126.git.tanggeliang%40kylinos.cn
