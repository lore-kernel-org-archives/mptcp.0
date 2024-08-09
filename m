Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E5A6C8C7
	for <mptcp@lists.linux.dev>; Fri,  9 Aug 2024 02:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723170120; cv=none; b=QgPgDJ7OkI8Vg+tT9szc/MqwKq+I7GHmkVeBF0Nk73vfDwh7H6zL1IcGrT9wABNLfjdrCI599jVp6/wI//FPZxXB80kVsZRBvlufzDlg54YpyHiR1d6KtvmzsMpG4nLcYgprI8uRi9PAxpSCUR/VOr1tB4JLF5DOdflRvVKjcPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723170120; c=relaxed/simple;
	bh=Q0Z8i4OKBuHm+ibWVzT0956W/G9zrdYZU62htDbPxDk=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sa0O/R69UckvASJajiY+Kyqh1f0UTphFJk77451P6v2F4uw2hTq0uDOujWmG1RxW3ZcU0EzmEx1BOBQJJ1xdCUuRYfNyoso1QPkDUniEztnTCX1VgNjvSqUC7EHBi78zSWWZuoZYZbYdYlG9z5yzjkUFLte+o+dlwsIMBLyTxg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X2GZL6JJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X2GZL6JJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEF93C32782;
	Fri,  9 Aug 2024 02:21:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723170119;
	bh=Q0Z8i4OKBuHm+ibWVzT0956W/G9zrdYZU62htDbPxDk=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=X2GZL6JJG3mT8cNqYc4k9bDhxV3JPE4dHaydYcK4nx1+gIequzzwSZ3jGyvA92qgB
	 uSvHMtSgHo3bd7Ds6Ogirl0cBjQRB2U+vZJy8iVoC2XQgPwxdE6DqclX/NaAELSz2J
	 Fvdo6605iO8E4GGJHqMG1FwfLiFJCvq3OdcSuh+uGs9//D4nkTfr7QwOeFDVn2LuUx
	 J7olYj/cUu+IIYhItHQ2/McXUSYjkxk6TvAxloa43Rp0mFt4Ey3ETlmb0Tb9tO1yPD
	 TI8sVT6VyU0FlDxWffApGt9L+tRcl7G/7nk3sTTi32pjRP2hjUkkvr1dNKmVNq6ldT
	 ZiAue+iWCNtPQ==
Message-ID: <e2fc22b0217c36fa516a4926994ae171f97fec38.camel@kernel.org>
Subject: Re: [PATCH mptcp-next v3 5/8] selftests: mptcp: join: validate MPJ
 SYN TX MIB counters
From: Geliang Tang <geliang@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, mptcp@lists.linux.dev
Date: Fri, 09 Aug 2024 10:21:55 +0800
In-Reply-To: <20240806-mptcp-join-tx-mib-v3-5-c3b54d2099e9@kernel.org>
References: <20240806-mptcp-join-tx-mib-v3-0-c3b54d2099e9@kernel.org>
	 <20240806-mptcp-join-tx-mib-v3-5-c3b54d2099e9@kernel.org>
