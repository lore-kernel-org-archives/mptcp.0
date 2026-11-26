Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795735789;
	b=DBMJO9t86fh0lG82QKGquOgX2A1B0sxmM7yiXGduV4AJho6CftfCVu741jSTzmH5bZx+
	 3bNoYFEZe2Tmv9PEoF4isX+aRdbZ8wr5DNyq357tFlWb+JI+hkUrEz6We1vT7HZk/UEtU
	 WREmcELNqVQF0Hv4+hqarVeOiobL/+OcCyaah2k2Iz9sGgOxEmd83mtOJ9aTi9HYMdWUA
	 NYckhrgqTM5ESelMv65avqvLBzrXDUTCeOiiDWlQICTu7aQP0zaEM4Xt4SUz84yvLsE19
	 M8fGGOEgPk6JUl5km/93cr4tGAj9H9dRGESpZ7PMa+syt0Mzhop5ngPiBiVwkxHX5vA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795735789;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=mRj7mzZy9jRNAx8CoPHsr3dUT7jyrOAs0hvMWwbw7ZM=;
	b=O6XtES/MezOMp6nm6WRAYNAixQJ/dyCjrRvhAAqFD353eix8Q1u2LgSYZWhEe/2b3XV1
	 d2o8L+DguFjs0QQuto0w+6u2ktqvfr5w4qaL1ophvUo8uAsWkfMTueohAB0G0D1XQI6G0
	 PY3FP75Oh1NjZLCW/xgC4Be6ghnj+rumoy9KNcCz5KU7I+yLnIm78PQ1R/DJ1sZ0raxtr
	 FaOz5MmM2mFmF+icINdKcMJiGZE2OKYHYAsqwidp3jzYPSOdLF1JeY1tHFuj1ubgkaIUs
	 iWqX9DSP2A2g9Qt1lo4f0Cng6rTWP3swjQXKIxUs6KVq9VgTwhgLkCYUWXAR6Mp7b5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UBkAUiGv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21107606A31C
	for <mptcp@lists.linux.dev>; Thu, 26 Nov 2026 23:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UBkAUiGv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43C371F0089C;
	Thu, 26 Nov 2026 23:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795735788;
	bh=mRj7mzZy9jRNAx8CoPHsr3dUT7jyrOAs0hvMWwbw7ZM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=UBkAUiGviWYayavn87wtD5PNkwOl2JwwCe+iFOZnXfKNMF4pQ9bJky2mBTZRNWrlT
	 Ss//gbM/T3xF+uVewTtKvDjrInRhAFmnAMuq947HxEqPTYfD+eGZQSjBjLPhf2f0Ce
	 OpIH4H/tCKPCFgFV08p1Od1mDn0ikl0PJh7wP8FBxS6NW0R5g3Xjrk94ppOXoOG9VW
	 e4gmqQ7DuCzx0zn2+biHGI071kE2W26XUBhce7ZDSeEbX/tJEW7vsdVWqafpoRzzJ0
	 imm650Ed3MOvdWO4doCswghxnleoOMKRpCU4dQwrnGXkoMh5PuYUKJsJMVkRIQVOZW
	 IHOzPpIeCjauA==
Subject:
 Re: [PATCH mptcp-net v3 12/50] mptcp: no sf left: process pending DATA_FIN
From: netdev-bot+sashiko@kernel.org
To: matttbe@kernel.org
Cc: mptcp@lists.linux.dev, kuba@kernel.org
Date: Thu, 26 Nov 2026 23:29:47 +0000
Message-ID: <179573578786.3133.16425345231871953312@kernel.org>
In-Reply-To: <20261124-mptcp-cmason-fixes-v3-12-416c0920c73f@kernel.org>
References: <20261124-mptcp-cmason-fixes-v3-12-416c0920c73f@kernel.org>
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

- [Medium] mptcp: pending DATA_FIN skipped for TCP_ESTABLISHED in
  __mptcp_close_ssk()
- [Low] The commit message's evidence does not test what this commit
  changes.

--

mptcp: no sf left: process pending DATA_FIN

This adds mptcp_check_rcv_close(). When the last subflow is closed, the
helper spools the MPTCP-level backlog and processes a pending DATA_FIN,
and a pending MP_FASTCLOSE, before __mptcp_close_ssk() moves the msk to
TCP_CLOSE. Without it, RCV_SHUTDOWN is never set if the DATA_FIN was
still waiting behind data in the backlog.

> This issue was causing the "Infinite map" subtest from mptcp_join.sh to
> be flaky: the server only got EPOLLHUP after having received all the
> data, and spun until the timeout:

[ ... ]

> The same issue was causing the 'peek mode' and 'full disconnect'
> subtests from mptcp_connect.sh to be flaky, in the MPTCP to TCP cases,
> so after a fallback at the connection: the client never got the end of
> file:

[ ... ]

> The root cause has been confirmed with a debug patch keeping the worker
> in FIN_WAIT2 after a fallback, until the subflow is closed: the same
> failures have been seen in the "Infinite map" subtest, and in the 'peek
> mode' and 'full disconnect' parts of mptcp_connect.sh, with the socket
> closed before the DATA_FIN:

[ ... ]

> To fix this, spool the backlog and process the pending DATA_FIN before
> the close, if the socket is still in use. This is done in a new helper,
> mptcp_check_rcv_close(), also processing a pending MP_FASTCLOSE: the
> next commit uses it at accept() time too. With the same debug patch,
> these subtests no longer failed.

