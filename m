Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 251983AB5C7
	for <mptcp@lists.linux.dev>; Fri, 29 May 2026 06:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780037721; cv=none; b=BhlWu8+TAcKkc1bSSB0q3r+c3yGd04aNcEmDLnA2uj2bhCQGLXSsGORtWWg7xrOH32RwLXpphIwn/+DbKTkPCpCi7+RMzNIOv8yKdjf7It7unyUtO790nTSSVN3t52yClqQEJO5G8DRnJauTniMPyY7ql2sPyOlIE0LH7X5PdAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780037721; c=relaxed/simple;
	bh=1wt95dx6E3FdkpMcEzZjTdKkvfniiq26SL8BwtDb/jE=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=cigB7Q3rgS91StdHWirpP+1V+oec0ICZy9Wa+w3UM99oNKez8voo5AvvSkyxS4zqDiclDv6/7hH3sQLMWuVZEqhUV6Glfk1D9vbA5MhXqQVA+W6th9D60EFyyXI8sn8/pdBZUnU3Bej0YROcTfTv9LoIC/64v8efIW2LGWSs4vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W4Ah9LGo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W4Ah9LGo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 500781F00893;
	Fri, 29 May 2026 06:55:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780037719;
	bh=1wt95dx6E3FdkpMcEzZjTdKkvfniiq26SL8BwtDb/jE=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=W4Ah9LGoW3DpQ5ciu0DQLE35edQo3OMj7PwyhIlIPK7FnNsK5CSSAJXdf0tfp09NO
	 noy5jzd3+tti3Zs+yBr1m4iF52KY2DXYi1QqmFBR0STdy/0Elk6WDnncT/2SLyTuNM
	 8SnS80CXXnKTRNfSyRAiyO+6xEDx8ZVzc3uOq2E3PtmbHO2tqsx/4uAuGxSsk3HFNT
	 Q/hQWhslZETYCzlhK9+qVfGIdPXb422pj6x3IGrMHFRkBDuMfXQG3BE2bC5Ytq8Qed
	 NiTi1vSiTt44g3UQugQXQbM1u5OS306/9Q1CLXa10EZADtrLiQhNeXDezqgYDteV/3
	 Xw9ZsK1d2xYEg==
Date: Fri, 29 May 2026 16:55:09 +1000
From: Matthieu Baerts <matttbe@kernel.org>
To: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
Cc: mptcp@lists.linux.dev, martineau@kernel.org, pabeni@redhat.com,
	shardul.b@mpiricsoftware.com, janak@mpiric.us,
	kalpanjani009@gmail.com, shardulsb08@gmail.com,
	syzbot+55c2a5c871441261ed14@syzkaller.appspotmail.com
Message-ID: <0f13954f-3bfa-4630-af9f-6f1f4b138a13@kernel.org>
In-Reply-To: <20260529064355.922763-1-kalpan.jani@mpiricsoftware.com>
References: <20260529064355.922763-1-kalpan.jani@mpiricsoftware.com>
Subject: Re: [PATCH net v2] mptcp: pm: drop pending ADD_ADDR when removing
 id 0 endpoint
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Correlation-ID: <0f13954f-3bfa-4630-af9f-6f1f4b138a13@kernel.org>

Hi Kalpan,

Thank you for the v2.

29 May 2026 16:44:12 Kalpan Jani <kalpan.jani@mpiricsoftware.com>:

> syzkaller hit the WARN_ON_ONCE() in mptcp_pm_alloc_anno_list() with
> the in-kernel path manager.
>
> When a signal endpoint is removed, the pending ADD_ADDR has to be
> cancelled: its retransmit timer stopped and the anno_list entry
> unlinked and freed. For a non-zero id endpoint this is done via
> mptcp_nl_remove_subflow_and_signal_addr() ->
> mptcp_pm_remove_anno_addr() -> mptcp_remove_anno_list_by_saddr().
>
> The id 0 removal path, mptcp_nl_remove_id_zero_address(), does not do
> this: it only queues a RM_ADDR and marks the id available again, but
> leaves any pending anno_list entry and its armed retransmit timer
> alive.
>
> So when the id 0 endpoint is removed and re-added while its previously
> sent ADD_ADDR is still awaiting the echo, the stale entry survives.
> The kernel PM reselects id 0, reaches mptcp_pm_alloc_anno_list() a
> second time, finds the stale entry and hits the WARN.
>
> Make the id 0 removal path symmetric with the non-zero one: drop the
> pending ADD_ADDR before queuing the RM_ADDR, and decrement
> add_addr_signaled if the address had been announced. This closes the
> race at its source, so the WARN_ON_ONCE() stays a valid assertion.
>
> Fixes: 740d798e8767 ("mptcp: remove id 0 address")
> Reported-by: syzbot+55c2a5c871441261ed14@syzkaller.appspotmail.com
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/620
> Signed-off-by: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
> ---
>
> v1 -> v2:
> - Do not drop the WARN_ON_ONCE(); it is a valid assertion.
> =C2=A0=C2=A0 (Matthieu Baerts)
> - Fix mptcp_nl_remove_id_zero_address() to tear down the pending
> =C2=A0=C2=A0 ADD_ADDR entry: call mptcp_remove_anno_list_by_saddr() and
> =C2=A0=C2=A0 decrement add_addr_signaled, mirroring the non-zero id path.
> =C2=A0=C2=A0 (Matthieu Baerts)
> =C2=A0=C2=A0
> net/mptcp/pm_kernel.c | 10 ++++++++++
> 1 file changed, 10 insertions(+)
>
> diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
> index fc818b63752e..ed0ad1c1b140 100644
> --- a/net/mptcp/pm_kernel.c
> +++ b/net/mptcp/pm_kernel.c
> @@ -1126,6 +1126,7 @@ static int mptcp_nl_remove_id_zero_address(struct n=
et *net,
> =C2=A0=C2=A0=C2=A0 while ((msk =3D mptcp_token_iter_next(net, &s_slot, &s=
_num)) !=3D NULL) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct sock *sk =3D (struct so=
ck *)msk;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct mptcp_addr_info msk_loc=
al;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool announced;
>
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (list_empty(&msk->conn_list=
) || mptcp_pm_is_userspace(msk))
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto n=
ext;
> @@ -1135,7 +1136,16 @@ static int mptcp_nl_remove_id_zero_address(struct =
net *net,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto n=
ext;
>
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 lock_sock(sk);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Drop a possibly pending ADD_ADDR=
 for this address: stop its
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * retransmit timer and unlink=
 the anno_list entry, so a later
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * re-add cannot find a stale =
entry and hit the WARN_ON_ONCE()
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * in mptcp_pm_alloc_anno_list=
(). Mirrors the non-zero id path
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * in mptcp_pm_remove_anno_add=
r().
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */

I'm not sure such a long comment in the code is that useful, and it
might: it can quickly become outdated when other parts are modified.
Limit it to the first line, the rest can be seen in the commit message.

> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 announced =3D mptcp_remove_anno_lis=
t_by_saddr(msk, &msk_local);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spin_lock_bh(&msk->pm.lock);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (announced)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 msk->pm.add=
_addr_signaled--;

It would be good to check this counter on the test/reproducer you will
provide. Did it work with packetdrill?

Cheers,
Matt

> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mptcp_pm_remove_addr(msk, &lis=
t);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mptcp_pm_rm_subflow(msk, &list=
);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __mark_subflow_endp_available(=
msk, 0);
> --
> 2.43.0

