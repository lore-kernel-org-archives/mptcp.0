Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6E14399C4
	for <mptcp@lists.linux.dev>; Thu, 24 Sep 2026 07:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790236290; cv=none; b=aKbxOdAasUpQMEJh37E+IO8MfBAu8kJsgxicinw9MnY1a4Nb6PzuGMkyNmyhht3+JUrqyQD+3xNjtfulTo3iyLI2DxF923HvFeBvC24rWgfad2r8GK/r30BlWEuzdfNJIBQWEMNDP29feuf3RILxVEh/O4FbC7owWmFVbACZjn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790236290; c=relaxed/simple;
	bh=Fyq3J5pdj5DoR7SZ36vHSS3dw9+8QNstgdTq1sjZH2w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FV9rNQBnHHVCpwNfuNNQ0zxp2ZBZ0nMv2yjnrvw8dwivcCD+ZvrG9S8jHDadI2GlbcYQhu2JwGcnm5VgJBtty4WWASmfhee4AGy5XRuqanpRyXAKBbPC7i2gEeXERHb7XjvD4faMydAcSQJlT/21/nwsDX/EVpQQfiIsUjY5J+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PgqAJjCd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PgqAJjCd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 778481F00893;
	Thu, 24 Sep 2026 07:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790236288;
	bh=BTDG4kRQeFYgstE/0FHxxtskGhFPhuQ/JCpACc6P22w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PgqAJjCdGAizncChpfEKefATlENOUkCkWCfrctsQb2OShAlYclFl6EXqi7Xca7Yfy
	 4l9vAoH3w6MHYOZQ/LyTxT1KUxsoV06B9L7NefMRgo/dQEM8/iSljxVxkdE1CkMuUE
	 ioVgrgwzkVm61wr8llE7cqNyrgZytuRAZZwWo5mTLCznsMcoweX5yYWClqi+0KVXjT
	 /8NxaNp0b7a2VV0fKJC7L/mg8nZY91oQ5KvIt1gKrle/WNwYBjYL7vvv5fQK6mcy4d
	 7aSS27dkMcl0IOBpmuHvWLXoUlq8GmKE2WB0XGJ92LJAfYU3Z1n+cB9wavhIqtoCUo
	 bC7VIQsG5ETSQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC -next 3/5] mptcp: sync memcg budget and drop backlog
 page compensation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Cai Xinchen" <caixinchen1@huawei.com>
Cc: tj@kernel.org, mkoutny@suse.com, mptcp@lists.linux.dev, hannes@cmpxchg.org
In-Reply-To: <20260924080219.1036588-4-caixinchen1@huawei.com>
References: <20260924080219.1036588-1-caixinchen1@huawei.com>
 <20260924080219.1036588-4-caixinchen1@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 07:51:28 +0000
Message-Id: <20260924075128.778481F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] mptcp: memcg accounting bypass when propagating SO_SNDBUF to subfl=
ows
--

commit 81a89371b8c44bb27224e5c7531703509f0431a0
Author: Cai Xinchen <caixinchen1@huawei.com>

mptcp: sync memcg budget and drop backlog page compensation

This commit syncs the memcg budget tracker at MPTCP budget writes and
refunds budgets when subflows move to the msk's memcg. By charging budgets
upfront, it removes the per-page compensation mechanism for unaccounted
backlogs to prevent double-charging.

[ ... ]

> diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
> index fcf6feb2a9eb5..05d9dafa8c071 100644
> --- a/net/mptcp/sockopt.c
> +++ b/net/mptcp/sockopt.c
> @@ -70,6 +70,7 @@ static int mptcp_get_int_option(struct mptcp_sock *msk,=
 sockptr_t optval,
>  static void __mptcp_subflow_set_rcvbuf(struct sock *ssk, int val)
>  {
>  	WRITE_ONCE(ssk->sk_rcvbuf, val);
> +	sk_memcg_budget_sync(ssk, gfp_memcg_charge());
>  	tcp_set_rcvbuf(ssk, val);
>  }

[Severity: High]
This patch introduces upfront memcg charging and correctly syncs the budget
for SO_RCVBUF updates via __mptcp_subflow_set_rcvbuf(), but is it also
necessary to sync the budget for SO_SNDBUF updates?

When SO_SNDBUF is propagated to subflows, the socket buffer limits are
updated but the memcg budget is not synced. For example, in
mptcp_sol_socket_sync_intval():

	case SO_SNDBUF:
	case SO_SNDBUFFORCE:
		ssk->sk_userlocks |=3D SOCK_SNDBUF_LOCK;
		WRITE_ONCE(ssk->sk_sndbuf, sk->sk_sndbuf);
		mptcp_subflow_ctx(ssk)->cached_sndbuf =3D sk->sk_sndbuf;
		break;

And similarly in sync_socket_options() when newly joined subflows inherit
the options:

	if (sk->sk_userlocks & SOCK_SNDBUF_LOCK) {
		WRITE_ONCE(ssk->sk_sndbuf, sk->sk_sndbuf);
		mptcp_subflow_ctx(ssk)->cached_sndbuf =3D sk->sk_sndbuf;
	}

Could this bypass memcg accounting for MPTCP subflows, allowing TCP socket
buffers to grow up to the new limits without the cgroup being charged?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924080219.1036=
588-1-caixinchen1@huawei.com?part=3D3
