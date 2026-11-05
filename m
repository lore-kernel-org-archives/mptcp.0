Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793839264;
	b=oYA448iQ0xJiPghslP9ebbFv+27VG9nVzpMAb9fz8NUHro02FOqVzaU8TxKgC6E88EQr
	 poMapM8pBAfq93ZbHfaqthU7S6+fvd2GpAC4dtg+HafVe4BVl4rnKv34C/VbmCHMvxl8T
	 jN6VFibhk4IDuv4eA1pw6sL9iD0A0ipc9ZJrkEPNt4HtguM2qXaGD4qit94rAADLDBoT8
	 BzijB7bgdH9wA7Q5mkSCI3XK4A7K1Jrknx8lNTaLw/DU7pcd66yOM15zytdwt9M5Mu8g3
	 9ifgb5gBM1262uz16gkwM1Dde44+Lih++evTlQNxTtORuk188/JBKqT/giNO0IfoPcQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793839264;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=zA6X+sVPu68P95yqe/TbIKnhqo4qC8rwWIc06mJlN1c=;
	b=FExMWx6yazZrhyi+R5dzwjANXAbHVFDak5ZqyKZHgaxOrCWjhDcuIWubjBUEKHgE+q3j
	 pXnePl4dklxFa+8nruwpM9bwOfWNcd2sQ8Q2JUnU8Bos2ywzdHSkWErTT/F+j3xMLAI84
	 8nOXaHmvttFX7zu2Zfp4F/yqVr8PDpRry+KTey0UkZr1XFbEPDqYFaIO+paL9BnZBw0X4
	 dagoWXlau6USG3X8sRsi3i2jjGb9WwwDkL7yblRw9PwQxdWoyY3amdSaBju6EaTisb7pj
	 fq96HhXh3zBm9K0y/zjzabMbo3XQVXLzZZZhjUwYF0FQ8TVgFKVhcMp9Pb3oxSsEnMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gLGqr3FM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D2E606A326
	for <mptcp@lists.linux.dev>; Thu,  5 Nov 2026 00:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gLGqr3FM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 253771F000C1;
	Thu,  5 Nov 2026 00:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793839263;
	bh=zA6X+sVPu68P95yqe/TbIKnhqo4qC8rwWIc06mJlN1c=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=gLGqr3FMRB1DNDvxAX5EBXTYpzNUllxh+9h6nvDjMa69yzqExjHyq/ExhAS367VB0
	 nhMA1EWzUbdqA3frsc124PgZ24eO2lZ1K2V4hkzTTI0TKBksZf46mamxtE94AI8KRW
	 vIEAfk1maHLpMzxQ1VGwqoHvPKudSnkf0g/3mFC66SWcJ9X8IqrngWRs4C2+QLg20D
	 HabMLKqw268vKr9xVcm+SbUHNoVWrAmjV+WYbkbczkTDul6Zi9yNw24ChDDSK28rz+
	 3Y9EZhdKHdTjF8TzGvSCtHwIYYokBeeN8sFd/j9najLvRFO9+hVgJ5FZG+8JxOCzmj
	 TV8/njD2vDfTA==
Subject: Re: [PATCH mptcp-next v20 4/6] mptcp: remove CB offset field
From: netdev-bot+sashiko@kernel.org
To: geliang@kernel.org
Cc: mptcp@lists.linux.dev, tanggeliang@kylinos.cn, pabeni@redhat.com,
 kuba@kernel.org
Date: Thu, 05 Nov 2026 00:41:02 +0000
Message-ID: <179383926266.488855.10835859936013043818@kernel.org>
In-Reply-To: <866f86ad2ea894fc21af7546ed0cf6f8b9d816de.1793695518.git.tanggeliang@kylinos.cn>
References: <866f86ad2ea894fc21af7546ed0cf6f8b9d816de.1793695518.git.tanggeliang@kylinos.cn>
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

Critical: 0 · High: 2 · Medium: 2 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] mptcp_inq_hint() (net/mptcp/protocol.c:2406-2425) was not
  updated and still returns `READ_ONCE(msk->ack_seq) -…
- [High] mptcp: stream corruption in mptcp_init_skb() on non-zero subflow
  offset
- [Medium] The commit message credits this patch with fixing the TFO
  "SIOCINQ and TCP_CM_INQ returned INT_MAX before the MPC ACK" behaviour…
- [Medium] subflow_check_data_avail() (net/mptcp/subflow.c:1505) changes
  the fallback dummy mapping anchor from `map_subflow_seq =…
