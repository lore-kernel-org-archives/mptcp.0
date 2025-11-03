Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB48A1DED4C
	for <mptcp@lists.linux.dev>; Mon,  3 Nov 2025 07:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762154180; cv=none; b=OrkWTKVqPmSqOFmh5Wsu9boxiva0AlIZIfr/Zxs0ui7qslrrMKckUWr9mGtaEB+Z9RS9Yb8yYCIL5ijBosvsWi+Y9K/uuAJJdCM40nz3AB2qVlv32aG1nxGOeMwL+UGB5gyxo0RbTfqHBvIug3GpwNAuVAz9jOZYiau6GRiMVbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762154180; c=relaxed/simple;
	bh=5rP7Is5pzGHM4U64nWX9HOKtihZhzIgHdo3Xx6KrDJw=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NHUJXd6omjN63So96QFclFe+VMNGAzRvZVZ1PY0uJW/I0M3eIJR0Le921O4Y1brqvKQl/utPdwxP7oYzYEo1nZ7E92apNVXKvYBL+XvjykOA5TBcx5iljHgzQQEYXMO7xUBiiky2jPCXUTyqOXBLZYn48JN1OvXrzVacbZg/3bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dc4G1QiK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dc4G1QiK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77EAFC4CEE7;
	Mon,  3 Nov 2025 07:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762154180;
	bh=5rP7Is5pzGHM4U64nWX9HOKtihZhzIgHdo3Xx6KrDJw=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=Dc4G1QiKbp3KnJVjyS1tEKX0v4I9IVjMuxAuXRc5gvf9m/abXbw4uhIei1My9lBG3
	 lrJ6V4FEG35udu1g7pvwwBqr3w8TFkoHqIc1xzgQwwb3GP6E5bQnLvGYU4/6Dc/kNM
	 rbkPEyCcaoTEWdDAllVZMYktgwOrIeDcHy6MsnalHDkepOlSr3fGTsX3XYJiRTlk23
	 MQ+KeJ2Xa3pEVpVVpfIpYCFoeDsjNn2Z3quc+/i/K5X0LZ+UQZ2XqzA/aK/WXP2FpZ
	 CQXz7M6i9vYBcj6y5hGBHdoWjfQVFBszaVXIoEYEPFVVJbFZSLL4tj+I44kDKFOjf5
	 yee0lMU1ZcwMw==
Message-ID: <8c0c5c48687518f351c3469cbd0f9e3497d6c22e.camel@kernel.org>
Subject: Re: [PATCH mptcp-net v2 5/6] selftests: mptcp: join: fastclose:
 drop plain RST
From: Geliang Tang <geliang@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, MPTCP Upstream
	 <mptcp@lists.linux.dev>
Date: Mon, 03 Nov 2025 15:16:16 +0800
In-Reply-To: <20251102-slft-join-inst-v2-5-b4f3ba15a7c4@kernel.org>
References: <20251102-slft-join-inst-v2-0-b4f3ba15a7c4@kernel.org>
	 <20251102-slft-join-inst-v2-5-b4f3ba15a7c4@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Matt,

On Sun, 2025-11-02 at 12:30 +0100, Matthieu Baerts (NGI0) wrote:
> These tests are sending data without any throttling. Quickly, one
> side
> will shutdown the connection, which will force sending a RST with
> MP_FASTCLOSE.
> 
> On the kernel side, the following path will be taken:
> 
>   mptcp_close
>   --> __mptcp_close
>     --> mptcp_do_fastclose
>       --> __mptcp_close_ssk
>         --> tcp_disconnect
>           --> tcp_send_active_reset
> 
> The subflow will be closed and the reset containing the MP_FASTCLOSE
> will be queued to be sent. If some data are received at the same
> time,
> it is possible a "plain" reset -- without ACK -- is sent from
> tcp_v[46]_send_reset, because no socket has been found for this
> packet
> (no_tcp_socket). In some cases, this "plain" reset can be sent before
> the one with the MP_FASTCLOSE. When this happens, the receiver will
> first close the connection upon the first RST reception, and then
> drop
> the second one because the connection has already been closed. In
> this
> case, the connection has been correctly reset, but the MPFastcloseRx
> and
> MPRstRx MIB counters have not been incremented, which is not what the
> test expects.
> 
> To solve this issue, the "plain" reset are now dropped to make sure
> the
> one with the MP_FASTCLOSE is parsed by the receiver.
> 
> Note that this instability seems to be more visible since commit
> 8cc6e542f150 ("mptcp: propagate shutdown to subflows when possible"),
> certainly because the subflows are closed slightly quicker.
> 
> Another solution is also possible: reset the connection with no
> ongoing
> data. But this means more changes: data being sent, probably set
> SO_LINGER, etc.
> 
> With this small modification, the test should no longer be flaky. It
> is
> then OK to remove the MPTCP_LIB_SUBTEST_FLAKY mark.
> 
> Fixes: 01542c9bf9ab ("selftests: mptcp: add fastclose testcase")
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

This patch looks good to me.

    Reviewed-by: Geliang Tang <geliang@kernel.org>
    Tested-by: Geliang Tang <geliang@kernel.org>

Thanks,
-Geliang

> ---
>  tools/testing/selftests/net/mptcp/mptcp_join.sh | 23
> +++++++++++++++++++----
>  1 file changed, 19 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index 1af96a63516c..0b084c502122 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -335,6 +335,23 @@ reset_check_counter()
>  	fi
>  }
>  
> +# $1: test name ; $2: counter to check
> +reset_fastclose()
> +{
> +	reset_check_counter "${1}" "${2}" || return 1
> +
> +	local netns
> +	for netns in "$ns1" "$ns2"; do
> +		# Drop "plain" RST sent because the connection is
> closed
> +		if ! ip netns exec "${netns}" "${iptables}" -A
> OUTPUT -p tcp \
> +				--tcp-flags ALL RST \
> +				-j DROP; then
> +			mark_as_skipped "unable to set the
> 'fastclose' rule"
> +			return 1
> +		fi
> +	done
> +}
> +
>  # $1: test name
>  reset_with_cookies()
>  {
> @@ -3650,8 +3667,7 @@ fullmesh_tests()
>  
>  fastclose_tests()
>  {
> -	if reset_check_counter "fastclose test"
> "MPTcpExtMPFastcloseTx"; then
> -		MPTCP_LIB_SUBTEST_FLAKY=1
> +	if reset_fastclose "fastclose test" "MPTcpExtMPFastcloseTx";
> then
>  		test_linkfail=1024 fastclose=client \
>  			run_tests $ns1 $ns2 10.0.1.1
>  		chk_join_nr 0 0 0
> @@ -3659,8 +3675,7 @@ fastclose_tests()
>  		chk_rst_nr 1 1 invert
>  	fi
>  
> -	if reset_check_counter "fastclose server test"
> "MPTcpExtMPFastcloseRx"; then
> -		MPTCP_LIB_SUBTEST_FLAKY=1
> +	if reset_fastclose "fastclose server test"
> "MPTcpExtMPFastcloseRx"; then
>  		test_linkfail=1024 fastclose=server \
>  			run_tests $ns1 $ns2 10.0.1.1
>  		join_rst_nr=1 \
> 

