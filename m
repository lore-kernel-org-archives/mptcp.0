Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795415548;
	b=vYPZw8LzZQx2Kc+q03gPyt503Bk1JQsGRGsCbewNogzBWExIIJY8iOo4beCVNR+X3Jlg
	 n2/4mljz/IthvZVdcks/gmNnQAiyCJD5lHmnc7bDP0FN14hZn1hsHB7PghhY4v2PH14bD
	 a914w6x/B1YGvf9o2p5eyCbHL6vYYEMfMl+O7ed17OQF/JgH1h+UWWnF1TvopDPzvb0FO
	 dVLYDFQqEO10f/VvM41ND7VhJVek8gdM2sGfFvJUTMp/jXiPqHjO1DhtyQLjouzbmHMUm
	 kBk7xO1jpgfzzGm+N5L/qb9o2DmbxprD6ty7MHZLvf+bFUZiUMZL/d+2TtJ5bHEMKTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795415548;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=TN31z62ZOcSg3aNtsNAr1oDiHL0vQtqpoCM153FPDAc=;
	b=txUDekjFw43/DzXJVFRlTdCKxL4ehNEnrr5nRqdIpMk3qBfoHAObYWATC3JBDPOjZwru
	 y7IqfWtpj0iJjBZ+rAz0hUFB17cmY6j8SxGgnRLtszEa+XxVxq+A24jD/36MGAxmjFHvM
	 rnetRP9qeo5fCRmXGH7OHGVv27nh497kOXz/aPftCqbwnpHfVxm7AjWc0KFRc1WnybROq
	 GdWrNlSIVJl/Tu1sC2dctj5VXvUTi0s38IGNotB8ak5N2rN9Hs+Z6H3J5z+A7FTgtMh+N
	 FSjvAdtC0vPhS7ZcPVh00Yj20/9CQTdgRgweDfq+OCKdNiR51B+s1dys9rTdpMfE2NA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fBeDTEKw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A47606A31A
	for <mptcp@lists.linux.dev>; Mon, 23 Nov 2026 06:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fBeDTEKw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA95D1F000C4;
	Mon, 23 Nov 2026 06:32:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795415548;
	bh=TN31z62ZOcSg3aNtsNAr1oDiHL0vQtqpoCM153FPDAc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=fBeDTEKwMbGPYdZWgR8zZGIHIJxvUBUIYdVhTuvbsMA6F/HbE+dBAcFMiICZoy0pU
	 9A/pHTjy2bMF7pzsciAuF/Yy8hdiecfiCauYIrjRgLmoMNQEsLegr76Zki+AYs0V4h
	 +/E9OFk69RAjUIlzoAAiE0kKFATlrkn62W39krGPEmNNXmSjNy76l00lbl/hGnonRI
	 4wXHlPElh3GuH+XdTceZWzKMuaC3+DeLu8Ozq5Z4QfRAKwLcgVwLONZDcZiDHD1RLx
	 JrmI0cNG48UoadavA3+3vZw5Ujo2YpVvVzuwndD8pjLQ4YoFt+tUV8jz1t13g42euH
	 NfuITPtHt7lpQ==
Subject: Re: [PATCH mptcp-net v2 17/62] mptcp: reset the subflow on abort
 after fallback
From: netdev-bot+sashiko@kernel.org
To: matttbe@kernel.org
Cc: mptcp@lists.linux.dev, kuba@kernel.org
Date: Mon, 23 Nov 2026 06:32:27 +0000
Message-ID: <179541554737.3133.824367187193234355@kernel.org>
In-Reply-To: <20261121-mptcp-cmason-fixes-v2-17-00327fd1de1f@kernel.org>
References: <20261121-mptcp-cmason-fixes-v2-17-00327fd1de1f@kernel.org>
X-sashiko-severity: Low
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

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] After this patch, an unaccepted MPTCP child that has fallen back
  to TCP sends two plain RSTs when its listener is closed.
- [Low] Fallen-back subflows now get an RST in states where TCP would not
  send one.

--

mptcp: reset the subflow on abort after fallback

