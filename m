Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E55F2110
	for <mptcp@lists.linux.dev>; Sun, 28 Dec 2025 03:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766891195; cv=none; b=IpgK9hlYEOSWzzml5kG6rWir0OqGxhNajc1vuZM0IYdP+s2Oo71PR60GpzcRvruaxWP6Ru563ZljFpmjZgDwSJAfvDHKVkGdNVyTBBs0Kif8BPxZaYtCYo9Tv7WCfqAD9OMjbKz68o6dkc02KRiRuQ1LA6XibYsmTvCcoZXovNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766891195; c=relaxed/simple;
	bh=RLW0gYQsMf1EboxhILpe2VTMP93N1Chid9qWYu+Rbxs=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UvfaLsKzHH5OvvfXXw7uBMHlXoCZ5K47XrCJHPzZQff1z6H32noCVvogMQ0yI4yjuOGKYphGFfGoPd+Q7hNN1O6GGYEMl0rV918/NOT5y4mV1WVhYYEw8ljJE38oTiqYjxYpMJPnAFY2UE/o5EW4JF050uMMaMj4uU0cRp0PWIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=awwCkoei; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="awwCkoei"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 239A8C116C6;
	Sun, 28 Dec 2025 03:06:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766891194;
	bh=RLW0gYQsMf1EboxhILpe2VTMP93N1Chid9qWYu+Rbxs=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=awwCkoeic6nOssPS2YR9Lg6uhkIl9kmx7xst+SIC08b850Ojq+XKoH5WfHYrznLVa
	 qXHP8oz745oX5oyfsbEaXOyBhtu/jnsMwqKmKM0t+OLDmtlf1cDcSpihKOjhsxq7Wt
	 ix/i8t1nMlKOvZoaBl3uNEPIkbr2YydDIF2rCzq84sbGbDmtZdlzoY9RnMmCh9wzAo
	 UM/10SXzB0ExKvbL9Q5QI8RGRFrNOMp8z/2x3teadUVHf4nLn+8QqRA3a8jZlypgpM
	 YDDe3bSu5d2K9WkMyXFo4MIEuscv6MiCKAHfIEdJn04xOvesHEqpDOSexOEsievtJp
	 ZSK1kvqfgFApA==
Message-ID: <c24cd268dc2f6797425e022a515776a006eaded6.camel@kernel.org>
Subject: Re: [PATCH mptcp-next] selftests: mptcp: join: no SKIP mark for
 group checks
From: Geliang Tang <geliang@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, MPTCP Upstream
	 <mptcp@lists.linux.dev>
Date: Sun, 28 Dec 2025 11:06:32 +0800
In-Reply-To: <20251211-sft-no-skip-new-cnt-v1-1-6dd6d70f8242@kernel.org>
References: <20251211-sft-no-skip-new-cnt-v1-1-6dd6d70f8242@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.2-4 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Matt,

Thanks for this patch.

On Thu, 2025-12-11 at 19:09 +0100, Matthieu Baerts (NGI0) wrote:
> When executing the last MPTCP selftests on older kernels, this output
> is
> printed:
> 
>   # 001 no JOIN
>   #       join Rx                             [SKIP]
>   #       join Tx                             [SKIP]
>   #       fallback                            [SKIP]
> 
> In fact, behind each line, a few counters are checked, and likely not
> all of them have been skipped because the they are not available on
> these kernels. Instead, "new" and unsupported counters for these
> groups
> are now ignored, and [ OK ] will be printed instead of [SKIP].
> 
> Note that on the MPTCP CI, when validating the dev versions, any
> unsupported counter will cause the tests to fail. So this is safe not
> to
> print 'SKIP' for these group checks.
> 
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
>  tools/testing/selftests/net/mptcp/mptcp_join.sh | 30 ++++++++++++---
> ----------
>  1 file changed, 15 insertions(+), 15 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index b2e6e548f796..77370b10651a 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -1407,7 +1407,7 @@ chk_join_tx_nr()
>  
>  	count=$(mptcp_lib_get_counter ${ns2}
> "MPTcpExtMPJoinSynTxCreatSkErr")
>  	if [ -z "$count" ]; then
> -		rc=${KSFT_SKIP}
> +		: # ignore skip
>  	elif [ "$count" != "$create" ]; then

In that case, wouldn't it be better to remove 'if [ -z "$count" ];
then' and directly check with 'if [ "$count" != "$create" ]; then'?

Thanks,
-Geliang

