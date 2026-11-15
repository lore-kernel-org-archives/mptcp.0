Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794739992;
	b=Y22YicxnYbECLqIwEn9D9WuYRWqvNrcacdu+RNiLsieKtPBgm48YUKKakBrZgwCpzDN0
	 l49bhOavaFH0BgSLmR5erDJ6Oi9O0199vKniP1o1m/X6nQAHmsh5qGM4uhWaogKf839nK
	 FOU1mGxSwM6cgCRWdgddBLN/WhS0XTE/97ahvJlNadnA9Hn4Mov4w4JERY42knWdNrIvp
	 mth+F3GwPS3un/xl2NtCXFL28hPNnhLlc9jxM7tA6BGvnMqtHl+Qs9D7j0IGFKoz6vIo1
	 BT//bge1Nq77nq4YgBihqxtXlbXAlw88jT67o1kilMv/ySfrUu159T2TOFran9uFl3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794739992;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=AsT/J24bnmglqNYvAj2y5P5MVGDYykTiNTFmzmFetpo=;
	b=BIK2d7TMWNsNMJ+KNH7HH0moCrOCYtlWtz1w5yicOqdi5d2vR1T/M1HJ4HH9bHtW4icJ
	 R7uAhTU6ueI9sgtdtORTeVAXadC8sVazj3D/4RjabpL6dcigxgQG0Kr+/gX3g3Dklmfoa
	 09JHAABq58U5be6Ank5A0YeW0rcmq/OjAK5dxdTxeXeHiWtizjPEtqmtO/teydZFP1aoJ
	 /lZn0BK49H94zsu+IoBF98XhXvaLoPR4bdV7pV/aXjBfNmbGXn37R1/Q7PZZ7iCJu48e3
	 Txo6pVeuVnNw6MVKLcw/9fi+AOu4eWMw/EVtF0joxX/vXmsHdfRNk/7LQQEn+RrR0ZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UxYX9k0O;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D308606A31A
	for <mptcp@lists.linux.dev>; Sun, 15 Nov 2026 10:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UxYX9k0O
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE3651F000CF;
	Sun, 15 Nov 2026 10:53:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794739992;
	bh=AsT/J24bnmglqNYvAj2y5P5MVGDYykTiNTFmzmFetpo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=UxYX9k0OpLkdYjHDomw24XJm8ldM2iQAMH4opMEx4nJNAdixvzsl5u0s8Kp/bcKGM
	 tSD0Jh7vVK/kQJRjbYGqP5AHRd4UIfUOC4btAMOqG4Yt6UvqtIpvYMWY/U7RxQ4mWk
	 Ed1HDJrUtDjXxoUIu3iYNZDrbpavDCKCENXrOD/UgxVmL6RIpfJn8NJXQAEz924gxs
	 PZczdLXJvXutjMyrJ+UlbkV6vUwEI9DBwxCWmCTaOuDg67GB4BRaBUyUKUdTtDloh9
	 AfxEOHSuSRPdziYTZkSHkXaM5jfWaMBjWJ6eyQO7VU7Ig/GQY5yF+xSLGO2+pJ3p1Y
	 7pU6+i1OmDNDA==
Subject: Re: [PATCH mptcp-net 26/34] mptcp: don't send a FIN before the
 pending data on fallback
From: netdev-bot+sashiko@kernel.org
To: matttbe@kernel.org
Cc:
 mptcp@lists.linux.dev, mason@kernel.org, pabeni@redhat.com, kuba@kernel.org
Date: Sun, 15 Nov 2026 10:53:11 +0000
Message-ID: <179473999142.488855.11499927609613707398@kernel.org>
In-Reply-To: <20261113-mptcp-cmason-fixes-v1-26-9205b77e9a2f@kernel.org>
References: <20261113-mptcp-cmason-fixes-v1-26-9205b77e9a2f@kernel.org>
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

- [Medium] mptcp: missing TCP FIN in mptcp_try_fallback() after data
  reinjection
- [Low] This patch adds a lockless, unannotated read of
  msk->first_pending in mptcp_try_fallback()…

--

mptcp: don't send a FIN before the pending data on fallback

On fallback, mptcp_try_fallback() now shuts the subflow down only when
the msk write queue has no pending data. Otherwise the FIN is left to
mptcp_check_send_data_fin(). This stops data from being lost when a TFO
server writes and shuts down before a third ACK that carries no MPTCP
options.

> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index e61b6a3a955de..d76eaed4f01eb 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -1339,7 +1339,10 @@ static inline bool mptcp_try_fallback(struct sock *ssk, int fb_mib)
>  
>  	if (!__mptcp_try_fallback(msk, fb_mib))
>  		return false;
> -	if (READ_ONCE(msk->snd_data_fin_enable) && !(ssk->sk_shutdown & SEND_SHUTDOWN)) {
> +
> +	/* no FIN before pending data: see mptcp_check_send_data_fin() */
> +	if (READ_ONCE(msk->snd_data_fin_enable) && !mptcp_send_head(sk) &&
> +	    !(ssk->sk_shutdown & SEND_SHUTDOWN)) {

[Severity: Medium]
Can this leave the initial subflow without a TCP FIN when first_pending
only points to reinjected data that the subflow already has?

Consider a connection that has pushed all its data on the initial
subflow ssk1 when the user calls shutdown(SHUT_WR) or close().
__mptcp_wr_shutdown() calls mptcp_check_send_data_fin(), which moves
msk->snd_nxt to msk->write_seq and sends the DATA_FIN on ssk1. ssk1 is
not shut down at that point because there is no fallback yet.

Then a not yet established MP_JOIN subflow ssk2 is closed via
__mptcp_close_ssk() with MPTCP_CF_PUSH. For example, it could still be
in SYN_SENT, so allow_infinite_fallback is still true. That calls
__mptcp_retransmit_pending_data(), which sets msk->first_pending back
to the rtx head for the unacked data, but leaves msk->snd_nxt equal to
msk->write_seq.

ssk1 can then fall back through mptcp_try_fallback() before that data
is pushed again. This can happen in the BH window before
__mptcp_push_pending() takes the ssk1 lock. It can also happen when
mptcp_subflow_get_send() returned NULL because of
sk_stream_memory_free() or a stale subflow. In both cases
mptcp_send_head(sk) is not NULL, and the new check skips
tcp_shutdown(ssk, SEND_SHUTDOWN).

After that, nothing seems to send the FIN. On the next push,
mptcp_sendmsg_frag() skips everything below msk->snd_nxt because the
connection has fallen back. first_pending goes back to NULL without
snd_nxt moving.

mptcp_check_send_data_fin() then returns early, because
msk->snd_nxt + 1 != msk->write_seq is now always true. The same test
in __mptcp_subflow_push_pending() stops mptcp_subflow_shutdown() from
being called. Once the peer acks, snd_una reaches snd_nxt and
mptcp_check_data_fin_ack() clears snd_data_fin_enable.

The result is ssk1 stuck in TCP_ESTABLISHED and the msk in
TCP_FIN_WAIT2 until a timeout or a reset. The sequence is fairly
specific, but it only needs an unprivileged MPTCP socket and a
middlebox that strips the options after the handshake.

The new comment says the FIN is left to mptcp_check_send_data_fin().
That only holds if the DATA_FIN has not been sent yet. Would it be
enough to also shut the subflow down when mptcp_data_fin_enabled(msk)
is true? In that case snd_nxt already equals write_seq, and the
pending fragments are only reinjected data below snd_nxt. Something
like:

	(!mptcp_send_head(sk) || mptcp_data_fin_enabled(msk))

[Severity: Low]
Should this read of msk->first_pending be annotated? mptcp_send_head()
is a plain load:

net/mptcp/protocol.h:mptcp_send_head() {
    ...
	return msk->first_pending;
}

Callers such as check_fully_established() and subflow_check_data_avail()
run mptcp_try_fallback() with only the ssk lock held. The msk data lock
is not held and sock_owned_by_user() is not checked. In
check_fully_established(), mptcp_data_lock() is taken only after
mptcp_try_fallback() returns.

The other BH reader, __mptcp_subflow_push_pending(), holds the msk data
lock and checks !sock_owned_by_user(sk). This makes the new check the
first truly lockless access to first_pending.

Some writers hold only the msk owner lock and use plain stores. For
example, in mptcp_sendmsg():

	if (!msk->first_pending)
		msk->first_pending = dfrag;

__mptcp_retransmit_pending_data() and __mptcp_clear_xmit() also use
plain stores.

The same condition already uses READ_ONCE() for snd_data_fin_enable.
Would READ_ONCE() here, with WRITE_ONCE() on the writers, be more
consistent?

There is also the ordering between the two loads. The && only gives a
control dependency, and that does not order a load before a later load.
LKMM allows the first_pending load to be satisfied before the
snd_data_fin_enable load.

In the TFO case this patch targets, the sequence would be:

  user (msk lock)                  BH (ssk lock)
  mptcp_sendmsg()
    msk->first_pending = dfrag
    (push blocked in SYN_RECV)
  shutdown()
    WRITE_ONCE(snd_data_fin_enable, 1)
                                   check_fully_established()
                                     mptcp_try_fallback()
                                       READ_ONCE(snd_data_fin_enable) == 1
                                       mptcp_send_head(sk) == NULL (stale)
                                       tcp_shutdown(ssk, SEND_SHUTDOWN)

On a weakly ordered CPU, could this still send the FIN before the
queued data? If that ordering matters, should snd_data_fin_enable be
read with smp_load_acquire()?

The window is small. mptcp_sendmsg() cannot store after SEND_SHUTDOWN,
__mptcp_retransmit_pending_data() returns early after fallback, and
release_sock() and lock_sock() run between the two stores. So the data
loss is speculative, and this is mainly about annotation and ordering.

>  		gfp_t saved_allocation = ssk->sk_allocation;
>  
>  		/* we are in a atomic (BH) scope, override ssk default for data

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261113-mptcp-cmason-fixes-v1-0-9205b77e9a2f%40kernel.org
