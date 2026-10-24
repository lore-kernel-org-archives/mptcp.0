Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792859172;
	b=rXyX9V7YS+nw46J3TIEFQmtGU1FGSMP48mEY0nEc+hRokihNqD5ENhtvx5x+Oe5JujaZ
	 Ghvqtwo/P/EGkp8z6w8Rxrc9/we8lqboanM5gdLjKlyvQ+dbVT/ydoO93la9GrVD+b+CJ
	 nPz6DSh82gwcWvpTPYWFjA9QK16G3rk6nnhu/KG7CEvEjEZiufMpHq9TjqTGVhXa6Wbcy
	 uHSpRBjxVyUM28OYp3NGfHaLS4mHdquHR19K3SKiABQvXT/5jKty/3yBhTruXEyoVAaSO
	 /aKBGwNCvWDqn3zRyR2fw3opt74TwKsnJ7DxBldytL1MBl+Qry6aygTtnMzcH0k+4WQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792859172;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=GmE7IW2f7VRno/63uFBPBK91mzyJ+97FbMRbLqJK62E=;
	b=5jOweYOhM3Xitcmh5qx7Oq6p1jfpPFtRllNWclXBZGOhS7dU/t1BtmpwMj5RLEUdznmF
	 XTe0MrcYMAuXtRvmwuclNACQfCsJw+JDS1UX+nyjOHtVsfJ8OAwZROFEX3nJ51ywneQSl
	 sACDbouyDLBtlHL6NwohkDWKNbDDw2MqG3RrtfQ1WRUaKifaEvtw6OcSgn7du+22DtkVe
	 R3YC+pzwgw6eZ+ldCRoZ5WbKxRT8RBoIFR4DwxztfCc/R4u9A2WVxZHq1TlWMhP0fdQaJ
	 Sfmpi5F2oO6YNrJB0d0MXEK8mkHEkceU4x0Ap5ecD3gRZ/mhKNEOUSwavy+mFTx/juw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FfbNdqH5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71943606A32A
	for <mptcp@lists.linux.dev>; Sat, 24 Oct 2026 16:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FfbNdqH5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE4C11F01828;
	Sat, 24 Oct 2026 16:26:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792859172;
	bh=GmE7IW2f7VRno/63uFBPBK91mzyJ+97FbMRbLqJK62E=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=FfbNdqH5+6s5zdMcGyhUasFJ6VL2fQXD7XaGXisfHWdVKxpJI41Q/Zu4rneGFiX83
	 ACyy0mB4YBjchglbU0UF24kJk6TC/NcGakJQkbJvX69Ajc9aAsPSiPUme+nlYalvPu
	 Mi6vAx1Qtm2A1B8TMvlQqdBaErsSvqSQYdjjNyhobQ0vABuEw3Ub3YeDq4mRTx0uh5
	 3YxgyYhZdVjROJ54D77kGIAu0bLxXT1569bc6dRdZbpFqnzNTQm0L79E3pm3ItIZjI
	 gFv6pGooI82xizTWctbJ6Ey8krJpe1bWAAeCO03V8+hBtHsJHUFrIIw5L7RcTBTb0V
	 vZsd+PxKixJJQ==
Subject: Re: [PATCH mptcp-next v15 06/11] mptcp: align FIN handling with TCP
 via SOCK_DONE
From: netdev-bot+sashiko@kernel.org
To: geliang@kernel.org
Cc: mptcp@lists.linux.dev, yangang@kylinos.cn, kuba@kernel.org
Date: Sat, 24 Oct 2026 16:26:11 +0000
Message-ID: <179285917135.3132.10302020302118747272@kernel.org>
In-Reply-To: =?utf-8?q?=3C920d36c7943127f886900b7cdd7404e9b2acab85=2E1792718?=
 =?utf-8?q?041=2Egit=2Etanggeliang=40kylinos=2Ecn=3E?=
References: =?utf-8?q?=3C920d36c7943127f886900b7cdd7404e9b2acab85=2E17927180?=
 =?utf-8?q?41=2Egit=2Etanggeliang=40kylinos=2Ecn=3E?=
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

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 1 · Low: 2 (1)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] On fallback (plain-TCP) MPTCP connections, a peer RST can now be
  reported to the application as a clean EOF instead of -ECONNRESET.
- [Medium] In mptcp_inq_hint(), the new `!hint_val && sock_flag(sk,
  SOCK_DONE)` condition (net/mptcp/protocol.c:2426-2428) can never be…
- [Low] mptcp_splice_read() (net/mptcp/protocol.c:4797) already had a
  `sock_flag(sk, SOCK_DONE)` check, added by commit 22f3bd9bf8e850.
- [Low] The From: address and the author's Signed-off-by address do not
  match.

