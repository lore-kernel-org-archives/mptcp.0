Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D19C210E1
	for <mptcp@lists.linux.dev>; Mon, 19 Feb 2024 09:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708333264; cv=none; b=g6VbuNN7MIk3wBlXZZk3Hs3MZHc0D32TokwsuXysHepXSBcLyqiXotqiuaG3fV3mK60d0GtER219V+KHypWGei2wnPBjCdjwxwcWWuSflgaM3QIUK3KXipCNsR4iNy6rPAPJKm9ERnVeIyV9ksn+y8YorbeMt+kzWNF6vje43VU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708333264; c=relaxed/simple;
	bh=s0MkwnES3ekJhAcLd2zDZkI1BOb+++iW/9RCE2679e8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bDdTrbc3k1ZH8aAeZ7isoFhk722AWP0rzK+7ByYT8vDECgcfgcn1gMUIjWYhnA0yXtpNOV3luhF1rhUoR8EJmAl7G8TtCOARw/tWRNhffGJDxUQzKp7fegCWv6Tb4x8Z25EyDVEAA0W6CdrTw3MgbEjQuWP4QcJfS361VeN+6Y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n6zzoHrx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n6zzoHrx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1B4AC433F1;
	Mon, 19 Feb 2024 09:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708333263;
	bh=s0MkwnES3ekJhAcLd2zDZkI1BOb+++iW/9RCE2679e8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=n6zzoHrxQu1p0sIy4ivspqtnRX60wNgufwTGa5TtGDAXZuCKu2xDmiS52l+UENDDR
	 AmDn44mJo7GH8XrqFl1z2X1X1ZKjM07c3POl9NR7eEPHekQPLJj8lU7qPqWNftsoPo
	 03+7LeYjGy9Btu13/LhL3NJjF1fWjK06/dmAy0Yja3CCVWi64tb34qqvq85zFtGMQ/
	 Z+el1mMamPc2oymZgpB7/CUxnHmheaCcf9Z6RIasgqFFvVATMbZFnfhQoSqS3aSkPq
	 UyEtkkILvYQ9sLFrz3EJ7S84hAkKOTlz86alV/Tp9M5EErMsCPXEm55EeG7xz2B65l
	 5LDkwMHjk2Xwg==
Message-ID: <ac77e129-a6ef-42e7-84e8-fb7e19bc6b30@kernel.org>
Date: Mon, 19 Feb 2024 10:01:00 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-next v3 2/2] selftests: mptcp: add
 mptcp_lib_check_tools helper
Content-Language: en-GB, fr-BE
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1708330720.git.tanggeliang@kylinos.cn>
 <428122f8879686b24852d3e46850b9e3538afb99.1708330720.git.tanggeliang@kylinos.cn>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <428122f8879686b24852d3e46850b9e3538afb99.1708330720.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

Thank you for the new version.

On 19/02/2024 09:22, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> This patch exports check_tools() helper from mptcp_join.sh into
> mptcp_lib.sh as a public one mptcp_lib_check_tools(). The arguments
> "ip", "ss", and "iptables" are passed into this helper to indicate

'ip6tables' can be passed too since v3.

> whether to check ip tool, ss tool and iptables tools.
> 
> This helper can be used in every scripts.

(...)

> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index d797b27b7626..d9df6eb6a52a 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -152,34 +152,12 @@ cleanup_partial()
>  	done
>  }
>  
> -check_tools()
> -{
> -	mptcp_lib_check_mptcp
> -	mptcp_lib_check_kallsyms
> -
> -	if ! ip -Version &> /dev/null; then
> -		echo "SKIP: Could not run test without ip tool"
> -		exit $ksft_skip
> -	fi
> -
> -	if ! ss -h | grep -q MPTCP; then
> -		echo "SKIP: ss tool does not support MPTCP"
> -		exit $ksft_skip
> -	fi
> -
> -	if ! "${iptables}" -V &> /dev/null; then
> -		echo "SKIP: Could not run all tests without ${iptables} tool"
> -		exit $ksft_skip
> -	elif ! "${ip6tables}" -V &> /dev/null; then
> -		echo "SKIP: Could not run all tests without ${ip6tables} tool"
> -		exit $ksft_skip
> -	fi
> -}
> -
>  init() {
>  	init=1
>  
> -	check_tools
> +	mptcp_lib_check_mptcp
> +	mptcp_lib_check_kallsyms
> +	mptcp_lib_check_tools ip ss iptables

You should use "${iptables}" -- just in case we switch to iptables-nft
or something else later -- and add "${ip6tables}" now that the check is
split.

>  	sin=$(mktemp)
>  	sout=$(mktemp)
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
> index 108a1e12436c..b92c5278730b 100644
> --- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
> @@ -319,3 +319,34 @@ mptcp_lib_wait_local_port_listen() {
>  		sleep 0.1
>  	done
>  }
> +
> +mptcp_lib_check_tools() {
> +	local tool
> +
> +	for tool in "${@}"; do
> +		case "${tool}" in
> +		"ip")
> +			if ! ip -Version &> /dev/null; then
> +				mptcp_lib_print_warn "SKIP: Could not run test without ip tool"
> +				exit ${KSFT_SKIP}
> +			fi
> +			;;
> +		"ss")
> +			if ! ss -h | grep -q MPTCP; then
> +				mptcp_lib_print_warn "SKIP: ss tool does not support MPTCP"
> +				exit ${KSFT_SKIP}
> +			fi
> +			;;
> +		"iptables"* | "ip6tables"*)
> +			if ! "${tool}" -V &> /dev/null; then
> +				mptcp_lib_print_warn "SKIP: Could not run all tests without ${tool} tool"
> +				exit ${KSFT_SKIP}
> +			fi
> +			;;
> +		*)
> +			mptcp_lib_print_warn "Unsupported tool: ${tool}"
> +			exit ${KSFT_SKIP}

If we are here, it means we have an internal error: we are checking a
tool we don't support. I think you should then use 'mptcp_lib_print_err'
and exit an error "${KSFT_FAIL}".

If you prefer, you can also print a more explicit message, e.g.

  Internal error: unsupported tool: ${tool}

Up to you, this error should not happen.

> +			;;
> +		esac
> +	done
> +}
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
> index dac8e1fc7143..edb71f44be45 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
> @@ -89,20 +89,7 @@ cleanup()
>  
>  mptcp_lib_check_mptcp
>  mptcp_lib_check_kallsyms
> -
> -ip -Version > /dev/null 2>&1
> -if [ $? -ne 0 ];then
> -	echo "SKIP: Could not run test without ip tool"
> -	exit $ksft_skip
> -fi
> -
> -if ! "${iptables}" -V &> /dev/null; then
> -	echo "SKIP: Could not run all tests without ${iptables} tool"
> -	exit $ksft_skip
> -elif ! "${ip6tables}" -V &> /dev/null; then
> -	echo "SKIP: Could not run all tests without ${ip6tables} tool"
> -	exit $ksft_skip
> -fi
> +mptcp_lib_check_tools ip iptables

Same here: use "${iptables}" instead, and add "${ip6tables}".

>  
>  check_mark()
>  {

(...)

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.
