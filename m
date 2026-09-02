Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F3CF445AFC
	for <mptcp@lists.linux.dev>; Wed,  2 Sep 2026 10:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788345244; cv=none; b=okspXnXqK08t6oT8RRdATaEkNpAjYWkH8ZEVfYBWzrbWzRhVcJE9iWK3If0WZfC3ZLqZg/e48T/bc7p7u3ybHJzLRL8BgBWxWaMm6KIgyDUZVDxiZPns3gDcgTtklaBdlkSNm/r+0OdHJ2rvAbEH6460yKYq1Jzdag1Ca8hvu7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788345244; c=relaxed/simple;
	bh=0H+KNdUzfxCyefP/DPhe/uLBcRsPLAKdV/Q8tprwi30=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lQC2uEEVmrnfv3hHHAvTZqU38kwH8CZefsn5YKmSYszlh8RiojFTx2N10ZKlEjsbdG7a2cSMBCldYfVf4TynjBHB1xkUiZc1LeB9YX9S+kfW+1lhFjPAHqQR04O3z6kp4uE0R0SjUeUI0vpaqv93mFli4DgdlDHcfIuSxpp+0pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WwaqcyFL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WwaqcyFL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C9AE1F000E9;
	Wed,  2 Sep 2026 10:34:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788345242;
	bh=adBQ0oO//lY67GdiwMaJGPiF+vGLHsN6ZmdZ4smGkz4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WwaqcyFLxUXLQsQN7DyX6gB4LkOppt1qRnWiNwK2Dfp53fXRDBzvyicUadVCGon0Z
	 Geji440upQocWFN25NygXXtSj2SHFExTVH/s5q4h4bNfEqL6co4WxstOqLRGXAvtLp
	 trDAqn/w8UrZUiXJ31z9RsAobHmyZE5ziceX0TR6ziLh1IaHnJTj+qCctPXG2qq4K2
	 l9FIbHBhmpUJEu3JehooR12ANwwBJMkhQGqVryE/MJYlDdil17czkaaU9RvhEQrgAw
	 mtzN2/2ZbN8jtD6W4e6d+5ox1omElIccvwJx2dkhWjnYAA4oPSLNtgVfsJ0Pt+VEQQ
	 hIry7CGxfBp6Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v5 2/2] mptcp: fix MP_CAPABLE token migration when
 cloning reqsk
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ren Wei" <weir@nebusec.ai>
Cc: mptcp@lists.linux.dev
In-Reply-To: <93dafd2c918b42d635b03e7d3d83f6f2cff49697.1788202924.git.caoruide123@gmail.com>
References: <cover.1788202924.git.caoruide123@gmail.com>
 <93dafd2c918b42d635b03e7d3d83f6f2cff49697.1788202924.git.caoruide123@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 10:34:02 +0000
Message-Id: <20260902103402.9C9AE1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Ignoring the return value of mptcp_init_sched() in mptcp_sk_cl=
one_init() causes a module refcount underflow.
--

commit 18a63fbca98d3e69ad5d14656be7de91ee0af91e
Author: Ruide Cao <caoruide123@gmail.com>

mptcp: fix MP_CAPABLE token migration when cloning reqsk

The patch fixes MP_CAPABLE token migration during TCP request migration by
moving token request ownership from the original request to the clone
under the token bucket lock. It also safely destroys the provisional MPTCP
socket if a passive MP_CAPABLE socket cannot claim the token.

Closes: https://sashiko.dev/#/patchset/86e2514b533bf4d55d4aa2fdbf1404022e8c=
9430.1776149210.git.caoruide123%40gmail.com

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index e1f08f71cdb16..30067f2a7ca8f 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c

[ ... ]

> @@ -3764,6 +3777,14 @@ struct sock *mptcp_sk_clone_init(const struct sock=
 *sk,
>  	mptcp_rcv_space_init(msk, ssk);
>  	msk->rcvq_space.time =3D mptcp_stamp();
> =20
> +	if (!mptcp_token_accept(subflow_req, msk)) {
> +		list_del_init(&subflow->node);
> +		WRITE_ONCE(msk->first, NULL);
> +		sock_put(ssk);
> +		mptcp_sk_clone_destroy(nsk);

[Severity: Critical]
This isn't a bug introduced by this patch, but could this error path expose=
 a
module refcount underflow?

Earlier in mptcp_sk_clone_init(), the code calls mptcp_init_sched() without
checking its return value:

	msk->setsockopt_seq =3D mptcp_sk(sk)->setsockopt_seq;
	mptcp_init_sched(msk, mptcp_sk(sk)->sched);

Because sk_clone_lock() byte-copies the parent's msk->sched pointer, if the
BPF scheduler module is concurrently unloading, bpf_try_module_get() can fa=
il
and return -EBUSY. This leaves a stale pointer in msk->sched.

When mptcp_sk_clone_destroy() is called here, it triggers
mptcp_release_sched(). Will this cause a use-after-free and refcount
underflow by unconditionally calling sched->release() and
bpf_module_put() on that stale scheduler pointer?

> +		return NULL;
> +	}
> +
>  	if (mp_opt->suboptions & OPTION_MPTCP_MPC_ACK)
>  		__mptcp_subflow_fully_established(msk, subflow, mp_opt);
>  	bh_unlock_sock(nsk);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1788202924.gi=
t.caoruide123@gmail.com?part=3D2