Pre-existing issues:
- [Low] Baseline decision: not a valid finding; kept only because
  requires_validation=true.

--

mptcp: align FIN handling with TCP via SOCK_DONE

This patch sets SOCK_DONE on the msk when mptcp_check_data_fin() processes
a DATA_FIN, and clears it again in mptcp_disconnect(). It also changes
mptcp_inq_hint() to check SOCK_DONE instead of TCP_CLOSE/RCV_SHUTDOWN, and
makes mptcp_recvmsg() check SOCK_DONE before sock_error().

> Co-developed-by: Zqiang <qiang.zhang@linux.dev>
> Signed-off-by: Zqiang <qiang.zhang@linux.dev>
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>

[Severity: Low]

This isn't a bug, but the author is Geliang Tang <geliang@kernel.org> and
the author sign-off uses tanggeliang@kylinos.cn. checkpatch reports this as
FROM_SIGN_OFF_MISMATCH.

Could the From: and Signed-off-by: addresses be made to match? Several
other patches from Geliang in this series (peek_len, sendmsg_locked,
app-limited, selftest) have the same mismatch.

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 3c3ad8991799a..7b0005d47bead 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -740,6 +740,7 @@ static void mptcp_check_data_fin(struct sock *sk)
>  
>  		WRITE_ONCE(sk->sk_shutdown, sk->sk_shutdown | RCV_SHUTDOWN);
>  		smp_mb__before_atomic(); /* SHUTDOWN must be visible first */
> +		sock_set_flag(sk, SOCK_DONE);

[Severity: High]

Can an RST on a fallback connection end up setting SOCK_DONE here?

When the fallback subflow gets an RST, tcp_done() moves the ssk to
TCP_CLOSE with SHUTDOWN_MASK. subflow_is_done() is also true for
TCP_CLOSE, so subflow_state_change()->subflow_sched_work_if_closed()
creates a dummy DATA_FIN even though no TCP FIN arrived:

net/mptcp/subflow.c:subflow_sched_work_if_closed() {
    ...
	if (__mptcp_check_fallback(msk) && subflow_is_done(ssk) &&
	    msk->first == ssk &&
	    mptcp_update_rcv_data_fin(msk, subflow->map_seq +
				      subflow->map_data_len, true))
		mptcp_schedule_work(sk);
}

If the user owns the msk at that point (a recvmsg() in progress, or the
worker running), subflow_error_report() only defers the error:

net/mptcp/subflow.c:subflow_error_report() {
    ...
	if (!sock_owned_by_user(sk))
		__mptcp_error_report(sk);
	else
		__set_bit(MPTCP_ERROR_REPORT,  &mptcp_sk(sk)->cb_flags);
    ...
}

The dummy DATA_FIN can then be consumed before the deferred error is
handled. For example, mptcp_release_cb() spools the backlog before it
checks MPTCP_ERROR_REPORT:

