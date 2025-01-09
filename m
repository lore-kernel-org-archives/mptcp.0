Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A179B2153CB
	for <mptcp@lists.linux.dev>; Thu,  9 Jan 2025 09:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736414686; cv=none; b=k9Ghbea3DfLw0OuljAnhrVKQ6E4R/24LfxW6UlN50fXyZ8qKICTx6QrYvclZ8DyxphWKDv22JLhYYbG7HxmVZ5gIGpxNtWvuzn/Y8FuWGUR6FwBu79Ok9JzR5O79/UYDVEiRgMO5n528PM7ir7YnVM/T3dzaOWBB4nJ0B6uQyCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736414686; c=relaxed/simple;
	bh=MYVugIHISsom5UeyiwIU7r6oUPJqN8aSUBS+xTjrqNw=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=onOvt2oP73UKbl2jCw2dUvVm3lCJPbxnHyM5ZTBhgC3iHwFDWCW+3BWWqKmhZGVaxPZI5dO6+eehCUtUStVfGFOo8o9ZoDhgdLCsuF9AkRXKNGjvoMEBoZ/MCaZTpVQ4yj8lf/UW20bLjAlpnDbatny44LdEhFNxK1kat8iv+gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Iatl8R1Z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Iatl8R1Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D3BEC4CED2;
	Thu,  9 Jan 2025 09:24:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736414686;
	bh=MYVugIHISsom5UeyiwIU7r6oUPJqN8aSUBS+xTjrqNw=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=Iatl8R1ZHvA36p1rD/pOjTYRR2RILsqrF+IIj3dluR81k2La689eI7aLz4L6T6+P1
	 f5UC4N64a8jpzSfOMEBs5Ar3hYUqHBPrFYKItVHxwMr1sDj3qPiNIchaP92GD2E080
	 lYDSzEFCJpvisC7NuvYVmdORY/nNyjTpxJTOsJj/Cb+/wLQ1k67oNQf923JwLGTaS7
	 Jjgzaqeea7YVE8w4KyWmOIExnZ0Wx9uZIUn30qNAtdUl4Jya/CUNHWYR83OijwuMGp
	 QJBNVb1epCtWz95tCHw1DRREqUirIc1QMKvZPxpTDJdbtFhLpFxfK+szLhqFCCqkSF
	 NbfKmLAY1nmDA==
Message-ID: <29b3e04b00e3d1dcaa59f589d43eed7e0c107a96.camel@kernel.org>
Subject: Re: [PATCH mptcp-next 2/5] selftests: mptcp: move stats info in
 case of errors to lib.sh
From: Geliang Tang <geliang@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, mptcp@lists.linux.dev
Date: Thu, 09 Jan 2025 17:24:42 +0800
In-Reply-To: <20250108-slft-mptcp-conn-misc-impr-v1-2-bdfbdba48a1f@kernel.org>
References: 
	<20250108-slft-mptcp-conn-misc-impr-v1-0-bdfbdba48a1f@kernel.org>
	 <20250108-slft-mptcp-conn-misc-impr-v1-2-bdfbdba48a1f@kernel.org>
Autocrypt: addr=geliang@kernel.org; prefer-encrypt=mutual;
 keydata=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
 Px+2P2cKc7LXXedb/qQ3M
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.54.0-1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Matt,

Thanks for this set.

