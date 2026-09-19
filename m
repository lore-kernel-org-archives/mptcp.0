Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26AAC379EDA
	for <mptcp@lists.linux.dev>; Sat, 19 Sep 2026 20:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789850574; cv=none; b=b0wxA+G9iyosuuw8jb0M/eIkBj+S6Dinv6VjcFHiLIHt0qAf87SXU/iGHiU7Ku4pFZMJnROdwvIpL95MS48B7dljaHT8aMXqMI0SrZfneQZOxMZXGygLxG4VshSm8Xs7MKAqqq6nIzOSHv/3dsCKS9pERNGmlLGDLMgpTe9rKak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789850574; c=relaxed/simple;
	bh=Lk/KDhnFQ87AEgVYqMBDS0LmMdslHtOZCpDQiYWhft4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Qklj7K/QMl4gKzLB0qqH3CbZVEsSc547OMGZbd6U4guFD0uIFoWCosGQBKdk9V2BKWgUcwl0QTIDgMMZgqc7SRg7ng5bC425BauHzoj8BsW8FCLK965IQRVMZmampCZA8JQCb6sAXhr7lAQJsusJ2CpQdX/Bs348w/CaExnheRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mUMSV02q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mUMSV02q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 313FF1F000FF;
	Sat, 19 Sep 2026 20:42:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789850568;
	bh=gOVl2bY6yeRpZuGC4cDNfPUv0CVSfN0PrezTmrS9pPU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mUMSV02q4v+T0ki/AidJhoAVTzJOnfepWcPxEMk/rSD6eOP8OTAVwq4ejtvx4Znj8
	 mGZRaJIM12jl2RURrm6fZWQUFKIp86LbW2v9dW8ZKykL7ItZlqv3fLM/gmEApFzV47
	 kMctG4riqJIfoMaDi9cWcdBNE/3K58XZYf6cKAY6q1N0vahv79TjTPOkmjXQU1hM2A
	 h+W30YCh9CmRENahQjgHSCyQNhs1yG9UNY77N6wajEwhdNUt/ArFcU/sIcP5iMXu4Y
	 1yAYlCCpGv1AvaZelJOo1md4AAEJjWk2VXuWQL0XFogmh7TaLB0KKLHbNaVUMx7nyi
	 IpqynjxcrckwA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5.15.y 1/2] mptcp: avoid unneeded actions on subflow
 reset
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWF0dGhpZXUgQmFlcnRzIChOR0kwKQ==?= <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
In-Reply-To: <20260919202918.2074632-5-matttbe@kernel.org>
References: <20260919202918.2074632-4-matttbe@kernel.org>
 <20260919202918.2074632-5-matttbe@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 19 Sep 2026 20:42:47 +0000
Message-Id: <20260919204248.313FF1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] mptcp: data race in subflow bitfield leads to deadlock
--

commit 748ca2aef871b6b237079df0a200a9001209199e
Author: Paolo Abeni <pabeni@redhat.com>
Subject: mptcp: avoid unneeded actions on subflow reset

This commit introduces a new flag, resetting, to exit early in
subflow_state_change(), preventing recursive calls to mptcp_data_ready()
and recursive spinlock acquisition. It also explicitly flushes the RX queue
at reset time.

Link: https://patch.msgid.link/20260917-net-mptcp-misc-fixes-7-3-rc4-v2-1-0=
cf5c72667c8@kernel.org

> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 609e7768fab31..913d9b1474b05 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -447,7 +447,8 @@ struct mptcp_subflow_context {
>  		stale : 1,	    /* unable to snd/rcv data, do not use for xmit */
>  		valid_csum_seen : 1,        /* at least one csum validated */
>  		close_event_done : 1,       /* has done the post-closed part */
> -		__unused : 11;
> +		resetting : 1,	    /* subflow is resetting */
> +		__unused : 10;
>  	enum mptcp_data_avail data_avail;
>  	bool	pm_listener;	    /* a listener managed by the kernel PM? */
>  	u32	remote_nonce;
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index 33b16ea7ae5bc..5ee090b74fa45 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -373,6 +373,10 @@ void mptcp_subflow_reset(struct sock *ssk)
>  	/* must hold: tcp_done() could drop last reference on parent */
>  	sock_hold(sk);
> =20
> +	subflow->resetting =3D 1;

[Severity: High]
Does this bitfield assignment introduce a data race that could clear the new
flag and cause a deadlock?

The C compiler implements bitfield modifications as non-atomic read-modify-=
write
operations on the containing 32-bit word.=20

Here in mptcp_subflow_reset(), subflow->resetting =3D 1 is set while holdin=
g the
subflow ssk lock and the mptcp_data_lock, but the msk socket lock is not he=
ld.

Concurrently, a PM event like mptcp_pm_nl_mp_prio_send_ack() can modify
send_mp_prio in the same bitfield word:

net/mptcp/pm_netlink.c:mptcp_pm_nl_mp_prio_send_ack() {
    ...
    subflow->send_mp_prio =3D 1;
    subflow->request_bkup =3D bkup;
    ...
}

This PM path holds the msk socket lock and pm.lock, but critically does not
hold the ssk lock.

If the concurrent unguarded writes race, could the PM thread's update silen=
tly
overwrite and clear the resetting flag?

If the resetting flag is lost, the fix introduced in this commit would be
bypassed. subflow_state_change() would fail to return early and instead
recursively call mptcp_data_ready(), which tries to re-acquire the already =
held
mptcp_data_lock spinlock, leading to an immediate deadlock.

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260919202918.2074=
632-4-matttbe@kernel.org?part=3D1
