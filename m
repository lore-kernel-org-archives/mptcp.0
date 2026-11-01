Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793498529;
	b=f9zIm9ftJRbdDtDXbnA4WCSVlrr1uVA+TvHd+MykVdqmPEY0Pa1sRnwo2TxtM6kv6/r1
	 DjqzZ3DQeO38RZrI5IKTKOv9X7gJ+ufL1EWQRcbmG9vTYZmBqpNvdOGmR8QvY6NYjAQpP
	 6KD5LJsj1E/Ib+gx0JNbqLXMepeRJNWGoXv8PQC7zokyaLvW9kTlaFE9k2V5GpM7ojYf+
	 hnqyIHrTyJOc3DEW8GoP9nXGZ0Nvsk31aQl8KkNdTyDpDzUWkviLftQ53HZA4OY3gB1d5
	 n8BVnVsOqpWjTOqWWBEkiqlOWoSmDHPprf8iqoZva6dq+mldVse1eWCkegmA8/N/UEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793498529;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=zjacEOMf9TSaQuQ55qRfW1YjfrNc+D4rESqWhqIrPu4=;
	b=JSh+GNy1u3KaNwKll7lGyXWsbT+s5HIORKlhh8KDguuVzjmWaNlf6wMw9TAc8tmkIbby
	 0TDDDnIA3LZ7bq/nyQ0ST6EIZ3MM6ryPIoTzoHXhzzTg76ItPP7HSWtbFtSZLccn5wjul
	 PdtdJpV1w1SJVVlzWFhdCobj1iwLcKqnZu9AaVQ9CP1PAq4mnSMpoenfBjankTVN93hgJ
	 pI9E/LfXHMMTii1owINFhgEJrUZt5eSFzVRn4BsC75VvIGhYEJUkaTAlw2U57u2wo9vn9
	 bjcxu3/t6KApktseSnMHsCizUpVPnXjYh3d5kXQNf9aHeJIrhWUDmGwLCVXzed0BENw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j2TpcWNV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F042C606A324
	for <mptcp@lists.linux.dev>; Sun,  1 Nov 2026 02:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j2TpcWNV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 633E91F000C1;
	Sun,  1 Nov 2026 02:02:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793498528;
	bh=zjacEOMf9TSaQuQ55qRfW1YjfrNc+D4rESqWhqIrPu4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=j2TpcWNVHs5H80G0mVIyrX5YEZcEIuKtKcAXqx6790bxL9GEAJtY8UKtE9ByQ0Flv
	 HLcNnAFB3ocihSxxuuhUma1aK1gl9Ryt+AOydwQgA6caFuwQ3eIk1xpThMB8tNhocJ
	 bOs77b8Ebe5HlK3tGRxvWOoEyi073kwFaxkVsZFBgqAWEFILZYuNnYWd0ZKUZDtVLF
	 /M0er5loAVod3QQqMspksWAoPT0bweApBmV2GrBXA6iT2I12amfr2dlxJkfDcD+JFT
	 Z9MInqPueNbCSp5BaBbRmGQ/CqcCd3JAbf/9rOruFvLGrAuV41HEXU0veBULF3pRcY
	 xGw7xMcj40BPA==
Subject: Re: [PATCH mptcp-next v19 2/5] mptcp: drop the cant_coalesce CB field
From: netdev-bot+sashiko@kernel.org
To: geliang@kernel.org
Cc: mptcp@lists.linux.dev, tanggeliang@kylinos.cn, pabeni@redhat.com,
 kuba@kernel.org
Date: Sun, 01 Nov 2026 02:02:07 +0000
Message-ID: <179349852795.3128.8265545956967139910@kernel.org>
In-Reply-To: =?utf-8?q?=3C0ad56f82094010d23ca6cb0fb8400e560ca2f454=2E1793361?=
 =?utf-8?q?629=2Egit=2Etanggeliang=40kylinos=2Ecn=3E?=
References: =?utf-8?q?=3C0ad56f82094010d23ca6cb0fb8400e560ca2f454=2E17933616?=
 =?utf-8?q?29=2Egit=2Etanggeliang=40kylinos=2Ecn=3E?=
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

