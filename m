Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 299A8136A
	for <mptcp@lists.linux.dev>; Mon, 12 Aug 2024 01:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723426764; cv=none; b=qZiUU0DOWUJqJzUYrlbGsSe6tjIvI6dHzAIxRbfSbfw0D5odxDthSOxUtUqpwKw1qYkvaPtzEsVeX8krJf8sMCUi/FjbOtIvce7osjDsO21MKEQgt2mM0DgM9SaxqDV5VhDSKCfu0t5yNiUHnJq0XFKMSFqkI5AH/uohIaioWac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723426764; c=relaxed/simple;
	bh=b5EMtdqwiWGlsldERkQgtT4d+U79EhCebNjscJl1TmA=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ebFB/jjXvVEyu0fQiLHrW9ZVcPtejvoSZA8xvrDIFJ6z9yGUl1GXXII+Ym0kLE3vGtLq3sgv9rTGX7axFGnEjuAg2Xf3+xWXNTr74h9UniO5dTB5QDHZvz4eu4tkXkBC23LwMMCwF9+HdJld+11VI+537ycATBhDL5dS3pthGL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z4TvuH9+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z4TvuH9+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2AF1C32786;
	Mon, 12 Aug 2024 01:39:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723426763;
	bh=b5EMtdqwiWGlsldERkQgtT4d+U79EhCebNjscJl1TmA=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=Z4TvuH9+IFmD1IzN0myYcFHeCAqSv68k9s9PIvgtf+xMKc1tKAihEyIvnSLJw0wbm
	 ab3zu0zo5v8goTYaLhilNmr+o+CB+3Ytggnzweg7mp/xJwOIkIEQ2GrSNFj/PaK6/C
	 K5/anXFDvRGM2Od+UIW0CfVFHdb8kRS5ts1iiKfysmlmMbO52uW3QxzZT5yVrDNuHE
	 JChUiuMTuCE3ZXIUplIaCpLTvkbvVeMKCmliP6H4/yyOWjXxVFAeGDvmHfA0+ULO8K
	 keSw2CCYmtjUzMDCyP4exK8xOul6aufnguzWkZpbGhOlaco4ximOBMVvWyaQNG4hdZ
	 8sqe2tapkU6pg==
Message-ID: <f314315ca1a9b1b98e7cf167f7ab19b461b31a04.camel@kernel.org>
Subject: Re: [PATCH mptcp-next v4 1/8] selftests: mptcp: join: no extra msg
 if no counter
From: Geliang Tang <geliang@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, mptcp@lists.linux.dev
Date: Mon, 12 Aug 2024 09:39:20 +0800
In-Reply-To: <20240809-mptcp-join-tx-mib-v4-1-98b0b0e098c5@kernel.org>
References: <20240809-mptcp-join-tx-mib-v4-0-98b0b0e098c5@kernel.org>
	 <20240809-mptcp-join-tx-mib-v4-1-98b0b0e098c5@kernel.org>
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

Thanks for this v4.

On Fri, 2024-08-09 at 13:51 +0200, Matthieu Baerts (NGI0) wrote:
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

The same code in chk_csum_nr() needs to be aligned too. You can update
it when merging this set.

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

