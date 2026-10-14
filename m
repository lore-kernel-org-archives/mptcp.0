Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB195187F8
	for <mptcp@lists.linux.dev>; Wed, 14 Oct 2026 13:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791984489; cv=none; b=MLiL8+Jns9RcLhRhyZNQHCuYdj4iW8s7y228eYO/24Lgqys6pUz0c+QH99OJWuVph4JrWo4oNWaJf8+4To+n8zTz4wzq4CBaT70k6uJKbEAUJyVyXLGHu0WDH5RoueUVcRNOtlLBODIDIDCXaeEdruL58bRgwZp+TgDku1c64KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791984489; c=relaxed/simple;
	bh=XIWZwn/fFBX0j4U29YKtbPVaAzwlYgWZtqeXO+3T+yg=;
	h=Message-ID:From:Subject:To:In-Reply-To:References:Content-Type:
	 Date; b=SlFiN1HCFZJ3NrH4jHF6UCB698PRAzwILQeq3QBUTEUvdscUtOvqoVB6SUOb89gnIFKXUrXXteWDbIm9TqdZR4KOZkxcFYplWc9w4g5JzJQ+1IS0r+HH7DWEMHkPVLkj4AxmMRC1JtNAZH5J+445Knmk4x/NevqYzSKluHtvQ3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nb4iTV7N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nb4iTV7N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB11A1F00893;
	Wed, 14 Oct 2026 13:28:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791984484;
	bh=3iRx6bqLJ6JRTlMkDzvr+gcQz9pVVsrfLrvtjO+X8NI=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=Nb4iTV7NUZ5LhbfLR3rDxf+yRCoGSSnesAQrmWssUx5437B2vDJ/8GvkesifioM49
	 WN/wrAVUj7nGzJEArNyW5LFgH+J6Kf+fNRIfW5AMm+QGehsYOYKsytY5uO2RVVHSSD
	 WFHIV9r3x/cSTomyzDMUAehetoI5alVNkaWuaoay2qw6u8+9dsdso9IuYnU1Wrw9EP
	 vv/bRDNYWmx+u4Km6na2M6DDWz4qvx+nXxVk13lsS4wmzZh3rbpHS3EXHQRN+zXJLQ
	 jpGbB1TxcY0XVbg+EKkmKKwSW+4WEzPFF8BE6il58P13eIq3thNedyN4Kwgxf1oyQW
	 7aaBs4xwPWpBg==
Message-ID: <sashiko-outbox-171355@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v8] mptcp: normalize seq numbers reported in
 mptcp_info
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kalpan Jani" <kalpan.jani@mpiricsoftware.com>, mptcp@lists.linux.dev
In-Reply-To: <20261014130809.1874184-1-kalpan.jani@mpiricsoftware.com>
References: <20261014130809.1874184-1-kalpan.jani@mpiricsoftware.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 14 Oct 2026 13:28:04 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] mptcp: MPTCP_INFO seq numbers revert to absolute on disconnect
- [Medium] mptcp: MPTCP_INFO drops statistics for TCP_CLOSE sockets
--

commit 226e0982ada8f162a7c854a2bd67d3b843a4af48
Author: Kalpan Jani <kalpan.jani@mpiricsoftware.com>

    mptcp: normalize seq numbers reported in mptcp_info

    The commit changes MPTCP_INFO to report write_seq and snd_una relative =
to
    the local IDSN, and rcv_nxt relative to the peer's initial data sequence
    number. It reads these baselines from the subflow context under RCU,
    handles missing contexts, and skips disconnected sockets.

    Link: https://github.com/multipath-tcp/mptcp_net-next/issues/445

> diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
> index fcf6feb2a9eb5..76bab204fc33b 100644
> --- a/net/mptcp/sockopt.c
> +++ b/net/mptcp/sockopt.c
> @@ -982,7 +985,8 @@ void mptcp_diag_fill_info(struct mptcp_sock *msk, str=
uct mptcp_info *info)
>  	info->mptcpi_add_addr_accepted =3D READ_ONCE(msk->pm.add_addr_accepted);
>  	info->mptcpi_local_addr_used =3D READ_ONCE(msk->pm.local_addr_used);
> =20
> -	if (inet_sk_state_load(sk) =3D=3D TCP_LISTEN)
> +	if (inet_sk_state_load(sk) =3D=3D TCP_LISTEN ||
> +	    inet_sk_state_load(sk) =3D=3D TCP_CLOSE)
>  		return;

[Severity: Medium]
Will this early return cause MPTCP_INFO to drop final statistics for sockets
in the TCP_CLOSE state?

Since the info structure is zero-initialized at the start of the function,
returning early means userspace tools reading MPTCP_INFO on a fully closed
socket will see zeroes for all historical connection stats like
mptcpi_bytes_sent and mptcpi_retransmits, unlike standard TCP.

[ ... ]

> @@ -1008,9 +1012,23 @@ void mptcp_diag_fill_info(struct mptcp_sock *msk, =
struct mptcp_info *info)
>  	info->mptcpi_flags =3D flags;
> =20
>  	slow =3D lock_sock_fast(sk);
> +	/* Hold a reference to the first subflow while accessing its context. */
> +	rcu_read_lock();
> +	first =3D READ_ONCE(msk->first);
> +	if (first && !refcount_inc_not_zero(&first->sk_refcnt))
> +		first =3D NULL;
> +	rcu_read_unlock();
> +
> +	rcu_read_lock();
> +	subflow =3D first ?
> +		rcu_dereference(inet_csk(first)->icsk_ulp_data) : NULL;
> +	if (subflow)
> +		local_idsn =3D subflow->idsn;

[Severity: Medium]
Can local_idsn be read as zero if the first subflow was reset?

If the MPTCP connection survives but the first subflow is closed,
__mptcp_subflow_disconnect() invokes mptcp_subflow_ctx_reset(). This zeroes
the reset struct group, clearing subflow->idsn to 0.

If this occurs, subtracting 0 will suddenly expose raw absolute sequence
numbers to userspace instead of the intended relative values.

> +	rcu_read_unlock();
> +
>  	info->mptcpi_csum_enabled =3D READ_ONCE(msk->csum_enabled);
>  	info->mptcpi_token =3D msk->token;

[ ... ]

> @@ -1023,17 +1041,26 @@ void mptcp_diag_fill_info(struct mptcp_sock *msk,=
 struct mptcp_info *info)
>  	unlock_sock_fast(sk, slow);
> =20
>  	mptcp_data_lock(sk);
> +	rcu_read_lock();
> +	subflow =3D first ?
> +		rcu_dereference(inet_csk(first)->icsk_ulp_data) : NULL;
> +	if (subflow && subflow->remote_key_valid)
> +		remote_idsn =3D subflow->iasn - 1;

[Severity: Medium]
Similarly, can subflow->iasn be read as zero or bypassed here?

If mptcp_subflow_ctx_reset() has been called, subflow->remote_key_valid and
subflow->iasn are also zeroed out. This would cause remote_idsn to remain 0,
again exposing absolute sequence numbers for mptcpi_rcv_nxt.

> +	rcu_read_unlock();
>  	info->mptcpi_last_ack_recv =3D jiffies_to_msecs(now - msk->last_ack_rec=
v);
> -	info->mptcpi_snd_una =3D msk->snd_una;
> -	info->mptcpi_rcv_nxt =3D msk->ack_seq;
> +	info->mptcpi_snd_una =3D msk->snd_una - local_idsn;
> +	info->mptcpi_rcv_nxt =3D msk->ack_seq - remote_idsn;
>  	info->mptcpi_bytes_acked =3D msk->bytes_acked;
>  	mptcp_data_unlock(sk);
> +
> +	if (first)
> +		sock_put(first);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261014130809.1874=
184-1-kalpan.jani@mpiricsoftware.com?part=3D1
