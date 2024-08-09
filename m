Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073E8125BA
	for <mptcp@lists.linux.dev>; Fri,  9 Aug 2024 02:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723169448; cv=none; b=JYUkwGrd/+cA4xJEGkB4sl6iGa3Nm5Jl9//8Jt7Jy3lOsEelhtya2KLoqLCq/MRtjAj/8rlCrF6mgFOejQ0GP1rpFWGyIfJCaBrjXprj5QIXhDgw0axA3xXfrY3sfhzINydVtRN196ZuEGigf39LKAqaYc5XTfo7Ki8HsbMmrWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723169448; c=relaxed/simple;
	bh=Ut7R3UEovssCeLbIveY+QMigTCo+0RbvLegFtRYIz38=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ueXgrt4PcUL+WOuAT7NkspQQvIUCvLiL1sSU9Cx7KLwYEXbxIWqX4+KRdv08PTdqlVC1gBpqhyPn5MDA/d8cp9vR/rzex75WJdfhurzVvR+v3vCdR3og7gpNDvvq2Z/6JZluT+LzdWkljbrf+G7eZzxy8FFokTH0JeXB0hhg8F8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sXLVFKyP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sXLVFKyP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5F72C32782;
	Fri,  9 Aug 2024 02:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723169447;
	bh=Ut7R3UEovssCeLbIveY+QMigTCo+0RbvLegFtRYIz38=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=sXLVFKyPo/K7kz1sV0pdG3zjSVov2rjoWmSIufuynAtxfeC3v8WLIlfGWgB/YsEah
	 nSGbAWYQe+zO3o+hsdlGUrSqGqhUgm2GNRNt30JgvcoSWHAWI5RO93TkJe2cmlYEsk
	 EqYl632pAyPUWAAY7pVPfA/s50u3dgFW1p8wNuKCPhVeANTuvPc6PXgGJmFVgSmtRk
	 W2NYdqM5mpEndR4hCnJLllTnG2A3gNVNdkIPR7bfPrfE3/rd2RRMe08f2YuUFe6iOi
	 9/juhhdsHkNYiA4YtNhOr3M/DN2KLzuGf6Ce22wLQO38KNYr+OMG3e9zVEeTzVztRX
	 k8POCc5FJNMsg==
Message-ID: <ffcd94a0d7154a93d6405c0402b0d01a015603b9.camel@kernel.org>
Subject: Re: [PATCH mptcp-next v3 4/8] selftests: mptcp: join: one line for
 join check
