Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792485459;
	b=TN/TWkrxIL50sedlU0hKCDOTaErlNPgScAoNDEM07rdhvfN54ud1vIQajQn6xqTGHON4
	 EYbpZ8nCXRXXbKW+Y5vQn6nMlgCPWtTffqp/ubrdc3h41LJUtMH2B9KPKPS0O2bt5cwLf
	 FltI1v0623HpG9MYp/tfYCfuFdPggI+RXT1vyXgLs0OdkM4712gHm7AsUvOkF7bTlZ9QW
	 JOe8WZ7j6CtQwkLD4Quavui2JJ5wo4KQbEtQRDCfNDeOpuNrkRSX7hGa4JIZhc2Bs4SSk
	 pWQJ9BrRAiDAxm+yqhoQYDVfZDM54OHTLxC8blK4qOLW88VIhZ2O2AEs6VaBWxNqMzQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792485459;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=naUDatEcSsotN09pW0WMIIE0q8qvzl9cpzTuv7LPKjY=;
	b=j+49JkGAaGuLAjN0lmip0aMazfaG4Ls1Xly5QpzoxcSVWPzrW6b/VjTtsgY8/m2CBb0n
	 r7SsFi2+bgy2H6B9jXZEU3FR9x7Gv2H/iSumr/JFbj4aUV0VARwbi31dzxiwG746OYbqV
	 fHee6S/GlvuF1sLWEBwCeIFDplg0om1GOaX+jqZXOt1y+DNwKckSWJtEaX/aqRRISIomu
	 BzUONbCa5uPw6vgfr92q6KTWTOtbB8/TkM6k0xXLuWbMAOP1KXvAQbdeWpsZyY7a7/XNN
	 qewsu6CJv5bITOHr1qxWxuDFT23pYTN3UAzSGuU+8J6zDROz5/fcHUNiSjg0dDNFl9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QDNDmsAn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76333606A319
	for <mptcp@lists.linux.dev>; Tue, 20 Oct 2026 08:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QDNDmsAn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DFE31F000C4;
	Tue, 20 Oct 2026 08:37:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792485459;
	bh=naUDatEcSsotN09pW0WMIIE0q8qvzl9cpzTuv7LPKjY=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=QDNDmsAn96Y9rztBiKiWYpjSu6RYvIWblTEOCK2Xm3mtlchiYItAnQwHJs+QymcT+
	 ETOxkz8y0Mj422Bg8ES6bfnFqgGNqOM5uvVix/AvIe1RjdB3sy6fAxPoexe2GAnS0Y
	 yES2nt9efwbXhkHyjQfhKyvKwLE1WwO5d+QYmOoUTCb+oIpT2++nogyvQuvqAQyYdD
	 7ilMYFhlHK8vRh03yKZpiFs+9lQOSVnf8YT62glTRxDjmfcn6D1uWg54Y44Ut7mIhD
	 LgiHWsR1mjy1s45YB8RZ07jgGbtZLhuzR+GS5kKYoJv3xM/gzShOt8KuWb34Pm5hvt
	 VxQs1sPtBcQLA==
Message-ID: <sashiko-outbox-178583@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-next v7 4/6] mptcp: pm: in-kernel: retry subflows
 closed after an error
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anil Kaushik" <anilkaushikwireless@gmail.com>, mptcp@lists.linux.dev
In-Reply-To: <20261020031711.1896660-5-anilkaushikwireless@gmail.com>
References: <20261020031711.1896660-1-anilkaushikwireless@gmail.com>
 <20261020031711.1896660-5-anilkaushikwireless@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 08:37:38 +0000
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] mptcp: __mptcp_close() disconnects retry subflows before closing=
 them
--

commit e4e5fe628ce5b62d531a83ca2d2c9088740581ed
Author: Anil Kaushik <anilkaushikwireless@gmail.com>

mptcp: pm: in-kernel: retry subflows closed after an error

