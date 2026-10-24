Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792859182;
	b=R9910kjhALkq/qzBn3EfGAcYk9guCq30SpyTixcPCBjfw52EXM93ATG4jN0v6xX36FyZ
	 08v5J5SUG8mHXEPULEZSzO2sOUxngz3VeSotQ+dGAKEJGYIza/Y1/OywaX4IlCvoKE9CC
	 UJk48/czxGKgPUTn3HDNmra+UO3mEF/73wII39XMtDtA8LdpmjiAHASuuQyLf+5HMy101
	 WwecZd2fJ43GRKZrok9BOVvvJ0ZbFzbqoJzaqD3c13pERnhGPdYbyYwncs9i/dyd5fks3
	 B0jamNCSPOiNso1CN1XcDhQEBnMuJC5kyrjF9p8P5qg9lndTXfVlu/9j2jwqLyh1hUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792859182;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=oW750dJo2CcYgDxEC9H8OejhE0shENt5wXhkApUwWrw=;
	b=MIV2Dezo5mGBlfakZQYiAu/MefG78Zhgc2Vq4eVlB8gcM899RM2yRNKbJqdpMgmG8HEp
	 NoPt70fqV3guEJdW/DL5g8jiem3AhvX06wcNjPDrlTUK/zryzBJmC7Mf1OV4hmHm94Ltg
	 QA08PfxX9xJteKOZ1flZxSmdsITPD6jARF1ooib+ccrBoMbe0Khajdd+YVNPiuCptmook
	 xpuQzc7JUmqdWxu5eQbl3EMa2HDydjLxuuXeY5wIyeQQMAhQc3jKnlEKGKWbYXEhifoQo
	 BtL7cEb3sxJq9vHPef1sooBtfkIkpsoNnSd5yfShdxazzzaTuh3udofIsJua4LbxBoA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QlICVoBA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C20E606A32A
	for <mptcp@lists.linux.dev>; Sat, 24 Oct 2026 16:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QlICVoBA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6C1F1F031EB;
	Sat, 24 Oct 2026 16:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792859172;
	bh=oW750dJo2CcYgDxEC9H8OejhE0shENt5wXhkApUwWrw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=QlICVoBA/r/41GQBZ1otTfdYnKqsum0Yb+stzGSaMb5aBi4TPudazdE/22n+2lw3j
	 3660LM4s8A6URtRbqlSoE1bfGG/0ZNrtR45JBvtuqEizLMkTug/cxOcZJvaRaTj4ev
	 iR4CKb0DsdslqihbRhBv4WPZIm3uFpIy3/CgBtpUpKj25X6u+ORnKCzIGeOYTMsY/F
	 oYpkWUvKQZ2TCpnBKKKKcPL0LSSG72V46fGZJ97vneUiz/2NUGNXkFiSZQJBACUZZC
	 EDI7slGCPLgTYCo71zZ2l2e0o/+Q/J3o9aJ6GWAJqk5XG5Mg4A6Fs7cGMLZUe5TFuk
	 OHFqs/bc9BM0w==
Subject:
 Re: [PATCH mptcp-next v15 07/11] mptcp: implement peek_len for proto_ops
From: netdev-bot+sashiko@kernel.org
To: geliang@kernel.org
Cc: mptcp@lists.linux.dev, yangang@kylinos.cn, kuba@kernel.org
Date: Sat, 24 Oct 2026 16:26:12 +0000
Message-ID: <179285917226.3132.1744926048999475719@kernel.org>
In-Reply-To: =?utf-8?q?=3C7f915090708935804fe0b5a61b50e24fcd232a40=2E1792718?=
 =?utf-8?q?041=2Egit=2Etanggeliang=40kylinos=2Ecn=3E?=
References: =?utf-8?q?=3C7f915090708935804fe0b5a61b50e24fcd232a40=2E17927180?=
 =?utf-8?q?41=2Egit=2Etanggeliang=40kylinos=2Ecn=3E?=
X-sashiko-severity: Medium
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

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 3 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] mptcp_inq() in net/mptcp/protocol.c returns 0 whenever
  MPTCP_SYNC_SEQ is set, without looking at sk_receive_queue.
- [Medium] In mptcp_inq() (net/mptcp/protocol.c), the order
  test_bit(MPTCP_SYNC_SEQ) -> smp_rmb() -> READ_ONCE(ack_seq) -…
