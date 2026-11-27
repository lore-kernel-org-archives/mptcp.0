Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795755026;
	b=0FGubwovbB0qVrA5dt7brqIzugabIOQp2ROZfAQFhIPUeN8+QB4n1Rr51A3S88Bz46PF
	 qgP3uS6MxRxKx1sLUn2jDlgo2U2Nopj/s0Ot1yPIKOsZIYYA18se4lgAxWI+wrvOxPeTq
	 GfBNCXoPQtYrsuBxDi31GmHQzR/OnXAcBP9da18E9dykH5zg8ThtZ8GCYdR8NIwcXzHTT
	 WL7yVQWd8UZXBgCkVRVjtueYTivkXvxFsHt84ihoO3ETQE1tE2eNuD4vcLvLLbS83EvCY
	 /Y/zWd4+ed8RljPDubNVJ2h9yKcSeRq/tBgBvub21lJbgex6jPuiRB63bScRaNuD0SA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795755026;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=LehYK4qM3IA+qBTVKksihvaQOeKSsRTjLpQrzFNtE9w=;
	b=hWnje77+KAjwkO/utDuyfm+H2sS6TrATIuBTH3WsaBlMLoCtXZDAPeD1hM93NWHoxq6H
	 qr3+x0rd19KUhqt+7Ui8TqIX4Ib75YgQlCFtXv+L1A448t3LElYMA8AuqwRfyDtBoeQii
	 0WFmC6J9B49a8mNzGtXDcERpBCRLt0Q6KKV3sy19+aMx83tGRuryPSB3AbYd1Bhsgz3wG
	 g+fHcreldSTKvCh1BXZKM4+vpQtoKHJHbA9fbW0tzn1n+lyVJ2FXjyvWgnBfulJ8T6YvB
	 xJB6Cv913Abi6Up61rqbdxjjslyjE41Wh/3HZhe8lXe/mcLwFuO2ND0iDweCwfixE+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=APDZRbCz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 219DE606A31C
	for <mptcp@lists.linux.dev>; Fri, 27 Nov 2026 04:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=APDZRbCz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F3B51F00899;
	Fri, 27 Nov 2026 04:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795755025;
	bh=LehYK4qM3IA+qBTVKksihvaQOeKSsRTjLpQrzFNtE9w=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=APDZRbCzt8F2FCZA5v59VU06Ln6vuHL7DVCeDWKc5jd7w0cFhElwVfbp5fueqYcBt
	 GQQnulY7nlDQnTaOxPgp047qcbQKDpwgWiR+tFBI+iD99/6drQZRcRvOUrPHCObRll
	 24zmVOrfiI13g8qVGXohXrk+AEFJYX/CrTY0bD9HHmvtzHubSDEDLsYGWIX4GrCIvJ
	 AY7Oh0alfDCNXSmafWEA7rcxorRz17WCVsVya2rJs9cTE/AJZZCueIDCF0p0NokbWg
	 y/0wAF1h+XYPEc+5h9taAu8LACyK+zQxcPdHWVXpw3PurlkQEnZRBaNsMv0RGwonU8
	 /e+TbEEDeQw5Q==
Message-ID: <sashiko-outbox-236620@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-next v10 7/7] selftests: mptcp: cover msg_zerocopy
 test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Geliang Tang" <geliang@kernel.org>, mptcp@lists.linux.dev
In-Reply-To: <00df42f4717147821e9d1d9481389aa3f7c9a842.1795753727.git.tanggeliang@kylinos.cn>
References: <cover.1795753727.git.tanggeliang@kylinos.cn>
 <00df42f4717147821e9d1d9481389aa3f7c9a842.1795753727.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 27 Nov 2026 04:50:25 +0000
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential
issues to consider:
- [Medium] selftests: mptcp: missing ../msg_zerocopy.sh in Makefile
  TEST_INCLUDES
- [Medium] selftests: mptcp: msg_zerocopy.sh returns KSFT_PASS when
  MPTCP is skipped
- [Low] selftests: mptcp: commit message claims symlink and omits
  CONFIG_DUMMY=3Dy
--