>  		rc=${KSFT_FAIL}
>  		print_check "syn tx create socket error"
> @@ -1416,7 +1416,7 @@ chk_join_tx_nr()
>  
>  	count=$(mptcp_lib_get_counter ${ns2}
> "MPTcpExtMPJoinSynTxBindErr")
>  	if [ -z "$count" ]; then
> -		rc=${KSFT_SKIP}
> +		: # ignore skip
>  	elif [ "$count" != "$bind" ]; then
>  		rc=${KSFT_FAIL}
>  		print_check "syn tx bind error"
> @@ -1425,7 +1425,7 @@ chk_join_tx_nr()
>  
>  	count=$(mptcp_lib_get_counter ${ns2}
> "MPTcpExtMPJoinSynTxConnectErr")
>  	if [ -z "$count" ]; then
> -		rc=${KSFT_SKIP}
> +		: # ignore skip
>  	elif [ "$count" != "$connect" ]; then
>  		rc=${KSFT_FAIL}
>  		print_check "syn tx connect error"
> @@ -1451,7 +1451,7 @@ chk_fallback_nr()
>  
>  	count=$(mptcp_lib_get_counter ${!ns}
> "MPTcpExtInfiniteMapTx")
>  	if [ -z "$count" ]; then
> -		rc=${KSFT_SKIP}
> +		: # ignore skip
>  	elif [ "$count" != "$infinite_map_tx" ]; then
>  		rc=${KSFT_FAIL}
>  		print_check "$ns infinite map tx fallback"
> @@ -1460,7 +1460,7 @@ chk_fallback_nr()
>  
>  	count=$(mptcp_lib_get_counter ${!ns}
> "MPTcpExtDSSCorruptionFallback")
>  	if [ -z "$count" ]; then
> -		rc=${KSFT_SKIP}
> +		: # ignore skip
>  	elif [ "$count" != "$dss_corruption" ]; then
>  		rc=${KSFT_FAIL}
>  		print_check "$ns dss corruption fallback"
> @@ -1469,7 +1469,7 @@ chk_fallback_nr()
>  
>  	count=$(mptcp_lib_get_counter ${!ns}
> "MPTcpExtSimultConnectFallback")
>  	if [ -z "$count" ]; then
> -		rc=${KSFT_SKIP}
> +		: # ignore skip
>  	elif [ "$count" != "$simult_conn" ]; then
>  		rc=${KSFT_FAIL}
>  		print_check "$ns simult conn fallback"
> @@ -1478,7 +1478,7 @@ chk_fallback_nr()
>  
>  	count=$(mptcp_lib_get_counter ${!ns}
> "MPTcpExtMPCapableFallbackACK")
>  	if [ -z "$count" ]; then
> -		rc=${KSFT_SKIP}
> +		: # ignore skip
>  	elif [ "$count" != "$mpc_passive" ]; then
>  		rc=${KSFT_FAIL}
>  		print_check "$ns mpc passive fallback"
> @@ -1487,7 +1487,7 @@ chk_fallback_nr()
>  
>  	count=$(mptcp_lib_get_counter ${!ns}
> "MPTcpExtMPCapableFallbackSYNACK")
>  	if [ -z "$count" ]; then
> -		rc=${KSFT_SKIP}
> +		: # ignore skip
>  	elif [ "$count" != "$mpc_active" ]; then
>  		rc=${KSFT_FAIL}
>  		print_check "$ns mpc active fallback"
> @@ -1496,7 +1496,7 @@ chk_fallback_nr()
>  
>  	count=$(mptcp_lib_get_counter ${!ns}
> "MPTcpExtMPCapableDataFallback")
>  	if [ -z "$count" ]; then
> -		rc=${KSFT_SKIP}
> +		: # ignore skip
>  	elif [ "$count" != "$mpc_data" ]; then
>  		rc=${KSFT_FAIL}
>  		print_check "$ns mpc data fallback"
> @@ -1505,7 +1505,7 @@ chk_fallback_nr()
>  
>  	count=$(mptcp_lib_get_counter ${!ns}
> "MPTcpExtMD5SigFallback")
>  	if [ -z "$count" ]; then
> -		rc=${KSFT_SKIP}
> +		: # ignore skip
>  	elif [ "$count" != "$md5_sig" ]; then
>  		rc=${KSFT_FAIL}
>  		print_check "$ns MD5 Sig fallback"
> @@ -1514,7 +1514,7 @@ chk_fallback_nr()
>  
>  	count=$(mptcp_lib_get_counter ${!ns} "MPTcpExtDssFallback")
>  	if [ -z "$count" ]; then
> -		rc=${KSFT_SKIP}
> +		: # ignore skip
>  	elif [ "$count" != "$dss" ]; then
>  		rc=${KSFT_FAIL}
>  		print_check "$ns dss fallback"
> @@ -1590,7 +1590,7 @@ chk_join_nr()
>  
>  	count=$(mptcp_lib_get_counter ${ns2}
> "MPTcpExtMPJoinSynAckHMacFailure")
>  	if [ -z "$count" ]; then
> -		rc=${KSFT_SKIP}
> +		: # ignore skip
>  	elif [ "$count" != "0" ]; then
>  		rc=${KSFT_FAIL}
>  		print_check "synack HMAC"
> @@ -1599,7 +1599,7 @@ chk_join_nr()
>  
>  	count=$(mptcp_lib_get_counter ${ns1} "MPTcpExtMPJoinAckRx")
>  	if [ -z "$count" ]; then
> -		rc=${KSFT_SKIP}
> +		: # ignore skip
>  	elif [ "$count" != "$ack_nr" ]; then
>  		rc=${KSFT_FAIL}
>  		print_check "ack rx"
> @@ -1608,7 +1608,7 @@ chk_join_nr()
>  
>  	count=$(mptcp_lib_get_counter ${ns1}
> "MPTcpExtMPJoinAckHMacFailure")
>  	if [ -z "$count" ]; then
> -		rc=${KSFT_SKIP}
> +		: # ignore skip
>  	elif [ "$count" != "0" ]; then
>  		rc=${KSFT_FAIL}
>  		print_check "ack HMAC"
> @@ -1617,7 +1617,7 @@ chk_join_nr()
>  
>  	count=$(mptcp_lib_get_counter ${ns1}
> "MPTcpExtMPJoinRejected")
>  	if [ -z "$count" ]; then
> -		rc=${KSFT_SKIP}
> +		: # ignore skip
>  	elif [ "$count" != "$syn_rej" ]; then
>  		rc=${KSFT_FAIL}
>  		print_check "syn rejected"
> 
> ---
> base-commit: ff3fd5f60460ba1ba338bfff405f13001e7131b8
> change-id: 20251211-sft-no-skip-new-cnt-40ad3fc1dcc8
> 
> Best regards,
