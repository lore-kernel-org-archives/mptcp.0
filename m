Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793498531;
	b=jccY52FO4Os3pa0khn9BkqNf2Z3j8LdCycG2/Hv2+15YFbHU5CtnVYx7rFmYjwL1Pzhk
	 pUqWcALYg/E0j+SvLQraRp9nJ8JqdRVYCNmR+7x8amH9+1msgaxNP90+u/ZhuM4Y2Nv4E
	 9ziEjEKWnTrg0re9O4ZsxbpVs+qHkUR1xkdfcALnNkWGkFy9kUmUQCmyrcLammb/T7tOR
	 wtOEAiL65EPJ1+lOYKyZbVCFM7f6xO53lGDpJFPq3cYsPXCCFBijnPVFcOPXulVSPXUnV
	 RG5Ri72ardRF7D/oBsnFQtP++s/S2ONSJxeFQ70T/VPeo0AmlZdbXq5zc7cLcjqRoVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793498531;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=MQaAiaaHLmMJmmF4JoLk4Q+Og5iELM1/YKmJaPzIOYk=;
	b=V9qRags4R1aExKA47FdvHE36YcOZH9MyK0aa+4qIvxaLrSSspIzaObU5TKrIxsfSnd+A
	 oTVKmgRJdae10X68xlanqg+TP3hZJYwMi1UukqmoDu//LX13VQcCY/SNZGQrwYpfurqR0
	 OoyFPYKXK8/WgQ7kNxjo6qDhLGz5SX24557IXroSHRxWadXjbSGlE42b0cOd/LozBhDJZ
	 sv01Nw5q/7Q3Poaygkm41dNJSiRvDSnMIyt3KAXRJkABCxkQWgZo0/GrOn8GVjUvLtXg6
	 yryMAfC+UQSmk0D03rZGPMuAZ42g2rRX2wzZtS7x2bgF0y43GTTFLQ9Z8Bgjrwui52w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WLtPz2iq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88EBE606A324
	for <mptcp@lists.linux.dev>; Sun,  1 Nov 2026 02:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WLtPz2iq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 223801F00919;
	Sun,  1 Nov 2026 02:02:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793498531;
	bh=MQaAiaaHLmMJmmF4JoLk4Q+Og5iELM1/YKmJaPzIOYk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=WLtPz2iqSUQb/7i+xdHsbf7HqcPrLMTjPeMLPCkiLQdnWrBoemEZVwHPHULwxlMZO
	 O0htMvbaR1Ikm1FGTNWVOYLULwfJL8OwzoYY1tkD72kv9rB6qrvbHlFQf8B9feyUdi
	 boPAIxSoxYQ4bnyGYi4ZzApKofYX53p3ww3T7w+WifMW1QNFQ+u+UeunoYM0Fp8P/z
	 xodLLOWWrB89daITWTgAE+1mhaQ2TqCjNgZUvEiyc/v1uf7x9x3tVCQ0rucONk4jIa
	 dsg1QL5G7pnGtjABE1HVK8Qw7WnGF3/awcQhROhbR9JBIn86qNbv2eb2hmz7pU8dfh
	 +cDAQRrd7CLvg==
Subject:
 Re: [PATCH mptcp-next v19 5/5] mptcp: defer read_sock cleanup to mptcp_worker
From: netdev-bot+sashiko@kernel.org
To: geliang@kernel.org
Cc: mptcp@lists.linux.dev, tanggeliang@kylinos.cn, pabeni@redhat.com,
 kuba@kernel.org
Date: Sun, 01 Nov 2026 02:02:10 +0000
Message-ID: <179349853067.3128.9608032801084641620@kernel.org>
In-Reply-To: =?utf-8?q?=3C90a300d74f44443759ebe14be70c07385267db5b=2E1793361?=
 =?utf-8?q?629=2Egit=2Etanggeliang=40kylinos=2Ecn=3E?=
References: =?utf-8?q?=3C90a300d74f44443759ebe14be70c07385267db5b=2E17933616?=
 =?utf-8?q?29=2Egit=2Etanggeliang=40kylinos=2Ecn=3E?=
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

Critical: 0 · High: 0 · Medium: 2 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The commit message presents the patch as a fix for a BH-
  context call path that does not exist in this tree.
- [Medium] __mptcp_read_sock() now always defers mptcp_rcv_space_adjust()
  and mptcp_cleanup_rbuf() to mptcp_worker(), including for callers that…
- [Low] The commit author is 'Geliang Tang <geliang@kernel.org>' but the
  only Signed-off-by is 'Geliang Tang <tanggeliang@kylinos.cn>'.
- [Low] The patch removes msk_owned_by_me(msk) from __mptcp_read_sock(),
  saying the "BH caller does not own the msk lock".

--

mptcp: defer read_sock cleanup to mptcp_worker

This patch moves the mptcp_rcv_space_adjust() and mptcp_cleanup_rbuf()
calls out of __mptcp_read_sock() and into mptcp_worker(). The consumed byte
count is accumulated in a new msk->read_copied field and signalled through
a new MPTCP_WORK_READ_COMPLETE bit. It also drops the backlog flush from
mptcp_recv_skb(), the msk_owned_by_me() assertion, and the post-loop
mptcp_recv_skb() call in __mptcp_read_sock().

> When MPTCP carries TLS, __mptcp_read_sock() is reached from BH context
> (via tls_strp_read_copyin() -> sk->sk_read_sock()), where calling
> mptcp_rcv_space_adjust() and mptcp_cleanup_rbuf() is not safe as both
> expect process context.

[Severity: Medium]
Can this call chain be reached in this tree?

tls_strp_read_copyin() calls tcp_read_sock() directly. It does not go
through sk->sk_read_sock():