This commit removes the fallback early return in mptcp_do_fastclose().
After a fallback to TCP, aborting an MPTCP socket now sends a plain TCP
reset on each subflow. As a result, close() with unread data, or with
SO_LINGER and a zero timeout, resets the connection instead of sending a
FIN.

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 541bf23d1bda1..201e77772bdd2 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -3245,10 +3245,7 @@ static void mptcp_do_fastclose(struct sock *sk)
>  	mptcp_backlog_purge(sk);
>  	msk->fastclosing = 1;
>  
> -	/* Explicitly send the fastclose reset as need */
> -	if (__mptcp_check_fallback(msk))
> -		return;
> -
> +	/* Explicitly send the fastclose reset, a plain one after a fallback */
>  	mptcp_for_each_subflow_safe(msk, subflow, tmp) {
>  		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
>  

[Severity: Low]
With this early return gone, can an unaccepted child that fell back to
TCP send two plain RSTs when its listener is closed?

The path looks like this:

mptcp_check_listen_stop()
  mptcp_subflow_queue_clean()
    __mptcp_unaccepted_force_close()
      sock_set_flag(sk, SOCK_DEAD);
      mptcp_do_fastclose(sk);
        tcp_send_active_reset(ssk, ...);  <- RST #1, ssk stays ESTABLISHED
      __mptcp_destroy_sock(sk);
        ...
          __mptcp_close_ssk()

__mptcp_close_ssk() then takes the early accept-queue branch:

	if (msk->in_accept_queue && msk->first == ssk &&
	    (sock_flag(sk, SOCK_DEAD) || sock_flag(ssk, SOCK_DEAD))) {
		...
		mptcp_subflow_drop_ctx(ssk);
		goto out_release;
	}

That branch skips the transition that ae155060247b relies on to avoid
duplicate resets:

	if (subflow->send_fastclose && ssk->sk_state != TCP_CLOSE)
		tcp_set_state(ssk, TCP_CLOSE);

Back in mptcp_check_listen_stop(), inet_csk_listen_stop() ->
inet_child_forget() -> tcp_disconnect() still sees the child in
ESTABLISHED. tcp_need_reset() is true, so a second RST is sent.

Before this patch, a fallback msk returned early here and only the
tcp_disconnect() RST went out. A peer can force the fallback on an
unaccepted server socket by sending data without a DSS mapping, via
subflow_check_data_avail() -> mptcp_try_fallback().

The same double reset already happened without a fallback (MP_FASTCLOSE
RST, then a plain RST). This patch extends it to fallback sockets, which
works against the goal of the commit in the Fixes: tag. The duplicate RST
is still present at the end of the series.

Related to this, the commit message says:

    Its other callers, on disconnect()
    and when the close timeout of an orphan expires, were already resetting
    the subflow after a fallback, via tcp_disconnect(), in most states: the
    reset is now sent as without a fallback.

Should it also mention __mptcp_unaccepted_force_close()? The same goes
for the orphan-OOM caller in __mptcp_close(), added earlier in this
series:

	if (mptcp_orphan_oom(sk))
		mptcp_do_fastclose(sk);

After a fallback, that path used to close the subflow with a FIN through
__tcp_close(), and it now sends an RST. That matches TCP's handling of
orphans under OOM, but the commit message doesn't describe the change.

[Severity: Low]
Does this also send an RST on fallback subflows in LAST_ACK or CLOSING,
where plain TCP would not?

Before this patch, fallback subflows reached tcp_disconnect() through
__mptcp_subflow_disconnect() and followed its ABORT rule:

	} else if (tcp_need_reset(old_state)) {
		tcp_send_active_reset(sk, SK_RST_REASON_TCP_STATE);
		...
	} else if (tp->snd_nxt != tp->write_seq &&
		   (1 << old_state) & (TCPF_CLOSING | TCPF_LAST_ACK)) {

Now they go through the filter in mptcp_do_fastclose(), which only skips
TCPF_LISTEN | TCPF_CLOSE:

	if ((1 << ssk->sk_state) & (TCPF_LISTEN | TCPF_CLOSE))
		goto unlock;

For example:

1. After a fallback, the peer sends a FIN.
2. The application calls shutdown(SHUT_WR). The subflow sends its FIN
   and enters LAST_ACK with snd_nxt == write_seq.
3. Before the final ACK arrives, the application calls close() with
   SO_LINGER {1, 0}.

__mptcp_close() then takes the linger-0 branch and calls
mptcp_do_fastclose(), which sends an RST on the LAST_ACK subflow.
connect(AF_UNSPEC) in the same state does the same through
mptcp_disconnect(). Plain TCP in that state sends no RST, and neither
did MPTCP after a fallback before this patch.

The SYN_SENT case is fixed later in this series by "mptcp: no fastclose
reset from SYN_SENT subflows". CLOSING and LAST_ACK are still affected at
the end of the series.

The commit message describes the change as resetting "as TCP does".
Should the filter follow tcp_need_reset() and the unsent-data check for
fallback subflows? If not, should the commit message mention this
difference?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261121-mptcp-cmason-fixes-v2-0-00327fd1de1f%40kernel.org
