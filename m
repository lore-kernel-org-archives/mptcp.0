Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793839262;
	b=C/12nomYsw1vfKFDdpzwCSf78YWqgK60new3SBEWcxcSHxc2tIOeWFnNPUICTDwt7jSK
	 jW+2lnvwDCoYGJTdQeaXmEeHWD6S9uaz6tc72mLlq3XZbph96RF2rLaNEQe6BdtV/BiEl
	 PEFZ7dMOjcCKS7prMgy7KMrY6Gw3lDs2+KTaYQrJEvYdGFfbKUiQ0zrVIU2r4dz1CAm4p
	 2bIhTCJxM5BOxV2bEqc5HVR3VmRA5kxJiPxgGhupBDN5JEODS19AXvy4v5l49x2jExq3+
	 0HZMZT+6/z3VkK8rBHWFb2XZYK/aDzv+o85XbW/JqD9vdmeANm4uEx4xc+GArdVduvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793839262;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=y5JPVd1xeDlxOSf4lwUE+QOdLJb10FSGSCe/p4YZejM=;
	b=N1qTmATe1FPofTW0Vp6R+TjgpMq0eWkrDDa19YCYgcicB/IFBWJoL8YZGk1Uez3nfto9
	 QkUwAXKaLFkrBx2TflUXn56fPz+XtRoQVxJ4w468ROw/vK3kozr9B7iaiZiIXtgWx5sOj
	 GlevR7u2/8nMq2ZWa5wOD3qBDYFyc4z4Q6okInIQXP4CZNosEFSniHyH68jZInF6YU1yJ
	 0PmowCXHZFEe8HyhnykMuqOsHaspY3WAaGjobrLnfltpJYh8/9agApXljYaHqwWcRyOs4
	 vZk48FjP7zQizefOi8QSLq+2LeWCL46+MPuSCdvEwaJVPFpLcbbCQThbk6/VLKFpgng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Srya1R2G;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC954606A31B
	for <mptcp@lists.linux.dev>; Thu,  5 Nov 2026 00:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Srya1R2G
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ECE11F000C1;
	Thu,  5 Nov 2026 00:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793839261;
	bh=y5JPVd1xeDlxOSf4lwUE+QOdLJb10FSGSCe/p4YZejM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Srya1R2G/orwPh/E0dIyDS1O0bm3NCTFQ5Ygkd4iYqt8XJhohxf/IuC6V4zanmWka
	 JiKbP2hjA+asS+JCPh/gPCOUHvV6xzpzbuExTshKvot+NJSDuJnNTZroPo2azHG0T7
	 c4fm4X6CUGIG3tbkLR3DHwYLJsLt5CY2IEfgvYoPTve++EcDhGe4zf0B0GHKIoP7Kh
	 hCoiITS6/yhlg9DZKUcrtLzLX7pCDSMH79TQYzK+O4SpaZcoFuuhM6ctdzNInuGJ+Z
	 Wufez6n+67gVn9bsSydM+B2KkgG+iRrZHkjUOAHq4Eq5ovVgsXMhxfyD/NyzFnh73c
	 Vj/LBE3vG4L/w==
Subject: Re: [PATCH mptcp-next v20 2/6] mptcp: drop the cant_coalesce CB field
From: netdev-bot+sashiko@kernel.org
To: geliang@kernel.org
Cc: mptcp@lists.linux.dev, tanggeliang@kylinos.cn, pabeni@redhat.com,
 kuba@kernel.org
Date: Thu, 05 Nov 2026 00:41:00 +0000
Message-ID: <179383926067.488855.17372066216647293147@kernel.org>
In-Reply-To: <9bd00acf2721c30b79fd852167b5b1343a2d67a0.1793695518.git.tanggeliang@kylinos.cn>
References: <9bd00acf2721c30b79fd852167b5b1343a2d67a0.1793695518.git.tanggeliang@kylinos.cn>
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

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] mptcp: mptcp_inq_hint() seq mismatch when MPTCP_SYNC_SEQ is
  deferred
- [Low] The commit message says MPTCP_SYNC_SEQ is consumed "using
  test_and_clear_bit() since __mptcp_sync_rcv_sequence() can also be…

--

mptcp: drop the cant_coalesce CB field

This commit removes the cant_coalesce field from the MPTCP skb control
block. The passive fastopen skb's dummy mapping is now synced from the
IASN stored in msk->tfo_iasn before any other skb lands in the msk. When
the msk is owned by user space at 3rd ack time, the sync is deferred via
the new MPTCP_SYNC_SEQ cb_flags bit.

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 528a72da646cc..f3b07b303f555 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c

[ ... ]

