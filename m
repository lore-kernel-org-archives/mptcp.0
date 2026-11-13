Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794604253;
	b=mDFaiZE2X3sUbVadc117B85ucFrLPlCzttGoC/6oxbYH+ecVUklKt3BUh1jPEGzvFyXJ
	 986qKoWlcyoBR/I38wPkmq9H4wPMSzYkNgNb+Ok/m/D8e/Uvy73fY4PzJS4dHPEXpummI
	 iZLWUomjEuxejh/v5j3fcLNwHdkkNtTokdjUmLx+hdIl8TJWXmqHS4qvpctjY24PUSseR
	 oNcklLKkGlCcAD8VMANTmrRz7x8wUsltmWRauqKZrlS6toJHJeYgq6zhJG66i8Xewu4ia
	 1CyetwUsZssHaIDKc/w+YKQvjeD+Wf9H2D0mztxjqNS8SCQ83Mm+nhOtZ6cf01i0FaA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794604253;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=2CzPkly5TAHP9Fv1AQbj6xjOxCWCEZcaB2/H9XsLG9k=;
	b=V/xHYTJWOEiWfYqrO/EkW8T0i9jvkjWa19CMqEIWfeXR4ne3x9DFSMMoXf3knBwIhvT8
	 QJ8gRKBSRnlDkwECuaQdCHC8LQ0Icx8M8VHwM9KFvJ87aplognBCD6dX3ayDY6C3CNRum
	 anPqXFqD1g7UZ2E/8zFHmeLgYgLAH37c+mlFsIJZ9FuZ9wzl2Ojvfs0Cz8b0dV+58LFe3
	 JTS6nzOycuhIcroJp5L9BmyQM+y3h51+t4U1OTUbb+4l5jXlYdZyv9DIR9WnmkObWEEn+
	 D/jbMmUL9NguKg+pDt4wHV1l5iZf9n3YbI3Bwpv2Vxkd/ZYTM2FwV6QJJTXu4A3lXAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="njnI/8rj";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F0F4606A332
	for <mptcp@lists.linux.dev>; Fri, 13 Nov 2026 21:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=njnI/8rj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C01351F000C5;
	Fri, 13 Nov 2026 21:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794604253;
	bh=2CzPkly5TAHP9Fv1AQbj6xjOxCWCEZcaB2/H9XsLG9k=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=njnI/8rjuDwUs8NXzLnjbq61WgCpQNtkWSVnxR9PENIpHPNaHuyWVDW+BFf7YlSWn
	 HeFkvT9RSQQOCf8WiA9xNErkeoJzY0O6wDU4ZCP1K2ylC/y62zDbbyxxcc7hTn/OrD
	 /xWFipx7IpbEfJfGT1Uz4uiGjaEJaBLb1zn83q0N/cS1NKS1YG6Wj0Yrv930Zmw9Vr
	 j3lSo/ZXQY2tSptlKiEVd3cA6ON44M9HeRRzS4lz1Ou10dR94C51tZ+kpR2ovzkP8c
	 joYw0uKqlX7hKI9lKd2zzhlYfOek5zE7mrahjRd0oZDjt0AkovKJDEDNJzomcp8ei4
	 mFFg45Jx5XxaQ==
Message-ID: <sashiko-outbox-213692@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-net 10/34] mptcp: don't leak an orphan when the PM
 closes its last subflow
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWF0dGhpZXUgQmFlcnRzIChOR0kwKQ==?= <matttbe@kernel.org>, "MPTCP
 Linux" <mptcp@lists.linux.dev>
In-Reply-To: <20261113-mptcp-cmason-fixes-v1-10-9205b77e9a2f@kernel.org>
References: <20261113-mptcp-cmason-fixes-v1-0-9205b77e9a2f@kernel.org>
 <20261113-mptcp-cmason-fixes-v1-10-9205b77e9a2f@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 21:10:52 +0000
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found no new issues
in this patch, but noticed 1 related pre-existing issue it does not
introduce:
- [High] mptcp: skipped TCP_CLOSE cleanup for msk->first in
  mptcp_close_ssk() [1]
--

commit 9c49fccbfab6fbc60fdc19e95bb13b504edf3ebc
Author: Matthieu Baerts (NGI0) <matttbe@kernel.org>

mptcp: don't leak an orphan when the PM closes its last subflow

This commit expires the close timeout and schedules mptcp_worker() when
__mptcp_close_ssk() leaves an orphaned MPTCP socket with only a closed
initial subflow, instead of moving it directly to TCP_CLOSE.

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 16824bed85b42..6dc55a3f027bd 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -2794,8 +2794,13 @@ static void __mptcp_close_ssk(struct sock *sk, str=
uct sock *ssk,
>  	 */
>  	if (list_is_singular(&msk->conn_list) && msk->first &&
>  	    inet_sk_state_load(msk->first) =3D=3D TCP_CLOSE) {
> -		if (sk->sk_state !=3D TCP_ESTABLISHED ||
> -		    msk->in_accept_queue || sock_flag(sk, SOCK_DEAD)) {
> +		if (sock_flag(sk, SOCK_DEAD)) {
> +			/* let the worker close and destroy the orphan */
> +			mptcp_set_close_tout(sk, tcp_jiffies32 -
> +					     (mptcp_close_timeout(sk) + 1));
> +			mptcp_schedule_work(sk);
> +		} else if (sk->sk_state !=3D TCP_ESTABLISHED ||
> +			   msk->in_accept_queue) {
>  			mptcp_set_state(sk, TCP_CLOSE);
>  			mptcp_close_wake_up(sk);
>  		} else {

[Severity: High]
This problem wasn't introduced by this patch, but can mptcp_close_ssk() skip
this TCP_CLOSE cleanup for msk->first when it is half-closed first [1]?

When msk->first is gracefully closed before reaching TCP_CLOSE (for example,
on a subflow-level FIN without DATA_FIN or via mptcp_pm_rm_addr_or_subflow(=
))
while msk->free_first and msk->fastclosing are false, mptcp_close_ssk() sets
subflow->close_event_done =3D true and __mptcp_close_ssk() calls
__mptcp_subflow_disconnect(), which only runs tcp_shutdown(ssk, SEND_SHUTDO=
WN)
before jumping to out: while msk->first is still not in TCP_CLOSE:

net/mptcp/protocol.c:__mptcp_subflow_disconnect() {
	if (((1 << ssk->sk_state) & (TCPF_CLOSE | TCPF_LISTEN)) ||
	    fastclosing) {
    ...
		WARN_ON_ONCE(tcp_disconnect(ssk, 0));
		mptcp_subflow_ctx_reset(subflow);
	} else {
		tcp_shutdown(ssk, SEND_SHUTDOWN);
	}
}

net/mptcp/protocol.c:mptcp_close_ssk() {
	if (subflow->close_event_done || READ_ONCE(subflow->local_id) < 0)
		return;

	subflow->close_event_done =3D true;
    ...
	__mptcp_close_ssk(sk, ssk, subflow, MPTCP_CF_PUSH);
}

When the FIN handshake later completes and msk->first reaches TCP_CLOSE,
__mptcp_close_subflow() calls mptcp_close_ssk() again, which returns early
because subflow->close_event_done is already set.  As a result, msk->first =
is
never disconnected or reset, and if it is the last subflow in msk->conn_lis=
t,
the parent msk never starts its close timeout timer or transitions to
TCP_CLOSE.

[1] https://sashiko.dev/#/bug/linux-47cd2e29-62e6-4ad6-9246-4044e6d4b0e9

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113-mptcp-cmas=
on-fixes-v1-0-9205b77e9a2f@kernel.org?part=3D10
