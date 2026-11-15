Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794704606;
	b=RTjPm6Z3uHNygO98wuMPAzJIyMTIxTGdzrnyXrSYkaoWXVo7y4ICTmlgRLq056i7evOS
	 klw+rIvfu3s4kNwH7p32Lf7r0AzJ3x3pl7kIFF1Bn3B4Cv99sqUD9IFA29mEwJ0PcDr1d
	 BhrDlaOq6BZ4Z8hDxfUPoj50DaOLbGF4aGMmnIN0X0mtDD6TDaz0wdkMmhAr4c0IoCLPj
	 px0by5z5Ul1XxEORsrq9nFVktV8Bibh+UtNzYAVpeby3MOZzVsTyq6ssGmyKE/O6JkG4V
	 IAU5EkZ3FOR+3CHPfEOrgdJWwxDT6nKcb8GlTY2Fs6U8j9ngApZX7omWtowjsLjhwgQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794704606;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=IGH9q3ew/D/1azaMtcrF1WWl20thurrndhn0BPjPhxQ=;
	b=cemzh8LGJazQ0LnDcaN0y+VLDJgSigBAkj8uB33M/3IJlUeT7RpI3xYFA9uPKTMJhfkt
	 qZuB4YAEH31OIAd2MT1PXirgABFNau/X+gl4u2MzkeFtln5LWUckkip+2KFz7Emc5UCPA
	 2PICb4xcd6uabbEcjfvxIDR6QI/+mBxq2M3Z0l7MOVec7mJYNMAzAUBt5L4zNQE97EHS8
	 hAnAMKPVkN0t1bWKJyrOFMNFT0e6lnLEfU99PrwSaZYItkukK3Hk30/xN2pavKTN83sRs
	 UgXpw5iG+fJd4ANtf/2QIU3AO7BrPLbbb4jWR/3wbUotinQk2I206YK79CvcsE4G7AA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M9jyDdsv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF57606A329
	for <mptcp@lists.linux.dev>; Sun, 15 Nov 2026 01:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M9jyDdsv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AB701F000C6;
	Sun, 15 Nov 2026 01:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794704606;
	bh=IGH9q3ew/D/1azaMtcrF1WWl20thurrndhn0BPjPhxQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=M9jyDdsvfhkxbaKKzu8p/oJsQxG3YUYG14LdAlpMDEMCfnS/wjLmJUeS+tFPv8fYl
	 pZ0zCMKAMogGZ2/g/REbsLuEPLY7b+ySofBStzGec2NiySEke2LXR0nzYUFuDlQSxr
	 Wk2VYcQLKu0B+Pyz1Ujf9NfvvVXBuoSpHX6pvJj+g6+SCvrN5TSAeQ/gx+2qgLbilR
	 GPT1t7KflABzev1nv3br8TEwYeXEWLJJ/UigZvQbh6HWejnD8QqCyQMdHq4/IMKwjv
	 a/m7y+sC4PJlZxEjwxWyW0cb08Yf4GGLUQ9K18AsEQY3Tf4GWsfvsPaADwLuCzKozZ
	 KTlUVw3r3RI0w==
Subject: Re: [PATCH mptcp-next v26 6/8] mptcp: remove CB offset field
From: netdev-bot+sashiko@kernel.org
To: geliang@kernel.org
Cc: mptcp@lists.linux.dev, kuba@kernel.org
Date: Sun, 15 Nov 2026 01:03:25 +0000
Message-ID: <179470460556.488855.4597057443760971544@kernel.org>
In-Reply-To: <0bd74213de97c6d796b835f567e0f426bee89008.1794563432.git.tanggeliang@kylinos.cn>
References: <0bd74213de97c6d796b835f567e0f426bee89008.1794563432.git.tanggeliang@kylinos.cn>
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

Thank you for your contribution! Sashiko AI review found 7 potential
issue(s) to consider.

Critical: 0 · High: 5 · Medium: 2 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] Much of the commit message describes code that is not in the
  patch, and none of it shows up later in the series.
- [High] MPTCP_SKB_CB_F_OFFSET is supposed to keep the rewound,
  unvalidated prefix [map_seq, map_seq+offset) of an skb out of…
- [High] After this patch mptcp_skb_cb::end_seq means two different
  things.
- [High] The new DATA_FIN check at the top of __mptcp_move_skb() calls
  mptcp_drop() before mptcp_borrow_fwdmem().
