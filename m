Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD0B495515
	for <mptcp@lists.linux.dev>; Thu,  1 Oct 2026 21:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790889133; cv=none; b=hxPOM1W2WtpJ/aifkD97djQBLg1svyLDy+4dOM6gweWVw7bI9LJFLfABDdz+ilG9NQDNOZ45TF6ulYmOHUZjUlPzre6H6/+RZrD0IN9+0AQYUaGLbAoIUjLEHJIGKpRugm8CaL41gwEpPsTNcSDP+Juk8YAHVv7N51UJpZstiuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790889133; c=relaxed/simple;
	bh=FTOctffQ7z/+XaSstjzKXOZ/v4A7YakNT1mjIbdU9tM=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Bt4/nkngazKRmYlA5rfb2MAEIpaWO2kFH7s4v9ssct6/WdJTaTeiyFpo21L+SBwLjJJSHRR+m0uvf4n5tuptvIgxCRHebw9N/MYKLwcJP51/V7q/NbgPxvZfIzWhBCdnagD5NKioYr/qc/FhVlRrPzyWTzdA700uFDsNRKAjzR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M5Uw5Ia/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M5Uw5Ia/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 906861F00893;
	Thu,  1 Oct 2026 21:12:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790889131;
	bh=kRyzBGx7mc3X5OrjxmcxpnmhC9Lkjp/5jYtNJjlkpUk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=M5Uw5Ia/EOHze6lnzInMGXWHHjR3qiy/lBP2RC17YYnzniPM3AycUkn2HAGxSuaZv
	 4MXaVybGQOM4v6Bo6WETELLFDqhg521BWQ9BEUcjVVOqHJtso0AAj6MMjmQnR731Xg
	 qJ4DKZxhZ5GUkW0oHIfj4KAgoh1jEqf89ipmRj2ecma4Mn13ZkA5bVBV5xDEr2ffe9
	 H7/RBTmaxjTBdQz1o4RR9qSp2V/IzkHQdnwwK07umXxZCI/ni+JskSh/i32yvO6aAS
	 4R9PndUDEDBUkjGIAJDvG+EZyc7vJpSJa9XK1Y4GOrWVErk4TwSS5TrkNNDYFD0gFX
	 jYXxuaXrpXRiw==
Subject: Re: [PATCH mptcp-next v14 06/11] mptcp: align FIN handling with TCP
 via SOCK_DONE
From: netdev-bot+sashiko@kernel.org
To: geliang@kernel.org
Cc:
 mptcp@lists.linux.dev, pabeni@redhat.com, yangang@kylinos.cn, kuba@kernel.org
Date: Thu, 01 Oct 2026 21:12:11 +0000
Message-ID: <179088913113.3135.12561434524857640069@kernel.org>
In-Reply-To: =?utf-8?q?=3C64ec5f3d886de8362ffea9c0cc173dd89487ef1d=2E1790734?=
 =?utf-8?q?083=2Egit=2Etanggeliang=40kylinos=2Ecn=3E?=
References: =?utf-8?q?=3C64ec5f3d886de8362ffea9c0cc173dd89487ef1d=2E17907340?=
 =?utf-8?q?83=2Egit=2Etanggeliang=40kylinos=2Ecn=3E?=
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 3 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The commit message describes a bug that cannot happen at this
  commit.
- [Medium] The new `if (!hint_val && sock_done) return 1;` branch in
  mptcp_inq_hint() can never be taken, so the claimed TCP-style FIN…
- [Medium] The new `if (sock_flag(sk, SOCK_DONE)) break;` in the
  copied==0 branch of mptcp_recvmsg() runs before the sk_err check.