Autocrypt: addr=geliang@kernel.org; prefer-encrypt=mutual;
 keydata=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
 Px+2P2cKc7LXXedb/qQ3M
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 2024-08-06 at 13:18 +0200, Matthieu Baerts (NGI0) wrote:
> A few new MPJoinSynTx MIB counters have been added in a previous
> commit.
> They are being validated here in mptcp_join.sh selftest, each time
> the
> number of received MPJ are checked.
> 
> Most of the time, the number of sent SYN+MPJ is the same as the
> received
> ones. But sometimes, there are more, because there are dropped, or
> there
> are errors.
> 
> While at it, the "no MPC reuse with single endpoint" subtest has been
> modified to force a bind() error.
> 
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
> Notes:
>   - v3:
>     - Force a bind error (Geliang)
>     - Validate join tx with rx ones. (Geliang)
> ---
>  tools/testing/selftests/net/mptcp/mptcp_join.sh | 84
> +++++++++++++++++++++----
>  1 file changed, 73 insertions(+), 11 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index b10bcb1ac970..23ea8acb7a36 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -1331,6 +1331,54 @@ chk_infi_nr()
>  	fi
>  }
>  
> +chk_join_tx_nr()
> +{
> +	local syn_tx=${join_syn_tx:-${syn_nr}}

syn_nr is only a local variable of chk_join_nr(), does this limit that
this chk_join_tx_nr() can only be called in chk_join_nr()? I think it
is necessary to break this limit. WDYT?

> +	local create=${join_create_err:-0}
> +	local bind=${join_bind_err:-0}
> +	local connect=${join_connect_err:-0}
> +	local rc=${KSFT_PASS}
> +	local count
> +
> +	count=$(mptcp_lib_get_counter ${ns2} "MPTcpExtMPJoinSynTx")
> +	if [ -z "$count" ]; then
> +		rc=${KSFT_SKIP}
> +	elif [ "$count" != "$syn_tx" ]; then
> +		rc=${KSFT_FAIL}
> +		print_check "syn tx"
> +		fail_test "got $count JOIN[s] syn tx expected
> $syn_tx"
> +	fi
> +
> +	count=$(mptcp_lib_get_counter ${ns2}
> "MPTcpExtMPJoinSynTxCreatSkErr")
> +	if [ -z "$count" ]; then
> +		rc=${KSFT_SKIP}
> +	elif [ "$count" != "$create" ]; then
> +		rc=${KSFT_FAIL}
> +		print_check "syn tx create socket error"
> +		fail_test "got $count JOIN[s] syn tx create socket
> error expected $create"
> +	fi
> +
> +	count=$(mptcp_lib_get_counter ${ns2}
> "MPTcpExtMPJoinSynTxBindErr")
> +	if [ -z "$count" ]; then
> +		rc=${KSFT_SKIP}
> +	elif [ "$count" != "$bind" ]; then
> +		rc=${KSFT_FAIL}
> +		print_check "syn tx bind error"
> +		fail_test "got $count JOIN[s] syn tx bind error
> expected $bind"
> +	fi
> +
> +	count=$(mptcp_lib_get_counter ${ns2}
> "MPTcpExtMPJoinSynTxConnectErr")
> +	if [ -z "$count" ]; then
> +		rc=${KSFT_SKIP}
> +	elif [ "$count" != "$connect" ]; then
> +		rc=${KSFT_FAIL}
> +		print_check "syn tx connect error"
> +		fail_test "got $count JOIN[s] syn tx connect error
> expected $connect"
> +	fi
> +
> +	print_results "join Tx" ${rc}
> +}
> +
>  chk_join_nr()
>  {
>  	local syn_nr=$1
> @@ -1385,6 +1433,8 @@ chk_join_nr()
>  
>  	print_results "join Rx" ${rc}
>  
> +	chk_join_tx_nr
> +
>  	if $validate_checksum; then
>  		chk_csum_nr $csum_ns1 $csum_ns2
>  		chk_fail_nr $fail_nr $fail_nr
> @@ -1925,9 +1975,11 @@ subflows_error_tests()
>  		pm_nl_set_limits $ns1 0 1
>  		pm_nl_set_limits $ns2 0 1
>  		pm_nl_add_endpoint $ns2 10.0.1.2 flags subflow
> +		pm_nl_add_endpoint $ns2 10.0.12.2 flags subflow
>  		speed=slow \
>  			run_tests $ns1 $ns2 10.0.1.1
> -		chk_join_nr 0 0 0
> +		join_bind_err=1 \
> +			chk_join_nr 0 0 0
>  	fi
>  
>  	# multiple subflows, with subflow creation error
> @@ -1939,7 +1991,8 @@ subflows_error_tests()
>  		pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow
>  		speed=slow \
>  			run_tests $ns1 $ns2 10.0.1.1
> -		chk_join_nr 1 1 1
> +		join_syn_tx=2 \
> +			chk_join_nr 1 1 1
>  	fi
>  
>  	# multiple subflows, with subflow timeout on MPJ
> @@ -1951,7 +2004,8 @@ subflows_error_tests()
>  		pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow
>  		speed=slow \
>  			run_tests $ns1 $ns2 10.0.1.1
> -		chk_join_nr 1 1 1
> +		join_syn_tx=2 \
> +			chk_join_nr 1 1 1
>  	fi
>  
>  	# multiple subflows, check that the endpoint corresponding
> to
> @@ -1972,7 +2026,8 @@ subflows_error_tests()
>  
>  		# additional subflow could be created only if the PM
> select
>  		# the later endpoint, skipping the already used one
> -		chk_join_nr 1 1 1
> +		join_syn_tx=2 \
> +			chk_join_nr 1 1 1
>  	fi
>  }
>  
> @@ -2058,7 +2113,8 @@ signal_address_tests()
>  		pm_nl_add_endpoint $ns1 10.0.14.1 flags signal
>  		pm_nl_set_limits $ns2 3 3
>  		run_tests $ns1 $ns2 10.0.1.1
> -		chk_join_nr 1 1 1
> +		join_syn_tx=3 \
> +			chk_join_nr 1 1 1
>  		chk_add_nr 3 3
>  	fi
>  
> @@ -2226,7 +2282,8 @@ add_addr_timeout_tests()
>  		pm_nl_set_limits $ns2 2 2
>  		speed=10 \
>  			run_tests $ns1 $ns2 10.0.1.1
> -		chk_join_nr 1 1 1
> +		join_syn_tx=2 \
> +			chk_join_nr 1 1 1
>  		chk_add_nr 8 0
>  	fi
>  }
> @@ -2326,7 +2383,8 @@ remove_tests()
>  		pm_nl_set_limits $ns2 2 2
>  		addr_nr_ns1=-3 speed=10 \
>  			run_tests $ns1 $ns2 10.0.1.1
> -		chk_join_nr 1 1 1
> +		join_syn_tx=2 join_connect_err=1 \
> +			chk_join_nr 1 1 1
>  		chk_add_nr 3 3
>  		chk_rm_nr 3 1 invert
>  		chk_rst_nr 0 0
> @@ -2391,7 +2449,8 @@ remove_tests()
>  		pm_nl_set_limits $ns2 3 3
>  		addr_nr_ns1=-8 speed=slow \
>  			run_tests $ns1 $ns2 10.0.1.1
> -		chk_join_nr 1 1 1
> +		join_syn_tx=3 \
> +			chk_join_nr 1 1 1
>  		chk_add_nr 3 3
>  		chk_rm_nr 3 1 invert
>  		chk_rst_nr 0 0
> @@ -3619,7 +3678,8 @@ endpoint_tests()
>  
>  		mptcp_lib_kill_wait $tests_pid
>  
> -		chk_join_nr 3 3 3
> +		join_syn_tx=4 \
> +			chk_join_nr 3 3 3
>  		chk_rm_nr 1 1
>  	fi
>  
> @@ -3654,7 +3714,8 @@ endpoint_tests()
>  		chk_mptcp_info subflows 2 subflows 2
>  		mptcp_lib_kill_wait $tests_pid
>  
> -		chk_join_nr 3 3 3
> +		join_connect_err=1 \
> +			chk_join_nr 3 3 3
>  		chk_add_nr 4 4
>  		chk_rm_nr 2 1 invert
>  	fi
> @@ -3685,7 +3746,8 @@ endpoint_tests()
>  		wait_mpj $ns2
>  		mptcp_lib_kill_wait $tests_pid
>  
> -		chk_join_nr 2 2 2
> +		join_syn_tx=3 join_connect_err=1 \
> +			chk_join_nr 2 2 2
>  		chk_add_nr 2 2
>  		chk_rm_nr 1 0 invert
>  	fi
> 

