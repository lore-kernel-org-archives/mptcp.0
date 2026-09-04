Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48BC626AC3
	for <mptcp@lists.linux.dev>; Fri,  4 Sep 2026 05:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788499734; cv=none; b=D1mk9rLLpsMrrf7DP519iIOoUuKgWvIMlPY24c5hW2aCGmPrbn4Q6r4YUeIZXiwLvXnixBucpxmIHebNyPKPEa2Pq10hdprWlmcxDAz4tQSWhNYYCNLRhDJreGXDAfbzTkTaRc1pgWwFVZL9Iy2i7TWki84LRQ2NSUJo55PceA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788499734; c=relaxed/simple;
	bh=axX8dGAHgdImU8FxxueWaFJ/nyLw05faTZcY7rYjl5k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PSQMMhuAQs40FLzkXdn4TwLbLIHqMKd9SgjRvaS+lZYiFWprQZi7VMzCmPGVwjZnhU9xMCNDhiDYoGeVED5eIznsVVI3FpeWGiraA0t/vUKDur7yr6Ne8DdA/5ildjbgOQkks0aXLjR08K3lvS1HrfsgVy0j1sKue8ukLcjtkxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cfb+F5zQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cfb+F5zQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E49251F00A3D;
	Fri,  4 Sep 2026 05:28:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788499733;
	bh=9dxFj66cXAgduQtA2iCf6prGnvcrHiaLTjKlbWWlfr4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Cfb+F5zQWtk4SOID2Lslv6SgFaUE6EJUGhHpOEjOHdHQWLPCH+CLn5qAa156Hv74e
	 3TtxH0GDbiltcrtKAF97UKv87sELB8RZxcy2Afa6TUVw55VGILMeUF6WjmXDDMFPtr
	 qzTOVPvo/rScR8k1wn+3jnbfA/vOaUIGTqnhkTiB90K3kZHR2iWCwbBbDQCl+uBkN4
	 Ak8EWu/NQWEr+Lzxf4Zw8A4gX8AsrZvJ63T9OZ0zD7lc0XbSwiMwd+LDVLoScpUDJJ
	 q0SW5dI/LZBkgwd78u8KrM/tViUsvWw0UVrVBdyen1ivbsyDPqt2bUTZtveYKpUUiB
	 ych1wSfAQHKtQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-next v3 2/3] mptcp: pm: skip extra_subflows
 accounting on disconnected msk
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tao Cui" <cui.tao@linux.dev>
Cc: mptcp@lists.linux.dev
In-Reply-To: <20260904051150.1196427-3-cui.tao@linux.dev>
References: <20260904051150.1196427-1-cui.tao@linux.dev>
 <20260904051150.1196427-3-cui.tao@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 05:28:52 +0000
Message-Id: <20260904052852.E49251F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Data race in mptcp_pm_data_reset() when clearing the pm->reset str=
uct group locklessly, causing torn reads/writes with concurrent PM operatio=
ns.
--

commit 0c791790f3c719050b1d2004c347405ffb76512f
Author: Tao Cui <cuitao@kylinos.cn>

mptcp: pm: skip extra_subflows accounting on disconnected msk

This commit addresses a remotely triggerable panic caused by a WARN_ON_ONCE
guard on extra_subflows underflow. It skips the PM accounting when the sock=
et
is in TCP_CLOSE, as the counters may have already been cleared by
mptcp_pm_data_reset().

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/629

> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> index 9881092c16e78..520f0c638e6f7 100644
> --- a/net/mptcp/pm.c
> +++ b/net/mptcp/pm.c
> @@ -671,9 +671,18 @@ void mptcp_pm_subflow_check_next(struct mptcp_sock *=
msk,
>  	update_subflows =3D subflow->request_join || subflow->mp_join;
>  	if (mptcp_pm_is_userspace(msk)) {
>  		if (update_subflows) {
> +			/* The PM counters have already been cleared if the
> +			 * msk got disconnected while this subflow was still
> +			 * queued in the join list
> +			 */

[Severity: High]
This isn't a bug introduced by this patch, but is there a data race when
clearing the pm->reset struct group locklessly in mptcp_pm_data_reset()?

Looking at net/mptcp/protocol.c:mptcp_disconnect(), it calls
mptcp_pm_data_reset() on an active, network-exposed socket without acquiring
pm->lock:

net/mptcp/protocol.c:mptcp_disconnect() {
    ...
    mptcp_pm_data_reset(msk);
    ...
}

Inside net/mptcp/pm.c:mptcp_pm_data_reset(), the code does a lockless memset
of the struct group:

net/mptcp/pm.c:mptcp_pm_data_reset() {
    ...
    memset(&pm->reset, 0, sizeof(pm->reset));
    ...
}

Could this cause torn reads and writes with concurrent PM operations?

For example, mptcp_pm_allow_new_subflow() concurrently modifies the memory
while holding pm->lock, but without holding the socket lock:

net/mptcp/pm.c:mptcp_pm_allow_new_subflow() {
    ...
    pm->extra_subflows++;
    ...
}

If a client socket initiates a local disconnect via connect(AF_UNSPEC), and
concurrently an in-flight SYN-ACK or remote MP_JOIN request is processed in
softirq context via mptcp_finish_join(), could they interleave?

It seems this might lead to data corruption of the pm->reset struct group
fields (including extra_subflows, accept_subflow, and addr_signal), which
could cause PM misbehavior such as permanent rejection of new subflows on a
reconnected socket.

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904051150.1196=
427-1-cui.tao@linux.dev?part=3D2
