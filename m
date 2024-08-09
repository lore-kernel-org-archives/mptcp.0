Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D409D11CAF
	for <mptcp@lists.linux.dev>; Fri,  9 Aug 2024 02:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723168861; cv=none; b=OiZg7fCWM5PZ/kjurrae9oARHWMYIwlCxgT2hA1Ww0GvuyueaPspl+r9cvkKA66/OYFgFaHelVAn7L+Jlf8Kvke3HWx6Pfk8GFTD+fBTZ0Hinvn9aOKj7369F/dHLeYf0/beycei2zPSM0JHyxsRGq8uWxdGtPPIRPUCa/BViVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723168861; c=relaxed/simple;
	bh=Cs8TgGN+JGEN5VnZfL61ebsAq59VbeHt82shCtsBTBc=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Dd7muGUOSLWyzZv5ODMesX09O5UcTEcuwNv7AxsKEaKJ6T/pGPpXNYNceUONnNS6V3B2PxgEH0JcZlbEP/SsXxlGlSHm+6Ub2cgct1LIt3DjelWfZ4k1Kb4uADArC/YtM99RWPlL1Te/WgmQwQ8GfKs79tunK3tQ3CTuYAY0l1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I2Xgd1Hf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I2Xgd1Hf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87B7FC32782;
	Fri,  9 Aug 2024 02:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723168861;
	bh=Cs8TgGN+JGEN5VnZfL61ebsAq59VbeHt82shCtsBTBc=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=I2Xgd1HfDPOPp2y+CWDl2sesiYzswbGMTSV5So8bO4X/qp5DP6SjseqBik0GahjQW
	 TgrjI0o4RfXZGJkaq66pTPFOJHMdUs6lKjBaPNZlFOnc1pLPezLgkuWLFoRCrY4DMX
	 ZWtAv05QrY3OpL7t7J+S+QLdnq4tILjudbjz8y9WJu8s/L2zZw+qHN1g0i86O+Hj5O
	 cnFBW7ogDoSj4We0EBsyPnUlDn/T0DPdNofYt7gFDrXiL1+20ILzjOmub1tAe1ZufL
	 Vr5W2daW5Svi2gZ/CN8OI6H4MmPIwHr4fizF2gwi+AzIBt5chRiyXIY3kA7I8fPSRy
	 ujV3o6lTIVI6A==
Message-ID: <4a12b5efddb6f09308e0f442feac7ae613eaa28b.camel@kernel.org>
Subject: Re: [PATCH mptcp-next v3 6/8] selftests: mptcp: join: more explicit
 check name