net/tls/tls_strp.c:tls_strp_read_copyin() {
    ...
	tcp_read_sock(strp->sk, &desc, tls_strp_copyin);
    ...
}

Nothing under net/ seems to reference sk->sk_read_sock. The TLS strparser
also uses tcp_inq() and tcp_recv_skb(), so it looks TCP-specific.

The TLS ULP can't be attached to an MPTCP socket either, because
mptcp_setsockopt_sol_tcp() rejects it:

net/mptcp/sockopt.c:mptcp_setsockopt_sol_tcp() {
    ...
	case TCP_ULP:
		return -EOPNOTSUPP;
    ...
}

The only caller of __mptcp_read_sock() is mptcp_read_sock(). That is
reached through proto_ops.read_sock and mptcp_splice_read(), and both run
in process context with lock_sock() held.

If this is groundwork for a pending MPTCP-over-TLS series, could the commit
message say so?

Could it also describe what changes for the existing callers? Those
changes are the deferred window update and autotuning, the dropped backlog
drain in the read path, and the removed lockdep assertion.

> Suggested-by: Paolo Abeni <pabeni@redhat.com>
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>

[Severity: Low]
This isn't a bug, but the author address is geliang@kernel.org and the only
Signed-off-by uses tanggeliang@kylinos.cn. checkpatch reports this as a
From:/Signed-off-by: email mismatch.

The neighbouring commits in this series ("mptcp: sync mptcp skb cb layout
with tcp one" and "mptcp: remove CB offset field") use geliang@kernel.org
in the Signed-off-by. Was this an oversight?

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 3ff07b9de08c0..13078f2f3c498 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c

[ ... ]

> @@ -4646,6 +4663,7 @@ static struct sk_buff *mptcp_recv_skb(struct sock *sk, u32 *off)
>  /*
>   * Note:
>   *	- It is assumed that the socket was locked by the caller.
> + *	- Can be invoked in BH scope.
>   */
>  static int __mptcp_read_sock(struct sock *sk, read_descriptor_t *desc,
>  			     sk_read_actor_t recv_actor, bool noack)
> @@ -4655,8 +4673,6 @@ static int __mptcp_read_sock(struct sock *sk, read_descriptor_t *desc,
>  	int copied = 0;
>  	u32 offset;
>  
> -	msk_owned_by_me(msk);
> -

[Severity: Low]
The commit message says the assertion is dropped because the "BH caller
does not own the msk lock". Would the assertion actually fire for that
caller?

msk_owned_by_me() ends up in sock_owned_by_me(), which checks
lockdep_sock_is_held():

include/net/sock.h:lockdep_sock_is_held() {
	return lockdep_is_held(&sk->sk_lock) ||
	       lockdep_is_held(&sk->sk_lock.slock);
}

A BH caller reached through sk->sk_data_ready() would hold the msk slock.
mptcp_data_ready() takes mptcp_data_lock(), which is spin_lock_bh() on
sk->sk_lock.slock, before it calls sk_data_ready(). tls_strp_data_ready()
also notes that it runs under bh_lock_sock.

With the assertion removed, nothing checks the locking in a function that
modifies sk_receive_queue, copied_seq, bytes_consumed, the rmem accounting
and read_copied. The comment above still only says the socket "was locked
by the caller", without saying which lock.

Could the assertion stay, or be replaced with something like
DEBUG_NET_WARN_ON_ONCE(!lockdep_sock_is_held(sk)), so both kinds of caller
are still checked?

>  	if (sk->sk_state == TCP_LISTEN)
>  		return -ENOTCONN;
>  	while ((skb = mptcp_recv_skb(sk, &offset)) != NULL) {
> @@ -4687,11 +4703,14 @@ static int __mptcp_read_sock(struct sock *sk, read_descriptor_t *desc,
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
> +		set_bit(MPTCP_WORK_READ_COMPLETE, &msk->flags);
> +		mptcp_schedule_work(sk);
>  	}
>  out:
>  	return copied;

[Severity: Medium]
Does this delay the window update for the existing process-context
callers?

In this tree those callers already own the msk lock, for example:

mptcp_splice_read()
  lock_sock(sk)
  __mptcp_splice_read()
    mptcp_read_sock()
      __mptcp_read_sock()

Before this patch, mptcp_cleanup_rbuf(msk, copied) ran inline. Its path
through mptcp_subflow_cleanup_rbuf() -> tcp_cleanup_rbuf() is what sends
the window-opening ACK.

Now every read that consumes data does sock_hold() plus schedule_work().
It then needs a full mptcp_worker() pass (lock_sock(), the PM worker, the
data-fin checks, release_sock()) just to run these two calls.

mptcp_splice_read() holds the msk lock across its loop and takes it again
right after each release_sock(sk)/lock_sock(sk). The worker usually can't
get the lock until the splice call returns or blocks in sk_wait_data().
The autotuning in mptcp_rcv_space_adjust() is delayed in the same way.

mptcp_release_cb() doesn't seem to cover this, because it passes
copied == 0:

net/mptcp/protocol.c:mptcp_release_cb() {
    ...
			/* notify ack seq update */
			mptcp_cleanup_rbuf(msk, 0);
    ...
}

With copied == 0, both the cleanup and rx_empty conditions in
mptcp_cleanup_rbuf() are false.

The order of operations changes too. mptcp_read_complete() runs inside
mptcp_worker(), before release_sock() spools msk->backlog_list. The old
code moved the backlog first, through the post-loop mptcp_recv_skb() ->
mptcp_move_skbs() call.

Would it work to defer only when the caller doesn't own the msk, and keep
the inline calls for process-context callers?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1793361629.git.tanggeliang%40kylinos.cn