- [Low] The new fallback else-branch in mptcp_propagate_state()
  (net/mptcp/subflow.c:562-569) does `WRITE_ONCE(msk->ack_seq, 0)` and a…

--

mptcp: remove CB offset field

This patch removes the offset field from struct mptcp_skb_cb. Read
progress is now tracked in a new msk->copied_seq field, as TCP does, and
readers compute the in-skb offset as copied_seq - map_seq. The patch also
shifts copied_seq on IASN resync and sets the fallback sequence space to 0
in mptcp_propagate_state().

> Prior to this patch, the TFO skb dummy mapping (map_seq = -(u32)skb->len,
> zero-extended to u64) caused mptcp_inq_hint() to compute a wrapped
> ack_seq - map_seq, so SIOCINQ and TCP_CM_INQ returned INT_MAX before the
> MPC ACK.  This patch fixes that behaviour through both the -(u64)skb->len
> sign fix and the new ack_seq - copied_seq hint.

[Severity: Medium]
Is this description accurate for this commit?

The -(u64)skb->len assignment in
mptcp_fastopen_subflow_synack_set_params() is only unchanged context in
the fastopen.c hunk of this diff. It appears to come from the parent
commit "mptcp: fix TFO map_seq sign extension in fastopen".

This patch doesn't touch mptcp_inq_hint() either, so there is no
ack_seq - copied_seq hint:

    u64 hint_val = READ_ONCE(msk->ack_seq) - MPTCP_SKB_CB(skb)->map_seq;

With the sign fix already applied, the hint before the MPC ACK is
ack_seq (0) - (-(u64)len) = len. Backporting only this commit for the
INT_MAX problem would not fix it.

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index f3b07b303f555..3bd7d38ce78c4 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c

[ ... ]