> @@ -2375,6 +2397,8 @@ static bool mptcp_move_skbs(struct sock *sk)
>  	u32 moved = 0;
>  
>  	mptcp_data_lock(sk);
> +	if (__test_and_clear_bit(MPTCP_SYNC_SEQ, &msk->cb_flags))
> +		__mptcp_sync_rcv_sequence(sk);
>  	while (mptcp_can_spool_backlog(sk, &skbs)) {
>  		mptcp_data_unlock(sk);
>  		enqueued |= __mptcp_move_skbs(sk, &skbs, &moved);

[Severity: Medium]
On a passive TFO socket, what happens if the 3rd ack arrives while
user space holds the msk socket lock? It looks like msk->ack_seq and
the queued TFO skb are then out of sync until release_sock().

subflow_set_remote_key() moves msk->ack_seq to subflow->iasn right
away. The TFO skb queued by mptcp_fastopen_subflow_synack_set_params()
keeps its dummy mapping (map_seq = -skb->len, end_seq = 0) until
MPTCP_SYNC_SEQ is consumed by mptcp_move_skbs() or mptcp_release_cb().

In that window mptcp_inq_hint() still peeks that skb and computes:

	u64 hint_val = READ_ONCE(msk->ack_seq) - MPTCP_SKB_CB(skb)->map_seq;

That evaluates to subflow->iasn + skb->len. It is almost always above
INT_MAX, so user space gets INT_MAX as the inq value. When the IASN
happens to be small, it gets a bogus value derived from it instead.

All of the following run under lock_sock(sk) and can reach
mptcp_inq_hint() while the bit is still pending:

  - mptcp_recvmsg() -> __mptcp_recvmsg_mskq() ->
    mptcp_rcv_space_adjust(), before mptcp_move_skbs() has run. If I
    read it correctly, the copied -= mptcp_inq_hint(sk) there would
    underflow as well.
  - the TCP_CM_INQ cmsg in mptcp_recvmsg(). When the 3rd ack carries
    no data, msk->backlog_list is empty and mptcp_move_skbs() is
    skipped, so the flag is only consumed later by mptcp_release_cb().
  - mptcp_ioctl(SIOCINQ). The 3rd ack can land in BH after
    mptcp_move_skbs() drops the data lock and before mptcp_inq_hint()
    reads msk->ack_seq.

A partial read or MSG_PEEK of the TFO data that races with the peer's
3rd ack should be enough to trigger this. The point of this patch is
to keep the TFO skb mapping consistent with msk->ack_seq, but the
deferred path still leaves a window where it is not.

Since these callers already own the socket, could they consume
MPTCP_SYNC_SEQ under mptcp_data_lock() before peeking at
sk->sk_receive_queue? Or is there another way to make the msk->ack_seq
update and the TFO skb resync visible together to the lock owner?

[Severity: Low]
This isn't a bug, but the commit message doesn't seem to match the code
here. It says:

    mptcp_move_skbs() and mptcp_release_cb() check MPTCP_SYNC_SEQ at each
    iteration before spooling the backlog, using test_and_clear_bit() since
    __mptcp_sync_rcv_sequence() can also be called without the socket lock
    held.

Both mptcp_move_skbs() and mptcp_release_cb() use the non-atomic
__test_and_clear_bit(). The only producer, subflow_set_remote_key() in
net/mptcp/subflow.c, uses the atomic variant:

	else
		set_bit(MPTCP_SYNC_SEQ, &msk->cb_flags);

The other cb_flags producers use __set_bit(). Examples are
mptcp_propagate_state() setting MPTCP_SYNC_STATE and __mptcp_data_acked()
setting MPTCP_CLEAN_UNA.

The non-atomic consumers look correct, because every access to
MPTCP_SYNC_SEQ appears to be serialized by the msk spinlock
(sk_lock.slock):

  - check_fully_established() wraps __mptcp_subflow_fully_established()
    in mptcp_data_lock()/mptcp_data_unlock() on the 3rd ack path
  - mptcp_propagate_state() holds mptcp_data_lock()
  - mptcp_sk_clone_init() runs under bh_lock_sock(nsk)
  - mptcp_move_skbs() holds mptcp_data_lock()
  - mptcp_release_cb() runs with sk_lock.slock held

The "without the socket lock" wording seems to refer only to the owner
lock. The spinlock is what actually protects cb_flags.

Could the commit message say that the msk data lock is what protects
MPTCP_SYNC_SEQ? Could subflow_set_remote_key() also use __set_bit(), like
the other cb_flags producers?

The same mismatch is still there at the end of the series. After
"mptcp: remove CB offset field", both consumers still use
__test_and_clear_bit() and subflow_set_remote_key() still uses set_bit().

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1793695518.git.tanggeliang%40kylinos.cn
