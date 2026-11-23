Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795415546;
	b=3CM7Z2fAdxJ6rB16oawKs2fdKCemKH4sbuqebB3kGIWw2oj5xGSYdzG1ttedc0jXpTPo
	 82Qba+5AJkiGE/xLRYiNsqAra59ggTI6MKixaSNzaa0aVDVitE5JL1zOLIDmbKqJ3p/bv
	 dP6JvWjQvG/tZ1QwZ470RoNAUG2wOc+U9ubrWiBDHYVkwCJZlXxo/KqBgZK6yUigSUH2r
	 NwdBTqp1H7oQRC8YD8FiYsLi2BZjQz4l8W0YAgSx4hVN0vffzzHhc4z2xkXZDNirRQAW5
	 DOHtpVkmR5VShhlhQMi2A3GDzBWmW3ms7NBDeKam3G0wOxT8Y+xuy8WD8eFtcq5Qpbg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795415546;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=zUahnoPga/jiCgJWJO2CDJzH7ESAfv/3v+m3sHp8pG8=;
	b=CbiiBNDDBQ/hGFd8fbc7Tfj39V5gQwEk6yC4o4wzSD2xZdwUVszXmtcThAvvD/37DUVo
	 dM1uhWig1c3w4tXTxquDv2VKVeRnBX/8LISWM6jZx9yfmF6D5Tf3X4dXhknFymwTnMv1W
	 rGTUm9+UEgRR5EKNf8I43GaaHp1Ejw6jRR5mKAw5WAbbupFF9CAFCLXK6ZXrYrezMAKT1
	 9ricxp3R/+oSc7LURx9EOWVrARNx5Lvsj620/UIUNy0qWgVniUG5aYk6HaLdGRuGGjAwy
	 DId39Qu0UxIuISqyi6TPzs2OVTouZE2TVSPDGghCmxWkDDV7k5XlGu8yQquk0oX5Psw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eVNnW0AF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FDDF606A31A
	for <mptcp@lists.linux.dev>; Mon, 23 Nov 2026 06:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eVNnW0AF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36BC81F000C4;
	Mon, 23 Nov 2026 06:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795415545;
	bh=zUahnoPga/jiCgJWJO2CDJzH7ESAfv/3v+m3sHp8pG8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=eVNnW0AFmCgd+kf6dXisCSO5xe0pozgBumPXhDNe5L2FwDNKmoV6DfrrJ5k8JMH+M
	 sAvxnK8K8YziVlR2Xe+UkAf4bHJoOo3leb0wggqwDLsipB+PfoXecpMvScdVChlqDZ
	 sv2B+3ZvvCh2r3/50i2PKTtWMBGDOMcjWHx4UPKxCC7xsPe85ZyV3gwcFUTnmHSEPB
	 7CRm7l3TU5eVcgl3xW5kUswxImyK3Lbf6KaVwnOxjJ2EhxpQRFy68GBnWVb0i0IVBa
	 xG+5du16lFRMo7cmhClhI71kl4yLOkApIJYP1XSeJEnBfgFEpyVKz2uBb6oiFE20df
	 Irs5bVvWV2ehw==
Subject: Re: [PATCH mptcp-net v2 15/62] mptcp: return EOF after a DATA_FIN, as
 TCP does
From: netdev-bot+sashiko@kernel.org
To: matttbe@kernel.org
Cc: mptcp@lists.linux.dev, kuba@kernel.org
Date: Mon, 23 Nov 2026 06:32:24 +0000
Message-ID: <179541554480.3133.8039878521061914181@kernel.org>
In-Reply-To: <20261121-mptcp-cmason-fixes-v2-15-00327fd1de1f@kernel.org>
References: <20261121-mptcp-cmason-fixes-v2-15-00327fd1de1f@kernel.org>
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

Critical: 0 · High: 0 · Medium: 3 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] In mptcp_check_fastclose() (net/mptcp/protocol.c), the patch
  reads msk->rcv_data_fin, drains msk->backlog_list with…
- [Medium] mptcp: early return in mptcp_check_fastclose() skips subflow
  close in FIN_WAIT2
- [Medium] mptcp: mptcp_check_data_fin() misses SOCK_DONE after subflow
  disconnect

