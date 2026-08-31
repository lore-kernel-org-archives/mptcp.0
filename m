Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88AEA3D3D10
	for <mptcp@lists.linux.dev>; Mon, 31 Aug 2026 10:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788170870; cv=none; b=T8E1aB1Nfm439KFI69AdY416Hy9wCbwJXvCdGiDpwnJ1a7bHp82qmGveswJyLsvChNG0Skalxlv0x7OT/KLUhNwMW9SmMoWLS9sFsaZpBfGy6Htnys7dyj+P7KXv9ZzQFMMvDSz7BvNJpp2z9KBN1nREnj6C1C/+5DOtZBzRkwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788170870; c=relaxed/simple;
	bh=sp4OyLAF1P8MgJ+iPo7g4mtiMd7/TSbN4xz8Dq5jB8E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Nz0cEII4rbxb62xrQxqfqyvx5SF5kzmTSMJe5iwOjCYu3Yg257Yqb2No33yWFq1FO4/BB/uxS4X6IQbcSyKlw1zGVmYTCK5ahMy5ighufNpF9/vRTQs+ab3m0gwmmF9YQE6cASbVLW1s9tfqe7H+NQTODKeoHUw0osj49MMFOg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OKcATQP6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OKcATQP6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CB581F000E9;
	Mon, 31 Aug 2026 10:07:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788170869;
	bh=ff9cHODE85Ho5uzIj0EfbQb2vIpAqf7YAHV2YGrS7lQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OKcATQP6ETW++1ejR/LqZ1v25Ay8PO69l8MlXrNdOq0iBL9FiOnZU8JTOibKHXEJc
	 nY+gsSOhMhiuwFKESN3hP3IQQmKoCaCj33j1K+psTwLGTP74S1LPeiruNZ50AYoon2
	 lHyK4eqDDZDHOe+aZoxcmlwWAFEQRnQGsGMD469MxY7IepNtoWfoKTLMDeV2s5JDRR
	 SeK4r0a9V/mzq2KWerml+EHN5Yy5T2rusLJ7IQI+Fl1ivuKp5XyxFeEG70cmFqpzdV
	 lNmjcoNvPQpTRaOo9u5YenO4Numh0AtEQZap5P4DwN8VqNRE8GdMmRC/wYXrR94hkR
	 N7dDVRdw4v1mw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-next v3 1/2] mptcp: sched: add subflow avoid flag
 and enforce it in core
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kalpan Jani" <kalpan.jani@mpiricsoftware.com>
Cc: mptcp@lists.linux.dev
In-Reply-To: <20260831094651.2682660-2-kalpan.jani@mpiricsoftware.com>
References: <20260831094651.2682660-1-kalpan.jani@mpiricsoftware.com>
 <20260831094651.2682660-2-kalpan.jani@mpiricsoftware.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 10:07:48 +0000
Message-Id: <20260831100749.0CB581F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Concurrent modification of the `mptcp_subflow_context` bitfield ca=
uses a read-modify-write data race, leading to corrupted critical subflow s=
tate.
- [Medium] The `avoid` flag is not enforced by the core when a custom BPF s=
cheduler is loaded, directly contradicting the commit message's claims.
--

commit 99e88cae3546011d9eecb7fbb324ce6a3cff75f9
Author: Kalpan Jani <kalpan.jani@mpiricsoftware.com>

mptcp: sched: add subflow avoid flag and enforce it in core

This commit adds a new avoid flag to the MPTCP subflow context to allow
BPF schedulers to bench subflows. It also modifies the core send and
retransmit paths to skip subflows marked with this flag.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/349

>  - mptcp_subflow_get_send() and mptcp_subflow_get_retrans() -- the
>    default in-kernel subflow picker -- now skip an avoided subflow
>    next to the existing active-subflow check. This runs regardless of
>    whether a custom scheduler is loaded, so the flag has real weight
>    on core selection and isn't only meaningful to whatever BPF
>    program happens to read it back. avoid defaults to false and only
>    an explicit set_avoid() call flips it, so this is a no-op for
>    anyone who doesn't use it;

[Severity: Medium]
Is this description accurate regarding custom BPF schedulers?

Looking at mptcp_sched_get_send() in net/mptcp/sched.c, if a custom
BPF scheduler is active (msk->sched !=3D &mptcp_sched_default), the core
directly returns the result of the custom scheduler's callback:

net/mptcp/sched.c:mptcp_sched_get_send() {
    ...
    if (msk->sched =3D=3D &mptcp_sched_default || !msk->sched)
        return mptcp_sched_default_get_send(msk);
    return msk->sched->get_send(msk);
}

This appears to bypass mptcp_subflow_get_send() entirely (which is
where the avoid check lives) when a custom scheduler is used. Does the
core provide fallback enforcement elsewhere, or does the flag become a
no-op unless the custom BPF program manually checks it?

> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 3d250e8204d52..7768a464ff4e8 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -586,7 +586,8 @@ struct mptcp_subflow_context {
>  		is_mptfo : 1,	    /* subflow is doing TFO */
>  		close_event_done : 1,       /* has done the post-closed part */
>  		mpc_drop : 1,	    /* the MPC option has been dropped in a rtx */
> -		__unused : 9;
> +		avoid : 1,	    /* pkt scheduler: skip subflow if possible */
> +		__unused : 8;
>  	bool	data_avail;

[Severity: High]
Can placing avoid in this shared bitfield lead to data corruption via
a read-modify-write (RMW) race?

The core network stack modifies other flags in this same 32-bit bitfield
from the RX softirq path while holding only the TCP subflow socket lock
(ssk). For example, it clears subflow->map_valid =3D 0 in
net/mptcp/subflow.c:mptcp_subflow_data_available().

Because bitfield assignments compile to non-atomic RMW operations on the
containing 32-bit word, modifying this new flag from the BPF kfunc under
the MPTCP socket lock (msk) could race with those softirq updates.

[ ... ]

> diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
> index 1e59072d478c9..8a448814a11d4 100644
> --- a/net/mptcp/sched.c
> +++ b/net/mptcp/sched.c
> @@ -165,6 +165,12 @@ void mptcp_subflow_set_scheduled(struct mptcp_subflo=
w_context *subflow,
>  	WRITE_ONCE(subflow->scheduled, scheduled);
>  }
> =20
> +__bpf_kfunc void mptcp_subflow_set_avoid(struct mptcp_subflow_context *s=
ubflow,
> +					 bool avoid)
> +{
> +	subflow->avoid =3D avoid;
> +}

[Severity: High]
Does this bitfield assignment risk overwriting concurrent softirq updates?

Since this function executes under the msk lock and not the ssk lock,
this assignment races with the ssk-locked updates to the same bitfield word
mentioned above, potentially causing flags like map_valid or mpc_drop
to be silently dropped.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831094651.2682=
660-1-kalpan.jani@mpiricsoftware.com?part=3D1
