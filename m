Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E38349B19
	for <mptcp@lists.linux.dev>; Fri, 14 Aug 2026 14:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786716918; cv=none; b=Kvw4hfxVLTHtOFYc3ZFNRIy21qlBE28qgYly1O97G7z4g10kxiQoNT9F83L5qPh5h4rdsLy5+PC89EKzkBvb8tfWFfxdkEooA+Yy3yRdpFrV2B/F0tnxY52Pc2cROv+lK31mI41usYtW0/bsyZyhUIhO037cqwPrcQC0L/zE88E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786716918; c=relaxed/simple;
	bh=Zx87GyLb6+rIvN1lbUzVzdB9q3F5Rl/HTw3hTs1h50c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lXJ5Lj8epgLB2aaKSXMe+2FPbGoJaO712m9ugCwzKuh25Q9Lv5yY+vwhvvGkQ5Uxq0PSYP9SdE/uh0XcVYrcq35JYtBk8v8/C22vMUF7EmfIqHoKb4F1tRuEI/i1uwSnLBrW9jCFZd9Z/LF3Ah1FUrQ6w5ynTBOqylpO9oYg9LY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hQaJTBk3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hQaJTBk3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A19A11F000E9;
	Fri, 14 Aug 2026 14:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786716900;
	bh=WcfWUJNuKnVyvS/DyqnoZlEV8jrsDo5eIGAmz3IinGM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hQaJTBk33xCCdTtT2l/DCjb37phRz1d1puHdVIv5bBlSx8VvsTQZdSCg8CBx/0R5X
	 hBTP49P+5geQZsikPnGWxCz4X4HECmJCKYdnZELKc4PBlgGhdl42yhU4up+1wIlC56
	 H2I+WeSv91AfIwfd77V/wpOr7gNGcPvxBJF61fah5HD55EahjVHqeOEv9DwmEW2yC4
	 0gcaYc50E2/ZJF7mW1uSEpazP434ift1IHNg02NADqnWtH9+c8vUSQWpX0Xh41FMAR
	 H8+LyGTA4GT4k6aq4rL8ajr8DjafT6UiWBp8ECTxdZM6MDEl6RZexXkNk25ICid55T
	 /BVlOO2kwtNyw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-next] selftests: mptcp: print stats before socket
 closure
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWF0dGhpZXUgQmFlcnRzIChOR0kwKQ==?= <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
In-Reply-To: <20260814-sft-mptcp-stats-b4-close-v1-1-2945a591be7e@kernel.org>
References: <20260814-sft-mptcp-stats-b4-close-v1-1-2945a591be7e@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 14:15:00 +0000
Message-Id: <20260814141500.A19A11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Invalid iproute2 command `ip netns id` causes an error message a=
nd incorrect NSTAT_HISTORY file path.
--

--- Patch [1]: [PATCH mptcp-next] selftests: mptcp: print stats before sock=
et closure ---
commit 0e02bc2b403cc7ef4929da44802ea29557081b60
Author: Matthieu Baerts (NGI0) <matttbe@kernel.org>

selftests: mptcp: print stats before socket closure

This commit adds a mechanism to dump socket statistics via ss and nstat
just before socket closure when a poll timeout occurs. This helps debug
timeout issues in the mptcp_connect test.

> diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/te=
sting/selftests/net/mptcp/mptcp_connect.c
> --- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
> +++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
[ ... ]
> @@ -210,6 +210,19 @@ static void xgetaddrinfo(const char *node, const cha=
r *service,
>  	}
>  }
> =20
> +static void print_err_stats(void)
> +{
> +	char cmd[128];
> +
> +	snprintf(cmd, sizeof(cmd), "ss -Menitam -o '%cport =3D :%s' >&2",
> +		 listen_mode ? 's' : 'd', cfg_port);
> +
> +	fprintf(stderr, "socket stats before socket closure:\n");
> +	(void)!system(cmd);
> +	(void)!system("NSTAT_HISTORY=3D'/tmp/$(ip netns id).nstat' nstat -s | "
[Severity: Medium]
Will this ip netns id command fail and cause an iproute2 error during the
test?

It appears ip netns id is an invalid command, and should likely be
ip netns identify.

If it fails, ip netns id will log an error message instead of outputting
the namespace name, which causes the NSTAT_HISTORY environment variable to
fall back to /tmp/.nstat.

Because this fallback file path isn't isolated per namespace, concurrent
test runs might share it, potentially resulting in garbled network
statistics in the debug logs when a timeout occurs.

> +		      "grep Tcp >&2");
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814-sft-mptcp-=
stats-b4-close-v1-1-2945a591be7e@kernel.org?part=3D1
