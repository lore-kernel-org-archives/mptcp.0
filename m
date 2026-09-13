Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5BFE38F253
	for <mptcp@lists.linux.dev>; Sun, 13 Sep 2026 10:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789296324; cv=none; b=fVhyl26a8U8gm0JRi00FwGWT1FkHxZZceZtNpMlQjScjLjIwxCI2V0YlIfHtH/4GpUSmqFwVVdzx7xkHZpwbhqu7uXEa/hdeN+Zy8FMWTi1pLi/4kElXOK/fAp/vfXKMQ0ICD0b5r5CKlxWNGppMNU1+pzdpX43pVUrcwwy5K6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789296324; c=relaxed/simple;
	bh=tniEt4COmC3RGwc105lhONwbbJVXaOqak172xI07J10=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BTOh7Nigq+VC7acNc08URMRTfuCpM/yCVlvu1ZZCoOuL0geCdpAie5YVv6ackk+MXKqv3jZO8kO6do7MIUg6488JzKlv9jdQwoqaPTqGzQDSxhIu+ITeFJjkJ09ZQBv8My51gheorKzxOo+WhMHcu0ELPaXNwrG9EkaWfiLVQ8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M94TqPec; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M94TqPec"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D6941F000FF;
	Sun, 13 Sep 2026 10:45:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789296320;
	bh=DxBxoK7T+isbtr19HP4TciS7nBxDYr2yIBMqAkNhUZ4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=M94TqPecgDgd+TZVMz/UXu8aIFlyKnyUz/0bEUFq4OWm449pwcmYFzuayeamD+Wg2
	 75AY4S3fBzIHFzXiJx++Cos2lPRZHrlBxCFsy1j1dLMxKgn2fcnJ6zFc2NZYaIRVOe
	 CJXQuT1BqD73aaPYfLj8A1JgjVWnC3HvuiYmdZo0kmO3TJ2QE13OxXTNUff3hI81dH
	 6VvQSkuJ7QZbMxm5MA/w7XJl44lIHUCgQKfPRot8EGheTgm2g/z9rf2t2316Y5qABW
	 RBfYnOV+xkPDZjcVXuYASo5atc5LZvz7CvCYs6rlJboB7Ta/nZlbNMkLcrmbDPI8aT
	 0n8IM6TvH0Hog==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-next v5 16/16] selftests/bpf: add MPTCP coverage
 to sockmap_listen
Reply-To: sashiko-reviews@lists.linux.dev
To: "Geliang Tang" <geliang@kernel.org>
Cc: mptcp@lists.linux.dev
In-Reply-To: <3857608bd79abf9079a7bebd3d589194bb6433ff.1789294365.git.tanggeliang@kylinos.cn>
References: <cover.1789294365.git.tanggeliang@kylinos.cn>
 <3857608bd79abf9079a7bebd3d589194bb6433ff.1789294365.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 13 Sep 2026 10:45:20 +0000
Message-Id: <20260913104520.9D6941F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [Medium] Unconditional loading of MPTCP BPF program breaks the entire tes=
t suite on kernels without CONFIG_MPTCP.
- [Medium] MPTCP redirect tests silently test standard TCP instead due to h=
ardcoded protocol in create_socket_pairs().
- [Medium] The test suite unconditionally executes MPTCP socket tests and w=
ill report them as failures if the kernel does not support MPTCP.
- [Low] The SOTYPE_PROTO macro uses a bitwise AND on the SOCK_STREAM enum v=
alue.
--

commit 94803c56b754dd47ba0a9cd2f2a41576b9144b10
Author: Geliang Tang <geliang@kernel.org>

selftests/bpf: add MPTCP coverage to sockmap_listen

Extend sockmap_listen tests to cover MPTCP sockets. Run the full test
suite (ops, redir, reuseport) in both TCP and MPTCP modes, using
IPPROTO_MPTCP for stream sockets when in MPTCP mode. Skip UDP-specific
tests in MPTCP mode. Add a dedicated BPF reuseport program
(prog_reuseport_mptcp) that uses bpf_mptcp_sk_select_reuseport() for
MPTCP-aware reuseport selection. Prefix subtest names with the protocol
(tcp/mptcp) for clarity.

> diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c b/to=
ols/testing/selftests/bpf/prog_tests/sockmap_listen.c
> index 1c96a3cf4b979..d31f3eb661d65 100644
> --- a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
> +++ b/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
> @@ -31,6 +31,10 @@
> =20
>  #define NO_FLAGS 0
> =20
> +static bool mptcp;
> +#define SOTYPE_PROTO(st) \
> +	(mptcp && ((st) & SOCK_STREAM) ? IPPROTO_MPTCP : 0)

