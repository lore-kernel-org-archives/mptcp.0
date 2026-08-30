Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76894325485
	for <mptcp@lists.linux.dev>; Sun, 30 Aug 2026 20:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788121679; cv=none; b=QhyWgH+MaPT/2rNTWv3xsIQvrZ4Fp9tMXjfUCapx+PllSSGA0UPdqY5wHep+cxThdhyXVNN1+BERgqSWhYh0480AZTihtfJYT7Y18+qs69BMk/SVlYRQA/uuFifKhWe9MPN7FAhCJeGQOC0IKBLxd+xZ2AqLSbkSofmG82ZpvbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788121679; c=relaxed/simple;
	bh=ITIIUvjUE84VYp+qK5sLKXpkjXrh4PRpBcU5pBduKLA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WdOtTLpOplL+UoSdypH38HKb3/rbFFpTp5Etq7IRFD3X8dcYyPH7jlHg8Q+aEc3hYqH7gNvzwpT6Sdn1PR8ymMxfvcBgV2CpDnl2drq/KQiSawO174Vwhs2mb6yVicGJagChdpizUgSlBxVrPjbe4GXV0IrPFpRAsT0qQ6me/P8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HsN8c0ZF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HsN8c0ZF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EA5E1F000E9;
	Sun, 30 Aug 2026 20:27:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788121674;
	bh=FWOk9sBKoKEkmpKgBaR14QR5QgCsgINYCwetZhFQv2M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HsN8c0ZFTyOffxXjJSpgnSNC9iguYs66ipgfyVrGZ7RAUcv1VAfx9u/N5Rew1a+Vq
	 bHf9YmwVS7Ip5JS2RIqWjFFuto4af4YNR0vlTe2pELbzEgLkJjGL7ZTXWr8hUGDVCT
	 0cEidiml6yrq/JBjXiFTmzP7/nZbcjusOwr83c5KlTVUPlHnfsD8YHpTKhbcS7BeOU
	 Z82K5g0nE6jDKzHyvcipCwXdz1bR51AVhsZaHCfLOzy1r8LhIKzIlSO6g4gkCKf2p/
	 7bXsU/9pFEATgJEWUgWdt3tARaKjV+STocKnmLVB4c1hP2NmqK/fWtYkG7PZcfLCwm
	 1B5MZ1/5HyQAA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/6] selftests/landlock: Add MPTCP network access tests
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?R8O8bnRoZXIgTm9hY2s=?= <gnoack3000@gmail.com>
Cc: mptcp@lists.linux.dev
In-Reply-To: <20260830201650.67050-5-gnoack3000@gmail.com>
References: <20260830201650.67050-1-gnoack3000@gmail.com>
 <20260830201650.67050-5-gnoack3000@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 30 Aug 2026 20:27:53 +0000
Message-Id: <20260830202754.6EA5E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] MPTCP test coverage was omitted from `port_specific` and `ipv4` =
test fixtures, and their test logic hardcodes `TCP_SANDBOX` and `UDP_SANDBO=
X`, ignoring `MPTCP_SANDBOX`.
--

commit 9e9cead822873e8f3cd15dd893c6f35928465c42
Author: G=C3=BCnther Noack <gnoack3000@gmail.com>

    selftests/landlock: Add MPTCP network access tests

    Test LANDLOCK_ACCESS_NET_BIND_MPTCP and LANDLOCK_ACCESS_NET_CONNECT_MPT=
CP:
   =20
    * Add the MPTCP_SANDBOX variant to the net_test fixtures.
    * Introduce prot_*() helper functions for audit tests.
    * Extend existing tests as needed for MPTCP, including the tcp_fastopen=
 test.

> diff --git a/tools/testing/selftests/landlock/net_test.c b/tools/testing/=
selftests/landlock/net_test.c
> index 3a0482beca5f4..fbb3a99bc3801 100644
> --- a/tools/testing/selftests/landlock/net_test.c
> +++ b/tools/testing/selftests/landlock/net_test.c
> @@ -40,6 +40,7 @@ enum sandbox_type {
>  	/* This may be used to test rules that allow *and* deny accesses. */
>  	TCP_SANDBOX,
>  	UDP_SANDBOX,
> +	MPTCP_SANDBOX,
>  };

[Severity: Medium]
When adding MPTCP_SANDBOX, should this patch also update the ipv4 and
port_specific fixtures to include MPTCP variants and handle MPTCP_SANDBOX in
their test logic?

Currently, MPTCP test coverage appears to be omitted from the port_specific
and ipv4 test fixtures. This means there is missing test coverage for MPTCP
port-specific rules, specifically for LANDLOCK_RULE_NET_PORT rules enforcing
boundary port constraints like zero port translation.

Additionally, their test logic hardcodes TCP_SANDBOX and UDP_SANDBOX:

tools/testing/selftests/landlock/net_test.c:
TEST_F(ipv4, from_unix_to_inet) {
    ...
	if (variant->sandbox =3D=3D TCP_SANDBOX ||
	    variant->sandbox =3D=3D UDP_SANDBOX) {
    ...
}

tools/testing/selftests/landlock/net_test.c:
TEST_F(port_specific, bind_connect_zero) {
    ...
	if (variant->sandbox =3D=3D TCP_SANDBOX ||
	    variant->sandbox =3D=3D UDP_SANDBOX) {
    ...
}

tools/testing/selftests/landlock/net_test.c:
TEST_F(port_specific, bind_connect_1023) {
    ...
	if (variant->sandbox =3D=3D TCP_SANDBOX ||
	    variant->sandbox =3D=3D UDP_SANDBOX) {
    ...
}

Because the sandbox setup logic is hardcoded using if conditions instead of
the newly updated sandbox_bind_access() helper, if MPTCP variants are added
to these fixtures in the future, the MPTCP_SANDBOX condition would evaluate
to false, causing the tests to silently bypass ruleset enforcement and fals=
ely
report success.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260830201650.6705=
0-1-gnoack3000@gmail.com?part=3D4
