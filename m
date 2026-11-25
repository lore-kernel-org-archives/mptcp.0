Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795592054;
	b=pMtTk0Q2+X+nZHvjnZQKOoHOJ33lYVnVcJUlDc3y5OdWI3PG+kESgAnVOW2xiQONJzaN
	 JuNYNsmKeg4HrDkzCpshHre3CjxaizQGebbZKHBrPPsGdXnpT2vMWQi/xFBupz51AZGT7
	 b7VfbxmBHdZ/0M8TOX9BmyKhEumx7HEFybucJsikyREhhedBtLkNTkRRT+3PAiKWa6X4J
	 /F2lSW3ydmYs60l0JByKLnD4qj2L/ivTwe537cWmbBtY16hSvdEcD0vADcoO+AAsr073m
	 a7n8wQNkX051ptpZZKHcQS8OykIwDYDwf0VGnFfyo8aMTU58uEtx+slF0ZmWvO8Ke/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795592054;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=+hidPzSaZXf/EdZVVynJe1JKfb9moPGDqK9aH2vjNo4=;
	b=O13Cswdo7jWq5OaOiwWD3I/nyOnYDIinlugv7SFpwP7d0Tc+3e2+xDbLQ7i5+kcHpkV6
	 mCLRe+JZbX4kKAMhTgyAvRtBRnuKPGj+61NK86MlReE0QrZfAG1VymKsEsgO5Pe8xDNcd
	 QXeRidhLN9JBYdEQ9OD1V91ClzHSfL+OGmCAq8M03n3Ath+/YcVQxjFx9lmoqEJm19EUR
	 WloLE/fWosFD3krXYJ26MIVPe7n0tyJCSx9mkdEnf7QKJ0XFzwKOrUTga58thXv6I4dmp
	 hywQFg/9WmI/wnuNcZF8oJ3fltXJjfrPezszNzH/aIrLd8B4/P+re+99twdCYoT8dGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O+xWrTZU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25111606A321
	for <mptcp@lists.linux.dev>; Wed, 25 Nov 2026 07:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O+xWrTZU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10FE11F000CF;
	Wed, 25 Nov 2026 07:34:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795592053;
	bh=+hidPzSaZXf/EdZVVynJe1JKfb9moPGDqK9aH2vjNo4=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=O+xWrTZUjPUm0XwPFFtlFilga7MyuYUuHlxdzOxAcT2DO23SY3RLztdMnG8Vz/jkO
	 4/80FjVZ0TjInwcxAJloONllpV0d4jux6LSD7HaDfY8BfNpLKdQwN4J63WTHTlpoDE
	 IRuVnfToHZbH0mMlf0+CC9XnyOQE5VNgnKv0jcu3jG3LzGAPFLva3UL1p9I8TL6L0G
	 5Ne84bcJzALYX8vmm1Z3qo4mmGge6tZW91Kkezabzne0TFlGdGyOT26VP5c2v0uHjU
	 ddksk/aS78w5Locz/jlxWoyZfNwiUAz8OfZRlkrt+8UlSMqX9oV0AXXsMrUmmN0Wy9
	 +uiuEiFpLlYSw==
Message-ID: <sashiko-outbox-232814@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-next v9 7/7] selftests: mptcp: cover msg_zerocopy
 test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Geliang Tang" <geliang@kernel.org>, mptcp@lists.linux.dev
In-Reply-To: <3bd50e8f16d828fd027f3c0c8ce0df829401a362.1795591278.git.tanggeliang@kylinos.cn>
References: <cover.1795591278.git.tanggeliang@kylinos.cn>
 <3bd50e8f16d828fd027f3c0c8ce0df829401a362.1795591278.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 07:34:11 +0000
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] selftests: mptcp: missing CONFIG_DUMMY in config for
  msg_zerocopy.sh
--

commit 5b3ee281d765d4c4bfa0409eafb89f384c870ea5
Author: Geliang Tang <geliang@kernel.org>

selftests: mptcp: cover msg_zerocopy test

This commit adds the msg_zerocopy test to the MPTCP selftest suite by
symlinking ../msg_zerocopy.sh and building msg_zerocopy from
../msg_zerocopy.c.

> diff --git a/tools/testing/selftests/net/mptcp/Makefile b/tools/testing/s=
elftests/net/mptcp/Makefile
> index 22ba0da2adb85..17d0d1051165c 100644
> --- a/tools/testing/selftests/net/mptcp/Makefile
> +++ b/tools/testing/selftests/net/mptcp/Makefile
> @@ -14,6 +14,7 @@ TEST_PROGS :=3D \
>  	mptcp_connect_splice.sh \
>  	mptcp_join.sh \
>  	mptcp_sockopt.sh \
> +	msg_zerocopy.sh \
>  	pm_netlink.sh \
>  	simult_flows.sh \
>  	userspace_pm.sh \

[Severity: Medium]
Does tools/testing/selftests/net/mptcp/config also need CONFIG_DUMMY=3Dy?

msg_zerocopy.sh runs under set -e and unconditionally creates a dummy
network device with "ip link add ... type dummy" for every subtest.
Unlike tools/testing/selftests/net/config, the mptcp config only enables
CONFIG_VETH=3Dy and omits CONFIG_DUMMY, so running the mptcp selftests on a
kernel built from tools/testing/selftests/net/mptcp/config will fail when
msg_zerocopy.sh tries to create dummy0.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1795591278.gi=
t.tanggeliang@kylinos.cn?part=3D7
