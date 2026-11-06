Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794006431;
	b=5A3dz+2Z3jLn1jOpHhLKIzX5hdxsGAlUwXBmw+QPjo2SGuL65C2pBbGgqyhxX3wCeylT
	 pT5klBeAq1E0O/Zufj7eGookqlHPBLkO8KHJ2reKO5FLRFC7MNVnPtkmh1m2Fvz1DGEMI
	 C7eiQfWu4EtlCQpp82kfF7EsZxDoqhjOz7MJeI+qWZ/UrhjA2J2aHVA+gGKQW9ee+hRUB
	 Y/HTQ7+nR0A/38SOaD2F0kR+B411NOxW8K1ahlNlTrnVm/7Q07qO/Qns+PbkEh/o/staP
	 CqvMA4J1qKrzc3fH8I8WcPWRVjnJdFfOMFKiA3k6RaQ7NgtEACjG0r5PlWJ/COpjokg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794006431;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=+rksQewR1QsnHANHudLh1no3EUobJINGakx+FeD+vfE=;
	b=IsdK3aPDbFMs/r6wTZIa44lbBI95BOI85FjOLRaZprwMLr6sAU7hgocs1BxhwoiphuYJ
	 kfMykI8C9cyFZGLAvDQyBG4InGb6O9E7VPZVe0xBI6zbHdssuFhEzvtVzuiRHOB5/oz4A
	 7fWO/Rm7UsKsmLTZfFuh1LuF6TAwXQeXTrEfeF4ImMVtW1YBXDT0KE6a0DtXgKbIBMILU
	 XKb38XWo6R23FTvEWv3tiUNlw9+5lFl7puHP1WMprxZYCH+ldKPVLtajfk5A+o5bDEoB1
	 Hpk2+9vF4nTuI2cC9ldq8jwbvxDHI6q2+Knssdn4mmIOVkJN8WYg7AcXh6SO+Eyp7Mw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ECoQEmYw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FFA8606A331
	for <mptcp@lists.linux.dev>; Fri,  6 Nov 2026 23:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ECoQEmYw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE7AE1F0089F;
	Fri,  6 Nov 2026 23:07:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794006431;
	bh=+rksQewR1QsnHANHudLh1no3EUobJINGakx+FeD+vfE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ECoQEmYw68YewQBZRDqFOC/EjFmQHZUH96f9EqACT5hGxH9Yn+h/WPkEUp7lUOiCK
	 Z2ieAth9np4sQ8SMIKhddnPEepEOeKiSHX/KQR5m5nZIv7uNydTQU6OsrrYtuzvLo5
	 m1URDhsj9pEf+2IABFaJOQd8jxfldvx2q+linmbSP2s85EzHUHKBoPUR5lAo0CfHQE
	 3gGekSMv8xYx9H6UAGYHvxy6hUdtPjbDQOA42kHrFvGf2Pu7XXwxdUy9kCl9tbJSOD
	 hk1ehtrU87FKD18QXKwJOqZhrcdjKoepI+9QZowKEzmSDWW6jUU0JYuBTwlcI0hZrU
	 RcpNKKspvdOUw==
Subject:
 Re: [PATCH mptcp-next v21 9/9] mptcp: defer read_sock cleanup to mptcp_worker
From: netdev-bot+sashiko@kernel.org
To: geliang@kernel.org
Cc: mptcp@lists.linux.dev, tanggeliang@kylinos.cn, pabeni@redhat.com,
 kuba@kernel.org
Date: Fri, 06 Nov 2026 23:07:10 +0000
Message-ID: <179400643026.488855.15598246325824992026@kernel.org>
In-Reply-To: <4d7cdcdd8a8aaed326244a33324f86ab54ed1d11.1793870710.git.tanggeliang@kylinos.cn>
References: <4d7cdcdd8a8aaed326244a33324f86ab54ed1d11.1793870710.git.tanggeliang@kylinos.cn>
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

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The patch removes the backlog flush (`if
  (!list_empty(&msk->backlog_list)) mptcp_move_skbs(sk);`) from…
- [Low] Nothing in the tree as submitted can reach the new deferred-
  cleanup machinery: msk->read_copied, MPTCP_WORK_READ_COMPLETE,…
- [Low] The inline and deferred post-read cleanup sequences in
  net/mptcp/protocol.c now differ, and the extra step in the inline one…

--

mptcp: defer read_sock cleanup to mptcp_worker

This commit prepares __mptcp_read_sock() for a future BH caller. When the
socket is not owned by the user, it defers mptcp_rcv_space_adjust() and
mptcp_cleanup_rbuf() to mptcp_worker() and records the consumed bytes in
msk->read_copied. It also removes the backlog flush from mptcp_recv_skb().

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 705b28219883f..b15100a67672d 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c

[ ... ]

