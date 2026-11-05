Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793839266;
	b=I8MfMd21YKhmrQu59Ys+wSNej1rUPGdO7WvzKmVzyJQhUSthJRwhotloS7ClLiSY6gY0
	 ZDucnYU/tVtl8C2DbqIxr2RTOhs0M5CnwPJNbTN/diZwp4pfaG640KjueyeqsnWtuK0y3
	 o8Qbgmbcz97GUWG3pi0dEbYxAirQEnJzoxIeebBCbDzXOldKQSRts1b4ZGMUoQBBNiCMG
	 +BT9GLbhJZfUk5iQy74BrxxHPMBmqA46HkmU9Ohid3pi7u1zEk94vRAImu+QyDZbcxv54
	 CRCB/pEdefmcOB3i8uTMQFP4HLfR73LxsBS2tl0TX3VmzBdDgjqYSlVYoy1hdTLGykg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793839266;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=whWxW3M8kjdADii1wJqe7FDbhCCVR0zfETJ7zEhGUrE=;
	b=rreE+pXVdd3XfLMs+CdsO8rio0cKSNsDBBIh389ml0kY3f7QMhrGov6eyTN0TchZeu2s
	 ie18fajbctxZhTgBZqsJC3ekhB5U68LhyGeV5t6Rr03OVVpC1M24bP/yACIkfqvfuVeDV
	 a83QOqymDDl/xDpkE0dhMVkp7uy3tgn6kXNDGP/bK2T5Mw7Ba0U2hiOrUHPv8Vv4YYkrK
	 VCfl3jls8X8cpAOaJADu71nPJRTxG0zmG1zR1608wkodfE4lr6Hc6fWMpwD2xkIraJMCi
	 GevoLUvgcoDRIpM4RPwhsJ+CGHZYpADU5WeHAWuh1AZqkrD6CBrHH0VWaHRRrXkgc9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fC+apUoo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF063606A326
	for <mptcp@lists.linux.dev>; Thu,  5 Nov 2026 00:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fC+apUoo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08D071F00A15;
	Thu,  5 Nov 2026 00:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793839265;
	bh=whWxW3M8kjdADii1wJqe7FDbhCCVR0zfETJ7zEhGUrE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=fC+apUooyhlLMne+KlbZp8VFWIuECcYH1xu5gkCkJOl8BZ7QteIFoau2Ae4oC/pmP
	 1Ij5oGCtQijBMmxJBmUUjWeuvMESJ3flyQ9j+ruxrmk4ghw9srMBJ15D1bbPm5r11A
	 JiXBtfWd/wotvMirjBguxotrGmn0SsxTrVEWt7DqcWrtaS+Y1d7xXDPk9UbrKb7NR4
	 Mll8sOrzlI+X5FLGhFvsbxj6jpvlk3FeHMirpgx0XT6E2YTGa9ObDfoNxoz7duyf9q
	 bzO2zR6zqGIcj4sG8bUMpBOlgx/7JwYWuEQ0yArYgL+y44vM8BvbCJCYnXlWrLVYw2
	 QNXIIk4oma5ag==
Subject:
 Re: [PATCH mptcp-next v20 6/6] mptcp: defer read_sock cleanup to mptcp_worker
From: netdev-bot+sashiko@kernel.org
To: geliang@kernel.org
Cc: mptcp@lists.linux.dev, tanggeliang@kylinos.cn, pabeni@redhat.com,
 kuba@kernel.org
Date: Thu, 05 Nov 2026 00:41:04 +0000
Message-ID: <179383926459.488855.719257474270349708@kernel.org>
In-Reply-To: <278ffcf759c109e3753112e62cb7c53b58159650.1793695518.git.tanggeliang@kylinos.cn>
References: <278ffcf759c109e3753112e62cb7c53b58159650.1793695518.git.tanggeliang@kylinos.cn>
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

Critical: 0 · High: 2 · Medium: 1 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] mptcp: broken mptcp_inq_hint() 32-bit map_seq subtraction and
  MSG_PEEK sync
