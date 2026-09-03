Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF173D1713
	for <mptcp@lists.linux.dev>; Thu,  3 Sep 2026 11:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788433868; cv=none; b=ereC4rzXPqoUEf883BhTMfNQUqy/9N6WdS8XoKX8gzmox5yr8gpm0cnuHocXgP3HBWTAJQdIFsrSXvVXD/A9EAP6wDRH/9DHDwdc583Ru8iFaA4E8npUnBLJOrb0d5l15sWzACueAsBSqmruyGkSL5vz0ao7jkQpLWmz0CRQnpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788433868; c=relaxed/simple;
	bh=uA5Zj4SsjUm8d9gKlw6xCQEa5SiGxtuJBWqumcD7NI8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lO5nDWIHwKI0x3LxPUJC3tjHm2vIONLYfGFk3JgS0Dsd6Y0FvWAn5RBAdepmYS9j166RQlCP+egIbOJbrz++hdAacMw3E7Sh7HLWlYrJYvlGbRNux8naDUuQCtHIjJgByAlQbUwYEMGaiBlzk4lyRVyyLee9beD+B/155jDi/Ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YRE1W/xw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YRE1W/xw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACCC11F000E9;
	Thu,  3 Sep 2026 11:11:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788433866;
	bh=wotIXdaNXnDG5UYpgNbObc0IaG07dHa+KcyTRaNKdqc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YRE1W/xwKyyUTRwJrO0LEJ6Xij7UC5ewm0aVOpM46pnlRvSPYZ7JwTgGnGs4zig4Y
	 0pxE2j00m5uVlR2lIkPn4lE0MmT4Fk4V80mAPJvm+I09XOYUmKhaO1Q/Z3nA3j+/CI
	 HzIRh6WmtbtI+wJ6a6Lh3n14PU6ZXgPqAokFf40krZRvfVbpBBFGEwWH4hpZqVBROO
	 3BK2YiDukRzrIg+lN+CPcioH4Frcg0h71AVazKSzx6m5LSYmuvn9onVlLpSegeq9BS
	 0OEPFrCd/Wgchf6euH3JjoXM6WZr3YFuYgNZPugbaeJzLsu1h0N9kEMNm18xL3eBqh
	 FAr/3AzNZTIvg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v5] mptcp: normalize seq numbers reported in
 mptcp_info
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kalpan Jani" <kalpan.jani@mpiricsoftware.com>
Cc: mptcp@lists.linux.dev
In-Reply-To: <20260903105515.906187-1-kalpan.jani@mpiricsoftware.com>
References: <20260903105515.906187-1-kalpan.jani@mpiricsoftware.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Sep 2026 11:11:06 +0000
Message-Id: <20260903111106.ACCC11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] Accessing `msk->first` locklessly under `mptcp_data_lock(sk)` =
without `READ_ONCE()` or RCU protection leads to a TOCTOU double-fetch, res=
ulting in a NULL pointer dereference or Use-After-Free.
- [Critical] The commit intentionally changes the semantics of UAPI fields =
`mptcpi_write_seq`, `mptcpi_snd_una`, and `mptcpi_rcv_nxt`, breaking usersp=
ace tools.
--

commit 7b94bc72d17bfabfa214a5c1eff0721e3dd01eea
Author: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
Subject: mptcp: normalize seq numbers reported in mptcp_info

This commit normalizes the data sequence numbers reported via mptcp_info
by subtracting the initial sequence numbers. It avoids caching the initial
numbers on the socket by reading them from the subflow context under the
data lock.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/445

> Note: this changes the semantics of mptcpi_write_seq, mptcpi_snd_una
> and mptcpi_rcv_nxt. They no longer report the raw on-the-wire MPTCP
> data sequence numbers, but values relative to the connection's
> initial sequence numbers. This is intentional. Tools that correlate
> these fields directly against captured DSS sequence numbers (e.g.
> via tcpdump) will need to account for the offset;

[Severity: Critical]
Does changing these UAPI fields from absolute on-the-wire sequence numbers
to relative offsets break the ABI for existing userspace tools?

The commit message notes that tools correlating these fields against captur=
ed
DSS sequence numbers will need to update how they account for the offset.
Will this break backwards compatibility for existing deployed userspace
applications that expect the previous behavior?

> diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
> index fcf6feb2a9eb5..1e0a5e06bb8a1 100644
> --- a/net/mptcp/sockopt.c
> +++ b/net/mptcp/sockopt.c
[ ... ]
> @@ -1008,9 +1009,19 @@ void mptcp_diag_fill_info(struct mptcp_sock *msk, =
struct mptcp_info *info)
>  	info->mptcpi_flags =3D flags;
> =20
>  	slow =3D lock_sock_fast(sk);
[ ... ]
>  	info->mptcpi_last_data_recv =3D jiffies_to_msecs(now - msk->last_data_r=
ecv);
>  	unlock_sock_fast(sk, slow);
> =20
>  	mptcp_data_lock(sk);
> +	if (msk->first) {
> +		struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(msk->first=
);

[Severity: Critical]
Can this sequence cause a NULL pointer dereference due to a race with
__mptcp_close_ssk()?

The commit message states that the transition of msk->first to NULL cannot =
be
observed mid-flight because mptcp_close() holds the same socket lock that
this function acquires via lock_sock_fast().

However, unlock_sock_fast() releases that lock right before acquiring the
spinlock mptcp_data_lock().

If a concurrent thread running mptcp_close() proceeds to __mptcp_close_ssk()
and executes WRITE_ONCE(msk->first, NULL) without holding mptcp_data_lock():

net/mptcp/protocol.c:__mptcp_close_ssk() {
    ...
	if (ssk =3D=3D msk->first)
		WRITE_ONCE(msk->first, NULL);
    ...
}

Could msk->first be modified to NULL between the if check and the dereferen=
ce
since READ_ONCE() is not used here under the spinlock?

If the first fetch is non-NULL and the second fetch is NULL,
mptcp_subflow_ctx() would compute a negative offset, leading to a crash when
accessing subflow->iasn.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260903105515.9061=
87-1-kalpan.jani@mpiricsoftware.com?part=3D1