net/mptcp/protocol.c:mptcp_release_cb() {
    ...
		if (spool_bl && __mptcp_move_skbs(sk, &skbs, &moved)) {
    ...
		if (__test_and_clear_bit(MPTCP_ERROR_REPORT, &msk->cb_flags))
			__mptcp_error_report(sk);
    ...
}

It can also happen through
mptcp_recvmsg()->mptcp_move_skbs()->__mptcp_move_skbs()->mptcp_check_data_fin()
or mptcp_worker()->mptcp_check_data_fin().

In each of these paths the msk is still TCP_ESTABLISHED and ack_seq equals
rcv_data_fin_seq, so this sock_set_flag() runs. Later,
__mptcp_error_report() sets sk_err to ECONNRESET and moves the msk to
TCP_CLOSE, but it never clears SOCK_DONE.

After the receive queue drains, the new SOCK_DONE check in mptcp_recvmsg()
and the existing one in mptcp_splice_read() both break out before
sock_error(). Wouldn't every later read return 0, so the reset shows up as
a clean EOF instead of -ECONNRESET? Before this patch, sock_error() ran
first on this path and returned -ECONNRESET.

The commit message says SOCK_DONE is needed because RCV_SHUTDOWN "is also
set by RST", but in fallback mode an RST can still set SOCK_DONE. Should the
dummy DATA_FIN created by a reset be kept from setting SOCK_DONE?

This looks like it is still present at the end of the series, since
"mptcp: update mptcp_check_readable" doesn't change mptcp_check_data_fin(),
mptcp_recvmsg() or subflow_sched_work_if_closed().

>  
>  		switch (sk->sk_state) {
>  		case TCP_ESTABLISHED:
> @@ -2423,7 +2424,7 @@ static unsigned int mptcp_inq_hint(const struct sock *sk)
>  		return INT_MAX;
>  
>  	if (!hint_val &&
> -	    (sk->sk_state == TCP_CLOSE || (sk->sk_shutdown & RCV_SHUTDOWN)))
> +	    sock_flag(sk, SOCK_DONE))
>  		return 1;

[Severity: Medium]

Can this condition ever be true?

mptcp_check_data_fin() is the only place in net/mptcp that sets SOCK_DONE,
and the same block bumps ack_seq:

net/mptcp/protocol.c:mptcp_check_data_fin() {
    ...
		WRITE_ONCE(msk->ack_seq, msk->ack_seq + 1);
    ...
		sock_set_flag(sk, SOCK_DONE);
    ...
}

copied_seq only advances by the payload bytes copied: *seq += count in
__mptcp_recvmsg_mskq() and msk->copied_seq += count in __mptcp_read_sock().
Nothing consumes the DATA_FIN sequence slot the way tcp_recvmsg_locked()
does with ++*seq at found_fin_ok.

The other copied_seq writes are setup-time resyncs: MPTCP_SYNC_SEQ (which
returns early in this function), the TFO dummy seq, and the fallback init.
mptcp_disconnect() resets ack_seq, copied_seq and SOCK_DONE together.

So whenever SOCK_DONE is set, hint_val = ack_seq - copied_seq is at least
1, and this branch is never taken.

The hunk does have one effect. The removed TCP_CLOSE / RCV_SHUTDOWN arm
used to return 1 without SOCK_DONE in these cases:

- after MP_FASTCLOSE (mptcp_check_fastclose() sets TCP_CLOSE and
  SHUTDOWN_MASK without touching ack_seq)
- after a local shutdown(SHUT_RD)
- after close
- on sockets that never connected

In these cases, with an empty receive queue, the TCP_CM_INQ cmsg from
mptcp_recvmsg() and SIOCINQ from mptcp_ioctl() now return 0 instead of 1.
mptcp_rcv_space_adjust() also sees a different value.

The new 0 matches tcp_inq_hint() for the reset case, but is this
user-visible change intended? Could the commit message describe it, given
that the new condition doesn't actually do what "mirroring tcp_inq_hint()"
suggests?

The tcp_inq == 1 checks in tools/testing/selftests/net/mptcp/mptcp_inq.c
pass from the ack_seq bump alone, so they don't exercise the new condition.

The later commit "mptcp: implement peek_len for proto_ops" also describes
mptcp_inq_hint() as returning 1 "when the calculated value is 0 and
SOCK_DONE is set". As shown above, that case can't happen.

[Severity: Low]

This is a pre-existing issue and was not introduced by this patch, but
since this function is being aligned with TCP: mptcp_ioctl() returns
mptcp_inq_hint() for SIOCINQ. After a DATA_FIN, that value includes the +1
from ack_seq. An empty queue reports 1, and pending data reports one more
than the bytes actually queued.

TCP's SIOCINQ goes through tcp_inq(), which subtracts the FIN:

include/net/tcp.h:tcp_inq() {
    ...
		/* Subtract 1, if FIN was received */
		if (answ && sock_flag(sk, SOCK_DONE))
			answ--;
    ...
}

Should mptcp_ioctl() subtract the FIN in the same way?

The later commit "mptcp: implement peek_len for proto_ops" adds a separate
mptcp_inq() that does subtract it. However, mptcp_ioctl() still uses
mptcp_inq_hint() at the end of the series, and that commit describes the
inq_hint behaviour as intentional for ioctl/cmsg users.

>  
>  	return (unsigned int)hint_val;
> @@ -2495,6 +2496,9 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
>  			    !timeo)
>  				break;
>  		} else {
> +			if (sock_flag(sk, SOCK_DONE))
> +				break;
> +
>  			copied = sock_error(sk);
>  			if (copied)
>  				break;

[Severity: Low]

This also changes splice() behaviour, which the commit message doesn't
mention. mptcp_splice_read() already checks SOCK_DONE before sock_error();
the check was added by commit 22f3bd9bf8e850:

net/mptcp/protocol.c:mptcp_splice_read() {
    ...
			if (sock_flag(sk, SOCK_DONE))
				break;
			ret = sock_error(sk);
    ...
}

Before this patch nothing set SOCK_DONE on an msk (tcp_fin() only runs on
the TCP subflows), so that check never fired. With this patch it does.

When a DATA_FIN is followed by a reset (for example mptcp_check_fastclose()
setting sk_err to EPIPE or ECONNRESET), both splice() and recvmsg() now
return 0 instead of the error from sock_error().

This matches tcp_splice_read(). Could the commit message mention the
splice change and the errno change for recvmsg() and splice()?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1792718041.git.tanggeliang%40kylinos.cn