commit 3cb1f313dd3fac2f574cee09c7b454ff59f42063
Author: Geliang Tang <geliang@kernel.org>

selftests: mptcp: cover msg_zerocopy test

This commit adds a wrapper script and build rules to run the net
msg_zerocopy selftest as part of the MPTCP selftest suite.

> Add the msg_zerocopy test to the MPTCP selftest suite by creating a
> symlink to the existing msg_zerocopy.sh script in the net selftests
> directory.
>=20
> Update the Makefile to add msg_zerocopy.sh to TEST_PROGS, add
> msg_zerocopy binary to TEST_GEN_FILES, and add build rule to compile
> msg_zerocopy from ../msg_zerocopy.c. Also add msg_zerocopy binary
> to .gitignore.

[Severity: Low]
This isn't a bug, but the commit message says msg_zerocopy.sh is created
as a symlink whereas the patch adds a wrapper script, and it does not
mention adding CONFIG_DUMMY=3Dy to tools/testing/selftests/net/mptcp/config.

> diff --git a/tools/testing/selftests/net/mptcp/Makefile b/tools/testing/s=
elftests/net/mptcp/Makefile
> index 22ba0da2adb85..ec243e400f4b4 100644
> --- a/tools/testing/selftests/net/mptcp/Makefile
> +++ b/tools/testing/selftests/net/mptcp/Makefile
[ ... ]
> @@ -37,3 +39,6 @@ TEST_INCLUDES :=3D ../lib.sh $(wildcard ../lib/sh/*.sh)
>  EXTRA_CLEAN :=3D *.pcap
> =20
>  include ../../lib.mk
> +
> +$(OUTPUT)/msg_zerocopy: ../msg_zerocopy.c
> +	$(LINK.c) $^ $(LDLIBS) -o $@

[Severity: Medium]
Should TEST_INCLUDES also list ../msg_zerocopy.sh?

When running or installing the net/mptcp target out-of-tree or standalone
(for example with TARGETS=3Dnet/mptcp), lib.mk only copies parent-directory
files listed in TEST_INCLUDES, so msg_zerocopy.sh will fail to exec
../msg_zerocopy.sh with "No such file or directory".

> diff --git a/tools/testing/selftests/net/mptcp/msg_zerocopy.sh b/tools/te=
sting/selftests/net/mptcp/msg_zerocopy.sh
> new file mode 100755
> index 0000000000000..118fff27dc5cd
> --- /dev/null
> +++ b/tools/testing/selftests/net/mptcp/msg_zerocopy.sh
> @@ -0,0 +1,8 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +
> +. "$(dirname "${0}")/mptcp_lib.sh"
> +
> +mptcp_lib_check_mptcp
> +
> +exec "$(dirname "${0}")/../msg_zerocopy.sh" "$@"

[Severity: Medium]
Does this exit with 0 (KSFT_PASS) instead of KSFT_SKIP when MPTCP
zerocopy is not supported or when net.mptcp.enabled=3D0 in the initial
network namespace?

mptcp_lib_check_mptcp only checks that /proc/sys/net/mptcp/enabled exists,
while ../msg_zerocopy.sh runs TCP and UDP tests first and then checks
MPTCP socket and SO_ZEROCOPY support in the initial namespace:

tools/testing/selftests/net/msg_zerocopy.sh:
	if ${BIN} -4 -t 1 check && ${BIN} -4 -t 1 check -z; then
		$0 4 mptcp -t 1 || ret=3D1
		$0 6 mptcp -t 1 || ret=3D1
	else
		echo "SKIP: MPTCP tests (not supported)"
	fi

	[[ "$ret" =3D=3D "0" ]] && echo "OK. All tests passed"
	exit $ret

If that check fails, ../msg_zerocopy.sh skips the MPTCP subtests and exits
with $ret (0 if TCP and UDP passed), reporting a pass for the MPTCP test
without running any MPTCP test cases or honoring
SELFTESTS_MPTCP_LIB_EXPECT_ALL_FEATURES=3D1.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1795753727.gi=
t.tanggeliang@kylinos.cn?part=3D7
