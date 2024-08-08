Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB431D554
	for <mptcp@lists.linux.dev>; Thu,  8 Aug 2024 02:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723084705; cv=none; b=lYy5GZV3wSWbqZ9IuI76EyMvb1n29pPaaCQqXyYGaUI3Pp5SoAguvwm+eYLNjSQMtvoI9VHSNOBDdnPIVdyAnvJcp9TJML6Z9k3/xymfuyxovJU/kkH84b/6wJPo60J6IdDDoX/FJzmaHF0msNjRtgDdHl57wM0Y35JdZZs2OBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723084705; c=relaxed/simple;
	bh=+N9V6uvTTwWS2pN/74XE6NVO+irJijBggwMFP/gP7zs=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bxqRVEfwN2ZVhOMPwiPAfJ2swU7i8vCXRQT2TTolrQjEL9OdY8OvXR/D+2NUUcSV1F6fvFmo1wewdrMSJGcEoxBix/ZKh3d5jvCcU55FUOlzGlYHKanGhbH7ReI4N/S1RMPFG+DgInx9k7HBUTWYh/dVb1Rrh3kkdgBIANDUUPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HzPvaUo4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HzPvaUo4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B65DC32781;
	Thu,  8 Aug 2024 02:38:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723084704;
	bh=+N9V6uvTTwWS2pN/74XE6NVO+irJijBggwMFP/gP7zs=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=HzPvaUo4zFltlGwB4tmkd4PBExs/JlsBxsfkszCkK5zXSLRJc44xWBgCjApAy51DH
	 z1/hrWGn1/pw7ZnpKS7WrPicj2gW6SJi/gKFDO3qSkQQTZCYdXrKV7GBcRyo6avEn3
	 V6eVVHKUDr79RW1dfon7XXRNPYf8Crd4T56rO6Sinoul8/CqbLPbqLdQB0iVeqcN5P
	 w5ffA3XJwLELbfWSrmeXzjrwaWLRPAj/lAa2QNk78iK+8AZZPHGdhE2toJcp01ERAl
	 XNqjJJ2xqdFW6nB71i+lIF6LsePFqJ4NJFcyPt56r+KeXNbc///5RiVK3apffLrQrV
	 +HYaPOsqPokXw==
Message-ID: <2c144f50dc8e6f92e1bd1569802ec75f362a9ec9.camel@kernel.org>
Subject: Re: [PATCH mptcp-next v3 1/8] selftests: mptcp: join: no extra msg
 if no counter
From: Geliang Tang <geliang@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, mptcp@lists.linux.dev
Date: Thu, 08 Aug 2024 10:38:19 +0800
In-Reply-To: <20240806-mptcp-join-tx-mib-v3-1-c3b54d2099e9@kernel.org>
References: <20240806-mptcp-join-tx-mib-v3-0-c3b54d2099e9@kernel.org>
	 <20240806-mptcp-join-tx-mib-v3-1-c3b54d2099e9@kernel.org>
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

Hi Matt,

Thanks for these patches.

On Tue, 2024-08-06 at 13:18 +0200, Matthieu Baerts (NGI0) wrote:
> The checksum and fail counters might not be available. Then no need
> to
> display an extra message with missing info.
> 
> While at it, fix the indentation around, which is wrong since the
> same
> commit.
> 
> Fixes: 47867f0a7e83 ("selftests: mptcp: join: skip check if MIB
> counter not supported")
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
>  tools/testing/selftests/net/mptcp/mptcp_join.sh | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index 01c1e0871aca..a1f80dac59a7 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -1112,7 +1112,7 @@ chk_csum_nr()
>  
>  	print_check "sum"
>  	count=$(mptcp_lib_get_counter ${ns1} "MPTcpExtDataCsumErr")
> -	if [ "$count" != "$csum_ns1" ]; then
> +	if [ -n "$count" ] && [ "$count" != "$csum_ns1" ]; then

We have checked [ -z "$count" ] in mptcp_lib_get_counter() already, so
I think no need to double check it here. Can we just let
mptcp_lib_get_counter() return "0" in this [ -z "$count" ] case, then
we can drop all these [ -n "$count" ] or [ -z "$count" ] (like in
chk_cestab_nr()) checks after mptcp_lib_get_counter()? WDYT?

Regards,
-Geliang

>  		extra_msg+=" ns1=$count"
>  	fi
>  	if [ -z "$count" ]; then
> @@ -1125,7 +1125,7 @@ chk_csum_nr()
>  	fi
>  	print_check "csum"
>  	count=$(mptcp_lib_get_counter ${ns2} "MPTcpExtDataCsumErr")
> -	if [ "$count" != "$csum_ns2" ]; then
> +	if [ -n "$count" ] && [ "$count" != "$csum_ns2" ]; then
>  		extra_msg+=" ns2=$count"
>  	fi
>  	if [ -z "$count" ]; then
> @@ -1169,13 +1169,13 @@ chk_fail_nr()
>  
>  	print_check "ftx"
>  	count=$(mptcp_lib_get_counter ${ns_tx} "MPTcpExtMPFailTx")
> -	if [ "$count" != "$fail_tx" ]; then
> +	if [ -n "$count" ] && [ "$count" != "$fail_tx" ]; then
>  		extra_msg+=",tx=$count"
>  	fi
>  	if [ -z "$count" ]; then
>  		print_skip
>  	elif { [ "$count" != "$fail_tx" ] && [ $allow_tx_lost -eq 0
> ]; } ||
> -	   { [ "$count" -gt "$fail_tx" ] && [ $allow_tx_lost -eq 1
> ]; }; then
> +	     { [ "$count" -gt "$fail_tx" ] && [ $allow_tx_lost -eq 1
> ]; }; then
>  		fail_test "got $count MP_FAIL[s] TX expected
> $fail_tx"
>  	else
>  		print_ok
> @@ -1183,13 +1183,13 @@ chk_fail_nr()
>  
>  	print_check "failrx"
>  	count=$(mptcp_lib_get_counter ${ns_rx} "MPTcpExtMPFailRx")
> -	if [ "$count" != "$fail_rx" ]; then
> +	if [ -n "$count" ] && [ "$count" != "$fail_rx" ]; then
>  		extra_msg+=",rx=$count"
>  	fi
>  	if [ -z "$count" ]; then
>  		print_skip
>  	elif { [ "$count" != "$fail_rx" ] && [ $allow_rx_lost -eq 0
> ]; } ||
> -	   { [ "$count" -gt "$fail_rx" ] && [ $allow_rx_lost -eq 1
> ]; }; then
> +	     { [ "$count" -gt "$fail_rx" ] && [ $allow_rx_lost -eq 1
> ]; }; then
>  		fail_test "got $count MP_FAIL[s] RX expected
> $fail_rx"
>  	else
>  		print_ok
> 