- [Low] The new smp_mb() in mptcp_check_data_fin() and the smp_rmb() in
  mptcp_inq_hint() (commented "Pair with smp_mb() in…

--

mptcp: align FIN handling with TCP via SOCK_DONE

This patch sets SOCK_DONE in mptcp_check_data_fin() when a DATA_FIN is
accounted. It tests the flag in mptcp_inq_hint() and mptcp_recvmsg(), and
clears it in mptcp_disconnect(). It also replaces smp_mb__before_atomic()
with smp_mb() in mptcp_check_data_fin() and adds a paired smp_rmb() in
mptcp_inq_hint().

> TCP uses SOCK_DONE to mark FIN reception because RCV_SHUTDOWN alone is
> ambiguous: it is also set by RST (via SHUTDOWN_MASK) without an ack_seq
> increment. mptcp_inq_hint() used the latter as a proxy for "FIN pending",
> causing over-count and potentially returning 0 to peek_len() on a
> RST-while-data-queued socket, hanging TLS/BPF strparser consumers.

[Severity: Medium]
Can this hang actually happen at this commit?

MPTCP does not have a .peek_len in its proto_ops yet. The only providers
are tcp_peek_len() in af_inet.c and af_inet6.c. Strparser reaches the
socket only through strp_peek_len():

    return sock->ops->peek_len(sock);

TLS also cannot be attached to an MPTCP socket, because
mptcp_setsockopt_sol_tcp() rejects TCP_ULP:

    case TCP_ULP:
        return -EOPNOTSUPP;

That is still the case at the end of the series.

The removed check also only ran when hint_val was 0:

    if (!hint_val &&
        (sk->sk_state == TCP_CLOSE || (sk->sk_shutdown & RCV_SHUTDOWN)))
            return 1;

So the old mptcp_inq_hint() could not return 0 while data was queued.

Even in the follow-up "mptcp: implement peek_len for proto_ops", peek_len
calls the new mptcp_inq(), not mptcp_inq_hint(). The hang argument reads
more like a reason for that later helper.

The change users will actually see is not described. The current callers
of mptcp_inq_hint() are SIOCINQ in mptcp_ioctl(), the TCP_CM_INQ cmsg in
mptcp_recvmsg(), and mptcp_rcv_space_adjust(). For them, a socket that is
TCP_CLOSE, reset, or locally RCV_SHUTDOWN with nothing queued now reports
0 instead of 1.

Could the commit message describe that change instead?

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 58b48a8962ccf..7eafe904dbc65 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -741,7 +741,8 @@ static void mptcp_check_data_fin(struct sock *sk)
>  		WRITE_ONCE(msk->rcv_data_fin, 0);
>  
>  		WRITE_ONCE(sk->sk_shutdown, sk->sk_shutdown | RCV_SHUTDOWN);
> -		smp_mb__before_atomic(); /* SHUTDOWN must be visible first */
> +		smp_mb(); /* Order SHUTDOWN, ack_seq before SOCK_DONE. */
> +		sock_set_flag(sk, SOCK_DONE);

[Severity: Low]
Is there a lockless writer or reader for this barrier pair to order
against?

mptcp_check_data_fin() has only two callers:

  - mptcp_worker(), under lock_sock().
  - __mptcp_move_skbs(), which runs from mptcp_move_skbs() (in
    mptcp_recvmsg() and mptcp_ioctl(), both under lock_sock()) or from
    mptcp_release_cb() while the socket is still owned.

The BH path in move_skbs_to_msk() only schedules the worker:

    if (mptcp_pending_data_fin(sk, NULL))
        mptcp_schedule_work(sk);

The readers also run with the msk owned:

  - mptcp_inq_hint() is reached from mptcp_recvmsg(), mptcp_ioctl() and
    mptcp_rcv_space_adjust(), which asserts msk_owned_by_me().
  - The SOCK_DONE checks in mptcp_recvmsg() and mptcp_splice_read() run
    under lock_sock().

If socket ownership already serializes all of these, the smp_mb() and
smp_rmb() pair, and the LoongArch reordering argument in the commit
message, describe a race that cannot happen.

Would it be clearer to document that SOCK_DONE is protected by msk socket
ownership?

[ ... ]

> @@ -2405,8 +2406,12 @@ static bool mptcp_move_skbs(struct sock *sk)
>  static unsigned int mptcp_inq_hint(struct sock *sk)
>  {
>  	const struct mptcp_sock *msk = mptcp_sk(sk);
> +	bool sock_done = sock_flag(sk, SOCK_DONE);
>  	u64 hint_val;
>  
> +	/* Pair with smp_mb() in mptcp_check_data_fin(). */
> +	smp_rmb();
> +
>  	/* Avoid races vs ack_seq updates and MPTCP_SYNC_SEQ flag. */
>  	mptcp_data_lock(sk);
>  	if (test_bit(MPTCP_SYNC_SEQ, &msk->cb_flags)) {
> @@ -2419,8 +2424,7 @@ static unsigned int mptcp_inq_hint(struct sock *sk)
>  	if (hint_val >= INT_MAX)
>  		return INT_MAX;
>  
> -	if (!hint_val &&
> -	    (sk->sk_state == TCP_CLOSE || (sk->sk_shutdown & RCV_SHUTDOWN)))
> +	if (!hint_val && sock_done)
>  		return 1;

[Severity: Medium]
Can this branch ever be taken?

SOCK_DONE is set only in mptcp_check_data_fin(), right after the DATA_FIN
byte is added to ack_seq:

    WRITE_ONCE(msk->ack_seq, msk->ack_seq + 1);
    ...
    sock_set_flag(sk, SOCK_DONE);

Nothing moves msk->copied_seq past that byte. Every update adds payload
length (*seq += count in __mptcp_recvmsg_mskq(), msk->copied_seq += count
in __mptcp_read_sock()), adds the IASN once at setup, or resets it. So
whenever sock_done is true, hint_val = ack_seq - copied_seq is at least 1.

The tcp_inq_hint() idiom works because tcp_recvmsg() advances copied_seq
over the FIN. MPTCP never does that.

As a result, SIOCINQ/FIONREAD through mptcp_ioctl() reports N + 1 when N
payload bytes are queued after a DATA_FIN. Once the queue is drained and
read() returns 0, it still reports 1.

TCP's SIOCINQ uses tcp_inq(), which does:

    if (answ && sock_flag(sk, SOCK_DONE))
        answ--;

TCP therefore reports N, and then 0.

This is still the case at the end of the series. "mptcp: implement
peek_len for proto_ops" adds mptcp_inq() with the subtraction, but
mptcp_ioctl() still calls mptcp_inq_hint().

The selftest check in mptcp_inq.c passes because of the FIN byte in
ack_seq, not because of this branch:

    /* tcp_inq should be 1 due to received fin. */
    assert(tcp_inq == 1);

The test does not cover FIONREAD after a FIN, or a reset socket with an
empty queue.

Should the SIOCINQ path subtract the FIN byte when SOCK_DONE is set, as
tcp_inq() does?

> @@ -2492,6 +2496,9 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
>  			    !timeo)
>  				break;
>  		} else {
> +			if (sock_flag(sk, SOCK_DONE))
> +				break;
> +
>  			if (sk->sk_err) {
>  				copied = sock_error(sk);
>  				break;

[Severity: Medium]
Can this hide a pending ECONNRESET on a fallback connection?

The commit message says the check fires only on a real DATA_FIN. After a
TCP fallback, a RST can also end up setting SOCK_DONE.

Suppose the msk is owned by the user (for example inside recvmsg) and
peer data is already queued on msk->backlog_list. A RST on the subflow
then does:

subflow_state_change()
  subflow_error_report()
    /* msk owned, so the error report is deferred */
    __set_bit(MPTCP_ERROR_REPORT,  &mptcp_sk(sk)->cb_flags);
  subflow_sched_work_if_closed()
    /* subflow_is_done() is true for TCP_CLOSE after the RST */
    mptcp_update_rcv_data_fin(msk, subflow->map_seq +
                              subflow->map_data_len, true)

Later the backlog is spooled, either by mptcp_move_skbs() in
mptcp_recvmsg() or by mptcp_release_cb(). mptcp_release_cb() spools the
backlog before it handles MPTCP_ERROR_REPORT:

mptcp_release_cb()
  __mptcp_move_skbs()
    mptcp_check_data_fin()
      /* msk still TCP_ESTABLISHED, ack_seq matches the synthesized FIN */
      sock_set_flag(sk, SOCK_DONE);
  __mptcp_error_report()
    /* sets TCP_CLOSE and sk_err = ECONNRESET, SOCK_DONE stays set */

Once the application drains the payload, every later read() hits
SOCK_DONE before the sk_err check and returns 0 instead of -ECONNRESET.
The application sees a clean close rather than a reset.

Before this patch the sk_err check came first and the reset was reported.
Plain TCP also reports ECONNRESET here, because tcp_reset() never sets
SOCK_DONE.

Should SOCK_DONE be left unset when the DATA_FIN was synthesized from a
subflow reset?

This change also makes the existing SOCK_DONE check in
mptcp_splice_read() live. It could never fire before, because MPTCP never
set SOCK_DONE. Should the commit message mention that as well?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1790734083.git.tanggeliang%40kylinos.cn
