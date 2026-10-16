Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 611A83546E9
	for <mptcp@lists.linux.dev>; Fri, 16 Oct 2026 16:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792168498; cv=none; b=LryP/R/fyoPY8zbNBIn9lM2J2hVULhOanVRChwzmhYoreOzYUr02SbzXtSBmWTOw89IlrKb2asUPhjdFMHkcFG2saYK7vxKUudSmP/V0UrevtqrO42k4UZiQ4Sr6oleqy5DKSJ2SMZc1Qfsr3DaEUhPtbWE1Ue1Ms6aznZvkPw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792168498; c=relaxed/simple;
	bh=B4T+hd5cJ/yTTV+fROXpiFpVkj9oMqYRxec0RPaNs4Q=;
	h=Message-ID:From:Subject:To:In-Reply-To:References:Content-Type:
	 Date; b=daI3LF+7huKj7nSrxtKgKg1PgrvX0uN6cf/97A6FDpltxR0TbPOpiwE0tZguNBoOThLhMBsDFO4ylSxA1IXnEsmYAv/GI+/zuWzBdjG3+Kn0JYp4dZN/W3X1vi44Sm+L4EjNLm+gjRj9Y38tZqNb3g4hkk8vYi47LJykUglUsFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R4v3lthf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R4v3lthf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F4F81F000C5;
	Fri, 16 Oct 2026 16:34:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792168497;
	bh=Wfby2FaV4mkZw4kRpqUiMWmBMpbtk5srqZocn/UQpt0=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=R4v3lthfaDHqKjZ3sMRyRSk3BdUjmkvwFv3vD1e3rYTS3X2IrtfJYL73+J6MS3fh4
	 osq5E1ZSg5UnG8TDg74kHjGZhNpjAfSnuXXPD3jrbsTHJ2iGucLjGwK7cNt1s4Co+L
	 ZlstmonQEwRLAvHggqQt0rmXUAGMPVJcekyDSTYgNmEdTOUjHoA4N97oPZsrQLE5YD
	 cg0QXkNZ/CeV9rvXWz5CLju4Q6RgBnetK0NTlvEtOmx3V7PLgsuLGMYgGTY00M/VG2
	 w4/qwz4FIfWRySvqIw3+oGaMzWFb2BV/bt48dLdLBuZddrfFbV0JppCLVJPT0EocLl
	 /HMR9u11v7kbQ==
Message-ID: <sashiko-outbox-174647@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-next v5 7/7] selftests: mptcp: join: validate
 subflow retry after link failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anil Kaushik" <anilkaushikwireless@gmail.com>, mptcp@lists.linux.dev
In-Reply-To: <20261016160926.1155262-8-anilkaushikwireless@gmail.com>
References: <20261016160926.1155262-1-anilkaushikwireless@gmail.com>
 <20261016160926.1155262-8-anilkaushikwireless@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 16:34:56 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] selftests/mptcp: sf_from() extracts Send-Q instead of local addr=
ess and port
- [Medium] selftests/mptcp: hand-rolled busy-wait polling loops instead of =
shared helpers
- [Medium] selftests: mptcp: background file generation race causes flaky t=
imeout
--

commit f8121441934e1bbc20d48bed94f57afe881c5d82
Author: Anil Kaushik <anilkaushikwireless@gmail.com>

selftests: mptcp: join: validate subflow retry after link failure

Test the subflow-retries limit, with its default value, and a long
connection in the background.

> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/test=
ing/selftests/net/mptcp/mptcp_join.sh
> index f4d8afaeda4f3..521f95d3027fa 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -2151,6 +2151,102 @@ wait_attempt_fail()
>  	return 1
>  }
> =20
> +# $1: ns ; $2: counter ; $3: expected minimum value
> +wait_counter()
> +{
> +	local cnt
> +
> +	for _ in $(seq $((timeout_poll * 10))); do
> +		cnt=3D$(mptcp_lib_get_counter "${1}" "${2}")
> +		[ "${cnt:-0}" -ge "${3}" ] && return 0
> +		sleep 0.1
> +	done
> +
> +	return 1
> +}

[Severity: Medium]
Does this hand-roll a busy-wait polling loop instead of using the shared
helpers?

The networking selftests library (tools/testing/selftests/net/lib.sh) alrea=
dy
provides busywait_for_counter specifically to handle this pattern robustly.

> +
> +# $1: client address ; prints the local address and port of its subflow
> +sf_from()
> +{
> +	ip netns exec $ns2 ss -tnH state established src "${1}" |
> +		awk '{ print $3; exit }'
> +}

