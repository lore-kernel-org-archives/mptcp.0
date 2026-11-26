Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795735785;
	b=bfl7hh89qYikTlzVFFoK1a2dYqXGlGXNmZza/QsmGaB+iWZKbbM+SG+4MBy1o7bDfh52
	 7YTg3jbAGLJRComBuPLNzjPX8nWMdHVGk7p4J9TvwSZ0H6VSmqbTAw9XHdmsvR7TUxDjY
	 7Itp6KNLYEvyCL5QSdWHxCBbFtuDv4Ti4+HJzHwSQaOwWAKDCvQNGPrmBfgN5RnbKu1k1
	 wgzcT4dQJZ52OtZJDdXRBqwwWkNTbxHjzlzhJaQchLJ3kNhtNmTCI/3xKLQeq5PfKYwRa
	 DKiLk0fZspzyPMcbGtx7ZxJpzl5GOjBrMCJHM9v7QIQ3Rc3yLz6v9nsB4AD1uKsQgNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795735785;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Y3/itk/F9v15KdzFhpu6t1K+wl96kO0jbs+n+PlVQCU=;
	b=I7gqNzv9kHcs6inOpej1z0Qt+tEMUqTqaYaWky4F88TXh89BKV5uaJCGLhOQsNxry8Qo
	 S6euSFvPkHrjae7FHkEcHOhXmMwiilzzXYVjEEg8AWhrBzPw3ol3vbZxqecTkSm5WSV/f
	 9JOqPD6WgsvXlgYaN6+Br0YU1qQhlMqTU4PDA0JqyPodX1wijKpw49F7qshhx0kLqYTsW
	 t0d8+bLgl0oq260PoFPyBhbzCQX+LdYAQQ8Bwqbz45b4fuBLYyDJsX56XYGw96dnYao6C
	 NA/kGYKmmSp8006kphb98irhS7nPx9e2SKR6FCwwHrDELtAmqx/atfnoj9V89CRjTkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N7gpgVhL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE5A1606A31C
	for <mptcp@lists.linux.dev>; Thu, 26 Nov 2026 23:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N7gpgVhL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EFCE1F00893;
	Thu, 26 Nov 2026 23:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795735785;
	bh=Y3/itk/F9v15KdzFhpu6t1K+wl96kO0jbs+n+PlVQCU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=N7gpgVhLsONQc6VxLLDWolk5tKtZXakfuzZXv+s+G+tAdeangIlzXpkxj3ghiqAN9
	 ZxvA/qmHLOQUep0a6LagKoJ89UDpLHDUOz5yQOqov59zjeBhQg7U4UTTc/ZBknBfGv
	 1e98gj7e9qA2Ffajt3VCKnr0m2PrZno9Bi7LZykz0mjMKUIuWb9JfE2LyZbVQMIFrD
	 ssyihKqVoQvZpr5t3ieVkoPF7RGX0wEWMV9WFlBq2wXHytoBh3d7xQhoDXTWgcDoQv
	 lsHIP/xV1GolL0utpYlvu96M30cpkom8w+/ZD97i5Wpv5GU6CLK/fDWjiRk8kXIGay
	 fAtv3kMZ8u/5g==
Subject: Re: [PATCH mptcp-net v3 04/50] mptcp: return EOF after a DATA_FIN, as
 TCP does
From: netdev-bot+sashiko@kernel.org
To: matttbe@kernel.org
Cc: mptcp@lists.linux.dev, kuba@kernel.org
Date: Thu, 26 Nov 2026 23:29:44 +0000
Message-ID: <179573578493.3133.15374382534527538949@kernel.org>
In-Reply-To: <20261124-mptcp-cmason-fixes-v3-4-416c0920c73f@kernel.org>
References: <20261124-mptcp-cmason-fixes-v3-4-416c0920c73f@kernel.org>
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

- [Medium] After a fallback, a race can still make recv() return an error
  instead of EOF after a FIN followed by a reset, which is the case this…
- [Low] The commit message leaves out several user-visible behaviour
  changes.

--