[Severity: Low]
Do these reproducers actually run the code this commit adds? Every one
of them is a fallback case.

For fallback, the earlier commit in this series, "mptcp: return EOF after
a DATA_FIN, as TCP does", already does the same spool and check in
mptcp_close_ssk(), just before it calls __mptcp_close_ssk():

net/mptcp/protocol.c:mptcp_close_ssk() {
    ...
	if (ssk == msk->first && __mptcp_check_fallback(msk) &&
	    READ_ONCE(msk->rcv_data_fin) && !sock_flag(sk, SOCK_DEAD)) {
		mptcp_move_skbs(sk);
		mptcp_check_data_fin(sk);
	}

	__mptcp_close_ssk(sk, ssk, subflow, MPTCP_CF_PUSH);
    ...
}

At that point the msk is still in FIN_WAIT1 or FIN_WAIT2. If the
DATA_FIN can be processed, mptcp_check_data_fin() clears rcv_data_fin.
The new mptcp_check_rcv_close() call in __mptcp_close_ssk() then reads
rcv_data_fin as false and skips its own spool and check.

If the first attempt cannot process the DATA_FIN, nothing that happens
before the second attempt changes that. No new data reaches the msk, so
the same mptcp_move_skbs() + mptcp_check_data_fin() sequence gives the
same result.

After a fallback, msk->first is the only subflow. The other direct
callers of __mptcp_close_ssk() don't reach this branch with a pending
DATA_FIN in a state where it could be processed. Those callers are the
close-timeout path in mptcp_worker(), which runs after
mptcp_do_fastclose(), and mptcp_destroy_common().

So in this series, the DATA_FIN part of the new helper seems to change
behaviour only for non-fallback MPTCP connections. One example is
FIN_WAIT2 after shutdown(SHUT_WR), with data and the DATA_FIN still in
the msk backlog when the last subflow is removed by a reset or by the PM.

Could the commit message describe that non-fallback case instead? Could
it also explain why mptcp_close_ssk() and mptcp_check_rcv_close() both
do the same spool and DATA_FIN check?

The v2 note after the --- line mentions the earlier commit, but that note
won't be kept in the git history. As written, "With the same debug
patch, these subtests no longer failed" gives this commit credit for
fixes the earlier commit already made.

[ ... ]

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -2819,9 +2831,7 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
>  			mptcp_schedule_work(sk);
>  		} else if (sk->sk_state != TCP_ESTABLISHED ||
>  			   msk->in_accept_queue) {
> -			/* After the close, an MP_FASTCLOSE would be ignored */
> -			mptcp_check_fastclose(msk);
> -
> +			mptcp_check_rcv_close(sk);
>  			mptcp_set_state(sk, TCP_CLOSE);
>  			WRITE_ONCE(sk->sk_shutdown,
>  				   sk->sk_shutdown | SEND_SHUTDOWN);
>

[Severity: Medium]
Does this still miss the DATA_FIN when the last subflow goes away
while the msk is in TCP_ESTABLISHED?

mptcp_check_rcv_close() is only called from the branch taken when
sk->sk_state != TCP_ESTABLISHED. But a DATA_FIN stuck behind data in
msk->backlog_list is exactly what keeps the msk in TCP_ESTABLISHED
instead of moving it to TCP_CLOSE_WAIT.

Take a non-fallback msk in TCP_ESTABLISHED that is not in the accept
queue and not orphaned. The peer sends its last data and the DATA_FIN
while mptcp_worker() owns the msk. mptcp_data_ready() queues the data
on msk->backlog_list, so msk->ack_seq does not move. The last subflow
is then reset or removed by the PM:

mptcp_worker()
  mptcp_check_data_fin(sk)
    ack_seq < rcv_data_fin_seq, state stays TCP_ESTABLISHED
  __mptcp_close_subflow(sk)
    mptcp_close_ssk()
      no spool here, this is not a fallback socket
      __mptcp_close_ssk()
        sk_state == TCP_ESTABLISHED
        mptcp_start_tout_timer(sk)
release_sock(sk)
  mptcp_release_cb()
    spools msk->backlog_list
    mptcp_check_data_fin(sk)
      TCP_ESTABLISHED -> TCP_CLOSE_WAIT

At that point the msk has no usable subflow left. It is in
TCP_CLOSE_WAIT without SEND_SHUTDOWN. Nothing re-evaluates the "all
subflows closed" condition, because only __mptcp_close_ssk() does
that. The msk is closed only when the close timeout fires, 60 seconds
later by default.

Now suppose the same data had arrived while the msk was not owned.
The DATA_FIN would have been processed first, so __mptcp_close_ssk()
would have seen TCP_CLOSE_WAIT. The msk would then have been moved to
TCP_CLOSE and woken up right away. So the outcome depends on whether
the worker happened to own the socket. That is the same kind of
timing dependency this commit is trying to remove.

Should the DATA_FIN part of mptcp_check_rcv_close() run before the
sk->sk_state test? Then the choice between closing the msk and
starting the timeout would be made on the state after the DATA_FIN
has been processed. Or is staying in TCP_CLOSE_WAIT until the timeout
intended here? If so, could the commit message say so?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261124-mptcp-cmason-fixes-v3-0-416c0920c73f%40kernel.org