- [High] mptcp: data corruption in mptcp_init_skb() when subtracting non-
  zero offset
- [Medium] The commit message and the new code describe a BH call path
  into __mptcp_read_sock() that does not exist in this tree.
- [Low] The commit message says the patch will 'drop the redundant
  mptcp_recv_skb() call after the main loop', but the call is still…
- [Low] The commit message gives the wrong reason for replacing
  msk_owned_by_me(msk) with…

--

mptcp: defer read_sock cleanup to mptcp_worker

This patch changes __mptcp_read_sock() so that, when the caller does not
own the socket lock, mptcp_rcv_space_adjust() and mptcp_cleanup_rbuf() are
deferred to mptcp_worker(). The commit message describes that case as the
BH context reached when MPTCP carries TLS. The patch also replaces the
msk_owned_by_me() assertion with a lockdep_sock_is_held() based
DEBUG_NET_WARN_ON_ONCE(), and removes the backlog flush from
mptcp_recv_skb().

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 3e10b06b7772d..25f0d10373d22 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c

[ ... ]

> @@ -4660,6 +4677,7 @@ static struct sk_buff *mptcp_recv_skb(struct sock *sk, u32 *off)
>  /*
>   * Note:
>   *	- It is assumed that the socket was locked by the caller.
> + *	- Can be invoked in BH scope.
>   */
>  static int __mptcp_read_sock(struct sock *sk, read_descriptor_t *desc,
>  			     sk_read_actor_t recv_actor, bool noack)
> @@ -4669,7 +4687,7 @@ static int __mptcp_read_sock(struct sock *sk, read_descriptor_t *desc,
>  	int copied = 0;
>  	u32 offset;
>  
> -	msk_owned_by_me(msk);
> +	DEBUG_NET_WARN_ON_ONCE(!lockdep_sock_is_held(sk));

[Severity: Low]

Is the reason given in the commit message for this change accurate?

  Replace msk_owned_by_me() assertion with DEBUG_NET_WARN_ON_ONCE using
  lockdep_sock_is_held() to verify proper locking for both process and
  BH contexts.

msk_owned_by_me() wraps sock_owned_by_me(). Under CONFIG_LOCKDEP that
function is:

    WARN_ON_ONCE(!lockdep_sock_is_held(sk) && debug_locks);

lockdep_sock_is_held() returns true when either sk->sk_lock or
sk->sk_lock.slock is held. A BH caller holding bh_lock_sock() therefore
already passed the old check.

The new code also calls sock_owned_by_user(), which calls
sock_owned_by_me() itself. The same check still runs whenever
copied > 0.

The only real change is that the check at the top of the function now
also depends on CONFIG_DEBUG_NET. That reduces debug coverage slightly,
and the commit message doesn't mention it.

Could the commit message be corrected, or the original assertion kept?

>  
>  	if (sk->sk_state == TCP_LISTEN)
>  		return -ENOTCONN;
> @@ -4701,11 +4719,18 @@ static int __mptcp_read_sock(struct sock *sk, read_descriptor_t *desc,
>  	if (noack)
>  		goto out;
>  
> -	mptcp_rcv_space_adjust(msk, copied);
> -
>  	if (copied > 0) {
> -		mptcp_recv_skb(sk, &offset);
> -		mptcp_cleanup_rbuf(msk, copied);
> +		if (sock_owned_by_user(sk)) {
> +			/* Process context: inline cleanup */
> +			mptcp_rcv_space_adjust(msk, copied);
> +			mptcp_recv_skb(sk, &offset);

[Severity: Low]

The commit message says:

  ... and drop the redundant mptcp_recv_skb() call after the main loop.

This call is still present in the sock_owned_by_user() branch, which is
the path that actually runs. Only the new deferral branch leaves it out.
Was this call meant to be removed as well?

Now that the backlog flush is gone from mptcp_recv_skb(), this call does
almost nothing. The loop above already eats every fully consumed skb. It
exits with either an empty queue or a partially consumed skb at the head.

> +			mptcp_cleanup_rbuf(msk, copied);
> +		} else {
> +			/* BH context: defer to worker */
> +			msk->read_copied += copied;
> +			set_bit(MPTCP_WORK_READ_COMPLETE, &msk->flags);
> +			mptcp_schedule_work(sk);
> +		}

[Severity: Medium]

Can this else branch be reached in the current tree?

The commit message says:

  When MPTCP carries TLS, __mptcp_read_sock() may be reached from BH
  context (via tls_strp_read_copyin() -> sk->sk_read_sock()), ...

However, tls_strp_read_copyin() in net/tls/tls_strp.c calls
tcp_read_sock() directly:

    tcp_read_sock(strp->sk, &desc, tls_strp_copyin);

There also doesn't seem to be an sk_read_sock hook anywhere under
include/ or net/.

In addition, mptcp_setsockopt_sol_tcp() in net/mptcp/sockopt.c rejects
TCP_ULP:

    case TCP_ULP:
        return -EOPNOTSUPP;

So kTLS can't be attached to an MPTCP socket at this point.

Two callers can actually reach mptcp_read_sock(): mptcp_splice_read(),
and svc_tcp_read_msg() in net/sunrpc/svcsock.c. Both hold lock_sock():

    lock_sock(sock->sk);
    len = sock->ops->read_sock(sock->sk, &desc, svc_tcp_recv_actor);

The other generic ->read_sock() user that runs in BH is strparser, via
strp_data_ready(). Its KCM user only attaches IPPROTO_TCP sockets, as
checked in kcm_attach():

    if ((csk->sk_family != AF_INET && csk->sk_family != AF_INET6) ||
        csk->sk_protocol != IPPROTO_TCP) {

If that is right, sock_owned_by_user() is always true here. This branch,
MPTCP_WORK_READ_COMPLETE and mptcp_read_complete() would then be dead
code. The "not safe as both expect process context" problem described in
the commit message also can't be triggered today.

Is this groundwork for a TLS-over-MPTCP series that hasn't been merged
yet? If so, could the commit message say that and name the series, or
could the patch be carried as part of that series?

Nothing in the tree currently exercises the locking assumptions this
branch depends on (slock held, owned == 0).

>  	}
>  out:
>  	return copied;

[ ... ]

> @@ -3156,6 +3156,21 @@ static void mptcp_backlog_purge(struct sock *sk)
>  	sk_mem_reclaim(sk);
>  }
>  
> +static void mptcp_read_complete(struct sock *sk)
> +{
> +	struct mptcp_sock *msk = mptcp_sk(sk);
> +	int read_copied;
> +
> +	mptcp_data_lock(sk);
> +	read_copied = msk->read_copied;
> +	msk->read_copied = 0;
> +	mptcp_data_unlock(sk);
> +
> +	mptcp_rcv_space_adjust(msk, read_copied);
> +	if (read_copied > 0)
> +		mptcp_cleanup_rbuf(msk, read_copied);
> +}
> +
>  static void mptcp_do_fastclose(struct sock *sk)
>  {
>  	struct mptcp_subflow_context *subflow, *tmp;

[Severity: High]
This isn't introduced by this patch, but both the inline branch and
the new mptcp_read_complete() go through mptcp_rcv_space_adjust(),
which does:

    copied = msk->rcvq_space.copied;
    copied -= mptcp_inq_hint(sk);
    if (copied <= msk->rcvq_space.space)
        goto new_measure;

mptcp_inq_hint() still computes:

    u64 hint_val = READ_ONCE(msk->ack_seq) - MPTCP_SKB_CB(skb)->map_seq;

MPTCP_SKB_CB(skb)->map_seq is now a u32. It is zero-extended and
subtracted from the 64-bit msk->ack_seq. msk->ack_seq is derived from
the IASN, so its upper 32 bits are non-zero on almost every
connection. Whenever anything is left in sk->sk_receive_queue,
hint_val ends up >= INT_MAX and mptcp_inq_hint() returns INT_MAX.

Even with a zero upper half the result is wrong. map_seq is no longer
advanced on partial reads, and consumption is tracked in
msk->copied_seq instead. The hint therefore also counts bytes already
read from the head skb. The commit that removed the CB offset field
said mptcp_inq_hint() would compute ack_seq - copied_seq, but that
change doesn't seem to be in the tree.

As a result, copied goes negative in mptcp_rcv_space_adjust() and
mptcp_rcvbuf_grow() is skipped. Receive buffer autotuning silently
stops whenever a read leaves a partially consumed skb behind. SIOCINQ
and TCP_CM_INQ report the same bogus value to userspace.

There is a related MSG_PEEK problem in mptcp_recvmsg(). peek_seq is
only resynced when mptcp_move_skbs() returns true. On a passive TFO
connection, mptcp_move_skbs() can process MPTCP_SYNC_SEQ, which adds
msk->tfo_iasn to msk->copied_seq, and still return false if no new
data was enqueued. peek_seq is then left in the dummy sequence space
used before the IASN was known.

Should mptcp_inq_hint() be computing msk->ack_seq - msk->copied_seq
here? This probably wants its own patch with a Fixes: tag rather than
being folded into this series. Is someone already looking at it?

[ ... ]

> @@ -4643,9 +4663,6 @@ static struct sk_buff *mptcp_recv_skb(struct sock *sk, u32 *off)
>  	struct sk_buff *skb;
>  	u32 offset;
>  
> -	if (!list_empty(&msk->backlog_list))
> -		mptcp_move_skbs(sk);
> -
>  	while ((skb = skb_peek(&sk->sk_receive_queue)) != NULL) {
>  		offset = (u32)msk->copied_seq - MPTCP_SKB_CB(skb)->map_seq;
>  		if (offset < skb->len) {

[Severity: High]
This one is pre-existing rather than something this patch adds.
mptcp_recv_skb() relies on MPTCP_SKB_CB(skb)->map_seq to find the
read offset in the head skb. That value can be wrong for an skb whose
prefix was discarded on the subflow.

In subflow_check_data_avail(), a subflow skb can hold the tail of an
already acked DSS mapping followed by the start of a new mapping. In
that case mptcp_subflow_discard_data() advances tp->copied_seq past
the old bytes, clears subflow->map_valid, and leaves the skb at the
head of ssk->sk_receive_queue. The next iteration then installs the
new mapping starting at that offset inside the same skb.

__mptcp_move_skbs_from_subflow() then calls
mptcp_init_skb(ssk, skb, offset), which does:

    MPTCP_SKB_CB(skb)->map_seq64 =
        mptcp_subflow_get_mapped_dsn(subflow) - offset;

That assigns the DSN range [mapped_dsn - offset, mapped_dsn) to the
discarded prefix bytes. This is only right if the old and new mappings
are contiguous in DSN space. When data is striped across several
subflows, the new mapping can be out of order, so contiguity is not
guaranteed.

__mptcp_move_skb() then classifies the skb using the shifted
map_seq64:

  - If mapped_dsn - offset <= msk->ack_seq < mapped_dsn, the skb is
    treated as in-sequence or partial. It is queued on
    sk->sk_receive_queue, and msk->ack_seq jumps over the hole
    [msk->ack_seq, mapped_dsn). The reader then copies the stale
    prefix bytes to userspace instead of data that was never
    received.

  - If mapped_dsn - offset > msk->ack_seq, the skb goes into
    out_of_order_queue covering the wrong range. Valid segments for
    [mapped_dsn - offset, mapped_dsn) are dropped as duplicates, and
    the stale prefix is delivered later.

Either way the application gets the wrong bytes. The segment layout
that triggers this is under the peer's control.

Should the discarded prefix be trimmed off the skb (or the skb split)
before it is moved to the msk, instead of shifting map_seq64 back by
offset? This looks like it needs its own fix with a Fixes: tag.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1793695518.git.tanggeliang%40kylinos.cn
