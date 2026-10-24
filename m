Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792859171;
	b=jbRwKfCnEiWaYVGGSqp1xio8GxvihQAvQMrDxNUiU/6NjbRXzvia3nAmb8fjX7q3I4qR
	 b40NX2i8rsKiZDUoqmXg8GZBN+gdyNf+50l/6jeD4ztu8PVC2UGepS8A1Upp5fom1+uri
	 IDsT0YS3+ZifqiXrzHVvPmBVjZKqoySEbiAYtK3+lE+zwGqw3tDdT1/9mlcqCvfJTGYZf
	 PtkK4fJ5gT9zcovFxQzLWV1yYc3Z/VL1XU5DFmuZqCBRwLBSYYjlRqyx17WbHcOkPpGj2
	 0Z2r0ZNOd6Z8vxytvSsEqfOM5Xt7uLwTX2NW6jrhGln+ki+wyTQmh3NHmjTMDEqQOFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792859171;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=3IU+EMRUdXKMRbnrueOhq3BIpvTkKN/1PocjyqtPoyQ=;
	b=WqAYYV5Vnu4Kpj+nzCZqGOJHk39RfXyFzt5ro5e0Ksq8ZwkTTxeMxYA6D6y4hwmKGgwL
	 Yi4IFoKummGJQQzO0GiQSgapyPDLtCQtDJ+3K2FTm4w7aE4N4hZGPQqa9vdRvy/MQtDqM
	 NDbmMYxcsF4S6LvnWjrEGGNxVNxj2uxwraIla1iERTdf4EuuxhtHnruqmwAMGTHRoiatp
	 d/PvQlTR751//EmF2IUqpqSH5RIe12MYApmxm7tSs+jgdHCpb2awUWWZOXeYru/wDi3uR
	 T/XKw9b/erKtwS8IR29cyGYZ7oBAVWxzSTeUWcPh2tAYuHlJ0a2/vGUK0R1BspoMKow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mpMeyoPQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F593606A32F
	for <mptcp@lists.linux.dev>; Sat, 24 Oct 2026 16:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mpMeyoPQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC4441F031EC;
	Sat, 24 Oct 2026 16:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792859171;
	bh=3IU+EMRUdXKMRbnrueOhq3BIpvTkKN/1PocjyqtPoyQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=mpMeyoPQKwGGtG/JalJopfIXhx1pT0C2ZKZW0n5pIUOmJRyCntRWIFJjr+fHNTKiN
	 6DtDvE3jnlR9krYmU1MYzIygft9vt8KEKe1qN0/vUXn+GLcx3IyhwtcyogXmds/nXT
	 aW5CexZCLMPON7Tn0+Emu3ry6jZzwYVFyKPCFm3WxnIQpzOrg/KOKfUf2P+rrScIsc
	 dbEOwUnF8+GLAbeM/2CbIqoTYC1/vStPNQkD4bBjq1Ga/VtMx8BHOc0cbLUPuWE4yj
	 BSCGIuwaf6dtdzfcOsOUZYj8Qm6m3rGLQXiLuodLDiKeAMmlq5Fu0U1/MDBUtHpF1L
	 FRDbeCBJi+XWg==
Subject: Re: [PATCH mptcp-next v15 05/11] mptcp: defer read_sock cleanup to
 mptcp_worker
From: netdev-bot+sashiko@kernel.org
To: geliang@kernel.org
Cc: mptcp@lists.linux.dev, yangang@kylinos.cn, kuba@kernel.org
Date: Sat, 24 Oct 2026 16:26:10 +0000
Message-ID: <179285917052.3132.12182354047724273812@kernel.org>
In-Reply-To: =?utf-8?q?=3Cd3072fed79af4d6dc637fd7ecf2263ac0d189cc6=2E1792718?=
 =?utf-8?q?041=2Egit=2Etanggeliang=40kylinos=2Ecn=3E?=
References: =?utf-8?q?=3Cd3072fed79af4d6dc637fd7ecf2263ac0d189cc6=2E17927180?=
 =?utf-8?q?41=2Egit=2Etanggeliang=40kylinos=2Ecn=3E?=
X-sashiko-severity: Low
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

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] msk->read_copied (struct mptcp_sock, protocol.h:330) is a signed
  int.
- [Low] The patch removes msk_owned_by_me() from __mptcp_read_sock() on
  the grounds that 'the BH caller does not own the msk lock'.

--

mptcp: defer read_sock cleanup to mptcp_worker

This commit prepares for kTLS-over-MPTCP, where __mptcp_read_sock() can be
reached from BH context. mptcp_rcv_space_adjust() and mptcp_cleanup_rbuf()
move out of __mptcp_read_sock() and into mptcp_worker(). The consumed byte
count goes into a new msk->read_copied field, and the worker is signalled
through MPTCP_WORK_READ_COMPLETE. The commit also removes the backlog flush
from mptcp_recv_skb() and the msk_owned_by_me() assertion from
__mptcp_read_sock().

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 01eb7fb314e76..3c3ad8991799a 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c

