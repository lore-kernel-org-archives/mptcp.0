Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F9537757F
	for <mptcp@lists.linux.dev>; Mon, 11 May 2026 11:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778500623; cv=none; b=kU7dyTT+3tKEDKc/13SRkFMzDenVaiC5Eia8jIMEwqC6sVPUTZGLOGf8gnq9cOdk4B/0imVgzAG8pSDq/LqPcGQQNihiF03ph1tPxP/KZpoPWQeb04NdNRQ/xbiAundBnm4Qwqy4j0Xwnx+TP9aqz0ABMj5UdX8S6bCLCdfO3y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778500623; c=relaxed/simple;
	bh=wMt0fh5j96gKBLa7dPoLntyU7Bdd/H+/+9v7AT2qXoI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Trplpu3SZ+ENifhma1XkE+I8XemesGwcniJR7SKusBajU38nCJLOLc2Xz7Touq15jB98eNBulnMPsJt1qZNX4fUAah0GkJhmHrHiWpEoK6gD08Dx3hCK2xiDnVoNHIqwEEfqUicnjFhDZozJd/733UTQxTxR6/FAdt/7FDlcuSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SwSZ4Cvm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SwSZ4Cvm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8DD5C2BCB0;
	Mon, 11 May 2026 11:56:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778500623;
	bh=wMt0fh5j96gKBLa7dPoLntyU7Bdd/H+/+9v7AT2qXoI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=SwSZ4CvmOSq3Nth1Ci7OgqHGh1hWie4RYPa4/mwTb6xt8p7wLpyhO0fJ93K+1gHra
	 jMr3tpmvvxj6WCwkmB3h5w5+WcNDz1OOjx3fergTEGDo77UC512WF4ZjSFNVxW4Z5T
	 YNyEwAGxrqlg549/7iGy6xNylxy/h31nMyYIwK0Yolc93TmqNGc4FlXEfffBDco5/e
	 Z31s1moHmP/1mB8jcSApLJAw7yM/iNJKd3SyxMYtk5CBiSXbSQoxoHB1Z0dNVdYIfo
	 m7nD6vkEM7/xvgKsrnLYU4T+mlYqnUNRUyBRKd1jOiiAFb46DnV4opvg630MMNCsyZ
	 GorrbQJPB8S3w==
Message-ID: <94cf17be-452b-4d63-a230-c0e657e02de7@kernel.org>
Date: Mon, 11 May 2026 13:56:56 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v2 2/2] selftests: mptcp: extend chk_rst_nr to validate
 per-event RST counters
Content-Language: fr
To: Shardul Bankar <shardul.b@mpiricsoftware.com>, mptcp@lists.linux.dev
Cc: martineau@kernel.org, geliang@kernel.org, pabeni@redhat.com,
 janak@mpiric.us, kalpan.jani@mpiricsoftware.com, shardulsb08@gmail.com
References: <20260509183335.969018-1-shardul.b@mpiricsoftware.com>
 <20260509183335.969018-2-shardul.b@mpiricsoftware.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20260509183335.969018-2-shardul.b@mpiricsoftware.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Shardul,

On 09/05/2026 20:33, Shardul Bankar wrote:
> Extend chk_rst_nr() with named env-var expectations for each
> per-event MPTCP_RST_EMPTCP counter, matching the pattern used by
> chk_join_nr().  Each counter defaults to 0 and is checked silently
> on success; mismatches print a check line and fail the test.
> Counters absent from the running kernel are skipped silently so
> older kernels do not false-fail.

Thank you for adding a test. This part looks good to me!
> Add a cross-namespace test that triggers MPJoinSynAckNoMPJoin: ns1
> announces an address belonging to a third namespace (ns3) where
> MPTCP is disabled, the client (ns2) JOINs to ns3 and receives a
> plain TCP SYN/ACK without MP_JOIN, and the new counter increments
> on the client side.
> 
> Other per-event counters (MD5SigReset, MPJoinAckNoMPJoin,
> MPJoinAckNoCtx, DssReset, MPJoinNotEstablished) are not currently
> reachable from mptcp_join.sh; the env-var hooks are in place for
> future tests to set expectations explicitly.

I guess packetdrill should be easier to hit some of these paths.

> Assisted-by: Claude:claude-opus-4-7

Thank you for mentioning this!

(...)

> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index 5d4d0f127f79..5d4fc8951f05 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh

(...)

> +rst_emptcp_tests()
> +{
> +	# Validate per-event MPTCP_RST_EMPTCP counters.  Use a third
> +	# namespace (ns3) to trigger paths that aren't reachable in the
> +	# standard ns1/ns2 setup: ns1 announces an address belonging to
> +	# ns3, the client (ns2) JOINs to ns3 where the SYN/ACK arrives
> +	# without an MP_JOIN option (MPTCP disabled there), and the
> +	# MPJoinSynAckNoMPJoin counter increments on the client side.
> +	local ns3

I'm not a big fan of adding a new netns here. Would it eventually work
to have $ns1 announcing an address that is on $ns2 and with
mptcp_connect listening on this address and port in TCP only?

If yes, then you can move this test to the end of signal_address_tests I
suppose.

If no, I don't know if it is worth it to have a such different test
here. Maybe it is enough to check the new RST counter like you did
above? (Eventually, adding a new check on packetdrill side if there are
already tests validating these paths.)

> +
> +	if reset "rst per event no mpj"; then
> +		if ! setup_ns ns3; then
> +			print_check "create ns3"
> +			print_skip
> +			return
> +		fi
> +
> +		ip link add ns2eth5 netns "$ns2" type veth peer name ns3eth1 netns "$ns3"
> +		ip -net "$ns2" addr add 10.0.6.2/24 dev ns2eth5
> +		ip -net "$ns2" link set ns2eth5 up
> +		ip -net "$ns3" addr add 10.0.6.1/24 dev ns3eth1
> +		ip -net "$ns3" link set ns3eth1 up
> +		ip -net "$ns3" link set lo up
> +		ip netns exec $ns3 sysctl -q net.mptcp.enabled=0
> +
> +		pm_nl_add_endpoint $ns1 10.0.6.1 flags signal id 5
> +		pm_nl_set_limits $ns2 1 1
> +
> +		local tport=$(get_port)
> +		ip netns exec ${ns3} ./mptcp_connect -l -t -1 -s TCP \
> +			-p $tport 10.0.6.1 &
> +
> +		speed=slow \

Do you really need the "slow" mode? Usually used when > 3 ADD_ADDR are
used or when actions need to be done during the connection. That's not
the case here.

> +			run_tests $ns1 $ns2 10.0.1.1
> +		wait_attempt_fail "$ns2"
> +
> +		rst_synack_no_mpjoin=1 \
> +			chk_rst_nr 0 0
> +
> +		cleanup_ns "$ns3"
> +	fi
> +}
> +
>  # [$1: error message]
>  usage()
>  {
> @@ -4527,6 +4620,7 @@ all_tests_sorted=(
>  	F@fail_tests
>  	u@userspace_tests
>  	I@endpoint_tests
> +	R@rst_emptcp_tests
>  )
>  
>  all_tests_args=""

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

