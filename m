Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792436485;
	b=2fS7MxFcWPLXX4YfxKmPRZuTtDsG14Uv+c68BHKqaE8AmBCbiFuIm0vBkNeR9pOq5OxM
	 E5iVgZMdCgbWppk9wes+hBH68xT2rd4dgOvmRF1xLRJX1fZeHX+C88rJxb58qLm2sT/B/
	 ZOEWsmWLdVrvfzwm9xYkLYiCHynvKm/2K4h7W5hTAkuyggKyOogTkjzP/jkRI2MVuJgu9
	 e8BLw3dBQDTX6dK40WU/GmbggAbtT3UCAEASS3O+luA0HIv3A2BjSBrouzkENWXjGzjji
	 PlTfNuQ9FVSeLZddZrRwu2djH5QUlpASJhnSowBPak4KhHQfpwboVGq7CrNB9c+C1mg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792436485;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Dvz8j0ryW4QcHdXQQAoLgHQczAhVJOsE5ev0OHfFl1k=;
	b=oiWw2wye0/0BWEFCeycoltJ1EY+8INnydFGTnKJ024IQSeowHGQzPxHE7RK/Nm9s5LCn
	 P2NNPV4Yf26F3B41ACD5phBXWsTnUDFF1GQz8RUF+6VDGsmZSTNJ0bi2m9vw0UOD4pJsJ
	 NVxpIDe+pZhJdx2UtCl1OdHjKUaC7CWfQpXKApegeHig75wfvknY31h7IHhmtuDfkvBFX
	 Uz6//BcRTATCxClkhT6ZyGoLtAQfgI7TeeAgQCd9eQtav44LOjFQhcUI4ZUIltv+KQA7i
	 j3HeQOWsjF/Fe7u5sEla4G+2PZkjas3ZmOsWN/OVMAAC0glNXEhjPEY/q2hqTcwvL+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EzDdJWdk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 803AE606A326
	for <mptcp@lists.linux.dev>; Mon, 19 Oct 2026 19:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EzDdJWdk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DED071F000C4;
	Mon, 19 Oct 2026 19:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792436485;
	bh=Dvz8j0ryW4QcHdXQQAoLgHQczAhVJOsE5ev0OHfFl1k=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=EzDdJWdkGBVH+33261IKxQt0v23Q8IANQ3md4jrU7WiHbK0gi9IYbQbP7ksqnA0Mw
	 O5h44NNK1YTV2WhKq4JsjdscxajV1I2ff7aBY6Z4OU9WIMURBxINjESxieVQMr6WZu
	 qZu+of0cPYseWaaeY7IZ5uQz8zqPetVrGiZy/rrF7ARUe5byhWbIPaWlQSh1Q3Igaa
	 kl8WIOXZOVIAokhWu+MMr7LHLzGJ2cCLg0XoLBZ9jEPvSLIpfLzWLURq3s/V9wpJRl
	 O92FEj40JhUd7PWaTbGg3AvRn7sY34Ye2CN7qLVjpUpJrgFnD0xlEZh+uKd0MEvlDs
	 C0hh5MOisjTFQ==
Message-ID: <sashiko-outbox-178124@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-net v3 2/2] selftests: mptcp: join: re-add the
 initial subflow endp with fullmesh
Reply-To: sashiko-reviews@lists.linux.dev
To: "Abdul Wasey" <w453y.me@gmail.com>, mptcp@lists.linux.dev
In-Reply-To: <20261019185512.458313-3-w453y.me@gmail.com>
References: <20261019185512.458313-1-w453y.me@gmail.com>
 <20261019185512.458313-3-w453y.me@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 19:01:24 +0000
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] selftests: mptcp: unconditional chk_join_nr() after guarded ipta=
bles setup
--

commit 9b7900e927e471e1fd39d7a60077bd9ea39be803
Author: Abdul Wasey <w453y.me@gmail.com>

selftests: mptcp: join: re-add the initial subflow endp with fullmesh

This commit adds two selftests to mptcp_join.sh to validate removing and
re-adding the endpoint used by the initial subflow when the fullmesh flag is
set, both with and without an initial subflow reset.

> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/test=
ing/selftests/net/mptcp/mptcp_join.sh
> index 18ce7136a2b0e..d2d105cef4a9b 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -4445,6 +4445,68 @@ endpoint_tests()

[ ... ]

> +	# same, but the initial subflow is reset before removing its endpoint
> +	if reset_with_events "delete and re-add, fullmesh, after reset" &&
> +	   continue_if mptcp_lib_kallsyms_has "subflow_rebuild_header$"; then
> +		pm_nl_set_limits $ns1 0 2
> +		pm_nl_set_limits $ns2 0 2
> +		pm_nl_add_endpoint $ns2 10.0.1.2 id 1 dev ns2eth1 flags subflow,fullme=
sh
> +		pm_nl_add_endpoint $ns2 10.0.2.2 id 2 dev ns2eth2 flags subflow,fullme=
sh
> +		{ timeout_test=3D120 test_linkfail=3D128 speed=3D5 \
> +			run_tests $ns1 $ns2 10.0.1.1 & } 2>/dev/null
> +		local tests_pid=3D$!
> +
> +		wait_event ns2 MPTCP_LIB_EVENT_ESTABLISHED 1
> +		wait_mpj 1
> +		chk_subflow_nr "before reset" 2
> +
> +		if ip netns exec "${ns1}" ${iptables} -A INPUT -s "10.0.1.2" \
> +		      -p tcp --tcp-option 30 -j REJECT --reject-with tcp-reset; then
> +			wait_event ns2 MPTCP_LIB_EVENT_SUB_CLOSED 1
> +			ip netns exec "${ns1}" ${iptables} -F INPUT
> +
> +			pm_nl_del_endpoint $ns2 1 10.0.1.2
> +			pm_nl_add_endpoint $ns2 10.0.1.2 id 1 dev ns2eth1 flags subflow,fullm=
esh
> +			wait_mpj 2
> +			chk_mptcp_info subflows 2 subflows 2
> +		fi
> +
> +		mptcp_lib_kill_group_wait $tests_pid
> +		kill_events_pids
> +
> +		chk_join_nr 2 2 2

[Severity: Medium]
In endpoint_tests(), what happens if the iptables command fails (for exampl=
e,
when netfilter TCP option match or REJECT target support is missing)?

Before the iptables block, only one MP_JOIN subflow is created (for 10.0.2.=
2,
as 10.0.1.2 matches the initial subflow). Both pm_nl_del_endpoint and
pm_nl_add_endpoint for 10.0.1.2 are inside the conditional block, so the
second MP_JOIN only happens when the iptables rule succeeds.

Because chk_join_nr 2 2 2 is called unconditionally outside the if block,
won't the test fail expecting 2 joins when only 1 occurred?

> +	fi
> +
>  	# remove and re-add
>  	if reset_with_events "delete re-add signal" &&
>  	   continue_if mptcp_lib_kallsyms_has "subflow_rebuild_header$"; then

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019185512.4583=
13-1-w453y.me@gmail.com?part=3D2