[ ... ]

> @@ -4655,6 +4672,7 @@ static struct sk_buff *mptcp_recv_skb(struct sock *sk, u32 *off)
>  /*
>   * Note:
>   *	- It is assumed that the socket was locked by the caller.
> + *	- Can be invoked in BH scope.
>   */
>  static int __mptcp_read_sock(struct sock *sk, read_descriptor_t *desc,
>  			     sk_read_actor_t recv_actor, bool noack)
> @@ -4664,8 +4682,6 @@ static int __mptcp_read_sock(struct sock *sk, read_descriptor_t *desc,
>  	int copied = 0;
>  	u32 offset;
>  
> -	msk_owned_by_me(msk);
> -
>  	if (sk->sk_state == TCP_LISTEN)
>  		return -ENOTCONN;
>  	while ((skb = mptcp_recv_skb(sk, &offset)) != NULL) {

[Severity: Low]
Is the reason given for dropping this assertion accurate? The commit
message says:

  "drop the msk_owned_by_me() assertion from __mptcp_read_sock() (the BH
  caller does not own the msk lock)"

msk_owned_by_me() ends up in lockdep_sock_is_held(), and that function
also accepts the socket spinlock:

include/net/sock.h:lockdep_sock_is_held() {
	return lockdep_is_held(&sk->sk_lock) ||
	       lockdep_is_held(&sk->sk_lock.slock);
}

The expected BH entry point is sk_data_ready, called from
mptcp_data_ready(). That path runs under mptcp_data_lock() and checks
ownership:

net/mptcp/protocol.c:mptcp_data_ready() {
	...
	mptcp_data_lock(sk);
	mptcp_rcv_rtt_update(msk, subflow);
	if (!sock_owned_by_user(sk)) {
	...
}

A caller like that would pass the assertion, so removing it only loses
lockdep coverage.

If the planned BH caller holds neither lock, __mptcp_read_sock() would do
several things without serialization:

  - unlink skbs from sk_receive_queue through mptcp_eat_recv_skb()
  - update copied_seq and bytes_consumed
  - do a plain "msk->read_copied += copied"

These would race with __mptcp_move_skbs_from_subflow(). They would also
race with mptcp_read_complete(), which reads and clears read_copied under
mptcp_data_lock().

The only current in-tree caller, mptcp_splice_read(), holds lock_sock, so
there is no live race today.

The header comment now says both "It is assumed that the socket was
locked by the caller" and "Can be invoked in BH scope". The new
read_copied field also has no annotation saying which lock protects it.

Could the assertion stay, with the locking rules for read_copied written
down?

[ ... ]

> @@ -4696,11 +4712,14 @@ static int __mptcp_read_sock(struct sock *sk, read_descriptor_t *desc,
>  	if (noack)
>  		goto out;
>  
> -	mptcp_rcv_space_adjust(msk, copied);
> -
> +	/* The backlog flushing is only needed when some data is actually
> +	 * moved and will take place in mptcp_release_cb() via
> +	 * release_sock() in the worker.
> +	 */
>  	if (copied > 0) {
> -		mptcp_recv_skb(sk, &offset);
> -		mptcp_cleanup_rbuf(msk, copied);
> +		msk->read_copied += copied;

[Severity: Low]
Can msk->read_copied overflow here? It is a signed int, and nothing
resets it until mptcp_worker() runs mptcp_read_complete(). If more than
INT_MAX bytes are consumed through read_sock/splice before the worker
drains the counter, this addition wraps.

The commit message says:

  "To prevent integer overflow when read_copied wraps to negative values,
  mptcp_read_complete() only calls mptcp_cleanup_rbuf() when
  read_copied > 0."

That check runs on the consumer side, after the wrap has already
happened:

net/mptcp/protocol.c:mptcp_read_complete() {
	...
	mptcp_rcv_space_adjust(msk, read_copied);
	if (read_copied > 0)
		mptcp_cleanup_rbuf(msk, read_copied);
}

With a negative value, mptcp_rcv_space_adjust() returns early:

	if (copied <= 0)
		return;

and mptcp_cleanup_rbuf() is skipped. The autotune sample and the window
update for the whole batch are dropped without any warning. If the value
wraps past zero again, both functions get an arbitrary positive count.

Hitting this needs the worker to stay off the CPU for more than 2 GiB of
reads. That could be a starved system_wq kworker, or a splicer that keeps
winning lock_sock. Each read_sock call is limited by what is in the
receive queue, so the wrap only happens across many calls.
CONFIG_UBSAN_SIGNED_WRAP would also report the wrap.

Would a u64 accumulator, or saturating before the add, avoid the wrap?
The commit message would then need updating, since the read_copied > 0
check does not prevent the overflow.

> +		set_bit(MPTCP_WORK_READ_COMPLETE, &msk->flags);
> +		mptcp_schedule_work(sk);
>  	}
>  out:
>  	return copied;

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1792718041.git.tanggeliang%40kylinos.cn