mptcp: return EOF after a DATA_FIN, as TCP does

This patch sets SOCK_DONE on the msk when a DATA_FIN is processed. It also
checks SOCK_DONE before the socket error in mptcp_recvmsg(), so recv()
returns EOF instead of an error when a reset follows a DATA_FIN. With an
MP_FASTCLOSE, or on a fallback in mptcp_close_ssk(), the pending DATA_FIN is
now processed before the reset or disconnect clears that state.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/647

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 9e297fa08bfed..de6da0b6c4ca4 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c

[ ... ]

> @@ -972,6 +976,9 @@ static bool __mptcp_subflow_error_report(struct sock *sk, struct sock *ssk)
>  	 * destroy the msk as needed.
>  	 */
>  	ssk_state = inet_sk_state_load(ssk);
> +	/* a FIN received before still leads to EOF, as with TCP */
> +	if (sock_flag(ssk, SOCK_DONE) && mptcp_pending_data_fin(sk, NULL))
> +		sock_set_flag(sk, SOCK_DONE);
>  	if (ssk_state == TCP_CLOSE && !sock_flag(sk, SOCK_DEAD))
>  		mptcp_set_state(sk, ssk_state);
>  	WRITE_ONCE(sk->sk_err, -err);

[Severity: Low]
This isn't a bug, but the commit message seems to leave out a few
user-visible behaviour changes. It says:

  As TCP does with a FIN, set SOCK_DONE when processing the DATA_FIN, and
  check it before the socket error in recvmsg().

In __mptcp_subflow_error_report(), SOCK_DONE is set on the msk but the
DATA_FIN is not processed. ack_seq is not bumped, rcv_data_fin is not
cleared and RCV_SHUTDOWN is not set. The msk then moves straight to
TCP_CLOSE. Could the message describe this path too?

mptcp_splice_read() already had a SOCK_DONE check. It could never fire,
because nothing in net/mptcp/ set SOCK_DONE on the msk:

net/mptcp/protocol.c:mptcp_splice_read() {
    ...
		} else if (!ret) {
			if (spliced)
				break;
			if (sock_flag(sk, SOCK_DONE))
				break;
			ret = sock_error(sk);
    ...
}

With this patch, splice() also returns EOF where it used to return an
error. Should the message mention that?

In mptcp_check_fastclose(), mptcp_check_data_fin() now runs before the
error switch:

	/* Mirror the tcp_reset() error propagation */
	switch (sk->sk_state) {
	...
	case TCP_CLOSE_WAIT:
		WRITE_ONCE(sk->sk_err, EPIPE);
		break;
	case TCP_CLOSE:
		return;
	default:
		WRITE_ONCE(sk->sk_err, ECONNRESET);
	}

With a pending DATA_FIN in ESTABLISHED, the msk first moves to CLOSE_WAIT.
SO_ERROR and send() then see EPIPE instead of ECONNRESET.

In FIN_WAIT2, the msk moves to TCP_CLOSE and the switch returns early. In
that case:

  - no sk_err is set
  - sk_error_report() is not called, so there is no EPOLLERR
  - MPTCP_WORK_CLOSE_SUBFLOW is not set
  - the reset subflows stay until close()

Only the notes below the '---' line explain this last case, and git history
won't keep them.

The message also targets stable backports down to v6.1. Could these
changes be documented in the commit message itself?

[ ... ]

> @@ -2820,12 +2832,21 @@ void mptcp_close_ssk(struct sock *sk, struct sock *ssk,

[ ... ]

> +	/* On fallback, the FIN of the first subflow is cleared when it is
> +	 * disconnected: process the DATA_FIN emulated from it before.
> +	 */
> +	if (ssk == msk->first && __mptcp_check_fallback(msk) &&
> +	    READ_ONCE(msk->rcv_data_fin) && !sock_flag(sk, SOCK_DEAD)) {
> +		mptcp_move_skbs(sk);
> +		mptcp_check_data_fin(sk);
> +	}
>  
>  	__mptcp_close_ssk(sk, ssk, subflow, MPTCP_CF_PUSH);
>  }

