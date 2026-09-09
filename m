Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A5C4A0927
	for <mptcp@lists.linux.dev>; Wed,  9 Sep 2026 10:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788948373; cv=none; b=fFyi75IpZkOGCiyiKnjSxDACBC1ZW3IdvvR4xisvjnrkh9Vngj8gmZoTU/iCl2+TsCEQ7ewZlOqcxh9TLyokEQPfCg1b+lcXtPR6nqWhtzp0re5nRb6IWnA2WbycsaNxJwV2UVd1uRQ0xquEeRM7/GNjebhnjE9uspVR+9mR7t8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788948373; c=relaxed/simple;
	bh=SszfnMa1N62Q7cWrV2VkEPpSGYmqj8lOX4ASyMrqWc8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=j9ly6ZmfYG2BVerNA98JAuPO3vWJTS7Jaxo3Ru3R0psvhl64u4ep4Gw3ytuQmr1o9R/0/Ld/iI2hBl8AUsEGB1ob36Yo2H74ixB81QZu6xRK29j6MUSEGRSg9lsvRSla8JXD7Ifp4h09q9f18XZXOS4NzM70Jq3nPSoYAqxooCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ls8cBN0g; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ls8cBN0g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 135491F00A3D;
	Wed,  9 Sep 2026 10:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788948372;
	bh=JQ3HdogSvV6Vy3hfi/zsCCfOmdIgXaE8P5kecFQTRTI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ls8cBN0gRMjrGmkopL+aSDVbcaZySHcCwUXeF9JO2451ocIUIVtcIwT+OIm7NpI8T
	 xbgOjpcBs8N/CcWbRqkjaph9V9u7OyULYsv+D9ZJGu5rnAtioImW7g7HVsuXBpMgbn
	 R6LkWe5Yt4ah3qV3+1eKW5OboA6BaSwD5Xnr9iXYlUHPGm29eEsuHc20Z9/KR7AqpH
	 AniLE/6MMaS7MLXSh+PWwG/6C/ZiReRIZobNBEFBFYwtTbu1f8SnS0FmQb2xL7TuIB
	 MXtS/I8DXNTAZbRhp/+ox9WzsfTUoljTmXsOspYyrXXCvmbDU8nk98daoeXmwK3TwK
	 9zEpusXKOl5zA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v6] mptcp: normalize seq numbers reported in
 mptcp_info
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kalpan Jani" <kalpan.jani@mpiricsoftware.com>
Cc: mptcp@lists.linux.dev
In-Reply-To: <20260909094800.766170-1-kalpan.jani@mpiricsoftware.com>
References: <20260909094800.766170-1-kalpan.jani@mpiricsoftware.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 10:06:11 +0000
Message-Id: <20260909100612.135491F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] The commit intentionally changes the semantics of UAPI fields (`mp=
tcpi_write_seq`, `mptcpi_snd_una`, `mptcpi_rcv_nxt`) from absolute on-the-w=
ire sequence numbers to relative sequence numbers, explicitly breaking exis=
ting userspace tools.
- [Medium] Unsynchronized concurrent read and read-modify-write of bitfield=
s in `struct mptcp_subflow_context`.
--

commit aed02b920bd2e723a86c213c2ac56f6fb6ab0d6e
Author: Kalpan Jani <kalpan.jani@mpiricsoftware.com>

mptcp: normalize seq numbers reported in mptcp_info

This patch modifies mptcpi_write_seq, mptcpi_snd_una, and mptcpi_rcv_nxt
to report relative sequence numbers rather than raw 64-bit data sequence
numbers. It does this by subtracting the initial sequence numbers from the
subflow context. The commit message notes this intentionally changes UAPI
semantics.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/445

> diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
> index fcf6feb2a9eb5..918ec873fcb05 100644
> --- a/net/mptcp/sockopt.c
> +++ b/net/mptcp/sockopt.c

[ ... ]

> @@ -1008,9 +1010,37 @@ void mptcp_diag_fill_info(struct mptcp_sock *msk, =
struct mptcp_info *info)

[ ... ]

>  	info->mptcpi_csum_enabled =3D READ_ONCE(msk->csum_enabled);
>  	info->mptcpi_token =3D msk->token;
> -	info->mptcpi_write_seq =3D msk->write_seq;
> +	info->mptcpi_write_seq =3D msk->write_seq - local_idsn;

[Severity: High]
Will this change break existing userspace tools?

The commit message mentions this intentionally changes the semantics of
mptcpi_write_seq, mptcpi_snd_una, and mptcpi_rcv_nxt from absolute
on-the-wire sequence numbers to relative sequence numbers.

Tools and scripts correlating these sequence numbers with network captures,
like those using tcpdump, might break when relying on the previous UAPI
semantics.

Is it acceptable to introduce a backward compatibility regression in the
exported UAPI values here?

>  	info->mptcpi_retransmits =3D inet_csk(sk)->icsk_retransmits;
>  	info->mptcpi_bytes_sent =3D msk->bytes_sent;
>  	info->mptcpi_bytes_received =3D msk->bytes_received;

[ ... ]

> @@ -1023,11 +1053,28 @@ void mptcp_diag_fill_info(struct mptcp_sock *msk,=
 struct mptcp_info *info)
>  	unlock_sock_fast(sk, slow);
> =20
>  	mptcp_data_lock(sk);
> +	if (first) {
> +		struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(first);
> +
> +		/* subflow->iasn is incremented once in subflow_set_remote_key(),
> +		 * which runs under this same mptcp_data_lock() (see
> +		 * mptcp_propagate_state()); compute remote_idsn here, under the
> +		 * same lock as the writer, and atomically with ack_seq below.
> +		 * first is the same held reference from earlier in this
> +		 * function, so it is guaranteed to still be valid here and to
> +		 * be the same subflow local_idsn was computed from above.
> +		 */
> +		remote_idsn =3D subflow->remote_key_valid ? subflow->iasn - 1 : 0;

[Severity: Medium]
Does this introduce a data race on the u32 container holding the
remote_key_valid bitfield?

The mptcp_diag_fill_info() function reads remote_key_valid while holding
mptcp_data_lock(sk). However, other concurrent writers modifying neighboring
bitfields in the same u32 container (like map_valid) do so under
bh_lock_sock(first) during softirq packet processing.

Because these locks are distinct, doesn't this result in an unmitigated
concurrent read and read-modify-write on the shared u32 word when diagnostic
tools are run concurrently with active connections?

> +	}
> +

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909094800.7661=
70-1-kalpan.jani@mpiricsoftware.com?part=3D1
