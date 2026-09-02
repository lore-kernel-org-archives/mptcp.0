Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4531444CADC
	for <mptcp@lists.linux.dev>; Wed,  2 Sep 2026 10:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788345410; cv=none; b=PAbcC3knF0qUFgxheLmr72jeULdGMcnlsaQMB7e5u8q+0G7M918nikAFlPnKzw0z3YLoIi1Jg+Q4Nxdl6mbZkfahehuq0herV96mty2N56U+ypTsg6QNE+XCOiBg9pjH7gtv1cNmL53MApvJctp3STNVTH9OQYccPekvHKsV+0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788345410; c=relaxed/simple;
	bh=hxH5UbwUe/Pg4Gi0aWSBoUj/l6gCqI597qqfYLKsJCc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=anpj9Qn+ST2sB4vnYTh2vgg+RPpvjtP/1+ieExWT6JYl3L5ZG0RUbSXrOBWpirz6h7xZRgEYgWTb9bNfh7tYawJPMS0kQ1eEeKlOJc/T0HWqanP0PF3woZkEqxQzbTJmbA2ytpVnKc90mQC2dcZLv/LvelbtVerwNfdtFR8E7dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j6Z8N1wt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j6Z8N1wt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04FD81F000E9;
	Wed,  2 Sep 2026 10:36:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788345409;
	bh=A0F9D95bCVqmOMdyrIvWy6xG3ssPLx14tmYDBhLG354=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=j6Z8N1wtbLmUbQ1BkoWrrqe/xcsYlntKdooFPccjCnsmqbzAZJtU01Oe4MhBxaaOP
	 t575jeOL2XU+ncOGHyteb5+rSmLCn1RkZ/pUivbOUjugVHnLzC1qM89YWcjqC8USBh
	 X/CqQFlQWP0ww4WYgHaTYWM15MtzTZC10vm59WCB7FUDtkUs0vUJdG1VBz2AywRzgV
	 NESCzxnKYOo2CiJPsdGXoCJqEeoSlZaF3vQVTot5DnIWHjofB7AiyR1/MVfv5P3GQu
	 GCJMyBPO3kcViOnfKxwngbv57VS6LXvPZFzE6wpTNKQo0GCNWywyS64yZV9QYE0C6U
	 uRvXB+ivms1Mg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v3] mptcp: normalize seq numbers reported in
 mptcp_info
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kalpan Jani" <kalpan.jani@mpiricsoftware.com>
Cc: mptcp@lists.linux.dev
In-Reply-To: <20260902102125.2035540-1-kalpan.jani@mpiricsoftware.com>
References: <20260902102125.2035540-1-kalpan.jani@mpiricsoftware.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 10:36:48 +0000
Message-Id: <20260902103649.04FD81F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Critical] Changing existing UAPI sequence fields from absolute to relati=
ve breaks backwards compatibility.
- [High] Normalization falls back to 0 when `msk->first` is NULL, causing m=
assive UAPI metric jumps for closed sockets.
- [Medium] Data race on `subflow->iasn` and `subflow->remote_key_valid` yie=
lds corrupted UAPI values.
--

commit 630c5d1d1841bed28f7903466f4319e79bf43c4c
Author: Kalpan Jani <kalpan.jani@mpiricsoftware.com>

mptcp: normalize seq numbers reported in mptcp_info

mptcpi_write_seq, mptcpi_snd_una and mptcpi_rcv_nxt report the raw
64-bit data sequence numbers, seeded from the connection's IDSN/IASN.
Since the IDSN/IASN come from mptcp_crypto_key_sha(), these fields
carry an effectively random offset and are not useful to userspace as
absolute values. This commit normalizes mptcpi_write_seq, mptcpi_snd_una
and mptcpi_rcv_nxt in mptcp_diag_fill_info() by subtracting the local and
remote initial sequence numbers.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/445

> diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
> index fcf6feb2a9eb5..88bd75672c96e 100644
> --- a/net/mptcp/sockopt.c
> +++ b/net/mptcp/sockopt.c
[ ... ]
> @@ -1008,9 +1009,22 @@ void mptcp_diag_fill_info(struct mptcp_sock *msk, =
struct mptcp_info *info)
>  	info->mptcpi_flags =3D flags;
> =20
>  	slow =3D lock_sock_fast(sk);
> +
> +	if (msk->first) {
> +		struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(msk->first=
);
> +
> +		local_idsn =3D subflow->idsn;
> +		/* subflow->iasn is incremented once in subflow_set_remote_key()
> +		 * to account for the peer's virtual SYN; undo that here so
> +		 * rcv_nxt normalizes against the same baseline write_seq and
> +		 * snd_una use.
> +		 */
> +		remote_idsn =3D subflow->remote_key_valid ? subflow->iasn - 1 : 0;

[Severity: High]
When the MPTCP connection enters TCP_CLOSE, msk->first can be set to NULL.
When diagnostic queries execute mptcp_diag_fill_info(), local_idsn and
remote_idsn will remain 0.

Does subtracting 0 cause the UAPI output to abruptly revert to the raw 64-b=
it
absolute sequence numbers?

For diff-based monitoring tools relying on the new relative behavior, could
this cause an astronomical jump in reported sequence values?

[Severity: Medium]
Is there a data race when accessing subflow->remote_key_valid and subflow->=
iasn
here?

mptcp_diag_fill_info() accesses these fields under lock_sock_fast(), which =
only
acquires the process context lock. Concurrently, subflow_set_remote_key()
writes to these fields in softirq context under mptcp_data_lock():

net/mptcp/subflow.c:subflow_set_remote_key() {
	...
	subflow->remote_key_valid =3D 1;
	subflow->remote_key =3D mp_opt->sndr_key;
	mptcp_crypto_key_sha(subflow->remote_key, NULL, &subflow->iasn);
	subflow->iasn++;
	...
}

Because remote_key_valid is set to 1 before mptcp_crypto_key_sha() populates
iasn, can this diagnostic code read iasn while it contains garbage?

> +	}
> +
>  	info->mptcpi_csum_enabled =3D READ_ONCE(msk->csum_enabled);
>  	info->mptcpi_token =3D msk->token;
> -	info->mptcpi_write_seq =3D msk->write_seq;
> +	info->mptcpi_write_seq =3D msk->write_seq - local_idsn;

[Severity: Critical]
Does changing the established UAPI semantics of mptcpi_write_seq,
mptcpi_snd_una, and mptcpi_rcv_nxt from absolute cryptographic sequence num=
bers
to 0-indexed relative values cause a regression in the kernel's ABI?

Could any userspace application or tracing tool that relies on these fields=
 to
correlate socket state with on-the-wire MPTCP packets (e.g., using tcpdump =
to
match DSS sequence numbers) break immediately?

>  	info->mptcpi_retransmits =3D inet_csk(sk)->icsk_retransmits;
>  	info->mptcpi_bytes_sent =3D msk->bytes_sent;
>  	info->mptcpi_bytes_received =3D msk->bytes_received;
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902102125.2035=
540-1-kalpan.jani@mpiricsoftware.com?part=3D1