From: Geliang Tang <geliang@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, mptcp@lists.linux.dev
Date: Fri, 09 Aug 2024 10:10:41 +0800
In-Reply-To: <20240806-mptcp-join-tx-mib-v3-4-c3b54d2099e9@kernel.org>
References: <20240806-mptcp-join-tx-mib-v3-0-c3b54d2099e9@kernel.org>
	 <20240806-mptcp-join-tx-mib-v3-4-c3b54d2099e9@kernel.org>
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
> Most tests are checking if the expected number of SYN/SYN+ACK/ACK
> JOINs
> have been received, each of them on one line.
> 
> More Join related tests are going to be checked soon, no need to add
> 5
> new lines per test in case of success, just one is enough. In case of
> issue, the errors will still be reported like before.
> 
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
>  tools/testing/selftests/net/mptcp/mptcp_join.sh | 45
> ++++++++++++++++---------
>  1 file changed, 30 insertions(+), 15 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index 0401ba1aaf1b..b10bcb1ac970 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -202,6 +202,22 @@ print_skip()
>  	mptcp_lib_pr_skip "${@}"
>  }
>  
> +# $1: check name; $2: rc
> +print_results()
> +{
> +	local check="${1}"
> +	local rc=${2}
> +
> +	print_check "${check}"
> +	if [ ${rc} = ${KSFT_PASS} ]; then
> +		print_ok
> +	elif [ ${rc} = ${KSFT_SKIP} ]; then
> +		print_skip
> +	else
> +		fail_test

To align error messages, it's better to pass an empty string to
fail_test to make sure an "EOL" is printed out:

		fail_test ""

001 no JOIN
      syn rx                 [FAIL] got 0 JOIN[s] syn rx expected 1
      synack rx              [FAIL] got 0 JOIN[s] synack rx expected 1
      ack rx                 [FAIL] got 0 JOIN[s] ack rx expected 1
      join Rx                syn tx                              [FAIL]
got 0 JOIN[s] syn tx expected 1
      join Tx                002 single subflow, limited by client
      join Rx                             [ OK ]
      join Tx                             [ OK ]

->

001 no JOIN
      syn rx                 [FAIL] got 0 JOIN[s] syn rx 
      synack rx              [FAIL] got 0 JOIN[s] synack rx expected 1
      ack rx                 [FAIL] got 0 JOIN[s] ack rx expected 1
      join Rx                [FAIL]
      syn tx                 [FAIL] got 0 JOIN[s] syn tx expected 1
      join Tx                [FAIL]
002 single subflow, limited by client

WDYT?

Regards,
-Geliang

> +	fi
> +}
> +
>  # [ $1: fail msg ]
>  mark_as_skipped()
>  {
> @@ -1326,6 +1342,7 @@ chk_join_nr()
>  	local rst_nr=${join_rst_nr:-0}
>  	local infi_nr=${join_infi_nr:-0}
>  	local corrupted_pkts=${join_corrupted_pkts:-0}
> +	local rc=${KSFT_PASS}
>  	local count
>  	local with_cookie
>  
> @@ -1333,43 +1350,41 @@ chk_join_nr()
>  		print_info "${corrupted_pkts} corrupted pkts"
>  	fi
>  
> -	print_check "syn"
>  	count=$(mptcp_lib_get_counter ${ns1} "MPTcpExtMPJoinSynRx")
>  	if [ -z "$count" ]; then
> -		print_skip
> +		rc=${KSFT_SKIP}
>  	elif [ "$count" != "$syn_nr" ]; then
> +		rc=${KSFT_FAIL}
> +		print_check "syn"
>  		fail_test "got $count JOIN[s] syn expected $syn_nr"
> -	else
> -		print_ok
>  	fi
>  
> -	print_check "synack"
>  	with_cookie=$(ip netns exec $ns2 sysctl -n
> net.ipv4.tcp_syncookies)
>  	count=$(mptcp_lib_get_counter ${ns2}
> "MPTcpExtMPJoinSynAckRx")
>  	if [ -z "$count" ]; then
> -		print_skip
> +		rc=${KSFT_SKIP}
>  	elif [ "$count" != "$syn_ack_nr" ]; then
>  		# simult connections exceeding the limit with cookie
> enabled could go up to
>  		# synack validation as the conn limit can be
> enforced reliably only after
>  		# the subflow creation
> -		if [ "$with_cookie" = 2 ] && [ "$count" -gt
> "$syn_ack_nr" ] && [ "$count" -le "$syn_nr" ]; then
> -			print_ok
> -		else
> +		if [ "$with_cookie" != 2 ] || [ "$count" -le
> "$syn_ack_nr" ] || [ "$count" -gt "$syn_nr" ]; then
> +			rc=${KSFT_FAIL}
> +			print_check "synack"
>  			fail_test "got $count JOIN[s] synack
> expected $syn_ack_nr"
>  		fi
> -	else
> -		print_ok
>  	fi
>  
> -	print_check "ack"
>  	count=$(mptcp_lib_get_counter ${ns1} "MPTcpExtMPJoinAckRx")
>  	if [ -z "$count" ]; then
> -		print_skip
> +		rc=${KSFT_SKIP}
>  	elif [ "$count" != "$ack_nr" ]; then
> +		rc=${KSFT_FAIL}
> +		print_check "ack"
>  		fail_test "got $count JOIN[s] ack expected $ack_nr"
> -	else
> -		print_ok
>  	fi
> +
> +	print_results "join Rx" ${rc}
> +
>  	if $validate_checksum; then
>  		chk_csum_nr $csum_ns1 $csum_ns2
>  		chk_fail_nr $fail_nr $fail_nr
> 