- [Medium] The commit message says a torn 64-bit read of
  ack_seq/copied_seq on 32-bit systems "is caught by the INT_MAX clamp".
- [Low] The commit message for "mptcp: implement peek_len for proto_ops"
  contains two factual errors.

--

mptcp: implement peek_len for proto_ops

This adds mptcp_inq(), which computes the number of readable bytes at the
MPTCP level from ack_seq - copied_seq. It is wired into a new
mptcp_peek_len() callback for both the IPv4 and IPv6 MPTCP proto_ops. The
commit describes this as preparatory work for an upcoming kTLS-over-MPTCP
series.

> This is preparatory work for
> an upcoming kTLS-over-MPTCP series: no in-tree consumer currently
> reaches ->peek_len on an MPTCP socket (the only caller, strp_peek_len(),
> cannot attach strparser to MPTCP; the existing TLS receive path calls
> tcp_inq() directly rather than going through ->peek_len).

[Severity: Low]
Is "the only caller" accurate? sock_has_rx_data() in drivers/vhost/net.c
also calls ->peek_len:

	if (sock->ops->peek_len)
		return sock->ops->peek_len(sock);

vhost-net only accepts packet/tun/tap sockets, so the conclusion that MPTCP
is not reached still holds. Only the wording is off.

> Note: mptcp_inq() intentionally differs from mptcp_inq_hint() when the
> calculated value is 0 and SOCK_DONE is set.