> @@ -4648,9 +4668,6 @@ static struct sk_buff *mptcp_recv_skb(struct sock *sk, u32 *off)
>  	struct sk_buff *skb;
>  	u32 offset;
>  
> -	if (!list_empty(&msk->backlog_list))
> -		mptcp_move_skbs(sk);
> -
>  	while ((skb = skb_peek(&sk->sk_receive_queue)) != NULL) {
>  		offset = (u32)msk->copied_seq - MPTCP_SKB_CB(skb)->map_seq;
>  		if (offset < skb->len) {

[Severity: Medium]
Does removing this flush change behaviour for the existing process context
callers?

The commit message says the flush is "covered by mptcp_release_cb()".
That only happens at release_sock() time, though. Both in-tree callers
hold lock_sock() for the whole read:

net/sunrpc/svcsock.c:svc_tcp_recvfrom() {
    ...
	lock_sock(sock->sk);
	len = sock->ops->read_sock(sock->sk, &desc, svc_tcp_recv_actor);
    ...
}

While the msk is owned, subflow data that arrives through
mptcp_data_ready() goes onto msk->backlog_list, not sk_receive_queue.

Before this patch, mptcp_recv_skb() moved that data into the receive
queue, and the read loop consumed it in the same call. Now the data stays
in the backlog until mptcp_release_cb() spools it and calls
sk_data_ready(), so the reader needs another pass.

For svc_tcp_recvfrom(), that can mean a partial record and another trip
through XPT_DATA.

Can a non-blocking mptcp_splice_read() with an empty receive queue now
return -EAGAIN while data is waiting in msk->backlog_list?

net/mptcp/protocol.c:mptcp_splice_read() {
    ...
			if (!timeo) {
				ret = -EAGAIN;
				break;
			}
    ...
}

mptcp_recvmsg() still flushes the backlog inside its loop:

net/mptcp/protocol.c:mptcp_recvmsg() {
    ...
		if (!list_empty(&msk->backlog_list) && mptcp_move_skbs(sk)) {
			if (flags & MSG_PEEK)
				peek_seq = msk->copied_seq + copied;
			continue;
		}
    ...
}

So recvmsg and read_sock now behave differently on the same socket.

Only the future BH caller needs the flush removed, because it would
already hold mptcp_data_lock(), which mptcp_move_skbs() takes. Could the
flush be kept for the sock_owned_by_user() case?

[ ... ]

> @@ -4706,11 +4724,18 @@ static int __mptcp_read_sock(struct sock *sk, read_descriptor_t *desc,
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
Now that the backlog flush is gone from mptcp_recv_skb(), can this call
ever eat an skb?

The read loop already calls mptcp_eat_recv_skb() on every fully consumed
skb. It only exits early when count <= 0 or count < data_len, and in both
cases the head skb still has offset < len. Otherwise, the queue is either
empty or the next skb starts at copied_seq.

sk_receive_queue cannot grow while the msk is owned, so this call looks
like a no-op.

The commit message says:

    The mptcp_recv_skb() call remains in the sock_owned_by_user() branch
    for inline cleanup.

mptcp_read_complete() leaves out this step, so the inline and deferred
cleanup sequences now differ. Should this call be dropped so the two
paths match?

> +			mptcp_cleanup_rbuf(msk, copied);
> +		} else {
> +			/* BH context: defer to worker */
> +			msk->read_copied += copied;
> +			set_bit(MPTCP_WORK_READ_COMPLETE, &msk->flags);
> +			mptcp_schedule_work(sk);

[Severity: Low]
Can anything in the tree reach this branch?

Every current caller of mptcp_read_sock() holds lock_sock(), so
sock_owned_by_user() is always true for them. Those callers are
mptcp_splice_read() and svc_tcp_recvfrom().

The other sock->ops->read_sock users never get an MPTCP socket:

  - KCM rejects sk_protocol != IPPROTO_TCP.
  - The sockmap strparser requires sk_is_tcp().
  - nvme-tcp only creates IPPROTO_TCP sockets.

That leaves msk->read_copied, MPTCP_WORK_READ_COMPLETE and
mptcp_read_complete() with no user, and nothing in the tree can exercise
them. Would it make sense to carry this patch in the TLS-over-MPTCP series
that adds the BH caller?

The commit message also names two functions that don't seem to exist:

    where it may be reached from BH context (via tls_strp_read_copyin() ->
    sk->sk_read_sock()).

There is no sk_read_sock in the tree. tls_strp_read_copyin() calls
tcp_read_sock() directly:

net/tls/tls_strp.c:tls_strp_read_copyin() {
    ...
	/* sk should be locked here, so okay to do read_sock */
	tcp_read_sock(strp->sk, &desc, tls_strp_copyin);
    ...
}

The second one is in this sentence:

    Currently, the only callers are mptcp_splice_read() and
    svc_tcp_read_msg()

There is no svc_tcp_read_msg() in net/sunrpc. Is svc_tcp_recvfrom() the
caller that was meant?

> +		}
>  	}
>  out:
>  	return copied;

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1793870710.git.tanggeliang%40kylinos.cn
