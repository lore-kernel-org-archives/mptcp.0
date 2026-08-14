Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB4D489864
	for <mptcp@lists.linux.dev>; Fri, 14 Aug 2026 18:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786733064; cv=none; b=R4flixPw4z8KUIURc6oGapYl1/tadA7f3waJ5dvXQclR3lw3v5xJoPiYHkYxrN15WDnUqsNP3z5MCmkNgpjF9/0N2poRbk5Xzf0vOSsehCPZoNsBMLXb0KURHOgCCdPHsey7VMtVC/vo6/VR/PZyJGukwmc+mZVQSb/xKwm9Yuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786733064; c=relaxed/simple;
	bh=IKUA1PaPEAVM/DxLKxNUuwNdd1OeE+RAU6AyuoKKvXQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SygkOF0yTZ+0QVep6mnP3WzcpjQJdMK5+Vo/8wxUbBq++TcKJzZgNI5nkmmJhkpfAi4+nU+Hcmu+Wze0auMcC0T7rjYZtxNZMqQ8GC83Ngjb7htNYznYX5Dg3T42XutiDI6UpSivN06OTkEal9zM63uEFL1wkaTMVGG5cHWJoko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WjFyswQE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WjFyswQE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DCDF1F000E9;
	Fri, 14 Aug 2026 18:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786733063;
	bh=IL7CRovME47Kszh/LIVxoOD+QZt5+GuRud57i51gafo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WjFyswQE9jOE7/VjYI+RgxDfSDIJP4HVpfhUoe9Y5elnu31nGc6i2xbDtFbaPc8+3
	 kIZnBfMUEcyZ+O7uTTwk3JgtTK8Di4l26SKPPYZr62Y5yTmmav97aSv3hFJRV+PA6I
	 mnmacmK2tNxkQgIax8OeZeLWk8TMla041G1T8RyGh9qbCxzqGQypB/N+lhm1viN/Ss
	 ataSpaWnlve6VS50Y2Wz/Makfw7udERrxt4Ea//kmVFNytWA6gQiDOz+BG/aYhpbwb
	 6LdH12h2hdOS1qwagdZs8BP2S1iAvnq3xvFoA84zIP1oMBUS65Ob8uT2HGxanU6a7e
	 pHpc9CrOYT5cA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-next v2] selftests: mptcp: print stats before
 socket closure
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWF0dGhpZXUgQmFlcnRzIChOR0kwKQ==?= <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
In-Reply-To: <20260814-sft-mptcp-stats-b4-close-v2-1-b7a8ab3ddae8@kernel.org>
References: <20260814-sft-mptcp-stats-b4-close-v2-1-b7a8ab3ddae8@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 18:44:22 +0000
Message-Id: <20260814184423.3DCDF1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Shell command substitution inside single quotes prevents evaluat=
ion in system() call
--

--- Patch [1]: [PATCH mptcp-next v2] selftests: mptcp: print stats before s=
ocket closure ---
commit 3f1a40cd885883e270f0fd3544c47bf2dc166581
Author: Matthieu Baerts (NGI0) <matttbe@kernel.org>

selftests: mptcp: print stats before socket closure

In case of a poll timeout, this commit invokes 'ss' and 'nstat' via
system() to print debug stats before exiting mptcp_connect.

Link: https://patch.msgid.link/20260814-sft-mptcp-stats-b4-close-v1-1-2945a=
591be7e@kernel.org

> diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/te=
sting/selftests/net/mptcp/mptcp_connect.c
> index ea4cb6c1bd5e2..e906abcd54096 100644
> --- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
> +++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
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
> +	(void)!system("NSTAT_HISTORY=3D'/tmp/$(ip netns identify).nstat' "
> +		      "nstat -s '*Tcp*' >&2");

[Severity: Medium]
Will this shell command substitution be evaluated properly?

Because the path is enclosed in single quotes, it appears NSTAT_HISTORY
will be set to the literal string '/tmp/$(ip netns identify).nstat' instead
of being evaluated by the shell.

If the shell does not evaluate the command substitution, could this cause
nstat to look for a non-existent history file and print absolute stats
instead of the expected differential stats?

> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814-sft-mptcp-=
stats-b4-close-v2-1-b7a8ab3ddae8@kernel.org?part=3D1
