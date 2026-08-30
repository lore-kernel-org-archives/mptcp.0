Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F52F306B3D
	for <mptcp@lists.linux.dev>; Sun, 30 Aug 2026 20:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788121514; cv=none; b=DcsKSD0nB3xmF7yI4J6Lmrfd/xnEYTkcp/8ig+F+haOAFt36ts4BI6o2YTVI2/5WAKSqcUS0uKt1jk7aiWpohzNFgSFrffuFyk4fY9mi1gZSkQmN0kgEg4oPk5CaLnBCGBifKzCHQcZJmYGpW0yXiME9+L0x070u/KLaCHL1wt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788121514; c=relaxed/simple;
	bh=YWdTJZ+/GmEHLqx1leh7BN4fuFLHkldOY45Ag3CEhCI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XaI7flnFf5JTviaBB5VogUT1igjsGgtwrFkLj62yCu6N73s23QXdfgZy0Q27g09fq4r3o9UxnKKAI6UJErAFd8NDC4i82hyoF0tRRi99rmciJI/SWPrBsGqm2uziqwMF69fE2vuuvZ0O8g8GamrtlHtRA+O1paMAGHMiPHgAkxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NEn8ywdl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NEn8ywdl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29C1F1F000E9;
	Sun, 30 Aug 2026 20:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788121513;
	bh=yLniD6im/zibxEqGEQ0+ZA1u/5sLjr4OGWVZYuGUUmU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NEn8ywdlYW/f+dONhJgbcuCeqk/e5FYgWo86usZNo3UImzTcGlRsiU28VUXbPFgro
	 OSDsDsp+E3ueckRTzXXpnQW2CYnSFvrjY9X+vHtF4GvICwb8+Hx283nOmUJN90dul8
	 lMajKIKfhek5Yh0JsZ81y2rAFsUuIdIPh65Wh+rBbhV/XoK3b7IWwtzm85r+L/ocvW
	 yOKxRNje5HKeOureQHsM2hj/J936e2vVJobA018lsABJiphxaHMUnfgJa8EMPx2jMh
	 6suoWOXd74Va5wy0X4b67aHwV1v32m7lQFP1p5fcHwke3mTWtmfztSifUxC7Gqmj9E
	 YNiy1dX2/Gj0g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/6] samples/landlock: Implement best-effort fallback
 for network rules.
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?R8O8bnRoZXIgTm9hY2s=?= <gnoack3000@gmail.com>
Cc: mptcp@lists.linux.dev
In-Reply-To: <20260830201650.67050-2-gnoack3000@gmail.com>
References: <20260830201650.67050-1-gnoack3000@gmail.com>
 <20260830201650.67050-2-gnoack3000@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 30 Aug 2026 20:25:12 +0000
Message-Id: <20260830202513.29C1F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The best-effort fallback logic introduces an early return that b=
ypasses `unsetenv()`, leaking sandbox configuration environment variables t=
o the child process.
--

commit 9984581b44a9424255f8b9ce2c25354f65e0816c
Author: G=C3=BCnther Noack <gnoack3000@gmail.com>

samples/landlock: Implement best-effort fallback for network rules.

This commit adds a best-effort fallback for network rules in the sandboxer
sample tool. If the Landlock ABI version does not support a requested netwo=
rk
feature, the operation is treated as a no-op instead of causing an error.

> diff --git a/samples/landlock/sandboxer.c b/samples/landlock/sandboxer.c
> index 030583273f3f7..1c514efecafbf 100644
> --- a/samples/landlock/sandboxer.c
> +++ b/samples/landlock/sandboxer.c
> @@ -198,6 +198,10 @@ static int populate_ruleset_net(const char *const en=
v_var, const int ruleset_fd,
>  		.allowed_access =3D allowed_access,
>  	};
> =20
> +	/* A rule without access rights and flags is a no-op. */
> +	if (!allowed_access && !flags)
> +		return 0;
> +

[Severity: Medium]
Does this early return bypass the cleanup of the environment variable?

Looking at populate_ruleset_net(), if the tool runs on an older kernel where
a network feature is not supported, the feature is masked out and
allowed_access becomes 0. Taking this early return avoids the unsetenv(env_=
var)
call further down in the function:

static int populate_ruleset_net(...)
{
    ...
    if (!allowed_access && !flags)
        return 0;

    env_port_name =3D getenv(env_var);
    if (!env_port_name)
        return 0;
    env_port_name =3D strdup(env_port_name);
    unsetenv(env_var);
    ...
}

Will this inadvertently leak the sandbox configuration environment variables
(like LL_TCP_BIND) to the sandboxed child process?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260830201650.6705=
0-1-gnoack3000@gmail.com?part=3D1
