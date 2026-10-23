Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792754080;
	b=RT+L0ZotDv0U+NnY3df1mVxhlXYxWG6n2Hs75aJkiO8HjKu4BK2A/tRI+qgYEb/0SOWs
	 ZDrA75mAZnvg7Y9sy8x0ZCs/1gXhumHAP/OXMoG6yq5faD2k0Lj8XtvUQEskUhdb0CdAz
	 cIcwy64cJSA/qgudDNc+kK339YVs+ebGSOfCYrUZXm4FAUUIPLPVGAHCQ1ziihIIbhgCG
	 qkO4oX8eKsHX24wCrZpIBw6nbEfoa6ZbOL89BPbN4BrG9G1E9k8tKTCV1R27s+ojYdK8f
	 cyfF9jMN2TTrMlFhUVChLix4dyHw2xiuAWS/LFrsDk6Z9+16I6UbiCqycUNvX6s0gHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792754080;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ONgawtVLxSNMOrNo8G3jy6kt0P0pTIj58M3DOqrncyk=;
	b=PXLQFMN1vOif0CYph1PfwTY0nKWH8B7j8H5W0wmPr2L/Q9Qy5dJj+jGUAf5yYyYiadxc
	 29johMIcrMU1/Q15ojkpRvnRSthCjG0iWA000n2ua/iXwQ+102ULd2DI7XrCHZlg4yTxj
	 qO6L/QntFgStu49KStPzCx6mJ3o3ts4FEDvaU3AYzAJjTnF8GxJp65VMXWTfzkBn8nu9/
	 O3jlKv6ntnvVV0pRrAQ3KAksYATEqgigrl1AUAzUH+bOuFLwjtc1lLeM7dJ/p6RrwI7nH
	 kRkydJ05tkSoK6zyTUY1Sp5H8/hQKjCvtS0y7vu7CFlaX1KEat15xLxZ+5B02c9Wj8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LeBXDppN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B391606A31A
	for <mptcp@lists.linux.dev>; Fri, 23 Oct 2026 11:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LeBXDppN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A17F1F01825;
	Fri, 23 Oct 2026 11:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792754079;
	bh=ONgawtVLxSNMOrNo8G3jy6kt0P0pTIj58M3DOqrncyk=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=LeBXDppN+o0EL+i2zo7p5n/yfMXU3ml+32yOK6cnF1wH8GwZphx+SkrKlRDgsFunv
	 os2twP54U5T9w8eMWO9l2QoepjpvxChSBZsmucXHGpRJj2tmsiEBF+/OVoDEuoNh70
	 LGPhsFxTkIQZ6NgaD6Wvn7IW3XSpIPxSAd+pjYObopRzglBSKxrcWqjZhM2almBnmP
	 Jp251rlNQHA+CqCc8voUKje84jNh45Ff9UZc3l36T+CyUVJaWlCPjpN93Eov2XmWcj
	 M/emVNivd8+sxOMqrC305hSiQJ7tpxTPkRquXp8w2hwZ2haKwM6dnlMiFhV/2bkNtJ
	 4tmSprS6cp6ug==
Message-ID: <sashiko-outbox-182722@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-net v7 2/2] selftests: mptcp: join: re-add the
 initial subflow endp with fullmesh
Reply-To: sashiko-reviews@lists.linux.dev
To: "Abdul Wasey" <w453y.me@gmail.com>, mptcp@lists.linux.dev
In-Reply-To: <20261023110321.403874-3-w453y.me@gmail.com>
References: <20261023110321.403874-1-w453y.me@gmail.com>
 <20261023110321.403874-3-w453y.me@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Oct 2026 11:14:38 +0000
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
- [Medium] selftests: mptcp: unset iptables variable in endpoint_tests() br=
eaks test
--

commit 5d801b552c8fda4d06f17bc60e0d917102aa1d3c
Author: Abdul Wasey <w453y.me@gmail.com>

selftests: mptcp: join: re-add the initial subflow endp with fullmesh

This commit adds four subtests to endpoint_tests() in mptcp_join.sh to
validate removing and re-adding the initial subflow endpoint when using the
fullmesh flag.

> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/test=
ing/selftests/net/mptcp/mptcp_join.sh
> index f4d8afaeda4f3..98dc8de81cf01 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -4424,6 +4424,135 @@ endpoint_tests()

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
> +			chk_evt_nr ns2 MPTCP_LIB_EVENT_SUB_CLOSED 1 error 1
> +
> +			pm_nl_del_endpoint $ns2 1 10.0.1.2
> +			pm_nl_add_endpoint $ns2 10.0.1.2 id 1 dev ns2eth1 flags subflow,fullm=
esh
> +			wait_mpj 2
> +			chk_mptcp_info subflows 2 subflows 2
> +			chk_join_nr 2 2 2
> +		else
> +			mark_as_skipped "unable to set the filter rules"
> +		fi

[Severity: Medium]
Will this filter setup in endpoint_tests() always fail?

Commit be3b69f3cedfaf ("selftests: mptcp: convert iptables to nftables for
mptcp_join.sh") converted mptcp_join.sh to nftables and removed the
definition of the iptables variable.

Because ${iptables} is unset and unquoted here, the command expands to:

    ip netns exec "${ns1}" -A INPUT -s "10.0.1.2" ...

which fails immediately, causing this subtest to always fall into the else
branch calling mark_as_skipped (or exit with KSFT_FAIL before killing
$tests_pid and the event listeners when
SELFTESTS_MPTCP_LIB_EXPECT_ALL_FEATURES=3D1 is set).

Should this subtest call init_nftables and use nft to add and flush the rul=
e,
matching userspace_tests() in mptcp_join.sh:

    init_nftables
    ...
    if ip netns exec "${ns1}" nft add rule ip filter INPUT \
            ip saddr "10.0.1.2" meta l4proto tcp \
            tcp option mptcp exists reject with tcp reset; then
        wait_event ns2 MPTCP_LIB_EVENT_SUB_CLOSED 1
        ip netns exec "${ns1}" nft flush chain ip filter INPUT
        ...

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261023110321.4038=
74-1-w453y.me@gmail.com?part=3D2
