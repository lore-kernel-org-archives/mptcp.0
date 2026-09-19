Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 378F231F9B9
	for <mptcp@lists.linux.dev>; Sat, 19 Sep 2026 20:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789851232; cv=none; b=EOv36DUuKbNICj0XcMbm8uWxdLHFjJszU8ut52gxeFWOtI08WWoSat+P/UVPPnVYL/5ovD0GiqQcOsKJs7IiywSMikUC7FIXrReLH7zJ4A07BDQCvmhhlteIzTZ5X0fut5hBNrQ7yQ0OcpF+boD83mqgRoS3YZQ8FPmXFMjNFVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789851232; c=relaxed/simple;
	bh=juRyZ9vLrhMPY4ZdqXDb/H/wrW4PkDI+vwLwt4DN8YM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SKoZ716FCobfdcJfVy6fXskbzfGH+uLvB/t9eLhNCxikTRp2bfLSoutLuMxjQ96ekyJla+1bYQRkQ4pA8pnG4xUpo2MT4fR2lnp658YLjFU7DJW0pDF0dOiwBPjpGUAbzVtvIzQquio+HXa0VCnK/KW9q5kA2BgU02MkRgAN3lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i0Q6inl0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i0Q6inl0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 956551F000FF;
	Sat, 19 Sep 2026 20:53:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789851230;
	bh=FxAHG3VcXKnMBUeyQE2NX9bfWQvrLwNy5t8gaqgKQ4Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=i0Q6inl0FIHBddZHNyNmEKTaSFqBsk5sflLlQzhS2PqeZvzK8eA2CmXhcTcliVRor
	 V6k9Z/wWCJ3awxnpJfqUJAxBNZ9kM5M7UHe+RLzwQzmB6QZFZydMWfIWD4sXblgDc/
	 rJqwI/SXjypuM/hTgYenGk/USZsics0wvdlgqPgMyik5hHpAfKDSac0AQ+iRylQk4O
	 8pss5Z4xOeMvEIm++cLsOQFvYZxC7I85atIPMhgPr9X1bcmI1pxDosqNCm3cRzssKX
	 RhOWnMYYOWbTqNtOWZyCrgDiTVZm0YnmTAk5jjanuPaHDZJegmSMxeO2OckUMAhIxX
	 MegsrXP/ZNWng==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5.10.y 3/3] mptcp: close race between scheduler and
 state change
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWF0dGhpZXUgQmFlcnRzIChOR0kwKQ==?= <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
In-Reply-To: <20260919204002.2106015-8-matttbe@kernel.org>
References: <20260919204002.2106015-5-matttbe@kernel.org>
 <20260919204002.2106015-8-matttbe@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 19 Sep 2026 20:53:50 +0000
Message-Id: <20260919205350.956551F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] mptcp: skipped timer reset when mss_now is 0 leads to connection s=
tall
- [High] mptcp: allow_infinite_fallback state corruption when mss_now is 0
--

commit 4c31a1df5ba815467dd012d7f0c9b7bc2457aca9
Author: Paolo Abeni <pabeni@redhat.com>

mptcp: close race between scheduler and state change

This commit adds a check for mss_now being 0 to prevent a divide by zero
operation when selecting a subflow socket. It modifies mptcp_sendmsg and
mptcp_worker to only trigger tcp_push if both copied and mss_now are non-ze=
ro.

Link: https://patch.msgid.link/20260917-net-mptcp-misc-fixes-7-3-rc4-v2-2-0=
cf5c72667c8@kernel.org

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 292c21713eb7f..fdebc451e23aa 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -1381,7 +1381,7 @@ static int mptcp_sendmsg(struct sock *sk, struct ms=
ghdr *msg, size_t len)
>  	}
> =20
>  	mptcp_set_timeout(sk, ssk);
> -	if (copied) {
> +	if (copied && mss_now) {
>  		tcp_push(ssk, msg->msg_flags, mss_now, tcp_sk(ssk)->nonagle,
>  			 size_goal);
> =20
>  		/* start the timer, if it's not pending */
>  		if (!mptcp_timer_pending(sk))
>  			mptcp_reset_timer(sk);
>  	}

[Severity: High]
Does this unintentionally skip resetting the retransmit timer when mss_now
is 0?

If multiple fragments are sent and a subsequent fragment fails, it can leave
copied > 0 but mss_now =3D=3D 0. By bundling the timer initialization with =
the
mss_now check, this might prevent data queued to the MPTCP socket from being
retransmitted if the current subflow fails, potentially stalling the
connection.

[ ... ]

> @@ -1891,7 +1891,7 @@ static void mptcp_worker(struct work_struct *work)
>  		if (!mptcp_ext_cache_refill(msk))
>  			break;
>  	}
> -	if (copied) {
> +	if (copied && mss_now) {
>  		tcp_push(ssk, msg.msg_flags, mss_now, tcp_sk(ssk)->nonagle,
>  			 size_goal);
>  		WRITE_ONCE(msk->allow_infinite_fallback, false);
>  	}

[Severity: High]
Could skipping this block when mss_now is 0 cause allow_infinite_fallback
state corruption?

In mptcp_worker(), if a subflow failure occurs during retransmission causing
mss_now =3D=3D 0, copied might still be > 0. Skipping the update to
msk->allow_infinite_fallback could leave it as true even after MPTCP data
was successfully queued. A subsequent error might then trigger an invalid
fallback to plain TCP, corrupting the connection state and stream data.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260919204002.2106=
015-5-matttbe@kernel.org?part=3D3
