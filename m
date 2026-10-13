Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F85459ACF
	for <mptcp@lists.linux.dev>; Tue, 13 Oct 2026 03:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791861093; cv=none; b=JAzXXGWNpM1/DLmgfcyJxTKhakdhu8WWka3GlMeHhFmRF9kL+Z9wHR2rtbF+uR2B4jIegL9zVaTt12YAGVCLiFN+thMFuwg+nYEMn0jH0dOOdz0Z7oveLmlZoI/4NEyk4TP+/CjjSlhUBqEM2clmBYgLGT9MXKTJkrfSEHHvLhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791861093; c=relaxed/simple;
	bh=L4oMXA/p0laA+FkR6Cf/xOthEzbBeyHBX6zNP1jfUS0=;
	h=Message-ID:From:Subject:To:In-Reply-To:References:Content-Type:
	 Date; b=Fdsn/Dh6KrSt+qaY0xsqf3Sl6ZsZyAfmhHv0Zi9XwP7p+CidfUkrcrN4mjZ5jFyDNVKebVoX15LYvKLUk5+KYW1BNS3pYbgFlx/MyZ2T20LRpoASW9qNZhnkRSzI8xVbR4tkG6v7zTNekBTvKLgbSHetrIPYh3lifMQjCM9y8X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VoobE8mU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VoobE8mU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 252251F000FF;
	Tue, 13 Oct 2026 03:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791861092;
	bh=5Sr0dv8JV+jUcXbUOPnc/kRNrmzHIjtOz3rDsrAdouk=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=VoobE8mUb8FiM+gUDm/pAzg59g3F8g1AHw2CG3fnu3Lr/wRfp2vqzLFbg1K5s5lUs
	 tFowXqlvyM9vZb2Vh47Ov2rmMU1g7drlcvAXkL3EswdHZeyqI186+I4JnW2TCwb+JM
	 fXqig+4xkGILyQ8ZDIh65wAUvBlkL+Tk5bukOl8Sp7Bf+RmfFto4gRxx3IGN1h/C3C
	 TqkkJtN5/GtUItSQW4gL4h2Y4gs5i8B4ElHImsjT4ApPIZ0ZCQLci2GTkIsB6ztx9C
	 5Z0QfdsPIv2okD2Fmz6EU56ayFNFcbK/J5YqKLBCjRmNR8KeSlwWE9+D0FPQ7rOvrg
	 +OMYcfagrf+PQ==
Message-ID: <sashiko-outbox-168893@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH mptcp-next v2 2/3] mptcp: pm: kernel: retry subflows
 closed after an error
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anil Kaushik" <anilkaushikwireless@gmail.com>, mptcp@lists.linux.dev
In-Reply-To: <20261013025653.523755-3-anilkaushikwireless@gmail.com>
References: <20261013025653.523755-1-anilkaushikwireless@gmail.com>
 <20261013025653.523755-3-anilkaushikwireless@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 03:11:31 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] mptcp: lockdep warning due to missing nested annotation in mptcp=
_subflow_reconnect()
--

commit 0bd36d5db0e57b64ed74ede4cce6a078baf37f44
Author: Anil Kaushik <anilkaushikwireless@gmail.com>

mptcp: pm: kernel: retry subflows closed after an error

This commit adds an opt-in sysctl to retry MPTCP subflows closed after
an error. It reuses the same socket for the next attempt if it cannot
connect, avoiding the need for extra state or timers.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/440

> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index 78e886b202585..0f1d3fae446e2 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c

[ ... ]

> @@ -1766,6 +1766,59 @@ int __mptcp_subflow_connect(struct sock *sk, const=
 struct mptcp_pm_local *local,
>  	return err;
>  }
> =20
> +/* Connect again an MPJ subflow that failed to connect, with the same so=
cket.
> + * The subflow never carried data: like for the initial subflow in
> + * __mptcp_subflow_disconnect(), resetting the TCP and the subflow state=
s is
> + * enough. Called with the msk socket lock held.
> + */
> +int mptcp_subflow_reconnect(struct sock *sk, struct sock *ssk,
> +			    const struct mptcp_pm_local *local,
> +			    const struct mptcp_addr_info *remote)
> +{
> +	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(ssk);
> +	struct mptcp_sock *msk =3D mptcp_sk(sk);
> +	struct sockaddr_storage addr;
> +	u32 remote_token;
> +	int addrlen;
> +	int err;
> +
> +	lock_sock(ssk);

[Severity: Medium]
Will this lock_sock(ssk) trigger a lockdep splat?

The function documentation states it is called with the msk socket lock
held. Since MPTCP sockets and their TCP subflows share the same lockdep
class, acquiring the child subflow lock while the parent socket lock is
already held might be seen as a recursive locking deadlock by lockdep.

Should this use lock_sock_nested(ssk, SINGLE_DEPTH_NESTING) to avoid
system panics when CONFIG_PANIC_ON_WARN is enabled?

> +	err =3D tcp_disconnect(ssk, 0);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013025653.5237=
55-1-anilkaushikwireless@gmail.com?part=3D2