> @@ -2252,14 +2237,12 @@ static int __mptcp_recvmsg_mskq(struct sock *sk, struct msghdr *msg,
>  		}
>  
>  		copied += count;
> +		*seq += count;
>  
>  		if (!(flags & MSG_PEEK)) {
>  			msk->bytes_consumed += count;
> -			if (count < data_len) {
> -				MPTCP_SKB_CB(skb)->offset += count;
> -				MPTCP_SKB_CB(skb)->map_seq += count;
> +			if (count < data_len)
>  				break;
> -			}

[Severity: High]
Without the map_seq += count adjustment, does mptcp_inq_hint() still
return the right value after a partial read? It wasn't updated and still
computes:

net/mptcp/protocol.c:mptcp_inq_hint() {
    ...
	skb = skb_peek(&sk->sk_receive_queue);
	if (skb) {
		u64 hint_val = READ_ONCE(msk->ack_seq) - MPTCP_SKB_CB(skb)->map_seq;
    ...
}

That formula only worked because every partial consumer moved the head
skb's map_seq up to the first unread byte. This patch removes all of
those adjustments:

- here in __mptcp_recvmsg_mskq()
- in __mptcp_read_sock()
- in the partial packet path of __mptcp_move_skb()
- in the uncoalesced path of __mptcp_ofo_queue()

map_seq now always refers to byte 0 of the skb.

For example, say the head skb covers DSN [X, X+1000) and ack_seq is
X+1000. After recvmsg() reads 100 bytes, copied_seq is X+100, but the
hint still returns 1000 instead of 900.

A peer can also inflate the hint by sending data whose DSN overlaps data
already received, because __mptcp_move_skb() now queues skbs with
map_seq < ack_seq.

The inflated value reaches user space through ioctl(SIOCINQ) in
mptcp_ioctl() and through the TCP_CM_INQ cmsg in mptcp_recvmsg(). It also
feeds "copied -= mptcp_inq_hint(sk)" in mptcp_rcv_space_adjust(), which
skews rcvbuf autotuning.

The selftest tools/testing/selftests/net/mptcp/mptcp_inq.c checks this
case in process_one_client() after a 1 byte read:

	assert((size_t)tcp_inq == (expect_len - 1));

Would this assertion, and the later tcp_inq <= expect_len - tot check,
now fail?

The commit message says the patch simplifies mptcp_inq_hint() and adds
an ack_seq - copied_seq hint, but that change isn't anywhere in the
series. Later in the series, "mptcp: sync mptcp skb cb layout with tcp
one" makes map_seq a u32. From then on the u64 subtraction returns
INT_MAX whenever ack_seq >= 2^32. That is almost always the case, since
the IASN is derived from a hash.

Should mptcp_inq_hint() use READ_ONCE(msk->ack_seq) - msk->copied_seq
instead?

[ ... ]

> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index 8a3ba490b5772..71c3b148cf04a 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c

[ ... ]

> @@ -557,6 +559,13 @@ static void mptcp_propagate_state(struct sock *sk, struct sock *ssk,
>  		WRITE_ONCE(msk->snd_una, subflow->idsn + 1);
>  		WRITE_ONCE(msk->wnd_end, subflow->idsn + 1 + tcp_sk(ssk)->snd_wnd);
>  		subflow_set_remote_key(msk, subflow, mp_opt);
> +	} else {
> +		/* Fallback (no MPTCP options at SYN-ACK) */
> +		subflow->map_seq = 0;
> +		subflow->map_subflow_seq = tcp_sk(ssk)->copied_seq -
> +					   subflow->ssn_offset;
> +		WRITE_ONCE(msk->ack_seq, 0);
> +		msk->copied_seq = 0;
>  	}

[Severity: Low]
The commit message says:

  The writes are safe without sock_owned_by_user() deferral because
  mptcp_propagate_state() already holds mptcp_data_lock().

Does the data lock actually protect copied_seq? The same message says
copied_seq is "always accessed under the msk socket lock".

The socket owner reads and updates it without the spinlock:

- mptcp_recvmsg() seeds peek_seq from it
- __mptcp_recvmsg_mskq() does *seq += count
- __mptcp_read_sock() does msk->copied_seq += count

This branch is reached from subflow_finish_connect() in softirq context
with only the data lock held. Unlike the MPTCP_SYNC_STATE handling just
below it, there is no sock_owned_by_user() check.

On the only caller path today, ack_seq and copied_seq are both already 0.
They are zeroed at allocation and reset in mptcp_disconnect(), so these
stores look redundant rather than harmful.

Are these writes needed at all? If they are, should they use the same
deferral as the other owner-protected state?

[ ... ]

> @@ -1493,7 +1502,7 @@ static bool subflow_check_data_avail(struct sock *ssk)
>  	skb = skb_peek(&ssk->sk_receive_queue);
>  	subflow->map_valid = 1;
>  	subflow->map_data_len = skb->len;
> -	subflow->map_subflow_seq = tcp_sk(ssk)->copied_seq - subflow->ssn_offset;
> +	subflow->map_subflow_seq = TCP_SKB_CB(skb)->seq - subflow->ssn_offset;

[Severity: Medium]
The commit message doesn't mention this change, and there's no Fixes:
tag. Should it be described, or split into its own patch?

Commit 2834f8edd74d ("mptcp: cleanup fallback dummy mapping generation")
anchored subflow->map_seq at the DSN of skb->seq
(iasn + skb->seq - ssn_offset - 1). It left map_subflow_seq anchored at
copied_seq. As a result, in fallback mode
mptcp_subflow_get_mapped_dsn() returned DSN(skb->seq) where
DSN(copied_seq) was expected.

TCP can queue a partially overlapping segment with seq < rcv_nxt. The
head subflow skb can then start before copied_seq, giving offset > 0 in
__mptcp_move_skbs_from_subflow().

Before this patch, mptcp_init_skb() then gave the data at offset a DSN
that was offset bytes too low. __mptcp_move_skb() would then skip another
offset bytes, or drop the skb as old data. That leaves a hole in the msk
stream: later fallback data waits in the OFO queue and the connection
stalls.

The new mapped_dsn - offset formula in mptcp_init_skb() only works
because of this anchor change. So this hunk is both a prerequisite for
the patch and a fix that stable kernels carrying 2834f8edd74d would want.

Also, the new fallback branch in mptcp_propagate_state() above still sets
map_subflow_seq with the old copied_seq based formula. That only works
because subflow_check_data_avail() overwrites it before use.

[ ... ]

> @@ -424,10 +422,13 @@ static void mptcp_init_skb(struct sock *ssk, struct sk_buff *skb, int offset,
>  	/* the skb map_seq accounts for the skb offset:
>  	 * mptcp_subflow_get_mapped_dsn() is based on the current tp->copied_seq
>  	 * value
> +	 *
> +	 * This is correct even when offset > 0 and mapping is out-of-order,
> +	 * because consumed prefix bytes are part of the same logical DSN range.
>  	 */
> -	MPTCP_SKB_CB(skb)->map_seq = mptcp_subflow_get_mapped_dsn(subflow);
> -	MPTCP_SKB_CB(skb)->end_seq = MPTCP_SKB_CB(skb)->map_seq + copy_len;
> -	MPTCP_SKB_CB(skb)->offset = offset;
> +	MPTCP_SKB_CB(skb)->map_seq = mptcp_subflow_get_mapped_dsn(subflow) -
> +				     offset;
> +	MPTCP_SKB_CB(skb)->end_seq = MPTCP_SKB_CB(skb)->map_seq + skb->len;
>  	MPTCP_SKB_CB(skb)->has_rxtstamp = has_rxtstamp;
>  
>  	__skb_unlink(skb, &ssk->sk_receive_queue);

[Severity: High]
Does the claim in the new comment hold when the head skb straddles a
DSS mapping boundary at tp->copied_seq?

mptcp_init_skb() now gives the already consumed prefix
skb->data[0 .. offset - 1] the DSN range
[mapped_dsn - offset, mapped_dsn), and end_seq covers the whole
skb->len. That is only right when the mapping installed at
tp->copied_seq also covers the start of the skb, as in fallback.

With several subflows, consecutive mappings on one subflow are
contiguous in subflow sequence space but not in DSN space. The DSNs
in between may have been sent on another subflow.

There seem to be at least two ways to get offset > 0 with a new
mapping M2 starting at tp->copied_seq:

- get_mapping_status() keeps the MPTCP extension on an skb that is
  not fully covered by the current mapping ("will validate the next
  map after consuming the current one"). Suppose the tail of the old
  mapping M1 inside that skb was already acked at msk level.
  subflow_check_data_avail() then calls mptcp_subflow_discard_data().
  That advances tp->copied_seq by offset without eating the skb and
  clears map_valid. The next loop iteration installs M2 at
  tp->copied_seq, offset bytes into the skb.

- After M1 was fully consumed, tcp_data_queue() can queue a
  partially overlapping segment with seq < rcv_nxt. Its prefix
  overlaps the end of M1 and its remainder carries M2.

In both cases the prefix belongs to M1, not to
[mapped_dsn - offset, mapped_dsn).

Now suppose M2 is out of order at msk level: mapped_dsn > ack_seq
because [ack_seq, mapped_dsn) is still in flight on another subflow,
and mapped_dsn - offset <= ack_seq.

__mptcp_move_skb() then takes the in-sequence or partial packet path
and advances msk->ack_seq across the hole. __mptcp_recvmsg_mskq() and
mptcp_recv_skb() hand the stale M1 bytes to user space as if they
were those DSNs. When the real data for that range arrives on the
other subflow, it is dropped as MPTCP_MIB_DUPDATA. A peer can trigger
this silent stream corruption.

Before this patch the prefix never got a DSN. map_seq was mapped_dsn,
end_seq was map_seq + copy_len, and the in-skb offset was kept in the
cb.

Removing the offset check in __mptcp_try_coalesce() makes this worse.
When mapped_dsn - offset equals to->end_seq, skb_try_coalesce()
appends the whole from skb, prefix included. That can happen in
__mptcp_add_backlog(), __mptcp_move_skb(), mptcp_data_queue_ofo() and
__mptcp_ofo_queue().

In mptcp_data_queue_ofo() the falsified start DSN can also replace,
or merge with, legitimate out of order segments covering
[mapped_dsn - offset, mapped_dsn).

Should mptcp_init_skb() use mapped_dsn - offset only when the current
mapping covers TCP_SKB_CB(skb)->seq (fallback, or map_subflow_seq at
or before the skb start)? Otherwise it could trim the prefix before
the skb reaches the msk, for example with pskb_pull(). Or is there
something that rules out a mapping boundary inside the head skb that
I am missing?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1793695518.git.tanggeliang%40kylinos.cn
