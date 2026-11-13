Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794600787;
	b=GMdJEmg2vdP164zGetOR4EZzkonGY3ZklypISa1QhX7wbwKekD2Hc6Efgyn5qFpKNIUl
	 usYhEDqpRKadimaaS2hFDqjI0zruCZdZyHwtwXhbJx69UCYALbLlAIWCUxcQZfzMyAU5y
	 n4VVuVRKNdoQOxTSHTIN3JztDc9gGyXiJktZ/2ZdvCluArRUFek+hzeExopT4ub/fY+f5
	 97skXbPcND7YeE7JNiFZGwa6GR6fbI3Krl/OBopwiGd7YaOMPSK5eqCZ9YarDCuAjsRUm
	 vuefdkIF1bVSMWRh/skRimtFboCz1hDzQvFFfmf6QPNOjDrpq/kxDjpPKHnrWK+JB6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794600787;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=G529l611Q6y5q+nTlLQ2tRV//FiazeVsP8dac4kaRko=;
	b=vXadNVNbc/cqW1teQdvG/OHC/L7TrlHsL46homqNyXAb01Ea6SPHBSQmvbTDThDHIrxk
	 e3c/nsEFJT/GQd9qyYDN2ZPGi/axAj0Ieu9GvZXEGXJLbn7TXc2m4OR7uhNowfc7uawqc
	 jQujNoK9zeTx1AtwYqPquUO0QtkZF6A7bZl0+DRwOMwh6nVKZ4sPf980ln7BC6PDPZDQG
	 G9aQQn+ALeyPJ+1+ReBcse5X5QSPvHUQ6dHSOwjroyJr1yZ6mgn+WZ1JFH5sbF+u/OsqX
	 TWsUlWWgzsJe9SoyIfCYSVAjhUrQuGrlxR6bJzbEAKOydO+gnZwtHmboQdHQvZ0WFWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AmmaaUkm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A1D606A327
	for <mptcp@lists.linux.dev>; Fri, 13 Nov 2026 20:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AmmaaUkm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E392B1F000C8;
	Fri, 13 Nov 2026 20:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794600787;
	bh=G529l611Q6y5q+nTlLQ2tRV//FiazeVsP8dac4kaRko=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=AmmaaUkm22dLWbqs5DimYdWJ02DovRShbPAdEM/b3UY66ozeVIyP38B7q+vOzf2Qr
	 wZXblpW3zTxxYDBfE1/tpTdtLtnvvdWyqDz8LE3t0B0DLhRmYsUH8EIQG9NyFUCbBy
	 2LbtgNXnU/egkhKbLKJ7JWoVueoDfWPHhkxqrO+18X/iMFYOjFQwnUDtxyNm9t17vd
	 XddsMPa5KF5IG0iQzXqWOPm6sHN+tXj9nolPT+2ciVJtAH+wsWeK7XzAfYNoAv1rsw
	 AoRANQH6xpderb4fTPE/fJoUNW3PxJbKpjkB/zVxwdE4l9zjKCqimg8A3ItCvyeiKU
	 esbth8T6J0M1g==
Message-ID: <sashiko-outbox-213627@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-net 02/34] mptcp: drain the queues of a listen()
 that fails
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWF0dGhpZXUgQmFlcnRzIChOR0kwKQ==?= <matttbe@kernel.org>, "MPTCP
 Linux" <mptcp@lists.linux.dev>
In-Reply-To: <20261113-mptcp-cmason-fixes-v1-2-9205b77e9a2f@kernel.org>
References: <20261113-mptcp-cmason-fixes-v1-0-9205b77e9a2f@kernel.org>
 <20261113-mptcp-cmason-fixes-v1-2-9205b77e9a2f@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 20:13:04 +0000
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
- [High] mptcp: missing inuse add and state reset in
  mptcp_pm_nl_create_listen_socket() [1]
--

commit 2094b28eb838bd9f43ac4fd932bbfb028ce12096
Author: Chris Mason <mason@kernel.org>

mptcp: drain the queues of a listen() that fails

This commit cleans up the subflow accept queue and Fast Open RST queue in
mptcp_listen() when __inet_listen_sk() fails and leaves the subflow in
TCP_CLOSE.

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 50de5cedfd0fb..dd9fb803cad5f 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -4381,6 +4381,11 @@ static int mptcp_listen(struct socket *sock, int b=
acklog)
> =20
>  	lock_sock(ssk);
>  	err =3D __inet_listen_sk(ssk, backlog);
> +	if (err && ssk->sk_state =3D=3D TCP_CLOSE) {
> +		/* inet_csk_listen_start() leaves this drain to MPTCP */
> +		mptcp_subflow_queue_clean(sk, ssk);
> +		inet_csk_listen_stop(ssk);
> +	}
>  	release_sock(ssk);
>  	mptcp_set_state(sk, inet_sk_state_load(ssk));
> =20

[Severity: High]
This problem wasn't introduced by this patch, but does the other
__inet_listen_sk() caller in mptcp_pm_nl_create_listen_socket() [1]
miss updating newsk's state and sock_prot_inuse_add()?

net/mptcp/pm_kernel.c:mptcp_pm_nl_create_listen_socket() {
	...
	inet_sk_state_store(newsk, TCP_LISTEN);
	sock_set_flag(newsk, SOCK_RCU_FREE);
	lock_sock(ssk);
	WRITE_ONCE(mptcp_subflow_ctx(ssk)->pm_listener, true);
	err =3D __inet_listen_sk(ssk, backlog);
	if (!err)
		mptcp_event_pm_listener(ssk, MPTCP_EVENT_LISTENER_CREATED);
	release_sock(ssk);
	return err;
}

Unlike mptcp_listen(), mptcp_pm_nl_create_listen_socket() does not call
sock_prot_inuse_add() on success or reset newsk from ssk's state when
__inet_listen_sk() fails.  When the PM listener socket is later closed via
__mptcp_pm_release_addr_entry() -> __mptcp_close() ->
mptcp_check_listen_stop(), seeing newsk in TCP_LISTEN decrements the
per-netns protocol in-use counter without a matching increment and triggers
WARN_ON_ONCE(inet_sk_state_load(ssk) !=3D TCP_LISTEN) if __inet_listen_sk()
failed and left ssk in TCP_CLOSE.

[1] https://sashiko.dev/#/bug/linux-2c383603-dae6-4f8b-a0ea-d210d6d43b44

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113-mptcp-cmas=
on-fixes-v1-0-9205b77e9a2f@kernel.org?part=3D2
