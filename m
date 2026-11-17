Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794953357;
	b=rg1KOOgfZDBx3kghwT51KAwbx1ZbSWo54HVpvJl/KmTxl9YdrTfSlebKrPaEO7KNiJCQ
	 /v6U+iIzVf7f9S4tyDFoM7n5ivfOWPGnPW1qLsxCm2wmt2z10nBEAq930iXP4hh+cF1q/
	 hZnqn70NpmivGmlGdNv7bXqrEvjOOBCys0dYNLZaOe1px9tRQdOJ8Ue3VN9TcyNy20B+d
	 OkfiOpCkxNa+AWEQdnrpIsdHELjI4yQB1YbpSIrJL7iIuysGfean45zcLhhY8Hv9Ckj13
	 7aSUnbJy2q5DYPRumH/amPuPWAjNjGEupS6zFNWpqFwquXjiGII2NnfWTB/QOa49IKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794953357;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=wa8GPK9dMoA+HzC0HX/7/z9KIR65enqsEwBAERbo630=;
	b=Y1IgGu1sjBIbP6B9Jczi/OFUVXDLirQrN7LzYe7MmJ/m1CJZgerXCgb4yos45eoyuRFM
	 yBPO+df6F7D/m+eFA1AuwubSidyPY3CFgHffFaVltJfIRGbIbSs9nnULJQT6ToELdZipQ
	 vrag0gcG4U3aNjczLxZtbveBhwGg+Z20km9rm1qlxXVbpptu4MddnNT8oixBTcKOl8DZU
	 UyoW1m+4TjD5UEwxf89+/AJgjdyW9YXRbphm7dg2ow34jmr1l2oVWcS9Z34bUUvswfzgv
	 bHlIiTcGSeeJFKV+LTDFodh2rdZsvZt09KsjsgSrDlq9l/GbN1NonDnz6DvQhCPAFhQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MAZYwqLM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 839CB606A32A
	for <mptcp@lists.linux.dev>; Tue, 17 Nov 2026 22:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MAZYwqLM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40F6A1F000CB;
	Tue, 17 Nov 2026 22:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794953357;
	bh=wa8GPK9dMoA+HzC0HX/7/z9KIR65enqsEwBAERbo630=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MAZYwqLMaHVo8cwU/eLOy8AXTBeJpBlURKRBdxl47zb1sjw4ExNB88pR4GeOTkFEC
	 Om+kTnbvzQc3I9WgG0WNvZqzNlaDkuZxbf9xYi+RrmU/XzQAoY1xw67YFzkjC0TkgL
	 EOqXZWYAikuLfhPVjrFrxE5JCYkKKcglL0Gg/ZuMfMGkBerFpmySaakw1rD4cavh1c
	 pRTWwZhllZ1mhfefeTYTatDd8bBMuipNZngsg7mgF/oE5CCOJNpWv85dQCtUGizg/V
	 qrkz1KrGfRmUKh48g33EqIrCd1ek8LlKdMREOdFncEcmLNMVh5lJBEzOow/lYNC3kC
	 bvz0fBUR3b0ug==
Message-ID: <sashiko-outbox-219732@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net 6/7] mptcp: don't send a FIN before the pending data
 on fallback
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWF0dGhpZXUgQmFlcnRzIChOR0kwKQ==?= <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
In-Reply-To: <20261116-net-mptcp-misc-fixes-7-4-rc4-v1-6-bf7656de653e@kernel.org>
References: <20261116-net-mptcp-misc-fixes-7-4-rc4-v1-0-bf7656de653e@kernel.org>
 <20261116-net-mptcp-misc-fixes-7-4-rc4-v1-6-bf7656de653e@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 22:09:16 +0000
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
- [Medium] mptcp: unadvanced snd_nxt in mptcp_try_fallback() with
  reinjected data
- [Medium] mptcp: missing pending data push after fallback in
  subflow_check_data_avail()
--

commit 7f5ccb63dcef4623a742b8e41a51358adb229738
Author: Matthieu Baerts (NGI0) <matttbe@kernel.org>

mptcp: don't send a FIN before the pending data on fallback

This commit avoids shutting down the subflow at fallback time when unsent
data is still pending in the MPTCP write queue, so that a TCP FIN is not
sent before the pending data.

> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 011e73d04ee60..7d226ee38315d 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -1333,7 +1333,11 @@ static inline bool mptcp_try_fallback(struct sock =
*ssk, int fb_mib)
>  	msk =3D mptcp_sk(sk);
>  	if (!__mptcp_try_fallback(msk, fb_mib))
>  		return false;
> -	if (READ_ONCE(msk->snd_data_fin_enable) && !(ssk->sk_shutdown & SEND_SH=
UTDOWN)) {
> +
> +	/* no FIN before new data: see mptcp_check_send_data_fin() */
> +	if (READ_ONCE(msk->snd_data_fin_enable) &&
> +	    !before64(READ_ONCE(msk->snd_nxt) + 1, READ_ONCE(msk->write_seq)) &&
> +	    !(ssk->sk_shutdown & SEND_SHUTDOWN)) {
>  		gfp_t saved_allocation =3D ssk->sk_allocation;
> =20
>  		/* we are in a atomic (BH) scope, override ssk default for data

[Severity: Medium]
Can mptcp_try_fallback() leave msk->snd_nxt at msk->write_seq - 1 when
reinjected data is still in msk->first_pending?

If an unjoined additional subflow closes and __mptcp_close_ssk() calls
__mptcp_retransmit_pending_data(), msk->first_pending is reset while
msk->snd_nxt stays at msk->write_seq.  If the application then shuts down
the write side before the initial subflow re-pushes that reinjected data,
__mptcp_wr_shutdown() increments msk->write_seq by 1, and
mptcp_check_send_data_fin() returns early without advancing msk->snd_nxt:

net/mptcp/protocol.c:mptcp_check_send_data_fin() {
	if (!msk->snd_data_fin_enable || msk->snd_nxt + 1 !=3D msk->write_seq ||
	    mptcp_send_head(sk))
		return;

	WRITE_ONCE(msk->snd_nxt, msk->write_seq);
    ...
}

When mptcp_try_fallback() runs next, msk->snd_nxt + 1 =3D=3D msk->write_seq
holds, so it sets SEND_SHUTDOWN on ssk without advancing msk->snd_nxt to
msk->write_seq.  Setting SEND_SHUTDOWN stops __subflow_push_pending() from
pushing the reinjected data and calling mptcp_check_send_data_fin().  On
subsequent packets, mptcp_incoming_options() only advances msk->snd_una to
READ_ONCE(msk->snd_nxt) (msk->write_seq - 1), so
mptcp_pending_data_fin_ack() never sees msk->snd_una =3D=3D msk->write_seq =
and
a half-closed MPTCP socket stays stuck in TCP_FIN_WAIT1.

[Severity: Medium]
Does skipping tcp_shutdown() here stall connection termination when
fallback is triggered after the handshake in subflow_check_data_avail() or
mptcp_dss_corruption()?

When unsent data is queued and the socket has been shut down,
mptcp_try_fallback() now defers the FIN, relying on the caller to push the
pending data so mptcp_check_send_data_fin() can send the FIN afterward.
Unlike check_fully_established(), subflow_check_data_avail() and
mptcp_dss_corruption() run after mptcp_incoming_options() has already
finished (and returned early when OPTION_MPTCP_DSS was absent), and neither
calls __mptcp_check_push() after mptcp_try_fallback():

net/mptcp/subflow.c:subflow_check_data_avail() {
    ...
		if (!mptcp_try_fallback(ssk, MPTCP_MIB_DSSFALLBACK)) {
			/* fatal protocol error, close the socket */
			subflow->reset_transient =3D 0;
			subflow->reset_reason =3D MPTCP_RST_EMPTCP;
			goto reset;
		}
    ...
}

If the head of msk->rtx_queue also has unacknowledged already-sent data,
__mptcp_retrans() sees the fallback in __mptcp_push_retrans() and jumps to
clear_scheduled without calling mptcp_check_and_set_pending(sk).  If the
peer sends no more packets, the pending data and the deferred FIN are never
transmitted.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116-net-mptcp-=
misc-fixes-7-4-rc4-v1-0-bf7656de653e@kernel.org?part=3D6
