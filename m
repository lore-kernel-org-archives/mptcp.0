Received: from mta0.migadu.com (out-54.mta0.migadu.com [91.218.175.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 332BE2D97BA
	for <mptcp@lists.linux.dev>; Tue, 18 Aug 2026 13:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787058179; cv=none; b=BXMDuk+j1kvGIfmW06mz0UBlXP3ZkdYmStGYfjs6PlgcsWpYVqf8VyfjbpQCjUMe3T2ohyyG3XxN4wySa9/pyepBokVuNMvXz8/XVJ90UN0U+DGJYa4Q3SWX7sA42gMdPnbJTK/xqKSlp3kcii53kWrVD+Ij4g4IPBTsrdgC3Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787058179; c=relaxed/simple;
	bh=M5o7MpfkbUIQS5De3ZnokH8AZQjOmOc6UuBLXscZUX8=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=s9phXT/0BYXgUBpKY6AlLEv4mZzULmg6fXpTOE7mXqWrphGYvHBBXB9w/9jqm1N1wIlLSn8Sp5FsZVZ6bOfT3yhvKPD8QdZoxUjxBwVDgu2Pb0YwOHwx2f/dHyn82nhASyNiH8kS7uKUGwkkJXtV4AherR5CPfiTyPK0d/iS1/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PtW+jYF7; arc=none smtp.client-ip=91.218.175.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PtW+jYF7"
X-Envelope-To: mptcp@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=M5o7MpfkbUIQS5De3ZnokH8AZQjOmOc6UuBLXscZUX8=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787058171; v=1; x=1787662971;
 b=PtW+jYF7NN6fJkAxB5T7xZKq2M/Fj4LlP7g7O69vsaGSgG+7zT4PZMK2NNl6sCO3QNboWyWX
 ek7CzPQIz4NR/MJJfhjS+NwhfXONbqjPzmFxz6hLGkp04uiZgLnrEgkplnjlHK4Cz7n9XRIenlU
 +alNsmM+IH92p0yMgYhJjZ+8=
X-Envelope-To: mptcp@lists.linux.dev
Received: from webmail.migadu.com (2001:41d0:303:fc7a::)
	by smtp.migadu.com with ESMTPS id 671611093a025cdf;
	Tue, 18 Aug 2026 13:02:41 +0000
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Date: Tue, 18 Aug 2026 13:02:37 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
From: gang.yan@linux.dev
Message-ID: <e0cd265f7d15246668d06c865adacf36943cc6c3@linux.dev>
TLS-Required: No
Subject: Re: [PATCH mptcp-next v2 3/5] mptcp: use READ_ONCE() over sysctls
To: sashiko-reviews@lists.linux.dev
Cc: mptcp@lists.linux.dev
In-Reply-To: <20260818100151.DD70A1F00A3E@smtp.kernel.org>
References: <20260818094825.48446-1-gang.yan@linux.dev>
 <20260818094825.48446-4-gang.yan@linux.dev>
 <20260818100151.DD70A1F00A3E@smtp.kernel.org>

August 18, 2026 at 6:01 PM, sashiko-bot@kernel.org mailto:sashiko-bot@ker=
nel.org  wrote:


>=20
>=20Thank you for your contribution! Sashiko AI review found 1 potential =
issue(s) to consider:
>=20
>=20Pre-existing issues:
> - [High] Concurrent sysctl writes or sysctl updates racing with socket =
creation can leave the socket's `pm_type` and `ops` mismatched, breaking =
MPTCP path management.
> --
>=20
>=20--- Patch [3]: [PATCH mptcp-next v2 3/5] mptcp: use READ_ONCE() over =
sysctls ---
> commit 77c9e4aa4cdd5f6c57cc4cab253d46fd0cf2dfb2
> Author: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>=20
>=20mptcp: use READ_ONCE() over sysctls
>=20
>=20This commit adds READ_ONCE() and WRITE_ONCE() macros around sysctl
> variables in the MPTCP networking code to avoid KCSAN issues. It also
> ensures the pm_type is written with WRITE_ONCE() in proc_path_manager()=
.
>=20
>=20Closes: https://lore.kernel.org/CANn89iL=3Dos-60kDKqMDdyiXuPF5CG=3Dee=
jS0vmthwpDGXz_Bp8A@mail.gmail.com
>=20
>=20>=20
>=20> diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
> >  index c0481b09c1a17..733706f06f1b1 100644
> >  --- a/net/mptcp/ctrl.c
> >  +++ b/net/mptcp/ctrl.c
> >=20
>=20[ ... ]
>=20
>=20>=20
>=20> @@ -251,7 +251,7 @@ static int proc_path_manager(const struct ctl_t=
able *ctl, int write,
> >  pm_type =3D MPTCP_PM_TYPE_KERNEL;
> >  else if (strncmp(pm_name, "userspace", MPTCP_PM_NAME_MAX) =3D=3D 0)
> >  pm_type =3D MPTCP_PM_TYPE_USERSPACE;
> >  - pernet->pm_type =3D pm_type;
> >  + WRITE_ONCE(pernet->pm_type, pm_type);
> >=20
>=20[Severity: High]
> This is a pre-existing issue, but can this sequential update race with =
socket
> creation and leave the socket's pm_type and ops mismatched?
>=20
>=20If an administrator writes to the sysctl while a new socket is being =
created,
> could mptcp_pm_data_reset() in net/mptcp/pm.c interleave like this:
>=20
>=20CPU1 (sysctl write)
> proc_path_manager()
>  mptcp_set_path_manager(pernet, pm_name); // Updates pernet->path_manag=
er
>=20
>=20CPU2 (socket creation)
> mptcp_pm_data_reset()
>  pm_type =3D mptcp_get_pm_type(net); // Reads old pm_type
>  ...
>  mptcp_get_path_manager(net, pm_name); // Reads new path_manager
>=20
>=20CPU1 (sysctl write resumes)
> proc_path_manager()
>  WRITE_ONCE(pernet->pm_type, pm_type); // Updates pernet->pm_type
>=20
>=20Would this leave the new socket corrupted with a contradictory path m=
anager
> state, breaking MPTCP path management logic?

Hi,

I think that may happen. Maybe need anothor patch to fix this.

When I have time, I'll look this.

Thanks
Gang


>=20
>=20>=20
>=20> }
> >  }
> >=20
>=20--=20
>=20Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/2026081809482=
5.48446-1-gang.yan@linux.dev?part=3D3
>