Thank you for your contribution! Sashiko AI review found 6 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 2 · Low: 3

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] __mptcp_move_skb() (net/mptcp/protocol.c:468-469) calls
  __mptcp_sync_rcv_sequence() whenever msk->rcvd_dummy_seq is true.
- [Medium] mptcp_move_skbs() (net/mptcp/protocol.c:2399-2400) does
  `test_and_clear_bit(MPTCP_SYNC_SEQ)` and then reads msk->tfo_iasn in…
- [Medium] The new lockless atomic `test_and_clear_bit(MPTCP_SYNC_SEQ,
  &msk->cb_flags)` in mptcp_move_skbs() (net/mptcp/protocol.c:2399)…
- [Low] Commit "mptcp: drop the cant_coalesce CB field" has no Signed-
  off-by tag, and no tags of any kind.
- [Low] In this commit, __mptcp_sync_rcv_sequence()
  (net/mptcp/protocol.c:439-455) rebases the passive-TFO skb with…
- [Low] The commit message does not match the code.

--

mptcp: drop the cant_coalesce CB field

This patch removes the cant_coalesce field from the MPTCP skb control
block. The dummy mapping of the passive fastopen skb is instead rebased
to the IASN, saved in msk->tfo_iasn, before any other skb lands in the
msk. When the msk is owned by user space, the update is deferred via
MPTCP_SYNC_SEQ.

> mptcp_move_skbs() and mptcp_release_cb() check MPTCP_SYNC_SEQ at each
> iteration before spooling the backlog, using test_and_clear_bit() since
> __mptcp_sync_rcv_sequence() can also be called without the socket lock
> held. A rcvd_dummy_seq flag tracks whether the TFO skb still carries the
> dummy mapping and needs synchronization.

[Severity: Low]
Is the "at each iteration" wording accurate for mptcp_move_skbs()? It
tests the bit only once, before the spool loop:

