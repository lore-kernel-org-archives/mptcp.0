Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B63C013B5B3
	for <mptcp@lists.linux.dev>; Thu, 13 Aug 2026 11:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786621751; cv=none; b=eH82bfD4NLVA3t4EvVlsUKaxvfP3XVmZ+XBDlZqvT2/eNl5c3d309zzbANtyvKH0/9kVNnFHLOHMoVrCYyauSYQRGAOaIApQi15prJbNXLONyt1WrPQAZ3dNKFoQX5p2Uo61CMP/YXKbyOsZqKed5oz18ncsvrjgJquC+6I07oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786621751; c=relaxed/simple;
	bh=/tjymOHJR1MfdLumJjCKzf/9pA88wjNr8XSMwxhmTbM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gnt5XJKfWMsEwlOYO4n7egtgdsjhVJxr8gHwEMFd7JJ7Yxu0lz6d99VPQ4j5DePKBcaQCz+q3x1nuAl3fEjIcvIkIG0ogUnGqVdJdInupk/QhL9lwN+1/NuQMqykIYWHmSB6e5HOv9Cp2yhL7MLO120PIaY3kIqx04kv0mRldkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iwWPLl22; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iwWPLl22"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEF721F000E9;
	Thu, 13 Aug 2026 11:49:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786621750;
	bh=f7UhFy+v6+jSpvDOZzUqqzqmygG5ZMX2xK3DwLEiE48=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iwWPLl22b8NBOhQtVSGWRhLRG+A+CNDvPUDcNt2IKPvKozNIGh9SxhTYawu9M/ubH
	 LzjqnF79/aqIkhOuu5dRsixBHUbvZkBb2MpscpIPc6/+CFwhYm5yA7Tb6KJpGKHJhS
	 InAbvUiPUKrOPlx4Z6wRgY4Rk4qlg+xfwobSwBLmvmEGaSKhkK87x5rp056vEgCfAv
	 0ty+mCvCfRtFLNgQv92cCrSoz1eOwzsFK4YF9lQ97L0OE4SdP8mV/I9x8UzTu/SyCz
	 +Ks2gDymortArfpgWDopvWLBzfaOYZTM0FqfVNTr5Uct7oOg3HEUMAqYhIjsOF/+0P
	 wjJg3DKj9JgtQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-next] mptcp: fix add_addr_accepted accounting on
 subflow close
Reply-To: sashiko-reviews@lists.linux.dev
To: "Akshit Patadiya" <akshit@mpiricsoftware.com>
Cc: mptcp@lists.linux.dev
In-Reply-To: <20260813113208.3809139-1-akshit@mpiricsoftware.com>
References: <20260813113208.3809139-1-akshit@mpiricsoftware.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 11:49:09 +0000
Message-Id: <20260813114909.EEF721F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Concurrent updates to msk->pm.rm_list_rx can cause RM_ADDR IDs to =
be silently skipped, resulting in leaked subflows.
--

--- Patch [1]: [PATCH mptcp-next] mptcp: fix add_addr_accepted accounting o=
n subflow close ---
commit 09eae8ab35dfee45655629d4bbc00b4a93d797f3
Author: Akshit Patadiya <akshit@mpiricsoftware.com>

mptcp: fix add_addr_accepted accounting on subflow close

When an accepted remote address is used by a subflow that is closed before
the corresponding RM_ADDR is received, the add_addr_accepted counter is not
decremented. This commit releases the accepted-address slot when the subflow
closes, allowing subsequent ADD_ADDR requests to reuse the budget.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/498

> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> --- a/net/mptcp/pm.c
> +++ b/net/mptcp/pm.c
[ ... ]
> @@ -786,7 +788,6 @@ static void mptcp_pm_rm_addr_or_subflow(struct mptcp_=
sock *msk,
> =20
>  	for (i =3D 0; i < rm_list->nr; i++) {
>  		u8 rm_id =3D rm_list->ids[i];
> -		bool removed =3D false;
> =20
>  		mptcp_for_each_subflow_safe(msk, subflow, tmp) {
>  			struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
> @@ -807,7 +808,6 @@ static void mptcp_pm_rm_addr_or_subflow(struct mptcp_=
sock *msk,
>  				 i, rm_id, id, remote_id, msk->mpc_endpoint_id);
>  			spin_unlock_bh(&msk->pm.lock);
>  			mptcp_subflow_shutdown(sk, ssk, how);

[Severity: High]
This isn't a bug introduced by this patch, but could this loop miss RM_ADDR=
=20
IDs and leak subflows due to concurrent list updates?

In mptcp_pm_rm_addr_or_subflow(), this loop iterates over the rm_list (whic=
h=20
is passed as &msk->pm.rm_list_rx) and temporarily drops pm->lock around=20
mptcp_subflow_shutdown().

If a remote peer sends multiple RM_ADDR options in rapid succession, softir=
q=20
context can call mptcp_pm_rm_addr_received(), which unconditionally overwri=
tes=20
pm->rm_list_rx while scheduling work:

net/mptcp/pm.c:mptcp_pm_rm_addr_received() {
    ...
    if (mptcp_pm_schedule_work(msk, MPTCP_PM_RM_ADDR_RECEIVED))
        pm->rm_list_rx =3D *rm_list;
    ...
}

If pm->rm_list_rx is overwritten mid-iteration while the worker thread drop=
ped=20
pm->lock, wouldn't the loop in mptcp_pm_rm_addr_or_subflow() either termina=
te=20
early or read incorrect indices from the new list, silently skipping unhand=
led=20
IDs from the original list and leaking the associated resources?

> -			removed |=3D subflow->request_join;
> =20
>  			/* the following takes care of updating the subflows counter */
>  			mptcp_close_ssk(sk, ssk, subflow);
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260813113208.3809=
139-1-akshit@mpiricsoftware.com?part=3D1
