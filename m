Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792433590;
	b=z4W0/iCZYCErfpDQAVRhOW4aJRGPDlaLz6HNXKmOfZvRrIBOpTPchQZ7fcZmatiXnxma
	 WTK9zZijI2LivdSrDqzFlehHcGcc03E1lUYEDWqGp00dtjSLj79LLj8xe5iX0GbTn8Cl7
	 jZ25Ctsjw+dQdbsAOPrg0IHqMxtKJtMGVtWa6N8dxbIat+4oFh8JXyJ0GfyDecAvY1zHO
	 /1w5Bm8Vn+1ZNrGolTtQCchaHAjuvuZ7ihfEOLDO/EtqIktU4upK3mqj34qs8ot+LOZo5
	 bxoxQGvXl5C5/7jLhHQRqNGSjH5cGJ70SlC7TsfDfTSvcMrsHjVGoBxhHi16HLAxNGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792433590;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=JRVZG82TFS8HgGNP5rd6Y8eVbFEk7lvzapdw1yhKeFU=;
	b=ySmLgeqCe94c66WtifH25XyMXOI8sCt03S96mSZg54PI5wy0VTp7lo53sYe+8l0RX/40
	 JiI1gXXcE+ApBDqLdELwGXerMbdKHRortohMD7Ehn7kP4AwW+UFlwIMpqvmPIrAbmiqFY
	 5od5ELXTp3EzyHvfdAXyaDIK1YAff0AWQ6a2q7TFGnqdCGy7zy0757MYy9oyDvb4TaasL
	 2c8bEH0M71y3EaL3UOAOoUS6UYr/TLUN7SjNReBsYZfVHh8nAxvqWdEmxRh+U4drVaRDQ
	 Z0dqd9GMm6QkahZM8AMkaVVTJ0XXjNP9MaH9d9MrM5P4e8MZs22oM476+U0sjCCrXNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="TJ/DlXJT";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66049606A31C
	for <mptcp@lists.linux.dev>; Mon, 19 Oct 2026 18:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TJ/DlXJT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C05941F000C4;
	Mon, 19 Oct 2026 18:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792433590;
	bh=JRVZG82TFS8HgGNP5rd6Y8eVbFEk7lvzapdw1yhKeFU=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=TJ/DlXJTiCwqRi+Ig61AjGdnaO74n9Y/fe8sT37Qf3LPY4c6IG82PY5bM9y459fkL
	 QFZ8SSP+g606B7Fx9HDj8ikLQ6gwnxN/7XAp9cDWFAJ8DwkMl/vBex02iBMqum2N3n
	 R1bJ744e5cLwP9gwP7RGX8xZSPVj0NUmp0Q2jO8dmTnW+xxt7D7nTq9cYl8rs7vltI
	 kBqFtnm/MVmpkYHCRcEHYRP3GH/dmrPti9cjt0zId5gKnn9Zty/vN+AGnP/vrwlMfT
	 U07jaCWpouBfdYkQ3v3+WZkSa0y98G5dMxDAr6T2OWpqsJ42ez4i8dUtANDUPxroRQ
	 LHkkas2VNErcw==
Message-ID: <sashiko-outbox-178065@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-net v2 2/2] selftests: mptcp: join: re-add the
 initial subflow endp with fullmesh
Reply-To: sashiko-reviews@lists.linux.dev
To: "Abdul Wasey" <w453y.me@gmail.com>, mptcp@lists.linux.dev
In-Reply-To: <20261019180306.382039-3-w453y.me@gmail.com>
References: <20261019180306.382039-1-w453y.me@gmail.com>
 <20261019180306.382039-3-w453y.me@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 18:13:09 +0000
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
- [Medium] selftests: mptcp: undefined init_nftables() breaks endpoint_test=
s()
--

commit bc814fecc7de467b22c281bbf58a319ea166e5a2
Author: Abdul Wasey <w453y.me@gmail.com>

selftests: mptcp: join: re-add the initial subflow endp with fullmesh

This commit adds two selftests to endpoint_tests() in mptcp_join.sh to
verify deleting and re-adding the endpoint of the initial subflow when the
fullmesh flag is set, both normally and after the initial subflow is reset.

> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/test=
ing/selftests/net/mptcp/mptcp_join.sh
> index 18ce7136a2b0e..0fa69aa2e9b80 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -4445,6 +4445,70 @@ endpoint_tests()
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
> +		init_nftables
> +		if ip netns exec "${ns1}" nft add rule ip filter INPUT \
> +				ip saddr "10.0.1.2" meta l4proto tcp \
> +				reject with tcp reset; then
> +			wait_event ns2 MPTCP_LIB_EVENT_SUB_CLOSED 1
> +			ip netns exec "${ns1}" nft flush chain ip filter INPUT
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
> +	fi

[Severity: Medium]
Where is init_nftables defined? It does not appear to exist in
tools/testing/selftests/net/mptcp/mptcp_join.sh, mptcp_lib.sh, or
net/lib.sh, so calling it here produces "init_nftables: command not found".

Because the ip filter table and INPUT chain are never initialized in
${ns1} (which was freshly created via reset_with_events() ->
init_partial()), the subsequent "nft add rule ip filter INPUT ..." command
also fails with "No such file or directory".

That causes the if block to be skipped without resetting the subflow or
deleting and re-adding endpoint 1, and then chk_join_nr 2 2 2 fails
unconditionally because only 1 MP_JOIN occurred.

Should this use ${iptables} instead, matching how userspace_tests() in
tools/testing/selftests/net/mptcp/mptcp_join.sh injects TCP resets:

		if ip netns exec "${ns1}" ${iptables} -A INPUT -s "10.0.1.2" \
		      -p tcp --tcp-option 30 -j REJECT --reject-with tcp-reset &&

> +
>  	# remove and re-add
>  	if reset_with_events "delete re-add signal" &&
>  	   continue_if mptcp_lib_kallsyms_has "subflow_rebuild_header$"; then

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019180306.3820=
39-1-w453y.me@gmail.com?part=3D2