--

mptcp: return EOF after a DATA_FIN, as TCP does

When an MPTCP socket processes a DATA_FIN, this commit sets SOCK_DONE, as
TCP does with a FIN. mptcp_recvmsg() then checks SOCK_DONE before the
socket error, so recv() returns EOF instead of an error after a later
reset. On MP_FASTCLOSE, the backlog is drained first so the DATA_FIN is not
missed.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/647

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 9e297fa08bfed..91639ae0c8a02 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c

[ ... ]

> @@ -2938,6 +2948,11 @@ static void mptcp_check_fastclose(struct mptcp_sock *msk)
>  	if (likely(!READ_ONCE(msk->rcv_fastclose)))
>  		return;
>  
> +	/* a DATA_FIN received before still leads to EOF, as with TCP */
> +	if (READ_ONCE(msk->rcv_data_fin))
> +		mptcp_move_skbs(sk);
> +	mptcp_check_data_fin(sk);
> +
>  	mptcp_token_destroy(msk);
>  
>  	mptcp_for_each_subflow_safe(msk, subflow, tmp) {

[Severity: Medium]
On fallback, this check relies on SOCK_DONE still being set on
msk->first when the DATA_FIN is finally processed on the msk. Can
tcp_disconnect() clear it before that happens?

Consider data + FIN, then a RST, arriving on the fallback subflow
while mptcp_worker() owns the msk socket lock. This can happen, for
example, right after shutdown(SHUT_WR) has scheduled the worker:

softirq, msk owned by mptcp_worker():
  tcp_fin(ssk)                    <- SOCK_DONE set on ssk
  mptcp_data_ready()
    __mptcp_move_skbs_from_subflow(msk, ssk, false)
      payload moved to msk->backlog_list, ack_seq not advanced
    subflow_sched_work_if_closed()
      MPTCP_WORK_CLOSE_SUBFLOW set, rcv_data_fin = 1
  RST: ssk moves to TCP_CLOSE, subflow_error_report() only
  defers via MPTCP_ERROR_REPORT

mptcp_worker():
  mptcp_check_data_fin(sk)
    backlog not spooled, ack_seq != rcv_data_fin_seq: no-op
  __mptcp_close_subflow(sk)
    mptcp_close_ssk()
      __mptcp_close_ssk()         <- ssk == msk->first, !dispose_it
        __mptcp_subflow_disconnect()
          tcp_disconnect(ssk, 0)  <- SOCK_DONE cleared on ssk
        goto out                  <- no error report here

release_sock(sk)
  mptcp_release_cb()
    backlog spooled -> mptcp_check_data_fin(sk)
      sock_flag(msk->first, SOCK_DONE) is now false
    MPTCP_ERROR_REPORT -> __mptcp_subflow_error_report(sk, ssk)
      sock_flag(ssk, SOCK_DONE) is false as well

The msk never gets SOCK_DONE. mptcp_recvmsg() then returns the data
followed by EPIPE or ECONNRESET. That is the fallback case this patch
is meant to fix with v1_connect_tcpfallback_fin_reset.pkt.

The mptcp_check_rcv_close() call added at the out label of
__mptcp_close_ssk() later in the series, by "mptcp: no sf left:
process pending DATA_FIN", seems to see the same cleared flag.

A bare FIN + RST landing between mptcp_check_data_fin() and
__mptcp_close_subflow() in mptcp_worker() looks like it can reach
the same path.

Should the FIN seen on the first subflow be recorded on the msk side
before the disconnect, e.g. in __mptcp_close_ssk() before calling
__mptcp_subflow_disconnect()? That would avoid reading SOCK_DONE
from msk->first later. Or should mptcp_worker() spool the backlog
before its mptcp_check_data_fin() call, as mptcp_check_fastclose()
now does?

[Severity: Medium]
What happens here if the msk is in TCP_FIN_WAIT2 and a DATA_FIN is
pending when the MP_FASTCLOSE is processed? This can happen after
shutdown(SHUT_WR) once the peer has sent its DATA_ACK.

In that state, mptcp_check_data_fin() takes its TCP_FIN_WAIT2 branch.
It calls mptcp_shutdown_subflows() and mptcp_send_ack(), then moves
the msk to TCP_CLOSE. So FIN and ACK segments get queued and sent,
and the retransmit timer gets armed, on subflows that the loop just
below is about to reset.

The bigger issue comes after that loop. The loop sends the resets and
calls tcp_set_state(tcp_sk, TCP_CLOSE) on each subflow. The switch on
sk->sk_state then hits the TCP_CLOSE case and returns early. That
skips setting MPTCP_WORK_CLOSE_SUBFLOW in msk->flags.

The bit may not already be set, for example when the MP_FASTCLOSE
arrived in a pure ACK or on another subflow. If so, and the msk is
not SOCK_DEAD, mptcp_worker() never calls __mptcp_close_subflow().
It will not do anything more for this msk now that it is TCP_CLOSE.

tcp_set_state() alone does not stop the subflow timers or purge their
write queues. The reset subflows therefore stay on msk->conn_list
until userspace closes the msk. __mptcp_close() cleans them up at
that point, so this is not a permanent leak. But a remote peer can
trigger it by sending a DATA_FIN followed by an MP_FASTCLOSE.

Should this new block only move the pending data and set RCV_SHUTDOWN
and SOCK_DONE, without going through the sk_state transitions in
mptcp_check_data_fin()? Or should the TCP_CLOSE case below still make
sure MPTCP_WORK_CLOSE_SUBFLOW is set when the subflows were just
reset here?

[Severity: Medium]
Can a subflow running RX in BH on another CPU still race with this drain?
The rcv_data_fin read, mptcp_move_skbs() and mptcp_check_data_fin() all
run before the loop below takes each subflow lock with lock_sock_fast().

When a segment carries both data and a DATA_FIN, rcv_data_fin is published
before the payload reaches msk->backlog_list:

subflow_data_ready()
  mptcp_subflow_data_available()
    get_mapping_status()
      mptcp_update_rcv_data_fin()   <- rcv_data_fin = 1
  mptcp_data_ready()
    mptcp_data_lock(sk)
    __mptcp_move_skbs_from_subflow(msk, ssk, false)  <- payload to backlog

Consider this interleaving:

CPU1 (subflow B, BH): parses MP_FASTCLOSE, sets rcv_fastclose, schedules
the worker.

CPU2 (subflow A, BH): get_mapping_status() sets rcv_data_fin = 1.

CPU0 (mptcp_worker, msk owned): mptcp_check_fastclose() sees
rcv_data_fin == 1. mptcp_move_skbs() finds the backlog still empty.
mptcp_check_data_fin() then sees ack_seq != rcv_data_fin_seq and does
nothing, so neither RCV_SHUTDOWN nor SOCK_DONE is set.

CPU2: takes the data lock and queues the payload on the backlog.

CPU0: lock_sock_fast(A) waits for CPU2 to finish. The subflows are then
reset. The msk is still ESTABLISHED, so the switch sets sk_err to
ECONNRESET and the msk moves to TCP_CLOSE.

Later, mptcp_release_cb() spools the late backlog. But the chain
__mptcp_move_skbs()->mptcp_check_data_fin()->mptcp_pending_data_fin()
now fails this check:

	if (READ_ONCE(msk->rcv_data_fin) &&
	    ((1 << inet_sk_state_load(sk)) &
	     (TCPF_ESTABLISHED | TCPF_FIN_WAIT1 | TCPF_FIN_WAIT2))) {

So SOCK_DONE is never set. mptcp_recvmsg() would then return the data,
followed by -ECONNRESET instead of EOF.

That is the behaviour the commit message describes as fixed: "recv()
returned an error after the data ... instead of EOF as TCP does".

The later commit in the series, "mptcp: report errors as TCP does when
closing", keeps the same order in mptcp_check_fastclose(). It still drains
and checks first, then runs the subflow loop, then sets sk_err. So the
window looks like it is still open at the end of the series.

Would it close the window to drain the backlog and call
mptcp_check_data_fin() after the lock_sock_fast()/tcp_set_state(TCP_CLOSE)
loop, but before the sk_state switch? By then any subflow BH already in
progress has finished, and the closed subflows cannot receive anything
more.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261121-mptcp-cmason-fixes-v2-0-00327fd1de1f%40kernel.org