- [High] The commit message says __mptcp_move_skb() now rejects data
  after DATA_FIN so that the read offset (copied_seq - map_seq) cannot…
- [Medium] __mptcp_recvmsg_mskq() now runs the `if (offset >= skb->len) {
  *last = skb; continue; }` skip for every read, not only MSG_PEEK (the…
- [Medium] The new drop check in __mptcp_move_skb() reads
  msk->rcv_data_fin and then msk->rcv_data_fin_seq with plain…

--

mptcp: remove CB offset field

This patch removes the per-skb offset field from the MPTCP skb control
block. The read position is now tracked by a new msk-level copied_seq
field, as TCP does. mptcp_init_skb() rewinds map_seq by the consumed
offset and marks such skbs with a new MPTCP_SKB_CB_F_OFFSET flag, and
__mptcp_move_skb() gains a check that drops data past DATA_FIN.

> In mptcp_init_skb(), map_seq is computed as mptcp_subflow_get_mapped_dsn()
> minus offset. A mapping boundary check using before() for proper 32-bit
> modular arithmetic detects when the skb spans multiple DSS mappings
> (offset > 0 and skb starts before the current mapping). In that case,
> the consumed prefix bytes belong to an old mapping and must be removed
> before setting map_seq. The function now returns bool to indicate success.
>
> When removing the prefix, we handle linear and paged data separately.

[ ... ]

> When mptcp_init_skb() fails, the caller increments seq to skip the
> problematic skb, records the failure via MPTCP_MIB_RCVPRUNED, and jumps
> to cleanup to ensure tp->copied_seq and more_data_avail are properly
> updated. This maintains TCP/MPTCP state consistency, and MPTCP-level
> retransmission will fill any resulting gaps.

[ ... ]

> merged into a validated buffer. mptcp_data_queue_ofo() skips the
> rb_replace_node() replacement when the new skb covers an existing OFO
> entry and carries the flag, so that previously validated data is not
> overwritten by an unvalidated prefix; the new skb is inserted after the
> existing entry instead, and the prefix is naturally skipped when the OFO
> queue is later processed.

[Severity: High]
Does this description match the code? I can't find most of it in this
patch, or later in the series (checked up to 86fa7a71827b):

mptcp_init_skb() in net/mptcp/protocol.c is still static void and does
not return bool.

There is no before() based check for an skb that spans more than one DSS
mapping.

The prefix is never removed. There is no skb_pull(), pskb_pull(),
skb_orphan(), truesize recompute or skb_set_owner_r() re-attach.

__mptcp_move_skbs_from_subflow() still calls
mptcp_init_skb(ssk, skb, offset, len) unconditionally. There is no
failure branch that skips the skb, bumps MPTCP_MIB_RCVPRUNED and jumps
to cleanup.

mptcp_data_queue_ofo() is unchanged around rb_replace_node(), so the
replacement still happens for MPTCP_SKB_CB_F_OFFSET skbs.

The message itself says that when an skb spans several mappings the
prefix "must be removed before setting map_seq". The code doesn't remove
it, so wouldn't those prefix bytes get DSNs extrapolated from the wrong
mapping through map_seq = mapped_dsn - offset?

The multi-mapping case looks reachable. mptcp_subflow_discard_data() can
consume the tail of the old mapping inside an skb and clear map_valid.
A new mapping is then read from the same skb's retained extension.

Should the code or the commit message be updated?

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 41fc2429d2fed..99dfcd0488a45 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -167,8 +167,9 @@ static bool __mptcp_try_coalesce(struct sock *sk, struct sk_buff *to,
>  {
>  	int limit = READ_ONCE(sk->sk_rcvbuf);
>  
> -	if (MPTCP_SKB_CB(from)->map_seq != MPTCP_SKB_CB(to)->end_seq ||
> -	    MPTCP_SKB_CB(from)->offset ||
> +	if (MPTCP_SKB_CB(from)->map_seq != MPTCP_SKB_CB(to)->map_seq +
> +					   to->len ||
> +	    MPTCP_SKB_CB(from)->flags & MPTCP_SKB_CB_F_OFFSET ||
>  	    ((to->len + from->len) > (limit >> 3)) ||
>  	    !skb_try_coalesce(to, from, fragstolen, delta))
>  		return false;

[Severity: High]
Only from is checked for MPTCP_SKB_CB_F_OFFSET here. What happens when to
carries the flag? After a successful merge, __mptcp_try_coalesce() does:

	MPTCP_SKB_CB(to)->end_seq = MPTCP_SKB_CB(from)->end_seq;

That overwrites the end_seq - map_seq encoding, which is the only record
of where the validated data in to starts. After the merge,
end_seq - map_seq equals to->len. __mptcp_move_skb() and
__mptcp_ofo_queue() then compute dsn = to->map_seq, the start of the
unvalidated prefix, instead of map_seq + offset.

A flagged to can be the backlog tail in __mptcp_add_backlog(),
msk->ooo_last_skb in mptcp_data_queue_ofo(), or skb1 in the rbtree walk.
Suppose ack_seq is at or below the merged dsn but still inside
[map_seq, map_seq + offset). Can the prefix bytes then be delivered to
user space as stream data?

Separately, the commit message says mptcp_data_queue_ofo() skips
rb_replace_node() for flagged skbs, but that branch is unchanged:

	rb_replace_node(&skb1->rbnode, &skb->rbnode,
			&msk->out_of_order_queue);
	mptcp_drop(sk, skb1);

Combined with the above, here is one path:

1. A TCP-level retransmission F overlaps a copy P that is already in the
   msk OFO queue, and F replaces P.
2. The next contiguous skb from the same subflow coalesces into F.
3. ack_seq reaches F's map_seq.

Would the unvalidated prefix of F then be delivered in place of P's
validated bytes? Before this patch, map_seq started at the validated DSN,
so the prefix could never be delivered.

This still appears to be present at the end of the series.

[ ... ]

> @@ -425,9 +429,10 @@ static void mptcp_init_skb(struct sock *ssk, struct sk_buff *skb, int offset,
>  	 * mptcp_subflow_get_mapped_dsn() is based on the current tp->copied_seq
>  	 * value
>  	 */
> -	MPTCP_SKB_CB(skb)->map_seq = mptcp_subflow_get_mapped_dsn(subflow);
> +	MPTCP_SKB_CB(skb)->map_seq = mptcp_subflow_get_mapped_dsn(subflow) -
> +				     offset;
>  	MPTCP_SKB_CB(skb)->end_seq = MPTCP_SKB_CB(skb)->map_seq + copy_len;
> -	MPTCP_SKB_CB(skb)->offset = offset;
> +	MPTCP_SKB_CB(skb)->flags = offset ? MPTCP_SKB_CB_F_OFFSET : 0;
>  	MPTCP_SKB_CB(skb)->has_rxtstamp = has_rxtstamp;
>  
>  	__skb_unlink(skb, &ssk->sk_receive_queue);
> @@ -450,17 +455,24 @@ void __mptcp_sync_rcv_sequence(struct sock *sk)

[ ... ]

>  static bool __mptcp_move_skb(struct sock *sk, struct sk_buff *skb)
>  {
>  	u64 copy_len = MPTCP_SKB_CB(skb)->end_seq - MPTCP_SKB_CB(skb)->map_seq;
> +	u64 dsn = MPTCP_SKB_CB(skb)->map_seq + skb->len - copy_len;
>  	struct mptcp_sock *msk = mptcp_sk(sk);
>  	struct sk_buff *tail;
>  
> +	if (READ_ONCE(msk->rcv_data_fin) &&
> +	    !before64(MPTCP_SKB_CB(skb)->map_seq,
> +		      READ_ONCE(msk->rcv_data_fin_seq))) {
> +		mptcp_drop(sk, skb);
> +		return false;
> +	}
> +
>  	mptcp_borrow_fwdmem(sk, skb);

[Severity: High]
Does this drop leak the lent forward memory? Both callers lend the skb
before calling __mptcp_move_skb(). __mptcp_move_skbs_from_subflow() does:

	mptcp_subflow_lend_fwdmem(subflow, skb);
	ret |= __mptcp_move_skb(sk, skb);

and __mptcp_add_backlog() does the same. Lending clears skb->destructor
and leaves skb->sk = ssk.

mptcp_borrow_fwdmem() is the only place that moves the truesize into the
msk forward allocation and subtracts it from ssk->sk_rmem_alloc.
mptcp_drop() is documented as expecting that step to be done already:

	/* The skb forward memory was already transferred to sk by
	 * mptcp_borrow_fwdmem(), even before setting the destructor.
	 */
	if (!skb->destructor)
		sk_mem_reclaim(sk);

On this path sk_mem_reclaim() has nothing to reclaim, and __kfree_skb()
runs no destructor. ssk->sk_rmem_alloc would grow by skb->truesize
permanently. The memory would also never be uncharged from the TCP
memory_allocated counter or from the memcg.

Each drop would shrink the subflow receive window through tcp_space().
When the subflow is freed, inet_sock_destruct() would hit
WARN_ON_ONCE(atomic_read(&sk->sk_rmem_alloc)).

A peer could trigger this for every packet. It sends DATA_FIN while a
DSN hole keeps rcv_data_fin set, then sends mappings with
map_seq >= rcv_data_fin_seq.

Should this check come after mptcp_borrow_fwdmem()? It is unchanged at the
end of the series.

[Severity: Medium]
Is the lockless read of rcv_data_fin and rcv_data_fin_seq ordered here?
The writer, mptcp_update_rcv_data_fin(), does:

	WRITE_ONCE(msk->rcv_data_fin_seq,
		   mptcp_expand_seq(READ_ONCE(msk->ack_seq), data_fin_seq, use_64bit));
	WRITE_ONCE(msk->rcv_data_fin, 1);

There is no release barrier. The writer is called from
get_mapping_status(), mptcp_incoming_options() and the subflow fallback
path, without the msk data lock or msk ownership. This reader holds
either the msk data lock or msk ownership, and neither excludes a writer
running on another subflow.

On weakly ordered CPUs such as arm64 or POWER, can this code see
rcv_data_fin == 1 together with an old rcv_data_fin_seq? The old value
would be 0 on a fresh msk. On a reused socket it would be stale, since
mptcp_disconnect() doesn't reset it. On 32-bit, the u64 accesses can also
tear.

With a stale 0, !before64(map_seq, 0) is true for any map_seq with the
top bit clear. A valid in-sequence skb would be dropped after
tp->copied_seq already moved past it. Recovery would need an MPTCP-level
retransmit, and the drop would also hit the forward memory leak above.

The older reader, mptcp_pending_data_fin(), only compares for equality
with ack_seq, so a stale value was harmless there.

[Severity: High]
Does this guard prevent the copied_seq - map_seq underflow described in
the commit message? It only runs while rcv_data_fin is set.
mptcp_check_data_fin() clears that flag once the DATA_FIN is processed:

	WRITE_ONCE(msk->ack_seq, msk->ack_seq + 1);
	WRITE_ONCE(msk->rcv_data_fin, 0);

Now suppose the peer sends a mapping at DSN fin_seq + 1.
subflow_check_data_avail() accepts it because D >= ack_seq.
mptcp_data_ready() and __mptcp_add_backlog() only reject TCP_CLOSE, not
CLOSE_WAIT. Since dsn == ack_seq, the skb is queued in sequence.

msk->copied_seq can never pass fin_seq. __mptcp_recvmsg_mskq() then
computes offset = copied_seq - (fin_seq + 1), which wraps to about
2^64 - 1, and the skb is skipped without being freed.

Each such skb would stay pinned in sk_receive_queue and sk_rmem_alloc
until close. Meanwhile mptcp_data_avail() reports data (poll is readable,
SIOCINQ > 0) but recvmsg returns 0. The read_sock path, through
mptcp_recv_skb(), eats the same skb instead.

Also, the check compares map_seq rather than dsn, so a flagged skb with
map_seq < fin_seq <= dsn passes it. This is unchanged at the end of the
series.

[ ... ]

> @@ -495,10 +507,6 @@ static bool __mptcp_move_skb(struct sock *sk, struct sk_buff *skb)
>  	/* Partial packet */
>  	if (after64(MPTCP_SKB_CB(skb)->end_seq, msk->ack_seq)) {
>  		copy_len = MPTCP_SKB_CB(skb)->end_seq - msk->ack_seq;
> -		MPTCP_SKB_CB(skb)->offset += msk->ack_seq -
> -					     MPTCP_SKB_CB(skb)->map_seq;
> -		MPTCP_SKB_CB(skb)->map_seq += msk->ack_seq -
> -					      MPTCP_SKB_CB(skb)->map_seq;
>  		goto insert;
>  	}

[Severity: High]
Is end_seq now read in two different ways?

mptcp_init_skb() sets map_seq = D - offset and end_seq = map_seq +
copy_len, where copy_len = skb->len - offset. That puts end_seq offset
bytes short of the real data end, E = map_seq + skb->len.

The dsn computation at the top of __mptcp_move_skb() and in
__mptcp_ofo_queue() reads end_seq - map_seq as a byte count, which
matches that. This partial packet branch still treats end_seq as the
absolute end. fastopen.c, __mptcp_sync_rcv_sequence() and
__mptcp_try_coalesce() also write end_seq as an absolute end.

Take a flagged skb with dsn D below ack_seq A. If A < E - offset, ack_seq
and bytes_received only advance to E - offset, while the whole skb up
to E is queued and readable.

Wouldn't ack_seq then lag the queued data by offset bytes? The next
in-order skb at E would be diverted to the OFO queue until an MPTCP-level
RTO retransmission.

bytes_received would also stay short while bytes_consumed counts every
byte read. mptcp_data_avail() could then underflow, mptcp_inq_hint()
would return INT_MAX, and mptcp_rcv_space_adjust() autotuning would be
affected.

If instead E - offset <= A < E, the valid new bytes [A, E) are dropped
as DUPDATA after tp->copied_seq has already moved past them.

Honest peers can hit this. A flagged skb, for example after
mptcp_subflow_discard_data() trims reinjected data or after a TCP
partial-overlap retransmission, is spooled from the backlog after
another subflow has already advanced ack_seq past its D.

In the later commit "mptcp: sync mptcp skb cb layout with tcp one", the
condition becomes after64(map_seq64 + len, ack_seq), but copy_len stays
u32 end_seq - (u32)ack_seq. For A in [E - offset, E), wouldn't copy_len
wrap to about 2^32 and push ack_seq and bytes_received about 4GB ahead?

[ ... ]

> @@ -2209,33 +2217,24 @@ static void mptcp_eat_recv_skb(struct sock *sk, struct sk_buff *skb)
>  }
>  
>  static int __mptcp_recvmsg_mskq(struct sock *sk, struct msghdr *msg,
> -				size_t len, int flags, int copied_total,
> +				size_t len, int flags, u64 *seq,
>  				struct scm_timestamping_internal *tss,
>  				int *cmsg_flags, struct sk_buff **last)
>  {
>  	struct mptcp_sock *msk = mptcp_sk(sk);
>  	struct sk_buff *skb, *tmp;
> -	int total_data_len = 0;
>  	int copied = 0;
>  
>  	skb_queue_walk_safe(&sk->sk_receive_queue, skb, tmp) {
> -		u32 delta, offset = MPTCP_SKB_CB(skb)->offset;
> +		u64 offset = *seq - MPTCP_SKB_CB(skb)->map_seq;
>  		u32 data_len = skb->len - offset;
>  		u32 count;
>  		int err;
>  
> -		if (flags & MSG_PEEK) {
> -			/* skip already peeked skbs */
> -			if (total_data_len + data_len <= copied_total) {
> -				total_data_len += data_len;
> -				*last = skb;
> -				continue;
> -			}
> -
> -			/* skip the already peeked data in the current skb */
> -			delta = copied_total - total_data_len;
> -			offset += delta;
> -			data_len -= delta;
> +		/* Skip the already peeked data. */
> +		if (offset >= skb->len) {
> +			*last = skb;
> +			continue;
>  		}

[Severity: Medium]
This skip now runs for normal reads as well as MSG_PEEK. In a non-peek
read, an skb with map_seq + len <= msk->copied_seq is skipped but never
passed to mptcp_eat_recv_skb(). Doesn't it then stay in
sk_receive_queue, with its truesize still charged to sk_rmem_alloc and
forward memory, until the socket is purged?

mptcp_recv_skb() on the read_sock path does eat such skbs:

	offset = msk->copied_seq - MPTCP_SKB_CB(skb)->map_seq;
	if (offset < skb->len) {
		*off = offset;
		return skb;
	}
	mptcp_eat_recv_skb(sk, skb);

so the two read paths disagree.

This state looks reachable. After the partial packet accounting issue in
__mptcp_move_skb() leaves ack_seq behind the queued data, the peer's
MPTCP retransmission of [E - offset, E) arrives in sequence. It is not
coalesced, because map_seq != tail->map_seq + tail->len, and it lies
entirely below copied_seq, so every recvmsg skips it.

Data after a processed DATA_FIN, described above, also ends up here.
This is still present at the end of the series.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1794563432.git.tanggeliang%40kylinos.cn
