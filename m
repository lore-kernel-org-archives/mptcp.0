Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B2433F5BC
	for <mptcp@lists.linux.dev>; Fri, 14 Aug 2026 05:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786684482; cv=none; b=piWXKhBbEIzz8PEH23yG3z3Qu/aEHMXTdlRoAn+iH79/oAgcaKBz9MTjkHcydqj4DyfFD6Ze6rFZkHvObcwSjzDxPVsoRaLLbGOPwRDy81rXkbibDmYfd7uZNDGjkhWwPIQ1IiKNJP1QEn27IUI2ioDM+Q36PIXVN7Z5q8UV0Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786684482; c=relaxed/simple;
	bh=gVUpUMAkyhrIlFwz7LXgkisyMkNvmLbI1qY/mr9pu0g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=a8s9VFQzd0p4D3zIk8l64sWudY4FhXt/ShfxX+YjlIQBKO3I3guIWw7I5XhR7daklMbnAYA0DiBqfd+6Es0XFIXYI/DQ9hdJiB/9fGltYcgPwoDH0Wv0VbTdMnyElIY5yiBDaUPyz1uC8cm1W44HlFMnQp5UyhZpm8Mc38DbbQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wm96+j3U; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wm96+j3U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD4F71F000E9;
	Fri, 14 Aug 2026 05:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786684481;
	bh=qM+q/LdAn39ja27EaSGhcOV+DUhhCKpyBR7uMOgb+fg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Wm96+j3UK+TJL/XRT+tKWyQ9hHSNUBfgct44IMg76DH2etEDPI8MfUEoHgm+saiF3
	 gblIMUVUpHo+qcj0/PAHqdCt9nez8YQgCv4VSu9TIMVYPPZW3e40cZ3l0lexWRTTnT
	 pnWg5IthgH/WDSfhO9xHDMU1ZpFbMq2GKT4mvYFpwjqgZ6I8DyuUABd4wHBKwkNS6m
	 22/xF/uIXxbYyFJsfYWi7OHfceDxcOdZ+LGqQ1Bfk0WrtPIrNzXPci2ZBbfDCG2FMN
	 RyCpsCl8Zt+Z6ZEfXgF3ocsEcyj9pHmK/B1nANJfMZc84amOnaEhYQUutKAvRuy7oe
	 Fsqpp6yZHSdVw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-net] selftests: mptcp: fix an UAF in
 mptcp_connect.c
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gang Yan" <gang.yan@linux.dev>
Cc: mptcp@lists.linux.dev
In-Reply-To: <20260814050625.80231-1-gang.yan@linux.dev>
References: <20260814050625.80231-1-gang.yan@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 05:14:40 +0000
Message-Id: <20260814051440.DD4F71F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] sock_reconnect() unconditionally connects to the first resolved =
address instead of iterating, introducing a logic regression for multi-IP h=
osts.
--

--- Patch [1]: [PATCH mptcp-net] selftests: mptcp: fix an UAF in mptcp_conn=
ect.c ---
commit 0dae1d93a2aa0c4ea91bddbe5e055fd748d90080
Author: Gang Yan <yangang@kylinos.cn>

selftests: mptcp: fix an UAF in mptcp_connect.c

This patch removes the peer out-parameter from sock_connect_mptcp() to prev=
ent a
use-after-free issue when the original address memory is freed. It introduc=
es a
sock_reconnect() helper to resolve the address and connect independently
during reconnection attempts.

> diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/te=
sting/selftests/net/mptcp/mptcp_connect.c
> index cbe573c4ab3ad..05ab9887485c0 100644
> --- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
> +++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c

[ ... ]

> @@ -427,6 +424,22 @@ static int sock_connect_mptcp(const char * const rem=
oteaddr,
>  	return sock;
>  }
> =20
> +static int sock_reconnect(const char *host, const char *port, int fd)
> +{
> +	struct addrinfo hints =3D {
> +		.ai_socktype =3D SOCK_STREAM,
> +		.ai_family =3D pf,
> +	};
> +	struct addrinfo *addr;
> +	int ret;
> +
> +	xgetaddrinfo(host, port, &hints, &addr);
> +	ret =3D connect(fd, addr->ai_addr, addr->ai_addrlen);

[Severity: Medium]
Will this unconditionally connect to the first address returned by
xgetaddrinfo() without iterating or attempting fallbacks?

The original connection logic in sock_connect_mptcp() implicitly saved the
successful connection address by keeping a pointer to the successful node
in the addrinfo list. By resolving the host again and blindly connecting to
the first returned address without looping, could this cause the selftest
to spuriously fail if the host resolves to multiple IPs (like dual-stack
IPv4/IPv6 on localhost) and the first address is not the one previously use=
d?

> +	freeaddrinfo(addr);
> +
> +	return ret;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814050625.8023=
1-1-gang.yan@linux.dev?part=3D1
