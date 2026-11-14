Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794616071;
	b=Ty4/A3l0rifZ6ZEmj0EvksQXmu8hBbkgOsVeppIutvmc0bsgZ4QWkIKE4uJmDwLPqQP6
	 DtdhQs9e8QkRve1oEndj0JmugqJIffuJRfiTx4EKOAZo4qWG1Wffy4FZpLdRN3rqabnjV
	 zJbkq10gjBejbqznrgpqW/UhQcVaIhfB4YK2m2c292+yN81/i6T2+CZgpctZalXbg8Z5U
	 gZeGHXH3OcuTWp0I5SOappDpyT5btt1B+x5hq4uhbHBPGGQN2eu8rzGR6+zJjozslP/w9
	 nS/kg0tLGes3fkShqDG7UW5kv1GsQ6709M/Xroi+ueV/yY7/tz+xUCPYMmGzun0y3bw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794616071;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Bu4gBqJEjXl4+TFcNFFkj6jTB0X1tmGxJkOhCe/aqEg=;
	b=QLdjGAZyDHX03uyQ0Uq9F1/sm0apqnEesMUQTby/M9ZqdwQpXrN86STGAIHx6tHWvJnv
	 mFTIan0G8bKa4qKFRLbXzhkqs7wmfBw5mFK+2iDnkS+/rUTd9YgJupvX3nWWxNAqo0vuW
	 at66PN39fxK2MOxdfCI/94XracymFJa7B3Hl5U6FI+9bJICuq5f1L4IZfkA74OnMJccDv
	 91nAwf3V6XP4CTv/b9I295aSoWE8gVOctTLFwutM/r5JTGMTmK089Xwauea3DpNoLqw88
	 8QIAjeeFNMCTUjw1vrkoqu/zLKKkoRg88NpQBpTaNZqcm/7dXeZmcKPzELo7C9Qh58w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fi0yoD0i;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 066AE606A329
	for <mptcp@lists.linux.dev>; Sat, 14 Nov 2026 00:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fi0yoD0i
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B97E61F000C4;
	Sat, 14 Nov 2026 00:27:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794616070;
	bh=Bu4gBqJEjXl4+TFcNFFkj6jTB0X1tmGxJkOhCe/aqEg=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=fi0yoD0iOR9uPIsMM8yrkmpWwmWrm36DZR7KNGN2OxhsgZ8dnG4N9KRfteG/ZdMrA
	 kOXeQbYjMCjfg8e2mBFpAuSZGlV5glKhkJ4FAasM/qK7+na4ILq4y1CXaBrri+kXlu
	 jYe2p48WAI1syc4tK3iccsUT4etIjLoxMLaNwHGQMsj5bk8UCewoDHj5GOhPoSQdp+
	 JpLqLA8wF7eGj/C/nD2au0LYa/3ONzEcAHA/pyjVKTjNYCsM5yDjEvIvphXL9jGMud
	 zdicwQZ8OtaT/irMk4v3CgE1q8zxsoqfQi5rwFqZ13YzOHUJEnYmQ2faI6fa+/2mQ7
	 SB8j08F5Zg3iQ==
Message-ID: <sashiko-outbox-213924@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-net 26/34] mptcp: don't send a FIN before the
 pending data on fallback
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWF0dGhpZXUgQmFlcnRzIChOR0kwKQ==?= <matttbe@kernel.org>, "MPTCP
 Linux" <mptcp@lists.linux.dev>
In-Reply-To: <20261113-mptcp-cmason-fixes-v1-26-9205b77e9a2f@kernel.org>
References: <20261113-mptcp-cmason-fixes-v1-0-9205b77e9a2f@kernel.org>
 <20261113-mptcp-cmason-fixes-v1-26-9205b77e9a2f@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 00:27:50 +0000
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Medium] mptcp: missing TCP FIN in mptcp_try_fallback() after data
  reinjection
- [Medium] mptcp: stalled pending data and FIN after fallback in
  mptcp_try_fallback()
--

commit a99710492ed63fdd9aa5e8bcc3f5436e41a0c574
Author: Matthieu Baerts (NGI0) <matttbe@kernel.org>

mptcp: don't send a FIN before the pending data on fallback

This commit updates mptcp_try_fallback() to skip shutting down the subflow
at fallback time when mptcp_send_head(sk) is non-NULL, deferring the TCP
FIN until the pending data has been pushed.

> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index e61b6a3a955de..d76eaed4f01eb 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -1339,7 +1339,10 @@ static inline bool mptcp_try_fallback(struct sock =
*ssk, int fb_mib)
> =20
>  	if (!__mptcp_try_fallback(msk, fb_mib))
>  		return false;
> -	if (READ_ONCE(msk->snd_data_fin_enable) && !(ssk->sk_shutdown & SEND_SH=
UTDOWN)) {
> +
> +	/* no FIN before pending data: see mptcp_check_send_data_fin() */
> +	if (READ_ONCE(msk->snd_data_fin_enable) && !mptcp_send_head(sk) &&
> +	    !(ssk->sk_shutdown & SEND_SHUTDOWN)) {
>  		gfp_t saved_allocation =3D ssk->sk_allocation;
> =20
>  		/* we are in a atomic (BH) scope, override ssk default for data

[Severity: Medium]
Can this regression skip sending a TCP FIN altogether if
__mptcp_retransmit_pending_data() has reset msk->first_pending after
mptcp_check_send_data_fin() already ran?

Once all data is pushed to the initial subflow and the socket is shut
down, mptcp_check_send_data_fin() sets msk->snd_nxt =3D msk->write_seq.
If an unestablished MP_JOIN subflow then closes via __mptcp_close_ssk(),
__mptcp_retransmit_pending_data() resets msk->first_pending to rtx_head
without changing msk->snd_nxt.  If the initial subflow falls back to TCP
before that reinjected data is processed, !mptcp_send_head(sk) is false
and mptcp_try_fallback() skips tcp_shutdown(ssk, SEND_SHUTDOWN) even
though ssk already has all data below msk->snd_nxt in its write queue.

Later, mptcp_sendmsg_frag() skips all bytes below msk->snd_nxt and
clears msk->first_pending back to NULL, but mptcp_check_send_data_fin()
will never run again because msk->snd_nxt =3D=3D msk->write_seq:

net/mptcp/protocol.c:mptcp_check_send_data_fin() {
	if (!msk->snd_data_fin_enable || msk->snd_nxt + 1 !=3D msk->write_seq ||
	    mptcp_send_head(sk))
		return;

	WRITE_ONCE(msk->snd_nxt, msk->write_seq);
    ...
}

As a result, the subflow never sends a TCP FIN and stays in
TCP_ESTABLISHED while the MPTCP socket remains stuck in TCP_FIN_WAIT2.
Allowing the shutdown when mptcp_data_fin_enabled(msk) is true (i.e.
!mptcp_send_head(sk) || mptcp_data_fin_enabled(msk)) would avoid this.

[Severity: Medium]
Can this regression also leave both the pending data and the TCP FIN
unsent when a non-TFO subflow falls back while both sent unacknowledged
data and unsent queued data exist?

Suppose mptcp_rtx_head(sk) has dfrag->already_sent > 0, unsent data
remains queued at mptcp_send_head(sk), and the application calls
shutdown(SHUT_WR).  When the peer sends a TCP ACK without MPTCP options
that acks the in-flight TCP data on ssk, check_fully_established() (when
!tcp_sk(ssk)->syn_fastopen_child) or subflow_check_data_avail() calls
mptcp_try_fallback() without updating msk->snd_una or calling
__mptcp_check_push(sk, ssk):

net/mptcp/options.c:check_fully_established() {
    ...
		if (!mptcp_try_fallback(ssk, MPTCP_MIB_MPCAPABLEACTFALLBACK))
			goto Inevitable;

		if (tcp_sk(ssk)->syn_fastopen_child) {
			mptcp_data_lock(sk);
			__mptcp_check_push(sk, ssk);
			mptcp_data_unlock(sk);
		}
		return false;
    ...
}

mptcp_try_fallback() clears MPTCP_RTX_ENABLED and skips
tcp_shutdown(ssk, SEND_SHUTDOWN) because mptcp_send_head(sk) is
non-NULL.  When the MPTCP retransmit timer later fires, msk->snd_una is
still below msk->snd_nxt, so __mptcp_retrans() sees
dfrag->already_sent > 0 after fallback, gets -1 from
__mptcp_push_retrans(), and jumps to clear_scheduled without calling
mptcp_check_and_set_pending(sk).  With ssk's TCP write queue empty and
the peer waiting for the remaining data and FIN, nothing ever pushes
mptcp_send_head(sk) or sends the FIN, stalling the connection.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113-mptcp-cmas=
on-fixes-v1-0-9205b77e9a2f@kernel.org?part=3D26
