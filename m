Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5E43515C7
	for <mptcp@lists.linux.dev>; Sun, 13 Sep 2026 10:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789295429; cv=none; b=KGo5Zyxx+gjbcFgMw2E4UWio6p98wC2L4i30xv1j3CcmOICL/Gr4CLKPDB07C9VBoXm88mBPXCuVk8vrVTUg/t8gebdfDWPbaM1ZLHjs3/C9WoTMV03JBk9AJUCsEZevcDlY6cheJB2OEjdAKU+fXmKeCXY1Qmrcw9Z6UlZQaxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789295429; c=relaxed/simple;
	bh=QbqB7CvVZ3LbmyNLvaD+pfRMT7uWQCilqmTAhG2Od0Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uzUFW1JRS2gtnom7qZlZNmL+a7J3Za7PwW7pqXsi8YWq9b84RW+pS6w8l6n0ZPvNGcIswsvIK42RZi2n805L2/qyKzTE94MaP5ShcwusetJzaOAUMrldTz32KaKUYeu5QxHRgZ4lk58J3RadHyk8jdzoQSjeHu6mgVddBctolPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N6xVcgvL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N6xVcgvL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1B431F000FF;
	Sun, 13 Sep 2026 10:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789295425;
	bh=fd8ofefA+W2IQww5l6hnNFNFF4ZHL0zdBTfofa5dBKs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=N6xVcgvLqpGHJzhC65szcyf9Sf+YIYYmryhbH7spsqf6/ppjr00UoPQsQ5txr4uvu
	 mxRWbolxaqyW7Edq2IwvWWFfXDcBtOgUbsLxt/HeH1YDbco5hhHsFcNcw7ToKMErof
	 u65GWrKKaf8HDBAgU13wFnq0dveLjDS8wRNKxt+HLLkP1C+PCfmXJyaE/p8Ql4l+sP
	 tOtnIREV9lgWoYBlP6EblZQxVr3T8ocKLPWjWWvMvb9fA7YTmUMBzx09mRXAp5/R6o
	 KqcI5vD+9Z/eaeZysTAYrUYTJZmGURnd8KmgvqJzZ/PipdIGu/FE3fMtML2clj6cRB
	 5iGVldKWeeLmg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-next v5 12/16] selftests/bpf: add MPTCP coverage
 to sockmap_basic
Reply-To: sashiko-reviews@lists.linux.dev
To: "Geliang Tang" <geliang@kernel.org>
Cc: mptcp@lists.linux.dev
In-Reply-To: <7aa10507517cb94460de386bd4bb81108d61aba2.1789294365.git.tanggeliang@kylinos.cn>
References: <cover.1789294365.git.tanggeliang@kylinos.cn>
 <7aa10507517cb94460de386bd4bb81108d61aba2.1789294365.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 13 Sep 2026 10:30:24 +0000
Message-Id: <20260913103024.D1B431F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Tests using `create_socket_pairs()` silently fall back to testin=
g TCP instead of MPTCP, resulting in incomplete coverage.
- [Medium] Duplicate subtest names for TCP and MPTCP runs make test results=
 indistinguishable in CI logs.
--

commit afd6e61e2a0ed4da071e04fed27c852f1128b3f9
Author: Geliang Tang <geliang@kernel.org>

    selftests/bpf: add MPTCP coverage to sockmap_basic
   =20
    This patch extends socket_helpers.h with protocol-aware variants
    (socket_loopback_proto, create_pair_proto) that accept an explicit prot=
ocol
    parameter. Run the sockmap_basic test suite in both TCP and MPTCP modes=
 by
    looping over run_basic_tests() with a mptcp flag. Skip UDP-specific tes=
ts
    in MPTCP mode since UDP is unaffected by MPTCP.

> diff --git a/tools/testing/selftests/bpf/prog_tests/socket_helpers.h b/to=
ols/testing/selftests/bpf/prog_tests/socket_helpers.h
> index 0d59503a0c73e..d9bd6b11e2cca 100644
> --- a/tools/testing/selftests/bpf/prog_tests/socket_helpers.h
> +++ b/tools/testing/selftests/bpf/prog_tests/socket_helpers.h
[ ... ]
> @@ -397,6 +405,9 @@ static inline int create_pair(int family, int sotype,=
 int *p0, int *p1)
>  	return 0;
>  }
> =20
> +#define create_pair(family, sotype, p0, p1) \
> +	create_pair_proto(family, sotype, 0, p0, p1)
> +
>  static inline int create_socket_pairs(int family, int sotype, int *c0, i=
nt *c1,
>  				      int *p0, int *p1)
>  {

[Severity: Medium]
Since create_socket_pairs() internally uses the create_pair() macro which n=
ow
hardcodes protocol 0 (TCP), do tests calling create_socket_pairs() silently
fall back to TCP when they are supposed to be testing MPTCP?

For example, do_test_sockmap_skb_verdict_fionread() in sockmap_basic.c:

	err =3D create_socket_pairs(AF_INET, sotype, &c0, &c1, &p0, &p1);
	if (!ASSERT_OK(err, "create_socket_pairs()"))
		goto out;

Should create_socket_pairs() be updated to accept a proto argument or shoul=
d a
create_socket_pairs_proto() variant be used instead?

> diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c b/too=
ls/testing/selftests/bpf/prog_tests/sockmap_basic.c
> index 1fef6ec2ba7ae..80919a5fef493 100644
> --- a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
> +++ b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
[ ... ]
> @@ -1436,6 +1444,15 @@ void test_sockmap_basic(void)
>  		test_sockmap_copied_seq(true);
>  	if (test__start_subtest("sockmap tcp multi channels"))
>  		test_sockmap_multi_channels(SOCK_STREAM);
> -	if (test__start_subtest("sockmap udp multi channels"))
> +	/* UDP is unaffected by MPTCP, only run it once (in tcp mode) */
> +	if (!mptcp && test__start_subtest("sockmap udp multi channels"))
>  		test_sockmap_multi_channels(SOCK_DGRAM);
>  }
> +
> +void test_sockmap_basic(void)
> +{
> +	for (int i =3D 0; i < 2; i++) {
> +		mptcp =3D i;
> +		run_basic_tests();
> +	}
> +}

[Severity: Medium]
Does this loop register identical subtest names for both TCP and MPTCP test=
 runs?

Because run_basic_tests() uses static string literals in test__start_subtes=
t(),
the subtests for TCP and MPTCP might be indistinguishable in the CI output.

Could a protocol suffix be added to the subtest names when mptcp is true?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789294365.gi=
t.tanggeliang@kylinos.cn?part=3D12
