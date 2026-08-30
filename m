Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C8B31D372
	for <mptcp@lists.linux.dev>; Sun, 30 Aug 2026 20:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788121733; cv=none; b=JYHeDonv4h1Ez72mtePFGq6urL3azXt1th9j0XvkxarusuRnfbE7Ja4O28+ONas0xw1HeZgiRqXE9DIKvPa9G0O4eESBoNE1hfcdtS4LwE8wqapmNTwXJM7Pwxd9s53a9b9vrcDhTHozTCKXudBigDSrD9ZnnfPzOxgmtcqq/M0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788121733; c=relaxed/simple;
	bh=MsmiTTzQXhnGYlmJC/gKVN6FB/YAS5cXPxwP5mHYltE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=V76EOjoKUIJfelgqxy/ja87p7+Q5p4ssYNdhMSsXnQTyGh17SuqLhtommJxoC8F9k/p9gd+CP0AklUHp8lVrUJmiDNWgqdqbUVk7T1rUcA3g708SZ0NffLkIEMo8M5kbxrm0l/A01nw5N3dSLSFUzt+G3I9CayNvfpu1qmebw8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=USOYII8h; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="USOYII8h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57A281F000E9;
	Sun, 30 Aug 2026 20:28:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788121731;
	bh=XXhqLUZRciyFrfuHGJimoAvAxeTn9sPLm7f7G7ctvpI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=USOYII8hfizRq+WKlYbRcjVscBinQn4zWiYIqb9aboRNgFw40nA0bfHAnAfmrJosO
	 exwkj180fhlp/1yBURAvpPDjwyFApjxiT3iuift2AlPL73GMk1HqhB2aZDbh72345w
	 LD7vGWJ+1oIeNSkvD3MGhI/0wyZjWrhLsI7aIPwCCEbsPpbXbXAdG4E7KtUEe1Vn88
	 nQn94GTolMXr4YXP0xptezvtMLZg0ol261mvHzywwqmlkDLXZQl2XmAGRWIRZTMUri
	 e9mO7e2Ij0wIcK7fv6vipOX8dXQkZ1ys0KAJObZxn4GEdDzwc1l+QAcoCroqyFEvyo
	 CXict+/o0yLCQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/6] selftests/landlock: Generalize net test helpers for
 multiple socket types
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?R8O8bnRoZXIgTm9hY2s=?= <gnoack3000@gmail.com>
Cc: mptcp@lists.linux.dev
In-Reply-To: <20260830201650.67050-3-gnoack3000@gmail.com>
References: <20260830201650.67050-1-gnoack3000@gmail.com>
 <20260830201650.67050-3-gnoack3000@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 30 Aug 2026 20:28:50 +0000
Message-Id: <20260830202851.57A281F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Incomplete refactoring: Several test fixtures retain hardcoded T=
CP/UDP checks instead of using the newly introduced generalized sandbox acc=
ess helpers.
--

commit e9dd22f54640c7d9439f23efd0049803e698947e
Author: G=C3=BCnther Noack <gnoack3000@gmail.com>

selftests/landlock: Generalize net test helpers for multiple socket types

Create helper methods for determining the access rights to be tested
based on socket type (TCP or UDP). This makes it simpler to add more
socket types with similar bind(2) and connect(2) restrictions in the
future.

> diff --git a/tools/testing/selftests/landlock/net_test.c b/tools/testing/=
selftests/landlock/net_test.c
> index a18761e0fd82f..3a0482beca5f4 100644
> --- a/tools/testing/selftests/landlock/net_test.c
> +++ b/tools/testing/selftests/landlock/net_test.c
[ ... ]
> @@ -108,11 +108,41 @@ static bool prot_is_udp(const struct protocol_varia=
nt *const prot)
>  static bool is_restricted(const struct protocol_variant *const prot,
>  			  const enum sandbox_type sandbox)
>  {
> -	if (sandbox =3D=3D TCP_SANDBOX)
> +	switch (sandbox) {
> +	case TCP_SANDBOX:
>  		return prot_is_tcp(prot);
> -	else if (sandbox =3D=3D UDP_SANDBOX)
> +	case UDP_SANDBOX:
>  		return prot_is_udp(prot);
> -	return false;
> +	case NO_SANDBOX:
> +	default:
> +		return false;
> +	}
> +}
> +
> +static __u64 sandbox_bind_access(const enum sandbox_type sandbox)
> +{
> +	switch (sandbox) {
> +	case TCP_SANDBOX:
> +		return LANDLOCK_ACCESS_NET_BIND_TCP;
> +	case UDP_SANDBOX:
> +		return LANDLOCK_ACCESS_NET_BIND_UDP;
> +	case NO_SANDBOX:
> +	default:
> +		return 0;
> +	}
> +}
> +
> +static __u64 sandbox_connect_access(const enum sandbox_type sandbox)
> +{
> +	switch (sandbox) {
> +	case TCP_SANDBOX:
> +		return LANDLOCK_ACCESS_NET_CONNECT_TCP;
> +	case UDP_SANDBOX:
> +		return LANDLOCK_ACCESS_NET_CONNECT_SEND_UDP;
> +	case NO_SANDBOX:
> +	default:
> +		return 0;
> +	}
>  }

[Severity: Medium]
Are there other test fixtures that also need to be updated to use these new
helpers?

It looks like TEST_F(ipv4, from_unix_to_inet), TEST_F(port_specific,
bind_connect_zero), and TEST_F(port_specific, bind_connect_1023) still use
the hardcoded TCP_SANDBOX and UDP_SANDBOX checks instead of the generalized
sandbox access helpers:

tools/testing/selftests/landlock/net_test.c:TEST_F(ipv4, from_unix_to_inet)=
() {
    ...
	if (variant->sandbox =3D=3D TCP_SANDBOX ||
	    variant->sandbox =3D=3D UDP_SANDBOX) {
		const __u64 access_rights =3D
			(variant->sandbox =3D=3D TCP_SANDBOX ?
				 LANDLOCK_ACCESS_NET_BIND_TCP |
					 LANDLOCK_ACCESS_NET_CONNECT_TCP :
				 LANDLOCK_ACCESS_NET_BIND_UDP |
					 LANDLOCK_ACCESS_NET_CONNECT_SEND_UDP);
    ...
}

Will this cause these tests to silently skip ruleset application or incorre=
ctly
fail if a new sandbox variant (such as MPTCP) is added in the future?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260830201650.6705=
0-1-gnoack3000@gmail.com?part=3D2
