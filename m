Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35EB3DDB1D
	for <mptcp@lists.linux.dev>; Mon, 31 Aug 2026 10:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788171090; cv=none; b=LVSOKdvz2RJVF665T5sxcfuTaNE6IZ3/V2W6NoY1lcH+X0jSx0VH3mmHnIa66fc1VAGpcBISGNKzMiZzWCC7NfCCqgMD6wLP6isSwj5rS+K4f9v1eGfc5NObHlFNtnJvMGfuoif5NfRSjVA1BfYrmpHuHBG6mQ73WLxReRLI1pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788171090; c=relaxed/simple;
	bh=PRokuK3i3ifpnwXKwSEZWzL1aaYGHg05zkNaMyZ16tU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fJrUuqhdHfFbsQosgM1R/8qiCh++BffQvUB/+Sb8WBC+/KfSM7qdpZu36n9KGvEnignG1fbyZBKhPQk+kQO4uhK1G+XlrTrLZjAMlQJVc89qhL7ShBgfIWcJrm5FkJYcutCIYUhPYDJ8XpPhHDxn7A2sLrQZsAQ1p2QLxD2v37M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LSmOJTB5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LSmOJTB5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 203081F000E9;
	Mon, 31 Aug 2026 10:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788171089;
	bh=RyqiEm5GKfgMGqbO4f2PWkJUiBOlSvVy74BaLlktv9I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LSmOJTB5aH8//vsxGU0mu3H04OzgkIYfuRDHD/7A53M2iMDKDny2LYEjTPqWyjHb+
	 NjaGrTVRu9G9BGoqE2hjoPo6PRhqcGUE0HFe0V9eDUJMtOH90b27dHepv4qmCbwK+s
	 FxdSa4Y8UvImwEg0sDqYvOYa9hx4scb7kJLDiBW6Ba/dtAo918lV7iQv3gVR5cLpqc
	 HqRPVisiiI3sNNtx9hNXjscnSwaiWHVZ4/joYZ7ixYd0QWaJ3ZO7Ad0f8vLua4Hfx8
	 BhqB7JPWiuik9sPtZQ/EXeduc9Jk6S9HS63G5E5t/wweJwBRd7PcoQc6BvPi73IKhW
	 O9dzR/0SxhGOw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-next 2/2] mptcp: pm: skip extra_subflows
 accounting on disconnected msk
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tao Cui" <cui.tao@linux.dev>
Cc: mptcp@lists.linux.dev
In-Reply-To: <20260831093206.689827-3-cui.tao@linux.dev>
References: <20260831093206.689827-1-cui.tao@linux.dev>
 <20260831093206.689827-3-cui.tao@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 10:11:28 +0000
Message-Id: <20260831101129.203081F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Subflows in `join_list` can be leaked due to unsynchronized zeroin=
g of `cb_flags` in `mptcp_disconnect`.
- [High] Data race on `pm->reset` and `pm->rm_list_*` fields due to missing=
 `pm->lock` in `mptcp_pm_data_reset()`.
--

commit 179deded54d27540d6b26de1228c24065e1fa9d4
Author: Tao Cui <cuitao@kylinos.cn>

mptcp: pm: skip extra_subflows accounting on disconnected msk

This commit addresses a WARN_ON_ONCE crash related to extra_subflows
underflow by skipping the PM accounting when the mptcp socket is in the
TCP_CLOSE state. It replaces the warnings with rate-limited prints and
avoids modifying the counters for disconnected sockets.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/629

> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> index b10895606542a..60276eb1ef384 100644
> --- a/net/mptcp/pm.c
> +++ b/net/mptcp/pm.c
> @@ -676,9 +676,18 @@ void mptcp_pm_subflow_check_next(struct mptcp_sock *=
msk,
>  	update_subflows =3D subflow->request_join || subflow->mp_join;
>  	if (mptcp_pm_is_userspace(msk)) {
>  		if (update_subflows) {
> +			/* The PM counters have already been cleared if the
> +			 * msk got disconnected while this subflow was still
> +			 * queued in the join list
> +			 */
> +			if (inet_sk_state_load(sk) =3D=3D TCP_CLOSE)
> +				return;

[Severity: High]
This is a pre-existing issue, but does mptcp_disconnect() leak subflows when
zeroing cb_flags non-atomically?

If a concurrent mptcp_finish_join() receives an MP_JOIN ACK for a subflow
while the parent socket is being disconnected, it can hit the
sock_owned_by_user(parent) branch. The subflow is added to msk->join_list
and MPTCP_FLUSH_JOIN_LIST is set in msk->cb_flags while holding the parent's
data lock.

Simultaneously, mptcp_disconnect() executes msk->cb_flags =3D 0 without hol=
ding
the mptcp_data_lock, erasing the MPTCP_FLUSH_JOIN_LIST flag:

net/mptcp/protocol.c:mptcp_disconnect() {
	...
	msk->cb_flags =3D 0;
	...
}

When the lock is released, release_sock() invokes mptcp_release_cb(), but
since the flag was erased, it skips the flush:

net/mptcp/protocol.c:mptcp_release_cb() {
	...
	if (flags & BIT(MPTCP_FLUSH_JOIN_LIST))
		__mptcp_flush_join_list(sk, &join_list);
	...
}

Can this lead to the sockets in join_list being completely leaked when
mptcp_destroy_common() later iterates only over conn_list?

[Severity: High]
This is a pre-existing issue, but is there a data race on pm->reset and
pm->rm_list_* fields when mptcp_pm_data_reset() is called during disconnect?

When mptcp_disconnect() sets sk->sk_state to TCP_CLOSE, it calls
mptcp_pm_data_reset(msk), which modifies PM structures without acquiring
pm->lock:

net/mptcp/pm.c:mptcp_pm_data_reset() {
	...
	memset(&pm->reset, 0, sizeof(pm->reset));
	pm->rm_list_tx.nr =3D 0;
	pm->rm_list_rx.nr =3D 0;
	...
}

At the same time, subflow receive paths can process incoming MP_JOIN or
RM_ADDR packets in BH context, holding only pm->lock and lock_sock(ssk) rat=
her
than lock_sock(msk). For example:

net/mptcp/pm.c:mptcp_pm_allow_new_subflow() {
	...
	spin_lock_bh(&pm->lock);
	if (READ_ONCE(pm->accept_subflow)) {
		ret =3D pm->extra_subflows < limit_extra_subflows;
	...
}

Could this unprotected memset in mptcp_pm_data_reset() cause torn writes and
corrupted PM state when racing with readers and writers that only hold
pm->lock?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831093206.6898=
27-1-cui.tao@linux.dev?part=3D2
