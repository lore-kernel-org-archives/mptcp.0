Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA9BE2F1FF7
	for <mptcp@lists.linux.dev>; Thu,  4 Sep 2025 09:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756977995; cv=none; b=s5MYpZ71veTpK4xT3Kf/EUoSgxX0hW/+fFDu9wIa7I5mHqmgQklPlTfLcYfBBudq0yB0tfn3Gp4aUNLQW5ug5YXM0Z4MrETYBA+qfRHJiHsw57lgq2zX6OaY6v+47zbRFuMOn7BiWiLPu1oRJmLoHfyGTv2XFsUoh+QLyK3flak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756977995; c=relaxed/simple;
	bh=HfyqB4Lu5aa6IYQp84qjyHhMf2npd+xxg5VN3Iv3IHg=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AuEMyks0FrMsT2XeGgC6dNPm5PPYUpeg291EpYtxgcMASFR+KJsa8DCk5YsxcxwMvgDm8xMUVOFuoXL+C78xkc6lzJ1sfvSafccyJ+176jSv1rAt/tl1EDXiJLplS09PL1srZFEr7skiqbKPYoWagpiDFSncmoVnQAVJXeW8G0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EnDWbHMX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EnDWbHMX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCB8BC4CEF0;
	Thu,  4 Sep 2025 09:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756977995;
	bh=HfyqB4Lu5aa6IYQp84qjyHhMf2npd+xxg5VN3Iv3IHg=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=EnDWbHMXO9d8VuyPai5a/ec7ncUjzq4brwt0X/2ZdYmJdUsJPXDSRrbgnaxbOXF7B
	 camWrMvuKx88JSir896sjcKSni4aFv1qNTjgEvSmkjrVJIEGpiPvMCBBL18ubkdG5Q
	 Xbcvzz+7eeVyVpzs+ojPTHvlb8llqcL3UkhW55wVEdPlxvsz6Vsu54fz8O/LTPQRZt
	 XzO0eaPADAPPFaAu/25JrHjaJritdnmj9lipwLQkb6GMDbUpTg84bUFgBrkLLPT6PB
	 bXbYCZtdCOuGI5icv1aMsBUjYcv3VNlw4OHvW6KcYycibj8m3jJlZyr1KdSLtOprek
	 6+9bRi6xSo07A==
Message-ID: <c598db197820b4452342d913f9cfc1554ab128ab.camel@kernel.org>
Subject: Re: [PATCH mptcp-next 2/3] selftests: mptcp: join: tolerate more
 ADD_ADDR
From: Geliang Tang <geliang@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, mptcp@lists.linux.dev
Date: Thu, 04 Sep 2025 17:26:25 +0800
In-Reply-To: <20250902-sft-mptcp-join-add_addr-no-retrans-v1-2-956a315d6a5a@kernel.org>
References: 
	<20250902-sft-mptcp-join-add_addr-no-retrans-v1-0-956a315d6a5a@kernel.org>
	 <20250902-sft-mptcp-join-add_addr-no-retrans-v1-2-956a315d6a5a@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.0-1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Matt,

On Tue, 2025-09-02 at 21:01 +0200, Matthieu Baerts (NGI0) wrote:
> ADD_ADDR can be retransmitted, and with, the parent commit, these
> retransmissions can be sent quicker: from 2 minutes to less than one
> second.
> 
> To avoid false positives where retransmitted ADD_ADDR causes higher
> counters than expected, it is required to be more tolerant. Errors
> are
> now only reported when fewer ADD_ADDRs have been sent/received.
> 
> An alternative could be to disable the ADD_ADDR retransmissions by
> default, but that's changing the default kernel behaviour. Plus,
> ADD_ADDR retransmissions can be required for some tests. To avoid
> adding
> exceptions to a few tests, it seems better to increase the tolerance.

I think adding "tolerate more ADD_ADDR" to the two general helpers
chk_add_nr() and chk_add_tx_nr() is not very accurate, because we don't
know which test sends/receives more ADD_ADDR. Because chk_add_nr() and
chk_add_tx_nr() of most tests are normal, only a few tests will be
affected and need to add "tolerate".

I think it can be handled like chk_csum_nr(), accepting a number with
"+", such as "+2" to allow more than two ADD_ADDR. In this way, we only
need to add this "+" to a few failed tests, so the control is more
accurate. What do you think?

Thanks,
-Geliang

> 
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
>  tools/testing/selftests/net/mptcp/mptcp_join.sh | 21 +++++++--------
> ------
>  1 file changed, 7 insertions(+), 14 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index
> 2f046167a0b6cc6fb5531a033d8d95c9ea399cf9..1028f3f931612d98e828707a9f5
> 5caa69be4a6ca 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -358,6 +358,7 @@ reset_with_add_addr_timeout()
>  		tables="${ip6tables}"
>  	fi
>  
> +	# set a maximum, to avoid too long timeout with exponential
> backoff
>  	ip netns exec $ns1 sysctl -q net.mptcp.add_addr_timeout=1
>  
>  	if ! ip netns exec $ns2 $tables -A OUTPUT -p tcp \
> @@ -1669,7 +1670,6 @@ chk_add_nr()
>  	local tx=""
>  	local rx=""
>  	local count
> -	local timeout
>  
>  	if [[ $ns_invert = "invert" ]]; then
>  		ns_tx=$ns2
> @@ -1678,16 +1678,13 @@ chk_add_nr()
>  		rx=" server"
>  	fi
>  
> -	timeout=$(ip netns exec ${ns_tx} sysctl -n
> net.mptcp.add_addr_timeout)
> -
>  	print_check "add addr rx${rx}"
>  	count=$(mptcp_lib_get_counter ${ns_rx} "MPTcpExtAddAddr")
>  	if [ -z "$count" ]; then
>  		print_skip
> -	# if the test configured a short timeout tolerate greater
> then expected
> -	# add addrs options, due to retransmissions
> -	elif [ "$count" != "$add_nr" ] && { [ "$timeout" -gt 1 ] ||
> [ "$count" -lt "$add_nr" ]; }; then
> -		fail_test "got $count ADD_ADDR[s] expected $add_nr"
> +	# Tolerate more ADD_ADDR then expected, due to
> retransmissions
> +	elif [ "$count" -lt "$add_nr" ]; then
> +		fail_test "got $count ADD_ADDR[s] expected $add_nr
> or more"
>  	else
>  		print_ok
>  	fi
> @@ -1774,19 +1771,15 @@ chk_add_tx_nr()
>  {
>  	local add_tx_nr=$1
>  	local echo_tx_nr=$2
> -	local timeout
>  	local count
>  
> -	timeout=$(ip netns exec $ns1 sysctl -n
> net.mptcp.add_addr_timeout)
> -
>  	print_check "add addr tx"
>  	count=$(mptcp_lib_get_counter ${ns1} "MPTcpExtAddAddrTx")
>  	if [ -z "$count" ]; then
>  		print_skip
> -	# if the test configured a short timeout tolerate greater
> then expected
> -	# add addrs options, due to retransmissions
> -	elif [ "$count" != "$add_tx_nr" ] && { [ "$timeout" -gt 1 ]
> || [ "$count" -lt "$add_tx_nr" ]; }; then
> -		fail_test "got $count ADD_ADDR[s] TX, expected
> $add_tx_nr"
> +	# Tolerate more ADD_ADDR then expected, due to
> retransmissions
> +	elif [ "$count" -lt "$add_tx_nr" ]; then
> +		fail_test "got $count ADD_ADDR[s] TX, expected
> $add_tx_nr or more"
>  	else
>  		print_ok
>  	fi
