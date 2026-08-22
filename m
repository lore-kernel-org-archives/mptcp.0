Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A4825B099
	for <mptcp@lists.linux.dev>; Sat, 22 Aug 2026 03:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787369286; cv=none; b=SNF//hvfc0xTt9cFqR1TJYnD7JdnnCYlPG3FtYQPL5fof1LY4B9SLmeyNktdaU5J/rLwzkZ81inL7KSp2xiIRXDh/CeygaR197rF7VVjrsn4ofh56oBOIbpVjpuJpJ0J76yLJ7gu7p1bJiMb2+i3vM8Ku3MzhmSQ5AxvbEpbqUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787369286; c=relaxed/simple;
	bh=v1MBaMoTpJCpB1Z5d5ozd22auCdpTxNG+qsMlAaBXKI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=M0WHlc28satnDlumG27eEMKNJuBue92wzsVm35vqfRZzzHM20ZfFDlFQ2QyI0ou0c/3n8z05dF3Uc1clj7KL+uByNbxTozoPoDmG3baV/8bMInfAmQZCgDnohK+BqGaERM1XOccnB1QqTrP4596dgbMHCMBG1xYz3a3U2O8F/ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XYM0+J6K; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XYM0+J6K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F030A1F000E9;
	Sat, 22 Aug 2026 03:28:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787369285;
	bh=X77NjIwO3kwnnmxpS8tw/ApLb2fHQOf2gU0q4IWVv3c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XYM0+J6Kk1Jvs76jxLIhcvyJJDLP+yFNXkNBJ5dvQ8gx74ZhnKbpybpPq9w0h5PPK
	 7IEBr/iBy8OjS3yJTToVK78raFXj6U78Qudk9fz2ZmmzcSIcFkXxwVkavrIBz+DBDf
	 kp9u5S/T2b7F7JT1thhzcXckTCL3ZSezYN+eMXzVJvXH+UnhdCbmTKJUx85R7fUahO
	 ZHR3Qq72QY0CbtKn7EHZf1ZuYxvjQx8TZEIqUaIZdzcn7cJix4VFEV3BpQlo63nMKp
	 k5n8ibnf5pDLU19d3goF92Mb4re8OTgr/Os1lL5Zack3hY3NRw+M5r+uAXRJ854kQS
	 O305ZJMMRmjww==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-next v5 6/7] mptcp: track app-limited state in
 mptcp_sendmsg
Reply-To: sashiko-reviews@lists.linux.dev
To: "Geliang Tang" <geliang@kernel.org>
Cc: mptcp@lists.linux.dev
In-Reply-To: <456a51551b99654bd84efa9565bdad7412a419cf.1787368526.git.tanggeliang@kylinos.cn>
References: <cover.1787368526.git.tanggeliang@kylinos.cn>
 <456a51551b99654bd84efa9565bdad7412a419cf.1787368526.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 22 Aug 2026 03:28:04 +0000
Message-Id: <20260822032804.F030A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Lockdep recursive locking warning due to missing nested lock ann=
otation in mptcp_sock_rate_check_app_limited().
--

--- Patch [6]: [PATCH mptcp-next v5 6/7] mptcp: track app-limited state in =
mptcp_sendmsg ---
commit 991a38880507b6d69cccc4a195bee5ef68452bf9
Author: Geliang Tang <tanggeliang@kylinos.cn>

mptcp: track app-limited state in mptcp_sendmsg

This commit splits the TCP app-limited rate checking logic into a helper
that takes a tcp_sock, and adds an MPTCP-specific helper to apply this
rate checking to each subflow individually during sendmsg.

[ ... ]

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 648eba89278f6..735cd39846462 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -2045,6 +2045,21 @@ static void mptcp_rps_record_subflows(const struct=
 mptcp_sock *msk)
>  	}
>  }
> =20
> +static void mptcp_sock_rate_check_app_limited(struct sock *sk)
> +{
> +	struct mptcp_sock *msk =3D mptcp_sk(sk);
> +	struct mptcp_subflow_context *subflow;
> +
> +	mptcp_for_each_subflow(msk, subflow) {
> +		struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
> +		bool slow;
> +
> +		slow =3D lock_sock_fast(ssk);

[Severity: Medium]
Does acquiring the subflow socket lock here trigger a lockdep recursive
locking warning?

mptcp_sendmsg() acquires the parent MPTCP socket lock using lock_sock(sk),
and then calls mptcp_sock_rate_check_app_limited(sk) right after. This
function iterates over the connection subflows and acquires each subflow's
socket lock via lock_sock_fast(ssk).

Because both locks share the same lock class, lockdep might flag this
nested acquisition as a possible recursive lock splat, which can disable
further lock debugging.

Is it possible to use lock_sock_fast_nested(ssk) or a similar nested lock
annotation here to suppress the false positive?

> +		tcp_sock_rate_check_app_limited(tcp_sk(ssk));
> +		unlock_sock_fast(ssk, slow);
> +	}
> +}
> +
>  static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
>  {
>  	struct mptcp_sock *msk =3D mptcp_sk(sk);

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1787368526.gi=
t.tanggeliang@kylinos.cn?part=3D6
