Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B88A361949
	for <mptcp@lists.linux.dev>; Wed, 26 Aug 2026 16:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787761527; cv=none; b=EyntG16uZcuXYJR0ht/EUljTyGFiew9fbuhK8ylCx5z5Ivy7wtz8n5tFB/KPZQrkWkLuuidQBfxzR7Kqc85ceiFyJqhAnmfacNmYIYf5d5vKRRcP0ZsBX6lGxAcl11cDjD4rPwTKWSTvlp7PU+j8WDw7OIC71qNnkB5OXrGjrHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787761527; c=relaxed/simple;
	bh=SOGNVxiwWX7c2UTtryZ5OPNbFbhA6RYUmj6vsUA8EEQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iufk6M+4omo0OaKNjg/ZTAjdDjJ5VfB0EhQyfG2xwhwBDJUAxW5sLY3cIhQ64dhJLuwVpQHTNiu05RfQTtvEhCzxvfRRqeH2Ye1lxJqx/C/PNeyK9UhRs3uBf+QGzW2LLXINyVD8G6qT4Ybgo3zzuJJIKIXnJw5QSMDHP7xPdOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Erz8Y9AC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Erz8Y9AC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D5F91F000E9;
	Wed, 26 Aug 2026 16:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787761525;
	bh=w52R7deGBaZ7R7vKumsGFj3mWlmkARfgP7Pdej+Vp4w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Erz8Y9ACy8NgV40t7dkI7Pm8aUGAuje82mvL0pnqnvt/aJZyJq52nd5bkWaAzvGGa
	 dAthZ/lAj9mnrn2F3xeceypUw37jat/DaL1oaxUZflqRp5x9/lnbjB0IMZy6P/98HN
	 bRCc9qrMM25G+wRsHBTptC5drVpgSXmHwzKSH+HEovFUyGP8TkeJ51owO5kA+qz48w
	 Y0db0mcuLEv2O7uaxKVXZDOi6N08A2h51Bv0dFE/a24lahfGyihCbc6z0rToZ6IHNC
	 0yPWQrhmHTuxueH8y3s3cShqRifuiJfkheEckvpg5DbV/auIWlkmw/puVOXf0Xlhhw
	 dM96vp9AjHZlw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-net v2 2/2] Squash-to: "mptcp: do not reschedule
 the RTX timer for fallback sockets"
Reply-To: sashiko-reviews@lists.linux.dev
To: "Paolo Abeni" <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
In-Reply-To: <134b1453d11ffac177571c72b7832a6c62fa06df.1787760635.git.pabeni@redhat.com>
References: <cover.1787760635.git.pabeni@redhat.com>
 <134b1453d11ffac177571c72b7832a6c62fa06df.1787760635.git.pabeni@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 26 Aug 2026 16:25:25 +0000
Message-Id: <20260826162525.8D5F91F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The MPTCP retransmission timer is not properly enabled for active =
connections or on subsequent connect() retries due to an early return in su=
bflow_chk_local_id(), completely breaking MPTCP retransmissions.
--

commit d97031273df9e2f644d64a1baa6fef7afaac166d
Author: Paolo Abeni <pabeni@redhat.com>

Squash-to: "mptcp: do not reschedule the RTX timer for fallback sockets"

This patch changes the MPTCP RTX status tracking from a 'disabled' flag
to an 'enabled' flag across the msk lifecycle.

> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index 01db7edce18a6..ac35ffdaf37f6 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -634,6 +634,13 @@ static int subflow_chk_local_id(struct sock *sk)
>  	if (likely(subflow->local_id >=3D 0))
>  		return 0;
> =20
> +	/* Slightly unrelated, leverage this code path being called once per
> +	 * connection before sending the first packet. Early fallback could
> +	 * take place at mptcp_connect() time.
> +	 */
> +	if (!__mptcp_check_fallback(msk))
> +		set_bit(MPTCP_RTX_ENABLED, &msk->flags);
> +

[Severity: High]
Will this flag setup ever be reached for the first subflow?

Looking at active connections, __mptcp_socket_create() explicitly
initializes the first subflow with local_id =3D 0:

net/mptcp/protocol.c:__mptcp_socket_create() {
	...
	/* This is the first subflow, always with id 0 */
	WRITE_ONCE(subflow->local_id, 0);
	...
}

When packet transmission calls subflow_chk_local_id(), the early return for
subflow->local_id >=3D 0 evaluates to true (0 >=3D 0), bypassing the call
to set_bit() for the MPTCP_RTX_ENABLED flag.

Because the patch flips the flag semantics from 'DISABLED' to 'ENABLED', th=
is
leaves the timer permanently bypassed in mptcp_reset_rtx_timer() since the
flag is never set for active connections.

Additionally, when mptcp_set_state() clears this flag on the first connect()
failure during TCP_CLOSE, the flag fails to be set on retry because the
subflow is reused with local_id =3D 0, leaving the timer disabled during
retries as well. Can this be adjusted to ensure the flag is properly set
for active connections?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1787760635.gi=
t.pabeni@redhat.com?part=3D2