[Severity: Low]
Does this bitwise AND on the socket type work correctly for all socket type=
s?

Since SOCK_STREAM is defined as 1, ((st) & SOCK_STREAM) coincidentally
evaluates to true for SOCK_STREAM (1) and false for SOCK_DGRAM (2). However,
it evaluates to true for other odd-numbered socket types like SOCK_RAW (3) =
or
SOCK_SEQPACKET (5).

Could this be rewritten as ((st) =3D=3D SOCK_STREAM)?

[ ... ]

> @@ -1359,7 +1375,8 @@ static void test_redir(struct test_sockmap_listen *=
skel, struct bpf_map *map,
>  	map_name =3D map_type_str(map);
> =20
>  	for (t =3D tests; t < tests + ARRAY_SIZE(tests); t++) {
> -		snprintf(s, sizeof(s), "%s %s %s", map_name, family_name,
> +		snprintf(s, sizeof(s), "%s %s %s %s",
> +			 mptcp ? "mptcp" : "tcp", map_name, family_name,
>  			 t->name);

[Severity: Medium]
Are the MPTCP redirect tests silently testing standard TCP instead?

The test_redir() function loops through tests like redir_to_connected() whi=
ch
use create_socket_pairs() to establish connections.

However, create_socket_pairs() (defined in socket_helpers.h) hardcodes
proto =3D 0, which resolves to IPPROTO_TCP for SOCK_STREAM. It completely i=
gnores
the SOTYPE_PROTO macro logic intended to create IPPROTO_MPTCP sockets.

[ ... ]

> @@ -1429,13 +1455,17 @@ void serial_test_sockmap_listen(void)
>  		return;
>  	}
> =20
> -	skel->bss->test_sockmap =3D true;
> -	run_tests(skel, skel->maps.sock_map, AF_INET);
> -	run_tests(skel, skel->maps.sock_map, AF_INET6);
> +	for (int i =3D 0; i < 2; i++) {
> +		mptcp =3D i;
> =20
> -	skel->bss->test_sockmap =3D false;
> -	run_tests(skel, skel->maps.sock_hash, AF_INET);
> -	run_tests(skel, skel->maps.sock_hash, AF_INET6);
> +		skel->bss->test_sockmap =3D true;
> +		run_tests(skel, skel->maps.sock_map, AF_INET);
> +		run_tests(skel, skel->maps.sock_map, AF_INET6);

[Severity: Medium]
Will this unconditionally execute MPTCP socket tests and report them as fai=
lures
if the kernel lacks MPTCP support?

When mptcp is set to 1, functions like socket_loopback_proto() call xsocket=
(),
which invokes FAIL_ERRNO("socket") if the socket creation fails (e.g., retu=
rning
-1 with EPROTONOSUPPORT).

Should the test check for MPTCP support first and gracefully skip the MPTCP
iterations?

[ ... ]

> diff --git a/tools/testing/selftests/bpf/progs/test_sockmap_listen.c b/to=
ols/testing/selftests/bpf/progs/test_sockmap_listen.c
> index b7250eb9c30cc..46e9929ba7c4d 100644
> --- a/tools/testing/selftests/bpf/progs/test_sockmap_listen.c
> +++ b/tools/testing/selftests/bpf/progs/test_sockmap_listen.c
> @@ -137,4 +140,26 @@ int prog_reuseport(struct sk_reuseport_md *reuse)
>  	return verdict;
>  }
> =20
> +SEC("sk_reuseport")
> +int prog_reuseport_mptcp(struct sk_reuseport_md *reuse)
> +{
> +	unsigned int *count;
> +	int err, verdict;
> +	__u32 zero =3D 0;
> +
> +	if (test_sockmap)
> +		err =3D bpf_mptcp_sk_select_reuseport(reuse, &sock_map,
> +						    &zero, 0);

[Severity: Medium]
Will this break the entire test suite on kernels without CONFIG_MPTCP?

The bpf_mptcp_sk_select_reuseport helper is unknown to the verifier when
CONFIG_MPTCP is disabled.

Since test_sockmap_listen__open_and_load() unconditionally loads all progra=
ms
in the skeleton, this will cause the load to fail and skip all standard TCP
and UDP tests.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789294365.gi=
t.tanggeliang@kylinos.cn?part=3D16