[Severity: Medium]
On a fallback connection, can a race still make recv() return an error
instead of EOF when a FIN is followed by a reset?

This check reads msk->rcv_data_fin without holding the subflow lock. The
FIN is cleared later, under lock_sock_nested(ssk):

mptcp_close_ssk()
  __mptcp_close_ssk()
    __mptcp_subflow_disconnect()
      tcp_disconnect()
        sock_reset_flag(sk, SOCK_DONE)

So the check and the disconnect are not in the same critical section.

The emulated DATA_FIN can be set for the first time only when the subflow
moves to TCP_CLOSE, after a FIN was already received. Two examples:

  - The msk is in FIN_WAIT1 after shutdown(SHUT_WR), and the peer FIN
    moves the subflow to CLOSING.
  - The subflow is in CLOSE_WAIT while our data is still pending.

In both cases subflow_sched_work_if_closed() returns early, and the
subflow keeps SOCK_DONE:

	if (likely(ssk->sk_state != TCP_CLOSE &&
		   (ssk->sk_state != TCP_CLOSE_WAIT ||
		    inet_sk_state_load(sk) != TCP_ESTABLISHED)))
		return;

When the RST arrives, subflow_sched_work_if_closed() schedules the worker
before it writes rcv_data_fin:

	if (!test_and_set_bit(MPTCP_WORK_CLOSE_SUBFLOW, &msk->flags))
		mptcp_schedule_work(sk);
	...
	if (__mptcp_check_fallback(msk) && subflow_is_done(ssk) &&
	    msk->first == ssk &&
	    mptcp_update_rcv_data_fin(msk, subflow->map_seq +
				      subflow->map_data_len, true))

A possible sequence:

CPU0 (softirq, ssk spinlock held)
tcp_reset()->tcp_done()->subflow_state_change()
  subflow_sched_work_if_closed()
    test_and_set_bit(MPTCP_WORK_CLOSE_SUBFLOW)
    mptcp_schedule_work()

CPU1 (mptcp_worker, already owning the msk)
  test_and_clear_bit(MPTCP_WORK_CLOSE_SUBFLOW)
  __mptcp_close_subflow()
    mptcp_close_ssk(first)
      READ_ONCE(msk->rcv_data_fin) == 0, new block skipped
      __mptcp_close_ssk()
        lock_sock_nested(ssk) spins

CPU0
    mptcp_update_rcv_data_fin() sets rcv_data_fin = 1
    subflow_error_report() only sets MPTCP_ERROR_REPORT, msk is owned
    ssk spinlock released

CPU1
        tcp_disconnect() clears SOCK_DONE, keeps ssk->sk_err
        tail of __mptcp_close_ssk() moves the non-ESTABLISHED msk to
        TCP_CLOSE

After that, mptcp_pending_data_fin() can never be true again.

At release_sock(msk), the deferred report runs:
__mptcp_error_report()->__mptcp_subflow_error_report(). By then the
subflow no longer has SOCK_DONE and the msk is closed, so the new check
there does not set SOCK_DONE. ECONNRESET or EPIPE is copied into
sk->sk_err.

recvmsg() then returns the queued data followed by the error instead of
EOF. The rescheduled worker exits right away because the msk is in
TCP_CLOSE.

Later patches in this series don't change mptcp_close_ssk() or
subflow_sched_work_if_closed(). At the end of the series,
mptcp_check_rcv_close() in the tail of __mptcp_close_ssk() processes the
DATA_FIN only after the disconnect. SOCK_DONE is still not set, and
mptcp_close_last_err() still reports the error.

The window is narrow, because mptcp_worker must be running at the same
time. When the msk is not owned, subflow_check_data_avail() sets
rcv_data_fin before subflow_error_report(), so the common paths are
covered.

Could the decision be made under the ssk lock, before
__mptcp_subflow_disconnect()? Alternatively, could the subflow FIN be
recorded on the msk before the disconnect?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261124-mptcp-cmason-fixes-v3-0-416c0920c73f%40kernel.org
