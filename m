Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795423011;
	b=MDf5Ac03QSxLeIPo+U4Qle6wcgyY7iDktJBoNskAeuiAav20ppt+4V4IR95idWsq5lf3
	 8MoAPLOkxLklB9Lfd/9IypCkHTu9PY+kKiws03r7VH3MtfxNdokoKFk+Y+insIjdm17Oh
	 Bbl+7G5ptRzoAvFLh8SsmEARtVlfE8oKg0C+BM6Z5PwXPdgBlHfcZ2WWP+o5nbsIjaP3h
	 Y+M4nDHWUTQE6hJr69k4OnTmsuooKP0SjlLga9gDFfxciKB2krFYVw6EoU0UJeqa32R2P
	 wM+UOmFekYVKJ0cqDuoX1P3GsNBwnd4szosX5QcA1+Qmapusg1TbqTWprYgBpz1K4pQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795423011;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=7UeuLbFnO4C209RBZnp//m9tcTDY+itsPFkTX+Vrq6I=;
	b=RGI6sCrLaavNDMI23HyBjegW6x5m0RxSQmY2v0CT5m8JMzQPsPoWSBJAc5SEmtvAYGVG
	 Fo/FCfDq1dhfHG1e+s17Zy01UtoKfn+QM3TDKR5Jyq2ziPvfUbUCZwsuZIHqzjxnDPyme
	 DObdL0E1b9bum1qvVPl+DXU6xKbuaEPhsxCC3Ho2pJyJTNAlztb94JbMPr2OtT8SBN5WJ
	 lP+vIOgs/2nrvepvGWeDndVb1b3EH60lhRm0X3iCkxZybJlf0yJ079lbVceDlBqOTfM4V
	 DIP/8knzWgafIQRJu4h/+j+MHY08+cJyhgEYaSmhEig6Ci9Br/DzS//15S05Qk5Bv0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="DeqI/srH";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB9B606A31A
	for <mptcp@lists.linux.dev>; Mon, 23 Nov 2026 08:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DeqI/srH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5727B1F000CF;
	Mon, 23 Nov 2026 08:36:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795423010;
	bh=7UeuLbFnO4C209RBZnp//m9tcTDY+itsPFkTX+Vrq6I=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=DeqI/srH36D3JuH03J2NaZCzlQ62lp4+PKOh2g2gaq6O+bdmTHzU+Pnla6tD0aztC
	 roN6QqiUybAGTAmB04yuCnCEkUs8bE5R95YwoqmH8B4vvNQK5s7sWxtfwSkofDqPDw
	 ekw8C7KCf54VSn/SXKkaiT0LXNC36E/FDYDVENMAVeSvpWsY4blPy6WYoa2H9nz4Xm
	 ashruWTVf2DvoizTU1Hl4g8UocYVQJhHQ66YmZtUNoQLo1PwTMzCXg8mXkrCmiwLPf
	 3wTQ08QDA2D+o3ACR/nelt6Nd/OFHZ7dBRr8TLmC+RK4GqgXPKBFK2HavdPk0MWeqp
	 kt12dM6QdUs9g==
Message-ID: <sashiko-outbox-228906@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-next v8 5/7] mptcp: handle SO_ZEROCOPY in
 setsockopt
Reply-To: sashiko-reviews@lists.linux.dev
To: "Geliang Tang" <geliang@kernel.org>, mptcp@lists.linux.dev
In-Reply-To: <154898fde8a9acdf6562d2adda67ebfe3ddd7246.1795421388.git.tanggeliang@kylinos.cn>
References: <cover.1795421388.git.tanggeliang@kylinos.cn>
 <154898fde8a9acdf6562d2adda67ebfe3ddd7246.1795421388.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 Nov 2026 08:36:49 +0000
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] mptcp: SO_ZEROCOPY lost on passive TCP fallback in
  mptcp_stream_accept()
--

commit 9eb510c1b5396bee88c876458fbf9feb12e69c9b
Author: Geliang Tang <geliang@kernel.org>

mptcp: handle SO_ZEROCOPY in setsockopt

This commit adds SO_ZEROCOPY support to MPTCP setsockopt by setting
SOCK_ZEROCOPY on the MPTCP socket.

> diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
> index 922f6ae5c80cb..889c17da3f773 100644
> --- a/net/mptcp/sockopt.c
> +++ b/net/mptcp/sockopt.c
> @@ -184,6 +184,19 @@ static int mptcp_setsockopt_sol_socket_tstamp(struct=
 mptcp_sock *msk, int optnam
>  	return 0;
>  }
> =20
> +static int mptcp_setsockopt_sol_socket_zerocopy(struct mptcp_sock *msk, =
int val)
> +{
> +	struct sock *sk =3D (struct sock *)msk;
> +
> +	if (val !=3D 0 && val !=3D 1)
> +		return -EINVAL;
> +
> +	lock_sock(sk);
> +	sock_valbool_flag(sk, SOCK_ZEROCOPY, val);
> +	release_sock(sk);
> +	return 0;
> +}

[Severity: Medium]
Does setting SOCK_ZEROCOPY only on msk lose the option when a listening
MPTCP socket accepts a non-MP_CAPABLE peer and falls back to plain TCP?

On passive fallback, subflow_syn_recv_sock() clones the child socket from
the listening TCP subflow (msk->first) rather than from msk, and
mptcp_stream_accept() grafts that plain TCP child onto newsock with plain
TCP ops.  Because mptcp_setsockopt_sol_socket_zerocopy() and
sync_socket_options() do not propagate SOCK_ZEROCOPY to subflows, the
accepted fallback socket has SOCK_ZEROCOPY cleared: subsequent
getsockopt(SO_ZEROCOPY) returns 0 and sendmsg(MSG_ZEROCOPY) silently falls
back to copying in tcp_sendmsg_locked() without queuing completion
notifications on MSG_ERRQUEUE.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1795421388.gi=
t.tanggeliang@kylinos.cn?part=3D5
