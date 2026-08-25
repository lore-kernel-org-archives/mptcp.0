Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C18D3FF8B9
	for <mptcp@lists.linux.dev>; Tue, 25 Aug 2026 11:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787658697; cv=none; b=QvpLzMVLlh11c9wxWGfmg8dBLUc1Fk5ZUzX587rpx34BOaaDAookQQJvzl8yMzySyXVLTWshsMhW1LloDbo03bTnOnaZ3MtMTxmRd6Mns53WsbIRbQGYXOGIAVZMNlJJUP0agrEnTz5nuMQiHmCumAC5WbIsXfysav5uzl71IXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787658697; c=relaxed/simple;
	bh=D+9jb6pYfsvxF1DulPcojSNorTX7TSyP2zjYUqgG4/o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Wz5fMsJ6rNhYztja+RgN2k5bnUxOKgcmASW6KACcsqdxekIWNz6t8e/NwgepLIoc/QXZI/o+R+Kb83KfRFtZ2QqHcm3C8A7Z6VUfWs6poxG8IaUGPltphTEAXIXiB36eCH4s4fsNBCcXrcFv+yuoWiZh0ck6ufe+6PE9yPqOul4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jcmoYtFc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jcmoYtFc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B746F1F000E9;
	Tue, 25 Aug 2026 11:51:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787658695;
	bh=SoJ9PxZLfYf7CiApKG+sk5+gohT7eAN8Og+lJzH9Ivo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jcmoYtFcd0vE9vJ15D0WDBXmV0sBpw3/km7kpp8Z8w++N6RVKuIebeXArz5Uf4ofb
	 uebwPano2wD1wTCrv6b0VE84paSYUlrdFzbDNaVKA0tBTiRjEEU3E4yJc0+D8I5g8k
	 l85lBxhmYhb1zGaXK/l0s+7kI6rFFW7vhmLI8GeivCtP6E6nv+fS+zKn8CtUKWzEaq
	 b1mofxUnthnGrheoJX3lJDr/hfWC4yrWQCQO9j21X71PeKkMDd4J9xOFyRgK9Wbctw
	 DtPYROW3HOhWlr6B1lK9j+diD7jnYKrHaBs2RtM7SyDEKaGehc/jPwTewMHK2fZ9WQ
	 E/FFrcfSHeR7Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next] mptcp: normalize seq numbers reported in
 mptcp_info
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kalpan Jani" <kalpan.jani@mpiricsoftware.com>
Cc: mptcp@lists.linux.dev
In-Reply-To: <20260825113355.3573376-1-kalpan.jani@mpiricsoftware.com>
References: <20260825113355.3573376-1-kalpan.jani@mpiricsoftware.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 25 Aug 2026 11:51:35 +0000
Message-Id: <20260825115135.B746F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Asymmetric normalization of local and remote sequence numbers cr=
eates an off-by-one inconsistency in MPTCP_INFO.
--

--- Patch [1]: [PATCH net-next] mptcp: normalize seq numbers reported in mp=
tcp_info ---
commit 6231029f4c06cd4480ab1f97fc9151acd4862390
Author: Kalpan Jani <kalpan.jani@mpiricsoftware.com>

mptcp: normalize seq numbers reported in mptcp_info

This commit normalizes the sequence numbers reported by mptcp_info.
It caches the local and remote initial sequence numbers and subtracts them
in mptcp_diag_fill_info() so the diagnostic fields start near 0.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/445

> diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
> index fcf6feb2a9eb5..0468099b19bfc 100644
> --- a/net/mptcp/sockopt.c
> +++ b/net/mptcp/sockopt.c
[ ... ]
> @@ -1010,7 +1010,7 @@ void mptcp_diag_fill_info(struct mptcp_sock *msk, s=
truct mptcp_info *info)
>  	slow =3D lock_sock_fast(sk);
>  	info->mptcpi_csum_enabled =3D READ_ONCE(msk->csum_enabled);
>  	info->mptcpi_token =3D msk->token;
> -	info->mptcpi_write_seq =3D msk->write_seq;
> +	info->mptcpi_write_seq =3D msk->write_seq - msk->local_idsn;
>  	info->mptcpi_retransmits =3D inet_csk(sk)->icsk_retransmits;
>  	info->mptcpi_bytes_sent =3D msk->bytes_sent;
>  	info->mptcpi_bytes_received =3D msk->bytes_received;
[ ... ]
> @@ -1024,8 +1024,8 @@ void mptcp_diag_fill_info(struct mptcp_sock *msk, s=
truct mptcp_info *info)
> =20
>  	mptcp_data_lock(sk);
>  	info->mptcpi_last_ack_recv =3D jiffies_to_msecs(now - msk->last_ack_rec=
v);
> -	info->mptcpi_snd_una =3D msk->snd_una;
> -	info->mptcpi_rcv_nxt =3D msk->ack_seq;
> +	info->mptcpi_snd_una =3D msk->snd_una - msk->local_idsn;
> +	info->mptcpi_rcv_nxt =3D msk->ack_seq - msk->remote_idsn;
>  	info->mptcpi_bytes_acked =3D msk->bytes_acked;
>  	mptcp_data_unlock(sk);
>  }
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index af81ad5e699d1..4fa19835c4055 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -465,6 +465,7 @@ void __mptcp_sync_state(struct sock *sk, int state)
>  		 * even for the FASTOPEN scenarios
>  		 */
>  		WRITE_ONCE(msk->write_seq, subflow->idsn + 1);
> +		WRITE_ONCE(msk->local_idsn, subflow->idsn);
>  		WRITE_ONCE(msk->snd_nxt, msk->write_seq);
>  		mptcp_set_state(sk, state);
>  		sk->sk_state_change(sk);
[ ... ]
> @@ -491,6 +492,7 @@ static void subflow_set_remote_key(struct mptcp_sock =
*msk,
> =20
>  	WRITE_ONCE(msk->remote_key, subflow->remote_key);
>  	WRITE_ONCE(msk->ack_seq, subflow->iasn);
> +	WRITE_ONCE(msk->remote_idsn, subflow->iasn);

[Severity: Medium]
Will this result in an asymmetric baseline where mptcpi_write_seq and
mptcpi_snd_una start at 1, while mptcpi_rcv_nxt starts at 0?

Looking at subflow_set_remote_key(), subflow->iasn is incremented before it=
 is
assigned to msk->remote_idsn:

	mptcp_crypto_key_sha(subflow->remote_key, NULL, &subflow->iasn);
	subflow->iasn++;

However, in __mptcp_sync_state(), msk->local_idsn is assigned the unincreme=
nted
subflow->idsn:

	WRITE_ONCE(msk->write_seq, subflow->idsn + 1);
	WRITE_ONCE(msk->local_idsn, subflow->idsn);

When these are subtracted in mptcp_diag_fill_info(), msk->write_seq (which =
is
subflow->idsn + 1) minus msk->local_idsn results in 1, while msk->ack_seq m=
inus
msk->remote_idsn results in 0.

Should msk->local_idsn and msk->remote_idsn both use either the incremented=
 or
unincremented hash to ensure the normalized sequences start at the same val=
ue?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260825113355.3573=
376-1-kalpan.jani@mpiricsoftware.com?part=3D1
