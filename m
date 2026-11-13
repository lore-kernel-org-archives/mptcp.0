Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794608944;
	b=pWAUQV2lR/Oy3YgjqgY1HtwZhRZf/omorcG2xzqJicpGbIQliowmnsvc8funV7HAkzAZ
	 mfSNvLiUA9L+0TWRasT8/OO0Uwfm4IBnJ58adFuXrd7ZATEx42BZcIY7Fe/aH8shBJ2ZH
	 jeZlgdz3Bd7b9VeaOc067QHbueGh+uP4nW1bXKcWQZw4X8iC5DlVagdSmRn4CblMThuv8
	 z/nfd4wgvGRbBL6LabUTUG+IWgbcpWTCF7NjtyDqu+ecFqb1JyLmyGIzCdNTfY46ckz7v
	 e97P+qQDx7fkRnh+5M/T5sGFwe9fqyixbei7fAdFsLqz0dkwTJUHz5BWjuWetY04q9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794608944;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=FNVZB1CY4tJysHh2H5y2f1mII/Xri40a4e8UbckTiw0=;
	b=hIoSZyWiQKrG2D7fDcrLxiaMpra5BwFbj4mg/OqY6ezorRnKZB/LlyL93TxBnUhe2N8j
	 fcmJV/j24cGoltSxW/cVJ+VrXWHkzNMAj8T9PTnXOf2qCd/uq8yzRokbWdOYxSGsQzSHf
	 l3/Gj177OiBzZInNGjbRnnf64r3QK3mo8hrda+S3fw9ixLycsbfKTXt5xhhtBo3vzW5vR
	 MgahP4o+kOTxmGHdhlooaj1t8V086IxGummkgEVf8B2/yEBXx94nAZKqLEiiBPUI5Dfsn
	 FKuJ7PCHqwzM4XJ8XLfK6v+wGYjC+RjARQD2OtEfBfQ5d+p3E2JQ44+WlMuZf8Na7iQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lQJ4xUeK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B0A606A88A
	for <mptcp@lists.linux.dev>; Fri, 13 Nov 2026 22:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lQJ4xUeK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 940501F000C4;
	Fri, 13 Nov 2026 22:29:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794608943;
	bh=FNVZB1CY4tJysHh2H5y2f1mII/Xri40a4e8UbckTiw0=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=lQJ4xUeKrJFbUIE0MCpFtae2ByElyX/OKgSTH+5PyxXy67/V/0F1FdB43uD2Lx6DY
	 ki4WHzxkpzFYG/MQbXv6K0SefMNmtvHi9LiVbg2UDTKpoMa210ZWAsxoRHn+5fP51i
	 YYzLZ3sBnzNyRSUaaUGFek6Hqqs7BdpmRF9jMBGMBncB6Xb7HB31SQc95Pp0pHwdMe
	 fmWiAmTKEnH0eZzVWyeZpnX5yQfvCFk+IDH8M1JgRDF9bQCzgtchGLhOA4kvI3sNGm
	 DBkysFXjkyXISfbe92NoLVANpT1pYBwMc50uwgjhfNqCPlk/vMSl90sWwFtyiuLUZT
	 vGGvFDYViPg6Q==
Message-ID: <sashiko-outbox-213809@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-net 19/34] mptcp: do not fallback while old data
 is in flight
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWF0dGhpZXUgQmFlcnRzIChOR0kwKQ==?= <matttbe@kernel.org>, "MPTCP
 Linux" <mptcp@lists.linux.dev>
In-Reply-To: <20261113-mptcp-cmason-fixes-v1-19-9205b77e9a2f@kernel.org>
References: <20261113-mptcp-cmason-fixes-v1-0-9205b77e9a2f@kernel.org>
 <20261113-mptcp-cmason-fixes-v1-19-9205b77e9a2f@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 22:29:02 +0000
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
- [High] mptcp: infinite map emission stall in
  mptcp_pm_mp_fail_received() [1]
--

commit 4c9a52a9f4dc2474ec08fa066289f109db0a1859
Author: Chris Mason <mason@kernel.org>

mptcp: do not fallback while old data is in flight

This commit prevents an MPTCP connection from falling back to plain TCP
while a zero window probe or reinjected data is still in flight on the
subflow, avoiding duplicate data delivery on the receiver.

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 8f954a752797d..7329deb43c622 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c

[ ... ]

> @@ -1582,7 +1594,10 @@ static int mptcp_sendmsg_frag(struct sock *sk, str=
uct sock *ssk,
>  out:
>  	if (READ_ONCE(msk->csum_enabled))
>  		mptcp_update_data_checksum(skb, copy);
> -	if (mptcp_subflow_ctx(ssk)->send_infinite_map)
> +
> +	/* the infinite map implies a fallback: wait for old data acks */
> +	if (mptcp_subflow_ctx(ssk)->send_infinite_map &&
> +	    !mptcp_subflow_ctx(ssk)->old_data_pending)
>  		mptcp_update_infinite_map(msk, ssk, mpext);

[Severity: High]
This problem wasn't introduced by this patch, but can subflow->send_infinit=
e_map
remain pending forever [1] when an MP_FAIL arrives while the connection
has unacknowledged data and no unsent data left on the send queue?

mptcp_pm_mp_fail_received() sets subflow->send_infinite_map =3D 1 and
msk->allow_subflows =3D false:

net/mptcp/pm.c:mptcp_pm_mp_fail_received() {
	...
	msk->allow_subflows =3D false;
	spin_unlock_bh(&msk->fallback_lock);

	if (!subflow->fail_tout) {
		pr_debug("send MP_FAIL response and infinite map\n");

		subflow->send_mp_fail =3D 1;
		subflow->send_infinite_map =3D 1;
		tcp_send_ack(sk);
	}
	...
}

Attaching the infinite map in mptcp_sendmsg_frag() requires sending a data
skb.  When there is no unsent data, mptcp_send_head(sk) is NULL so
__mptcp_subflow_push_pending() does not call mptcp_sendmsg_frag().  Meanwhi=
le,
the MPTCP retransmission timer cannot retransmit the unacknowledged data to
carry the infinite map because __mptcp_push_retrans() aborts when
!msk->allow_subflows:

net/mptcp/protocol.c:__mptcp_push_retrans() {
	...
			spin_lock_bh(&msk->fallback_lock);
			if (__mptcp_check_fallback(msk) ||
			    !msk->allow_subflows) {
				spin_unlock_bh(&msk->fallback_lock);
				release_sock(ssk);
				return -1;
			}
	...
}

As a result, the infinite map is never transmitted and the connection stalls
indefinitely.

[1] https://sashiko.dev/#/bug/linux-906f0960-8875-45cb-8066-cc9808d83b26

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113-mptcp-cmas=
on-fixes-v1-0-9205b77e9a2f@kernel.org?part=3D19
