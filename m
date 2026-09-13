Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A900D2853F3
	for <mptcp@lists.linux.dev>; Sun, 13 Sep 2026 10:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789295586; cv=none; b=YAgJOKTd0xwpthQ7GhUqtG6KAtY6EcfnJvuH0vxSm1Xz9/WuDHvyTYyPAuke3flGat9DF3IqBA7gbnlB7jJluLT635dH+iQHfYh1p3uoq0/o/d1P6ztTxeg3HpWByhxS9IB2kn0hz190L1KZIh761tnAcQdZ1yo9RYa2C7eOF5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789295586; c=relaxed/simple;
	bh=+DI52emjL2DQs26tK8PJWNJTsmAhT9PdzrdcZteU4B8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=f441yxLP1PiBRc/zAPCoIGTJVM6Ynvdy8U7VQbbr9UYPEz3lmBrd0pngq+3ZA6TTgxxXqRTjz7sWm6Wk4NLITi8z1z8NV+lm9ldH5fYhRRTKoRxysLlTducPaL+7eQ4jX4r9TEWu+/hkOn50wXvsg82O7yDdTcgVdToFKihx5Po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oMFPfDzD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oMFPfDzD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 142771F00898;
	Sun, 13 Sep 2026 10:33:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789295585;
	bh=behDU6c93FNcQfGhegzSW0sbd89ZU1vVv1AMdRO2ruA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oMFPfDzDuoMVUzVRdCFTwgg7bSHtqkEMXLU16HmFoYXTdLYPbz0LoDU7Vxv+AB8bR
	 iQjgCRi6FNlAiGRMih+qOuHLw9+hS57gvcZHiDwTiungfVOxEOj8FcbKojMJjDTdpz
	 MZ0s0SU9JDd82pXZKCpF7Hu8a5JbXan51cAIwcIxssO+gZVkGLapy62V+9Xhzwxrw4
	 lrT1iPaA7qOuDscNYhpCyHurWL+zREe/DgaWUi3CKNewr3Kz06PG/mbXFglPpL05Uk
	 g0NvviVQv8uAuWTwDBWzWnww6W8kD/WUxC0OmwaHOybpfAPd2ueMRiHvvsrFBdR8MF
	 NjSG/gbSj4hqA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-next v5 08/16] selftests/bpf: enable MPTCP support
 in sockmap tests
Reply-To: sashiko-reviews@lists.linux.dev
To: "Geliang Tang" <geliang@kernel.org>
Cc: mptcp@lists.linux.dev
In-Reply-To: <d41e0548d50abfaf2cee060e587889748e3a1f14.1789294365.git.tanggeliang@kylinos.cn>
References: <cover.1789294365.git.tanggeliang@kylinos.cn>
 <d41e0548d50abfaf2cee060e587889748e3a1f14.1789294365.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 13 Sep 2026 10:33:04 +0000
Message-Id: <20260913103305.142771F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Missing state validation in `bpf_mptcp_sock_map_update` allows BPF=
 programs to insert sockets in unsafe states into sockmaps.
- [Medium] Test logic error causes spurious pass due to unreset state varia=
ble combined with a race condition.
--

commit d0c081b9b82e0db905c0b2d9dbdca1c86bbc4292
Author: Geliang Tang <geliang@kernel.org>

selftests/bpf: enable MPTCP support in sockmap tests
   =20
Update sockmap tests to reflect new MPTCP support. MPTCP sockets are now
allowed in sockmap, so test expectations are adjusted accordingly.

> diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testi=
ng/selftests/bpf/prog_tests/mptcp.c
> index d77c9f8c53c75..59ea562882a08 100644
> --- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
> +++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
[ ... ]
> @@ -570,20 +570,20 @@ static void test_sockmap_reject_mptcp(struct mptcp_=
sockmap *skel)
>  	if (!ASSERT_OK_FD(client_fd1, "connect_to_fd client_fd1"))
>  		goto end;
> =20
> -	/* bpf_sock_map_update() called from sockops should reject MPTCP sk */
> -	if (!ASSERT_EQ(skel->bss->helper_ret, -EOPNOTSUPP, "should reject"))
> +	/* bpf_mptcp_sock_map_update() called from sockops should be allowed */
> +	if (!ASSERT_EQ(skel->bss->helper_ret, 0, "should be allowed"))

[Severity: Medium]
Will this test spuriously pass due to the state variable not being reset?

test_sockmap_with_mptcp_fallback() executes first, which successfully
triggers bpf_mptcp_sock_map_update() and sets skel->bss->helper_ret =3D 0.

When test_sockmap_with_mptcp() executes, it doesn't reset helper_ret.
After connect_to_fd() initiates a connection, the server's BPF program
might not execute until the server processes the final ACK, creating a race.
Because the expected value is now 0, the immediate check of helper_ret will
match the stale value from the previous test, guaranteeing a pass even if
the BPF program hasn't run yet.

Could we reset skel->bss->helper_ret before the connect_to_fd() call?


While reviewing this test, I noticed an issue in the underlying helper being
tested, introduced in commit d25c16225b28 ("mptcp: add sock_map_update BPF =
helper"):

> diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
> index 662b80ce2cf63..7ecafbf51fa05 100644
> --- a/net/mptcp/bpf.c
> +++ b/net/mptcp/bpf.c
[ ... ]
> +BPF_CALL_4(mptcp_sock_map_update, struct bpf_sock_ops_kern *, sops,
> +	   struct bpf_map *, map, void *, key, u64, flags)
> +{
[ ... ]
> +	return sock_map_update_common(map, *(u32 *)key, sk, flags);

[Severity: High]
Does this code allow inserting sockets in unsafe states into sockmaps?

The standard bpf_sock_map_update helper explicitly validates the socket's
state via sock_map_op_okay() and sock_map_sk_is_suitable() before inserting
it.

By calling sock_map_update_common() directly without these checks, a BPF
program could insert closing or uninitialized sockets into the map, which
bypasses the invariants established by the sockmap subsystem. This could
lead to use-after-free or resource leaks.

Should this function validate the socket state before insertion?

> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789294365.gi=
t.tanggeliang@kylinos.cn?part=3D8