From: Geliang Tang <geliang@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, mptcp@lists.linux.dev
Date: Fri, 09 Aug 2024 10:00:57 +0800
In-Reply-To: <20240806-mptcp-join-tx-mib-v3-6-c3b54d2099e9@kernel.org>
References: <20240806-mptcp-join-tx-mib-v3-0-c3b54d2099e9@kernel.org>
	 <20240806-mptcp-join-tx-mib-v3-6-c3b54d2099e9@kernel.org>
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
> Before, the check names had to be very short. It is no longer the
> case
> now that these checks are printed on a dedicated line.
> 
> Then, it looks better to have more explicit names.
> 
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
>  tools/testing/selftests/net/mptcp/mptcp_join.sh | 59 +++++++++++++--
> ----------
>  1 file changed, 30 insertions(+), 29 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index 23ea8acb7a36..46e8e43c4a54 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -856,7 +856,7 @@ chk_cestab_nr()
>  	local cestab=$2
>  	local count
>  
> -	print_check "cestab $cestab"
> +	print_check "currently established: $cestab"
>  	count=$(mptcp_lib_get_counter ${ns} "MPTcpExtMPCurrEstab")
>  	if [ -z "$count" ]; then
>  		print_skip
> @@ -1132,7 +1132,7 @@ chk_csum_nr()
>  		csum_ns2=${csum_ns2:1}
>  	fi
>  
> -	print_check "sum"
> +	print_check "checksum server"
>  	count=$(mptcp_lib_get_counter ${ns1} "MPTcpExtDataCsumErr")
>  	if [ -n "$count" ] && [ "$count" != "$csum_ns1" ]; then
>  		extra_msg+=" ns1=$count"
> @@ -1145,7 +1145,8 @@ chk_csum_nr()
>  	else
>  		print_ok
>  	fi
> -	print_check "csum"
> +
> +	print_check "checksum client"
>  	count=$(mptcp_lib_get_counter ${ns2} "MPTcpExtDataCsumErr")
>  	if [ -n "$count" ] && [ "$count" != "$csum_ns2" ]; then
>  		extra_msg+=" ns2=$count"
> @@ -1189,7 +1190,7 @@ chk_fail_nr()
>  		fail_rx=${fail_rx:1}
>  	fi
>  
> -	print_check "ftx"
> +	print_check "fail tx"
>  	count=$(mptcp_lib_get_counter ${ns_tx} "MPTcpExtMPFailTx")
>  	if [ -n "$count" ] && [ "$count" != "$fail_tx" ]; then
>  		extra_msg+=",tx=$count"
> @@ -1203,7 +1204,7 @@ chk_fail_nr()
>  		print_ok
>  	fi
>  
> -	print_check "failrx"
> +	print_check "fail rx"
>  	count=$(mptcp_lib_get_counter ${ns_rx} "MPTcpExtMPFailRx")
>  	if [ -n "$count" ] && [ "$count" != "$fail_rx" ]; then
>  		extra_msg+=",rx=$count"
> @@ -1236,7 +1237,7 @@ chk_fclose_nr()
>  		extra_msg="invert"
>  	fi
>  
> -	print_check "ctx"
> +	print_check "fast close tx"
>  	count=$(mptcp_lib_get_counter ${ns_tx}
> "MPTcpExtMPFastcloseTx")
>  	if [ -z "$count" ]; then
>  		print_skip
> @@ -1247,7 +1248,7 @@ chk_fclose_nr()
>  		print_ok
>  	fi
>  
> -	print_check "fclzrx"
> +	print_check "fast close rx"
>  	count=$(mptcp_lib_get_counter ${ns_rx}
> "MPTcpExtMPFastcloseRx")
>  	if [ -z "$count" ]; then
>  		print_skip
> @@ -1277,7 +1278,7 @@ chk_rst_nr()
>  		extra_msg="invert"
>  	fi
>  
> -	print_check "rtx"
> +	print_check "reset tx"
>  	count=$(mptcp_lib_get_counter ${ns_tx} "MPTcpExtMPRstTx")
>  	if [ -z "$count" ]; then
>  		print_skip
> @@ -1289,7 +1290,7 @@ chk_rst_nr()
>  		print_ok
>  	fi
>  
> -	print_check "rstrx"
> +	print_check "reset rx"
>  	count=$(mptcp_lib_get_counter ${ns_rx} "MPTcpExtMPRstRx")
>  	if [ -z "$count" ]; then
>  		print_skip
> @@ -1310,7 +1311,7 @@ chk_infi_nr()
>  	local infi_rx=$2
>  	local count
>  
> -	print_check "itx"
> +	print_check "infi tx"
>  	count=$(mptcp_lib_get_counter ${ns2}
> "MPTcpExtInfiniteMapTx")
>  	if [ -z "$count" ]; then
>  		print_skip
> @@ -1320,7 +1321,7 @@ chk_infi_nr()
>  		print_ok
>  	fi
>  
> -	print_check "infirx"
> +	print_check "infi rx"
>  	count=$(mptcp_lib_get_counter ${ns1}
> "MPTcpExtInfiniteMapRx")
>  	if [ -z "$count" ]; then
>  		print_skip
> @@ -1403,7 +1404,7 @@ chk_join_nr()
>  		rc=${KSFT_SKIP}
>  	elif [ "$count" != "$syn_nr" ]; then
>  		rc=${KSFT_FAIL}
> -		print_check "syn"
> +		print_check "syn rx"
>  		fail_test "got $count JOIN[s] syn expected $syn_nr"

I think it's better to update fail_test messages too:

		fail_test "got $count JOIN[s] syn rx expected $syn_nr"

>  	fi
>  
> @@ -1417,7 +1418,7 @@ chk_join_nr()
>  		# the subflow creation
>  		if [ "$with_cookie" != 2 ] || [ "$count" -le
> "$syn_ack_nr" ] || [ "$count" -gt "$syn_nr" ]; then
>  			rc=${KSFT_FAIL}
> -			print_check "synack"
> +			print_check "synack rx"
>  			fail_test "got $count JOIN[s] synack
> expected $syn_ack_nr"

Same here:

	fail_test "got $count JOIN[s] synack rx expected $syn_ack_nr"

>  		fi
>  	fi
> @@ -1427,7 +1428,7 @@ chk_join_nr()
>  		rc=${KSFT_SKIP}
>  	elif [ "$count" != "$ack_nr" ]; then
>  		rc=${KSFT_FAIL}
> -		print_check "ack"
> +		print_check "ack rx"
>  		fail_test "got $count JOIN[s] ack expected $ack_nr"

And here:

		fail_test "got $count JOIN[s] ack rx expected $ack_nr"