This commit teaches the in-kernel path manager to re-create established
subflows that were initiated locally and closed after a path error such
as a retransmission or keepalive timeout. It also closes any re-created
subflows that are still connecting when the MPTCP socket is closed.

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 60cbd91be6320..5cee1ed788caa 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c

[ ... ]

> @@ -3494,6 +3499,26 @@ static void mptcp_check_listen_stop(struct sock *s=
k)
>  	release_sock(ssk);
>  }
> =20
> +/* Re-created subflows still connecting are useless once the msk is clos=
ed,
> + * and their SYN retransmissions could keep them around for a long time.
> + */
> +static void mptcp_close_retry_subflows(struct sock *sk)
> +{
> +	struct mptcp_subflow_context *subflow, *tmp;
> +	struct mptcp_sock *msk =3D mptcp_sk(sk);
> +
> +	mptcp_for_each_subflow_safe(msk, subflow, tmp) {
> +		struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
> +
> +		if (!subflow->retry || inet_sk_state_load(ssk) !=3D TCP_SYN_SENT)
> +			continue;
> +
> +		/* it never carried data: nothing to push or re-inject */
> +		mptcp_pm_subflow_check_next(msk, subflow);
> +		__mptcp_close_ssk(sk, ssk, subflow, 0);
> +	}
> +}
> +
>  bool __mptcp_close(struct sock *sk, long timeout)
>  {
>  	struct mptcp_subflow_context *subflow;
> @@ -3520,6 +3545,8 @@ bool __mptcp_close(struct sock *sk, long timeout)
>  		__mptcp_wr_shutdown(sk);
>  	}
> =20
> +	mptcp_close_retry_subflows(sk);
> +
>  	sk_stream_wait_close(sk, timeout);
> =20
>  cleanup:

[Severity: Medium]
Should mptcp_close_retry_subflows() be called before mptcp_do_fastclose()
and __mptcp_wr_shutdown(), or also handle retry subflows that have already
been disconnected?

When closing an established or TCP_CLOSE_WAIT MPTCP socket that has no
unsent data queued in mptcp_send_head(sk), __mptcp_wr_shutdown() calls
mptcp_check_send_data_fin(), which iterates over msk->conn_list and calls
mptcp_subflow_shutdown(sk, tcp_sk, SEND_SHUTDOWN) on every subflow:

net/mptcp/protocol.c:mptcp_subflow_shutdown() {
	...
	switch (ssk->sk_state) {
	case TCP_LISTEN:
		break;
	case TCP_SYN_SENT:
		WARN_ON_ONCE(tcp_disconnect(ssk, O_NONBLOCK));
		break;
	...
}

For a retry subflow in TCP_SYN_SENT, tcp_disconnect() sets ssk->sk_state to
TCP_CLOSE without invoking sk_state_change, unlinking the subflow from
msk->conn_list, or decrementing msk->pm.extra_subflows.

When mptcp_close_retry_subflows() runs right after __mptcp_wr_shutdown() (or
during close() after an earlier shutdown(fd, SHUT_WR)), it checks for
TCP_SYN_SENT:

	if (!subflow->retry || inet_sk_state_load(ssk) !=3D TCP_SYN_SENT)
		continue;

Because ssk->sk_state is already TCP_CLOSE, mptcp_close_retry_subflows()
skips the retry subflow. This leaves msk->pm.extra_subflows incremented and
leaves the disconnected retry subflow on msk->conn_list, which can also
prevent sk->sk_state from transitioning to TCP_CLOSE before
sk_stream_wait_close(sk, timeout) when all other subflows are already
closed.

Similarly, on the fastclose path, calling mptcp_do_fastclose() before
mptcp_close_retry_subflows() calls tcp_send_active_reset() on the
TCP_SYN_SENT retry subflow before mptcp_close_retry_subflows() can close it.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261020031711.1896=
660-1-anilkaushikwireless@gmail.com?part=3D4
