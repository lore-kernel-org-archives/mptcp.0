Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC05F2417D9
	for <mptcp@lists.linux.dev>; Sat, 22 Aug 2026 03:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787369816; cv=none; b=kACtZKiGPWGH3ceUfhuqAWnwaDsGZj/Hv4i01S//3NfodVtQl2O/RwXNzOQ17qen7Ph8+8e5FlxJTNdf1H/rtVpN9jsa300QjZNRFDCVTZBUhrEwTL7l3T/TgNYocaB3eanPFbcfcp9Om7rHd2BsrlZZ7ijZ4NeEsy80vSBQedo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787369816; c=relaxed/simple;
	bh=KALsMd3lyK2bWChalZXg5lifrM9nlj8aj8WR9roPMRg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fu/st58vgThR2ENlKYMv0m3SnSTNybNx5HOFLIkRf64nk6QUV7+ZvN5QQ0P08TJE7wYu+1z0AkLiMhZ21mUZ/5iWNANTLm3bxXgbl5dzKs8UzieachvLn1bRA1X2XcW2jytUfpvO9Qwh2yifbCuPnfA73Cm0a9boe2gCPeQBtNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kBA0G1t+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kBA0G1t+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35ED61F000E9;
	Sat, 22 Aug 2026 03:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787369815;
	bh=SQ8GAkoqq/y+uZlLoIwWJTBRliN82WJNLn+I4sSvdYQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kBA0G1t+OjyGFGN0Sifybw1BasS53NIeMDHXHOvmYpMfz4KcZnJFzWIgFQ42lCNeW
	 jHm+OiB15CfrbLlUZsNp9pnAHpqI4Co0l6n5kv9iFM0a85TC/ZvmM7LCGGZX1JQxrv
	 +ME+I7al2SG175g5Dvh+d8B/HDFkUIaw+ugU8N3sEUbGnuh0a1XkITmRTIRivxSWVS
	 iq80/DxAQBPXBdsmyF8cb4cajucaJncnJUB9UduEEI0KIK0zQe2bT0WSEJlqFSwjRP
	 ns3I8Dl4V0eG+vJbintraVyEwDm39uZu7OCyvy0bmf4fhWIevZVeA//ZfTt9tm6t3s
	 L6O2Me0Vndl1A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-next v5 5/7] mptcp: defer read_sock cleanup to
 mptcp_worker
Reply-To: sashiko-reviews@lists.linux.dev
To: "Geliang Tang" <geliang@kernel.org>
Cc: mptcp@lists.linux.dev
In-Reply-To: <7aedfbb77f40f047f2c7724c481220a8322b7ad2.1787368526.git.tanggeliang@kylinos.cn>
References: <cover.1787368526.git.tanggeliang@kylinos.cn>
 <7aedfbb77f40f047f2c7724c481220a8322b7ad2.1787368526.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 22 Aug 2026 03:36:54 +0000
Message-Id: <20260822033655.35ED61F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Inverted order of `mptcp_cleanup_rbuf()` and `mptcp_rcv_space_ad=
just()` causes delayed receive window expansion.
--

--- Patch [5]: [PATCH mptcp-next v5 5/7] mptcp: defer read_sock cleanup to =
mptcp_worker ---
commit 7c6cfb1e14c2505035ad95612907c5f1c34d25e5
Author: Paolo Abeni <pabeni@redhat.com>

mptcp: defer read_sock cleanup to mptcp_worker

This commit defers sk->sk_data_ready(sk) cleanup tasks to the MPTCP worker
using a new MPTCP_WORK_READ_COMPLETE flag. This avoids locking recursions a=
nd
context-related issues when MPTCP carries TLS.

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 6006193388f12..648eba89278f6 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -3133,6 +3133,15 @@ static void mptcp_backlog_purge(struct sock *sk)
>  	sk_mem_reclaim(sk);
>  }
> =20
> +static void mptcp_read_complete(struct sock *sk)
> +{
> +	struct mptcp_sock *msk =3D mptcp_sk(sk);
> +
> +	mptcp_cleanup_rbuf(msk, msk->read_copied);
> +	mptcp_rcv_space_adjust(msk, msk->read_copied);

[Severity: Medium]
Does the inverted order of these function calls delay receive window expans=
ion?

Before this patch in __mptcp_read_sock(), mptcp_rcv_space_adjust() was call=
ed
before mptcp_cleanup_rbuf(). Because mptcp_cleanup_rbuf() evaluates the
current socket receive buffer capacity to decide whether to send a window
update ACK, calling mptcp_rcv_space_adjust() afterward means the buffer
capacity is expanded after the cleanup check has already run.

Could this cause the ACK sent to advertise the old, smaller window size,
delaying the expanded window advertisement until the next cycle?

> +	msk->read_copied =3D 0;
> +}
> +
>  static void mptcp_do_fastclose(struct sock *sk)

[ ... ]

> @@ -4641,11 +4651,14 @@ static int __mptcp_read_sock(struct sock *sk, rea=
d_descriptor_t *desc,
>  	if (noack)
>  		goto out;
> =20
> -	mptcp_rcv_space_adjust(msk, copied);
> -
> +	/* The backlog flushing is only needed when some data is actually
> +	 * moved and will take place in the workers's release callback.
> +	 */
>  	if (copied > 0) {
>  		mptcp_recv_skb(sk, &offset);
> -		mptcp_cleanup_rbuf(msk, copied);
> +		msk->read_copied +=3D copied;
> +		set_bit(MPTCP_WORK_READ_COMPLETE, &msk->flags);
> +		mptcp_schedule_work(sk);
>  	}
>  out:
>  	return copied;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1787368526.gi=
t.tanggeliang@kylinos.cn?part=3D5