>  	fi
>  
> @@ -1507,7 +1508,7 @@ chk_add_nr()
>  
>  	timeout=$(ip netns exec ${ns_tx} sysctl -n
> net.mptcp.add_addr_timeout)
>  
> -	print_check "add"
> +	print_check "add addr rx"
>  	count=$(mptcp_lib_get_counter ${ns_rx} "MPTcpExtAddAddr")
>  	if [ -z "$count" ]; then
>  		print_skip
> @@ -1519,7 +1520,7 @@ chk_add_nr()
>  		print_ok
>  	fi
>  
> -	print_check "echo"
> +	print_check "add addr echo rx"
>  	count=$(mptcp_lib_get_counter ${ns_tx} "MPTcpExtEchoAdd")
>  	if [ -z "$count" ]; then
>  		print_skip
> @@ -1530,7 +1531,7 @@ chk_add_nr()
>  	fi
>  
>  	if [ $port_nr -gt 0 ]; then
> -		print_check "pt"
> +		print_check "add addr rx with port"
>  		count=$(mptcp_lib_get_counter ${ns_rx}
> "MPTcpExtPortAdd")
>  		if [ -z "$count" ]; then
>  			print_skip
> @@ -1540,7 +1541,7 @@ chk_add_nr()
>  			print_ok
>  		fi
>  
> -		print_check "syn"
> +		print_check "syn rx port"
>  		count=$(mptcp_lib_get_counter ${ns_tx}
> "MPTcpExtMPJoinPortSynRx")
>  		if [ -z "$count" ]; then
>  			print_skip
> @@ -1551,7 +1552,7 @@ chk_add_nr()
>  			print_ok
>  		fi
>  
> -		print_check "synack"
> +		print_check "synack rx port"
>  		count=$(mptcp_lib_get_counter ${ns_rx}
> "MPTcpExtMPJoinPortSynAckRx")
>  		if [ -z "$count" ]; then
>  			print_skip
> @@ -1562,7 +1563,7 @@ chk_add_nr()
>  			print_ok
>  		fi
>  
> -		print_check "ack"
> +		print_check "ack rx port"
>  		count=$(mptcp_lib_get_counter ${ns_tx}
> "MPTcpExtMPJoinPortAckRx")
>  		if [ -z "$count" ]; then
>  			print_skip
> @@ -1573,7 +1574,7 @@ chk_add_nr()
>  			print_ok
>  		fi
>  
> -		print_check "syn"
> +		print_check "syn rx port mismatch"
>  		count=$(mptcp_lib_get_counter ${ns_tx}
> "MPTcpExtMismatchPortSynRx")
>  		if [ -z "$count" ]; then
>  			print_skip
> @@ -1584,7 +1585,7 @@ chk_add_nr()
>  			print_ok
>  		fi
>  
> -		print_check "ack"
> +		print_check "ack rx port mismatch"
>  		count=$(mptcp_lib_get_counter ${ns_tx}
> "MPTcpExtMismatchPortAckRx")
>  		if [ -z "$count" ]; then
>  			print_skip
> @@ -1608,7 +1609,7 @@ chk_add_tx_nr()
>  
>  	timeout=$(ip netns exec $ns1 sysctl -n
> net.mptcp.add_addr_timeout)
>  
> -	print_check "add TX"
> +	print_check "add addr tx"
>  	count=$(mptcp_lib_get_counter ${ns1} "MPTcpExtAddAddrTx")
>  	if [ -z "$count" ]; then
>  		print_skip
> @@ -1620,7 +1621,7 @@ chk_add_tx_nr()
>  		print_ok
>  	fi
>  
> -	print_check "echo TX"
> +	print_check "add addr echo tx"
>  	count=$(mptcp_lib_get_counter ${ns2} "MPTcpExtEchoAddTx")
>  	if [ -z "$count" ]; then
>  		print_skip
> @@ -1658,7 +1659,7 @@ chk_rm_nr()
>  		extra_msg="invert"
>  	fi
>  
> -	print_check "rm"
> +	print_check "rm addr rx"
>  	count=$(mptcp_lib_get_counter ${addr_ns} "MPTcpExtRmAddr")
>  	if [ -z "$count" ]; then
>  		print_skip
> @@ -1668,7 +1669,7 @@ chk_rm_nr()
>  		print_ok
>  	fi
>  
> -	print_check "rmsf"
> +	print_check "rm subflow"
>  	count=$(mptcp_lib_get_counter ${subflow_ns}
> "MPTcpExtRmSubflow")
>  	if [ -z "$count" ]; then
>  		print_skip
> @@ -1703,7 +1704,7 @@ chk_rm_tx_nr()
>  {
>  	local rm_addr_tx_nr=$1
>  
> -	print_check "rm TX"
> +	print_check "rm addr tx"
>  	count=$(mptcp_lib_get_counter ${ns2} "MPTcpExtRmAddrTx")
>  	if [ -z "$count" ]; then
>  		print_skip
> @@ -1722,7 +1723,7 @@ chk_prio_nr()
>  	local mpj_syn_ack=$4
>  	local count
>  
> -	print_check "ptx"
> +	print_check "mp_prio tx"
>  	count=$(mptcp_lib_get_counter ${ns1} "MPTcpExtMPPrioTx")
>  	if [ -z "$count" ]; then
>  		print_skip
> @@ -1732,7 +1733,7 @@ chk_prio_nr()
>  		print_ok
>  	fi
>  
> -	print_check "prx"
> +	print_check "mp_prio rx"
>  	count=$(mptcp_lib_get_counter ${ns1} "MPTcpExtMPPrioRx")
>  	if [ -z "$count" ]; then
>  		print_skip
> 