On Wed, 2025-01-08 at 19:40 +0100, Matthieu Baerts (NGI0) wrote:
> A few MPTCP selftests are using the same code to print stats in case
> of
> error. This code can then be moved to mptcp_lib.sh.
> 
> No behaviour changes intended, except to print the error in red and
> to
> stderr, like most error messages.
> 
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
>  tools/testing/selftests/net/mptcp/mptcp_connect.sh |  8 ++------
>  tools/testing/selftests/net/mptcp/mptcp_join.sh    |  9 ++-------
>  tools/testing/selftests/net/mptcp/mptcp_lib.sh     | 21
> +++++++++++++++++++++
>  tools/testing/selftests/net/mptcp/mptcp_sockopt.sh |  6 +-----
>  tools/testing/selftests/net/mptcp/simult_flows.sh  |  8 ++------
>  5 files changed, 28 insertions(+), 24 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
> b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
> index
> b48b4e56826a9cfdb3501242b707ae2ebe29b220..bfdaecd0a6a0564020530345daf
> 91bed296bc15c 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
> @@ -445,12 +445,8 @@ do_transfer()
>  	printf "(duration %05sms) " "${duration}"
>  	if [ ${rets} -ne 0 ] || [ ${retc} -ne 0 ]; then
>  		mptcp_lib_pr_fail "client exit code $retc, server
> $rets"
> -		echo -e "\nnetns ${listener_ns} socket stat for
> ${port}:" 1>&2
> -		ip netns exec ${listener_ns} ss -Menita 1>&2 -o
> "sport = :$port"
> -		cat /tmp/${listener_ns}.out
> -		echo -e "\nnetns ${connector_ns} socket stat for
> ${port}:" 1>&2
> -		ip netns exec ${connector_ns} ss -Menita 1>&2 -o
> "dport = :$port"
> -		[ ${listener_ns} != ${connector_ns} ] && cat
> /tmp/${connector_ns}.out
> +		mptcp_lib_pr_err_stats "${listener_ns}"
> "${connector_ns}" "${port}" \
> +			"/tmp/${listener_ns}.out"
> "/tmp/${connector_ns}.out"
>  
>  		echo
>  		cat "$capout"
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index
> c07e2bd3a315aac9c422fed85c3196ec46e060f7..13a3b68181ee14eb628a858e573
> 8094c3c936b74 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -1039,13 +1039,8 @@ do_transfer()
>  
>  	if [ ${rets} -ne 0 ] || [ ${retc} -ne 0 ]; then
>  		fail_test "client exit code $retc, server $rets"
> -		echo -e "\nnetns ${listener_ns} socket stat for
> ${port}:" 1>&2
> -		ip netns exec ${listener_ns} ss -Menita 1>&2 -o
> "sport = :$port"
> -		cat /tmp/${listener_ns}.out
> -		echo -e "\nnetns ${connector_ns} socket stat for
> ${port}:" 1>&2
> -		ip netns exec ${connector_ns} ss -Menita 1>&2 -o
> "dport = :$port"
> -		cat /tmp/${connector_ns}.out
> -
> +		mptcp_lib_pr_err_stats "${listener_ns}"
> "${connector_ns}" "${port}" \
> +			"/tmp/${listener_ns}.out"
> "/tmp/${connector_ns}.out"
>  		return 1
>  	fi
>  
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
> b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
> index
> 975d4d4c862afff2e685e86dc08a892dbd09d783..50ca64357053b14cd4989e6647d
> 825337978fdba 100644
> --- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
> @@ -107,6 +107,27 @@ mptcp_lib_pr_info() {
>  	mptcp_lib_print_info "INFO: ${*}"
>  }
>  
> +# $1-2: listener/connector ns ; $3 port ; [ $4-5 listener/connector
> stat file ]
> +mptcp_lib_pr_err_stats() {
> +	local lns="${1}"
> +	local cns="${2}"
> +	local port="${3}"
> +	local lstat="${4:-}"
> +	local cstat="${5:-}"

I think it's better to add a separate patch to add

	cat /tmp/${listener_ns}.out

and

	cat /tmp/${connector_ns}.out

in mptcp_sockopt.sh, then we can drop the last two arguments "lstat"
and "cstat" of this helper.

WDYT?

Thanks,
-Geliang

> +
> +	echo -en "${MPTCP_LIB_COLOR_RED}"
> +	{
> +		printf "\nnetns %s (listener) socket stat for %d:\n"
> "${lns}" "${port}"
> +		ip netns exec "${lns}" ss -Menita -o "sport =
> :${port}"
> +		[ -s "${lstat}" ] && cat "${lstat}"
> +
> +		printf "\nnetns %s (connector) socket stat for
> %d:\n" "${cns}" "${port}"
> +		ip netns exec "${cns}" ss -Menita -o "dport =
> :${port}"
> +		[ "${lstat}" != "${cstat}" ] && [ -s "${cstat}" ] &&
> cat "${cstat}"
> +	} 1>&2
> +	echo -en "${MPTCP_LIB_COLOR_RESET}"
> +}
> +
>  # SELFTESTS_MPTCP_LIB_EXPECT_ALL_FEATURES env var can be set when
> validating all
>  # features using the last version of the kernel and the selftests to
> make sure
>  # a test is not being skipped by mistake.
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
> b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
> index
> 5e8d5b83e2d092879efc179f1a450542be4e575e..6b366c604a9eeccdb759f260be4
> feafc380ccb0b 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
> @@ -192,11 +192,7 @@ do_transfer()
>  	print_title "Transfer ${ip:2}"
>  	if [ ${rets} -ne 0 ] || [ ${retc} -ne 0 ]; then
>  		mptcp_lib_pr_fail "client exit code $retc, server
> $rets"
> -		echo -e "\nnetns ${listener_ns} socket stat for
> ${port}:" 1>&2
> -		ip netns exec ${listener_ns} ss -Menita 1>&2 -o
> "sport = :$port"
> -
> -		echo -e "\nnetns ${connector_ns} socket stat for
> ${port}:" 1>&2
> -		ip netns exec ${connector_ns} ss -Menita 1>&2 -o
> "dport = :$port"
> +		mptcp_lib_pr_err_stats "${listener_ns}"
> "${connector_ns}" "${port}"
>  
>  		mptcp_lib_result_fail "transfer ${ip}"
>  
> diff --git a/tools/testing/selftests/net/mptcp/simult_flows.sh
> b/tools/testing/selftests/net/mptcp/simult_flows.sh
> index
> e98e5907d52c2d0e9c0152efda82176861905cf1..9c2a415976cbf7a0b56cd4b2fbd
> d36c9e1ef3c8c 100755
> --- a/tools/testing/selftests/net/mptcp/simult_flows.sh
> +++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
> @@ -204,12 +204,8 @@ do_transfer()
>  	fi
>  
>  	mptcp_lib_pr_fail "client exit code $retc, server $rets"
> -	echo -e "\nnetns ${ns3} socket stat for $port:" 1>&2
> -	ip netns exec ${ns3} ss -Menita 1>&2 -o "sport = :$port"
> -	cat /tmp/${ns3}.out
> -	echo -e "\nnetns ${ns1} socket stat for $port:" 1>&2
> -	ip netns exec ${ns1} ss -Menita 1>&2 -o "dport = :$port"
> -	cat /tmp/${ns1}.out
> +	mptcp_lib_pr_err_stats "${ns3}" "${ns1}" "${port}" \
> +		"/tmp/${ns3}.out" "/tmp/${ns1}.out"
>  	ls -l $sin $cout
>  	ls -l $cin $sout
>  
> 

