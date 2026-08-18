Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64CC529E11A
	for <mptcp@lists.linux.dev>; Tue, 18 Aug 2026 10:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787047313; cv=none; b=QqIqTl0FEz/oFhD+l9upf89HNZV/xRlpakihpnCrYGdU7XuWjpyg+baz8/zNBOYEDUyv1Kaer8LOTJBJGScGRmVgwp+gV3tWss80VO+J12iX4Cj5U73UBdRtOLrlhfZqvyU9OprUKCDwfKLd5VM8FhpDP/IhCF3h1KsihEymqqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787047313; c=relaxed/simple;
	bh=lxgS0GKdXTQT+b56AwLVH+1i5EZqjVN0UMqByWiSQNs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=p0fLCvmqfIbXvuWE7vtMCBWgEaP+CxZhYJG37v27KJpLh0SwwKxASSH9SLAS5kU9HTAeeCWccjPlrbceE5YQI+uh/hqA2fjtRB+qq4kh7q91tU632WGi+0UQ337a7NgpIumyuBBJmCHh4Y7tQTr/HZaE1vt7T5PGdDjlZegudYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=klA9GKCm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="klA9GKCm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD70A1F00A3E;
	Tue, 18 Aug 2026 10:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787047312;
	bh=2QgJnnpgrULwKtYoBjOnRFEhFp9dw27H4gQQ4XwLrUQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=klA9GKCmoU1cXJ1mI3DxGGHo9k/3eqfvgg/lSpaOYBUtoZ3KFXgyF+j+X3cR3xraH
	 lTqkHEuONUYLnEh68Up2zehlBfiRRaGeLNtYHO6slh4zuylnu9+YdrBR9qrWN8M1dh
	 pJ1BCpGb/xUjtFZgTGlbUX5FUKfXVaJMeaUktPVJiQfuNTYBKjpd4ykxDys0pX9D9O
	 ugEczMUa45llWS4q3U0gxN5dzx3GGrLKPHJTjLDHqnN4S9LiyUyt3Hlrx35LMBhWNw
	 r6xgqgqx1j4ihIRchv2Hh+d1+2Q8Fhd07oCtDV4YD8U4KB9Dx8Gdy1oSY8xWfTVgYK
	 hQCWHNIxE9VFQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-next v2 3/5] mptcp: use READ_ONCE() over sysctls
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gang Yan" <gang.yan@linux.dev>
Cc: mptcp@lists.linux.dev
In-Reply-To: <20260818094825.48446-4-gang.yan@linux.dev>
References: <20260818094825.48446-1-gang.yan@linux.dev>
 <20260818094825.48446-4-gang.yan@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 18 Aug 2026 10:01:51 +0000
Message-Id: <20260818100151.DD70A1F00A3E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Concurrent sysctl writes or sysctl updates racing with socket crea=
tion can leave the socket's `pm_type` and `ops` mismatched, breaking MPTCP =
path management.
--

--- Patch [3]: [PATCH mptcp-next v2 3/5] mptcp: use READ_ONCE() over sysctl=
s ---
commit 77c9e4aa4cdd5f6c57cc4cab253d46fd0cf2dfb2
Author: Matthieu Baerts (NGI0) <matttbe@kernel.org>

mptcp: use READ_ONCE() over sysctls

This commit adds READ_ONCE() and WRITE_ONCE() macros around sysctl
variables in the MPTCP networking code to avoid KCSAN issues. It also
ensures the pm_type is written with WRITE_ONCE() in proc_path_manager().

Closes: https://lore.kernel.org/CANn89iL=3Dos-60kDKqMDdyiXuPF5CG=3DeejS0vmt=
hwpDGXz_Bp8A@mail.gmail.com

> diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
> index c0481b09c1a17..733706f06f1b1 100644
> --- a/net/mptcp/ctrl.c
> +++ b/net/mptcp/ctrl.c

[ ... ]

> @@ -251,7 +251,7 @@ static int proc_path_manager(const struct ctl_table *=
ctl, int write,
>  				pm_type =3D MPTCP_PM_TYPE_KERNEL;
>  			else if (strncmp(pm_name, "userspace", MPTCP_PM_NAME_MAX) =3D=3D 0)
>  				pm_type =3D MPTCP_PM_TYPE_USERSPACE;
> -			pernet->pm_type =3D pm_type;
> +			WRITE_ONCE(pernet->pm_type, pm_type);

[Severity: High]
This is a pre-existing issue, but can this sequential update race with sock=
et
creation and leave the socket's pm_type and ops mismatched?

If an administrator writes to the sysctl while a new socket is being create=
d,
could mptcp_pm_data_reset() in net/mptcp/pm.c interleave like this:

CPU1 (sysctl write)
proc_path_manager()
    mptcp_set_path_manager(pernet, pm_name); // Updates pernet->path_manager

CPU2 (socket creation)
mptcp_pm_data_reset()
    pm_type =3D mptcp_get_pm_type(net);        // Reads old pm_type
    ...
    mptcp_get_path_manager(net, pm_name);    // Reads new path_manager

CPU1 (sysctl write resumes)
proc_path_manager()
    WRITE_ONCE(pernet->pm_type, pm_type);    // Updates pernet->pm_type

Would this leave the new socket corrupted with a contradictory path manager
state, breaking MPTCP path management logic?

>  		}
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260818094825.4844=
6-1-gang.yan@linux.dev?part=3D3