Can that state actually happen? mptcp_check_data_fin() bumps ack_seq and
sets SOCK_DONE together:

	if (mptcp_pending_data_fin(sk, &rcv_data_fin_seq)) {
		WRITE_ONCE(msk->ack_seq, msk->ack_seq + 1);
		...
		sock_set_flag(sk, SOCK_DONE);

copied_seq only advances by the number of data bytes in recvmsg and
read_sock, so it never moves past the DATA_FIN. After a DATA_FIN,
ack_seq - copied_seq is therefore always at least 1.

That would make the !hint_val && SOCK_DONE branch in mptcp_inq_hint()
unreachable. The real difference between the two helpers would then be
N + 1 vs N for N unread bytes. Could the note be updated to say that?

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 7b0005d47bead..ad11a96b83eba 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -4848,6 +4848,43 @@ static ssize_t mptcp_splice_read(struct socket *sock, loff_t *ppos,
>  	return ret;
>  }
>  
> +static int mptcp_inq(struct sock *sk)
> +{
> +	const struct mptcp_sock *msk = mptcp_sk(sk);
> +	int answ;
> +
> +	if ((1 << sk->sk_state) & (TCPF_SYN_SENT | TCPF_SYN_RECV)) {
> +		answ = 0;
> +	} else if (test_bit(MPTCP_SYNC_SEQ, &msk->cb_flags)) {
> +		answ = 0;

[Severity: Medium]
Can this branch under-report readable data on a passive Fast Open (TFO)
socket?

For a passive TFO msk, mptcp_sk_clone_init() has already moved the msk to
TCP_ESTABLISHED, so the SYN_SENT/SYN_RECV check above doesn't filter it.
mptcp_fastopen_subflow_synack_set_params() has also queued the SYN payload
on sk_receive_queue with a dummy mapping.

If the MPC third ACK is processed while the user owns the msk,
check_fully_established()->__mptcp_subflow_fully_established()->
subflow_set_remote_key() takes the deferred path:

net/mptcp/subflow.c:subflow_set_remote_key() {
    ...
	WRITE_ONCE(msk->ack_seq, subflow->iasn);
    ...
	} else {
		/* Ensure ack_seq is visible before setting the flag */
		smp_wmb();
		set_bit(MPTCP_SYNC_SEQ, &msk->cb_flags);
	}
}

The flag stays set until mptcp_release_cb() or __mptcp_move_skb() clears
it. During that time, a ->peek_len caller holding lock_sock() gets 0 here.
recvmsg() or read_sock() can still read the queued TFO bytes in that window.

The existing mptcp_inq_hint() handles the same state by looking at the
queue:

	if (test_bit(MPTCP_SYNC_SEQ, &msk->cb_flags)) {
		skb = skb_peek(&sk->sk_receive_queue);
		return skb ? skb->len : 0;
	}

A peek_len consumer such as strp_data_ready() treats this value as a gate:

	if (strp_peek_len(strp) < strp->need_bytes)
		return;

Suppose the whole message arrived in the SYN data and nothing else follows.
Could the reader stall in that case? There is no in-tree MPTCP ->peek_len
consumer yet, so this would show up with the planned kTLS user.

The commit message doesn't mention this case as a difference from
mptcp_inq_hint(). Should this branch do what mptcp_inq_hint() does?

> +	} else {
> +		bool sock_done = sock_flag(sk, SOCK_DONE);
> +		u64 hint_val;
> +
> +		/* Ensure we see updated ack_seq and copied_seq after
> +		 * checking MPTCP_SYNC_SEQ flag.
> +		 */
> +		smp_rmb();
> +
> +		hint_val = READ_ONCE(msk->ack_seq) - READ_ONCE(msk->copied_seq);

[Severity: Medium]
Does this smp_rmb() give the guarantee the comment describes?

In subflow_set_remote_key(), the writer stores ack_seq, then does smp_wmb()
and set_bit(MPTCP_SYNC_SEQ). When the msk is user-owned, it defers the
copied_seq rebase. That pairing only orders accesses for a reader that sees
the flag set, which is what __mptcp_move_skb() does:

	if (test_and_clear_bit(MPTCP_SYNC_SEQ, &msk->cb_flags)) {
		/* Ensure we see the updated ack_seq after seeing the flag */
		smp_rmb();
		msk->copied_seq += mptcp_iasn(msk);

Here the barrier is only reached after the flag was seen clear, and a clear
flag says nothing about ack_seq.

Take a passive TFO msk that is ESTABLISHED via mptcp_sk_clone_init(), with
ack_seq 0 and copied_seq set to minus the TFO length, owned by a lock_sock()
holder:

CPU0                                CPU1 (BH, MPC third ACK)
mptcp_inq()                         check_fully_established()
  test_bit(MPTCP_SYNC_SEQ) == 0
                                      subflow_set_remote_key()
                                        WRITE_ONCE(msk->ack_seq, iasn)
                                        smp_wmb()
                                        set_bit(MPTCP_SYNC_SEQ)
  smp_rmb()
  READ_ONCE(msk->ack_seq)     -> iasn
  READ_ONCE(msk->copied_seq)  -> not yet rebased

hint_val then becomes iasn minus the old copied_seq. With a hash-derived
64-bit iasn, that is almost always >= INT_MAX, so INT_MAX would be returned
as the readable byte count.

Would re-checking the flag after the loads close this window?

The commit message also says:

  READ_ONCE() is used instead of mptcp_data_lock() for the u64 reads of
  ack_seq and copied_seq because mptcp_inq() will be called from TLS
  contexts with the socket lock held - taking the spinlock would deadlock.

A lock_sock() owner doesn't hold sk_lock.slock, so taking
mptcp_data_lock() there would not deadlock. Could the data lock be taken
when the caller owns the socket?

> +		if (hint_val >= INT_MAX)
> +			hint_val = INT_MAX;

[Severity: Medium]
The commit message says:

  On 32-bit systems a torn read can produce a wrapped subtraction (close to
  2^64), which is caught by the INT_MAX clamp.

Is "caught" the right word here? The clamp doesn't reject a torn value. It
turns it into INT_MAX, which mptcp_inq() then returns as the readable byte
count.

A torn read leaves the difference off by about 2^32, in either direction.
It is either a small real value plus 2^32, or a negative difference that
wraps near 2^64. Both cases end up as INT_MAX.

In the lock_sock() owner context, subflow_set_remote_key() is still a
concurrent u64 writer of ack_seq:

	WRITE_ONCE(msk->ack_seq, subflow->iasn);

On 32-bit, READ_ONCE() and WRITE_ONCE() of a u64 are two 32-bit accesses.
That would let ->peek_len report about 2GB readable on a socket holding
little or no data.

tcp_inq(), which this is meant to mirror, doesn't have this problem because
TCP sequence numbers are 32-bit. Would a retry, a fallback to 0, or taking
the data lock in owner context fit better here?

> +
> +		answ = (unsigned int)hint_val;
> +
> +		/* Subtract 1, if FIN was received. Mirror tcp_inq() */
> +		if (answ && sock_done)
> +			answ--;
> +	}
> +
> +	return answ;
> +}

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1792718041.git.tanggeliang%40kylinos.cn