net/mptcp/protocol.c:mptcp_move_skbs() {
    ...
	if (test_and_clear_bit(MPTCP_SYNC_SEQ, &msk->cb_flags))
		__mptcp_sync_rcv_sequence(sk);

	mptcp_data_lock(sk);
	while (mptcp_can_spool_backlog(sk, &skbs)) {
    ...
}

Only mptcp_release_cb() checks it inside its for (;;) loop.

The message also leaves out a change that user space can see. Since commit
f03afb3aeb9d, after the 3rd ack a passive TFO msk had ack_seq = IASN
while the TFO skb kept map_seq = -skb->len (2^32 - len). As a result,
mptcp_inq_hint() returned INT_MAX through SIOCINQ and TCP_CM_INQ, and
rcvspace autotuning was skewed. With the rebase done here, the hint
becomes len.

Could the commit message describe this behaviour change?

[Severity: Low]
The commit message ends here with no Signed-off-by tag, and no other tag
of any kind. The other patches in the series, such as "mptcp: drop the
mptcp_ooo_try_coalesce() helper" and "mptcp: remove CB offset field",
carry Signed-off-by lines. Was it dropped by accident?

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 528a72da646cc..e855aaa59da29 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c

[ ... ]

> @@ -438,6 +436,24 @@ static void mptcp_init_skb(struct sock *ssk, struct sk_buff *skb, int offset,
>  	skb_dst_drop(skb);
>  }
>  
> +void __mptcp_sync_rcv_sequence(struct sock *sk)
> +{
> +	struct mptcp_sock *msk = mptcp_sk(sk);
> +	struct sk_buff *skb;
> +
> +	if (likely(!msk->rcvd_dummy_seq))
> +		return;
> +
> +	/* User space can have already received the TFO skb. */
> +	msk->rcvd_dummy_seq = false;
> +	skb = skb_peek_tail(&sk->sk_receive_queue);
> +	if (!skb)
> +		return;
> +
> +	MPTCP_SKB_CB(skb)->map_seq = msk->tfo_iasn - skb->len;
> +	MPTCP_SKB_CB(skb)->end_seq = msk->tfo_iasn;

[Severity: Low]
Does this rebase lose the partial read progress on the TFO skb? Partial
reads in __mptcp_recvmsg_mskq() and __mptcp_read_sock() advance offset
and map_seq together, so map_seq points at the first unread byte:

net/mptcp/protocol.c:__mptcp_recvmsg_mskq() {
    ...
			if (count < data_len) {
				MPTCP_SKB_CB(skb)->offset += count;
				MPTCP_SKB_CB(skb)->map_seq += count;
				break;
    ...
}

Suppose user space accept()s the passive TFO child and reads k bytes
before the 3rd ack arrives. The sync here then leaves map_seq k bytes too
low, while the CB offset stays at k. mptcp_inq_hint() over-reports unread
data by k:

	u64 hint_val = READ_ONCE(msk->ack_seq) - MPTCP_SKB_CB(skb)->map_seq;

That value feeds SIOCINQ, TCP_CM_INQ and mptcp_rcv_space_adjust(). Data
delivery is still correct, because recvmsg uses the CB offset.

The later patch "mptcp: remove CB offset field" in this series appears to
fix this. It drops the CB offset, adds tfo_iasn to copied_seq at sync
time, and computes the hint as ack_seq - copied_seq.

> +}
> +
>  static bool __mptcp_move_skb(struct sock *sk, struct sk_buff *skb)
>  {
>  	u64 copy_len = MPTCP_SKB_CB(skb)->end_seq - MPTCP_SKB_CB(skb)->map_seq;
> @@ -446,6 +462,12 @@ static bool __mptcp_move_skb(struct sock *sk, struct sk_buff *skb)
>  
>  	mptcp_borrow_fwdmem(sk, skb);
>  
> +	/* Be sure to sync the eventual fastopen dummy mapping before any other
> +	 * skb lands into the msk.
> +	 */
> +	if (unlikely(msk->rcvd_dummy_seq))
> +		__mptcp_sync_rcv_sequence(sk);

[Severity: High]
Can this sync run with a tfo_iasn value that was never set for this
connection?

Take a passive TFO connection whose 3rd ack has no MPC option.
check_fully_established() falls back via mptcp_try_fallback(), and
subflow_set_remote_key() is never called. tfo_iasn then keeps whatever
value sk_clone_lock() copied from the listener msk, because neither
__mptcp_init_sock() nor mptcp_sk_clone_init() initializes it.

mptcp_disconnect() resets the flag but leaves tfo_iasn alone:

	msk->rcvd_dummy_seq = false;

Consider a socket that does an active MPTCP connect(), which sets
tfo_iasn in subflow_set_remote_key(). It then calls connect(AF_UNSPEC),
then listen() with TCP_FASTOPEN. Its passive children inherit a stale
non-zero tfo_iasn (X):

mptcp_fastopen_subflow_synack_set_params()
    msk->rcvd_dummy_seq = true;

3rd ack without MPC:
check_fully_established()
    mptcp_try_fallback()        /* tfo_iasn left as X */

first fallback data skb:
__mptcp_move_skb()
    __mptcp_sync_rcv_sequence()
        map_seq = X - len, end_seq = X

Fallback data is mapped from 0 (subflow->iasn and msk->ack_seq are both
0), so the TFO skb no longer lines up with the rest of the stream. In
this commit, mptcp_inq_hint() then returns INT_MAX for SIOCINQ,
TCP_CM_INQ and autotuning.

After "mptcp: remove CB offset field" later in the series, the effect is
worse. Fastopen sets copied_seq = -len, and the passive fallback path
never adjusts it. __mptcp_recvmsg_mskq() then computes:

	u32 offset = (u32)(*seq) - MPTCP_SKB_CB(skb)->map_seq;

This gives offset >= skb->len for the TFO skb and for every following
fallback skb. recvmsg skips each of them as already peeked, and
mptcp_recv_skb() on the read_sock path throws them away.

Would the application on such a connection ever see the received data?
Should tfo_iasn also be reset in mptcp_disconnect()?

> +
>  	if (MPTCP_SKB_CB(skb)->map_seq == msk->ack_seq) {
>  		/* in sequence */
>  insert:

[ ... ]

> @@ -2374,6 +2396,9 @@ static bool mptcp_move_skbs(struct sock *sk)
>  	bool enqueued = false;
>  	u32 moved = 0;
>  
> +	if (test_and_clear_bit(MPTCP_SYNC_SEQ, &msk->cb_flags))
> +		__mptcp_sync_rcv_sequence(sk);

[Severity: Medium]
Can this lockless test_and_clear_bit() race with the non-atomic cb_flags
updates that run under sk_lock.slock while the msk is owned? For example:

net/mptcp/protocol.c:__mptcp_data_acked() {
	if (!sock_owned_by_user(sk))
		__mptcp_clean_una(sk);
	else
		__set_bit(MPTCP_CLEAN_UNA, &mptcp_sk(sk)->cb_flags);
}

MPTCP_PUSH_PENDING, MPTCP_RETRANSMIT, MPTCP_SYNC_SNDBUF,
MPTCP_FLUSH_JOIN_LIST, MPTCP_SYNC_STATE and MPTCP_ERROR_REPORT are
updated the same way.

A softirq __set_bit() on another CPU can load cb_flags before this atomic
clear and store it back after. MPTCP_SYNC_SEQ is then set again, and the
next mptcp_release_cb() sees it a second time. KCSAN would also report
the mix of plain and atomic accesses.

The commit message explains the atomic op with "since
__mptcp_sync_rcv_sequence() can also be called without the socket lock
held". A single atomic access does not protect a word whose other
writers are non-atomic, though.

In this commit a resurrected bit is harmless, because
__mptcp_sync_rcv_sequence() returns early once rcvd_dummy_seq is false.
After "mptcp: remove CB offset field", however, both mptcp_move_skbs()
and mptcp_release_cb() run this unconditionally whenever the bit is set:

	msk->copied_seq += msk->tfo_iasn;

A resurrected bit would add the IASN twice and stall delivery in
__mptcp_recvmsg_mskq().

Could this check move under mptcp_data_lock() using
__test_and_clear_bit(), with the writer using __set_bit(), as the other
cb_flags users do?

> +
>  	mptcp_data_lock(sk);
>  	while (mptcp_can_spool_backlog(sk, &skbs)) {
>  		mptcp_data_unlock(sk);

[ ... ]

> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index 78e886b202585..8a3ba490b5772 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c

[ ... ]

> @@ -533,6 +535,12 @@ static void subflow_set_remote_key(struct mptcp_sock *msk,
>  	WRITE_ONCE(msk->ack_seq, subflow->iasn);
>  	WRITE_ONCE(msk->can_ack, true);
>  	atomic64_set(&msk->rcv_wnd_sent, subflow->iasn);
> +	msk->tfo_iasn = subflow->iasn;
> +
> +	if (!sock_owned_by_user(sk))
> +		__mptcp_sync_rcv_sequence(sk);
> +	else
> +		set_bit(MPTCP_SYNC_SEQ, &msk->cb_flags);

[Severity: Medium]
What orders the tfo_iasn store before the set_bit()? Per
Documentation/atomic_bitops.txt, set_bit() gives no ordering. The reader
in mptcp_move_skbs() tests the bit and reads tfo_iasn before taking
mptcp_data_lock(), so the spin_unlock on this side does not help:

CPU0 (owner)                         CPU1 (softirq)
ioctl(SIOCINQ)
  lock_sock()
  mptcp_move_skbs()
                                     check_fully_established()
                                       mptcp_data_lock()
                                       subflow_set_remote_key()
                                         msk->tfo_iasn = subflow->iasn;
                                         set_bit(MPTCP_SYNC_SEQ, ...);
    test_and_clear_bit(MPTCP_SYNC_SEQ)
    __mptcp_sync_rcv_sequence()
      reads old msk->tfo_iasn

On weakly ordered CPUs such as arm64 or powerpc, the owner can see the
bit set and still read the old tfo_iasn. On 32-bit, the u64 read can also
tear. __mptcp_sync_rcv_sequence() clears rcvd_dummy_seq unconditionally,
so the stale mapping is never corrected.

In this commit, that leaves the TFO skb with a dummy-like mapping and a
wrong inq hint. After "mptcp: remove CB offset field", mptcp_move_skbs()
also does copied_seq += tfo_iasn from the same read. A stale value there
throws copied_seq out of sync, and __mptcp_recvmsg_mskq() then skips
every later skb.

>  }

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1793361629.git.tanggeliang%40kylinos.cn