[Severity: Medium]
Does this extract the Send-Q column instead of the Local Address:Port colum=
n?

The command ss -tnH state established outputs columns: State, Recv-Q, Send-=
Q,
Local Address:Port, Peer Address:Port. So the 3rd column is Send-Q, rather =
than
Local Address:Port.

Because the previously blocked subflow has queued, dropped packets, its Sen=
d-Q
is non-zero. The newly created subflow has an empty Send-Q (0). The test lo=
gic
later evaluates [ "${after}" =3D "${before}" ] as [ "0" =3D "<non-zero>" ],
which evaluates to false, causing the test to pass by coincidence without e=
ver
verifying that the new subflow originated from a different port.

[ ... ]

> +
> +# $1: result of the wait for the subflow being re-created before the clo=
se
> +chk_no_sf_connecting()
> +{
> +	print_check "no subflow connecting after close"
> +	if [ "${1}" -ne 0 ]; then
> +		fail_test "no subflow re-created before the close"
> +		return
> +	fi
> +
> +	# closed with the MPTCP socket
> +	for _ in $(seq $((timeout_poll * 10))); do
> +		if ! ip netns exec $ns2 ss -tnH state syn-sent | grep -q .; then
> +			print_ok
> +			return
> +		fi
> +		sleep 0.1
> +	done
> +
> +	fail_test "subflow still connecting after close"
> +}

[Severity: Medium]
Does this hand-roll a busy-wait polling loop instead of using the shared
helpers?

The networking selftests library (tools/testing/selftests/net/lib.sh) alrea=
dy
provides busywait to handle this pattern robustly.

[ ... ]

> @@ -2585,6 +2681,62 @@ link_failure_tests()
>  		chk_stale_nr $ns2 1 -1 2
>  		chk_link_usage $ns2 ns2eth3 $cinsent 50
>  	fi
> +
> +	# subflows closed after a silent link failure, then re-created: the
> +	# additional one, then the initial one. Then close the connection
> +	# while a subflow is being re-created.
> +	if reset_with_events "subflow retry after link failure" &&
> +	   continue_if has_subflow_retries; then
> +		init_nftables
> +		# slow links, short queues: the transfer lasts the whole test on
> +		# any machine, and the blocked subflow always has data in flight
> +		local i
> +		for i in 1 3; do
> +			tc -n $ns1 qdisc add dev ns1eth$i root netem \
> +				rate 4mbit limit 30 delay 1ms
> +			tc -n $ns2 qdisc add dev ns2eth$i root netem \
> +				rate 4mbit limit 30 delay 1ms
> +		done
> +		ip netns exec $ns2 sysctl -q net.ipv4.tcp_retries2=3D3
> +		ip netns exec $ns2 sysctl -q net.ipv4.tcp_syn_retries=3D1
> +		ip netns exec $ns2 sysctl -q net.ipv4.tcp_syn_linear_timeouts=3D0
> +		pm_nl_set_limits $ns1 0 4
> +		pm_nl_set_limits $ns2 0 2
> +		pm_nl_add_endpoint $ns2 10.0.3.2 dev ns2eth3 flags subflow
> +		# created here, not in the background job, for cleanup()
> +		if [ -z "$cinfail" ]; then
> +			cinfail=3D$(mktemp)
> +		fi
> +		if [ -z "$sinfail" ]; then
> +			sinfail=3D$(mktemp)
> +		fi
> +		# killed at the end: the timeout only stops a stuck test
> +		{ timeout_test=3D600 test_linkfail=3D131072 \
> +			run_tests $ns1 $ns2 10.0.1.1 & } 2>/dev/null
> +		local tests_pid=3D$!
> +
> +		wait_counter $ns1 "MPTcpExtMPJoinAckRx" 1

[Severity: Medium]
Could this foreground polling loop time out before the background file
generation completes?

The test case sets test_linkfail=3D131072 and launches run_tests in the
background. Inside run_tests, it sequentially generates 128MB of random data
per file via dd, blocking the network transfer from starting until both fil=
es
are fully generated.

Meanwhile, the foreground script immediately calls wait_counter, which polls
for the MPTcpExtMPJoinAckRx counter to increment with a 30-second timeout.
If the dd commands take longer than 30 seconds on a slow test runner, the
foreground script will time out and fail the test before the actual connect=
ion
has even started.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016160926.1155=
262-1-anilkaushikwireless@gmail.com?part=3D7
