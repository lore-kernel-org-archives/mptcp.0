Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 599FA2AD0C
	for <mptcp@lists.linux.dev>; Fri, 16 Oct 2026 01:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792115212; cv=none; b=GdLPkbj7z0KFxn4qGW/ZPyinKJZSx3tUFqBfRlunpeiur9ENe844F3s5KQl+ov6VswkGIsjW+Ruz7aZdRWtJLk9NWoUELIbtYwFSUPLcZgiJ5xm5Pb540xwtpjC7Z8qOh3u+6hatJaSV4cshqNIqxhfugwZMS0cQffOF7NZXOfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792115212; c=relaxed/simple;
	bh=uX2+2ZmjyssZmllNb0gTntJ8CCe+/PGWV1s/SVIzmL0=;
	h=Message-ID:From:Subject:To:In-Reply-To:References:Content-Type:
	 Date; b=rM8pQxh20jfQVhPLVIch4RK1GHKlLH6fY9qJVxC90Ykg1paQse3NrdXL4H6EqgIlfOYv/jfN/1Le6+Ukxkri/Q51yGhdmhl4qgX87sp438T9fJXz+BaSXmXw4IzRcXFuEXIvz9ckK0D/Sl0ufrMkFMbI/iydmDKAI/H2Ns+aLqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iSv1tX30; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iSv1tX30"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFB641F000C4;
	Fri, 16 Oct 2026 01:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792115211;
	bh=2n5opp0wTAieu/o2HjYqnIG5T2Uuf/1B1kw5iPxkhWU=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=iSv1tX30aF2uZbDV/dU1/76CUiVCa5VRirD9onOU6bjSyW4dWg+xTjM3iTWAAEk51
	 OzabiQAfaktYkFL5bjxcUY55sRrzEhYC51E8Dks2zTcsywrImoXcCzC0xD7w5MMzxi
	 HP3bN9NhEsFf3qxW8i1FytJ/uH7CZYXvt4KjTttOiwEDHQ4EZJmwPx3SsYS9AihWHm
	 qtPB6tzviu4WlDgvSrgRaqTzcPcNE/EA/U1SVuzf9JAUe5gzlGc/WhXkJx+e/vSE1Z
	 DS2YiYAnCOlHvm+OOAKnU98bPEhP3EzOqh9+JSYHVf9xCS+dttx0NSH7pcnrWlSxgZ
	 gtFM7wC/Fw1aA==
Message-ID: <sashiko-outbox-173561@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-next v2 1/2] mptcp: give MPTCP sockets a distinct
 lockdep class
Reply-To: sashiko-reviews@lists.linux.dev
To: "Geliang Tang" <geliang@kernel.org>, mptcp@lists.linux.dev
In-Reply-To: <8651f29fb4e11de14a7ea7d05d97a33b1e5390f3.1792114102.git.tanggeliang@kylinos.cn>
References: <cover.1792114102.git.tanggeliang@kylinos.cn>
 <8651f29fb4e11de14a7ea7d05d97a33b1e5390f3.1792114102.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 01:46:50 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] mptcp: lockdep warning fix bypassed for passive sockets
--

commit 554f965b1a52d1d1bbbc1a03f3a216e91642e81f
Author: Geliang Tang <geliang@kernel.org>

mptcp: give MPTCP sockets a distinct lockdep class

This commit extracts lock reclassification logic into mptcp_reclassify_sock=
et()
and calls it from __mptcp_init_sock() to fix a lockdep "possible recursive
locking" warning. It aims to cover both active and passive socket creation
paths.

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 60cbd91be6320..68f339311993e 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
[ ... ]
> @@ -3245,6 +3245,9 @@ static void __mptcp_init_sock(struct sock *sk)
>  	/* re-use the csk retrans timer for MPTCP-level retrans */
>  	timer_setup(&sk->mptcp_retransmit_timer, mptcp_retransmit_timer, 0);
>  	timer_setup(&msk->sk.mptcp_tout_timer, mptcp_tout_timer, 0);
> +
> +	if (sk->sk_socket)
> +		mptcp_reclassify_socket(sk);

[Severity: Medium]
Does this check evaluate to false for cloned passive sockets, bypassing the
lock reclassification entirely?

During passive socket creation, mptcp_sk_clone_init() calls sk_clone_lock(),
which clones the socket, acquires its spinlock, and explicitly clears sk_so=
cket:

net/core/sock.c:sk_clone() {
    ...
    sk_set_socket(newsk, NULL);
    ...
}

When mptcp_sk_clone_init() then calls __mptcp_init_sock(), sk->sk_socket
is NULL, causing the intended lockdep fix to be bypassed for passive socket=
s.

Additionally, if mptcp_reclassify_socket() were called unconditionally here
without the sk_socket check, would it re-initialize the actively held spinl=
ock
from sk_clone_lock() and cause a BUG on unlock?

>  }
> =20
>  static void mptcp_ca_reset(struct sock *sk)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1792114102.gi=
t.tanggeliang@kylinos.cn?part=3D1
