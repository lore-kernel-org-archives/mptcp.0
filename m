Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1797077F1D
	for <mptcp@lists.linux.dev>; Fri, 16 Feb 2024 13:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708091287; cv=none; b=a81wH1+WSSrAl7qI3pHxIAcxmWxvVSFQE15CH8g1SPQv82HuKyekTr20ZsnQ6yqeYdZB3RhCtrI12rVs3GlaRQFEkS1Qwgz2sm37HQKM//dyNx1PsiPp1q28761nRBbzz4M4xm7fzobhjST5FDeWbGfUxasleZSqG16x1mARANE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708091287; c=relaxed/simple;
	bh=vDq6L9RcYIglrL8bslxk/wSYTvHUzhwqnAUzAckvBXc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A9BIYRayO/7waKMKs2sKgXmpGgWmoxKNq0ryt+Yyc1RLWmIAMY1ul9cRC5DoXs7BoaOR5c1JAY/Lova7SHut6KVeJO10RnKgSBAxEa/Khh9tRq/H3QVYickykJu0giDDA9TNjdpHLvlgZDWnXvuyMsPH3m0++nlkWo/Gm5/0oj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hEfo2OpT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hEfo2OpT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F33B2C433F1;
	Fri, 16 Feb 2024 13:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708091286;
	bh=vDq6L9RcYIglrL8bslxk/wSYTvHUzhwqnAUzAckvBXc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=hEfo2OpTjUg7DWeLp3M4V9ZefyeR63tE/klVKg9YyyRmRRtqXpxPQHQnlHM7Vvb8W
	 74/EFgYOwlKz8MKY1DwJFazn6JNzyMLkcSBv2VHYQuDqZ6sjw0J2MhVLbyMkcO9K6x
	 /N5qtduoH7whceua02guIO0FvbzntQen+P1azGjNB8PJtXp2v/VG1Kria6bQE89P+o
	 I3HOrzOzj7kF5jk1yAB9QIl7R2COEnQaMywq6HR2sQjIvD7bK7RvCREE80zO0ViifS
	 iqGNJdMyDuIOcN8nrgCV43kteeIZbccRK5/Hj4dxLofu/ooFn69mUtENyozg+jDiFE
	 r4ZTAHNfC6S/A==
Message-ID: <951d1f6a-0ed7-49a0-abeb-c94a90ca6748@kernel.org>
Date: Fri, 16 Feb 2024 14:48:03 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-next v2 7/7] selftests: mptcp: add
 mptcp_lib_check_tools helper
Content-Language: en-GB, fr-BE
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1708076886.git.tanggeliang@kylinos.cn>
 <f7ca03a3e2d9b8c8a49e9226d88b40c935875e14.1708076886.git.tanggeliang@kylinos.cn>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <f7ca03a3e2d9b8c8a49e9226d88b40c935875e14.1708076886.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 16/02/2024 10:50, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> This patch exports check_tools() helper from mptcp_join.sh into
> mptcp_lib.sh as a public one mptcp_lib_check_tools(). The arguments
> "ip", "ss", and "iptables" are passed into this helper to indicate
> whether to check ip tool, ss tool and iptables tools.
> 
> This helper can be used in every scripts.
> 
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>  tools/testing/selftests/net/mptcp/diag.sh     | 13 +--------
>  .../selftests/net/mptcp/mptcp_connect.sh      | 14 +--------
>  .../testing/selftests/net/mptcp/mptcp_join.sh | 26 +----------------
>  .../testing/selftests/net/mptcp/mptcp_lib.sh  | 29 +++++++++++++++++++
>  .../selftests/net/mptcp/mptcp_sockopt.sh      | 22 +-------------
>  .../testing/selftests/net/mptcp/pm_netlink.sh |  8 +----
>  .../selftests/net/mptcp/simult_flows.sh       |  8 +----
>  .../selftests/net/mptcp/userspace_pm.sh       |  8 +----
>  8 files changed, 36 insertions(+), 92 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/mptcp/diag.sh b/tools/testing/selftests/net/mptcp/diag.sh
> index 8573326d326a..7c68160ad3b9 100755
> --- a/tools/testing/selftests/net/mptcp/diag.sh
> +++ b/tools/testing/selftests/net/mptcp/diag.sh
> @@ -33,18 +33,7 @@ cleanup()
>  	ip netns del $ns
>  }
>  
> -mptcp_lib_check_mptcp

(see below) Here, we don't need to check for mptcp_lib_check_kallsyms.

(...)

> mptcp_lib_check_tools "ip" "ss"

(you can remove the double quotes if you don't use variables)

> diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
> index 108a1e12436c..cdb8948749eb 100644
> --- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
> @@ -319,3 +319,32 @@ mptcp_lib_wait_local_port_listen() {
>  		sleep 0.1
>  	done
>  }
> +
> +mptcp_lib_check_tools() {
> +	mptcp_lib_check_mptcp
> +	mptcp_lib_check_kallsyms

I would not move that here, better to have an explicit check in each
selftest I think. Also, see above/below: some selftests don't need kallsyms.

> +	if [ "${1:-""}" == "ip" ]; then

Probably better to use a switch/case, so the order is not important, no?


  local tool

  for tool in "${@}"; do
      case "${tool}" in
      "ip")
          if ! ip -Version &> /dev/null; then
              (...)
          fi
          ;;
      "ss")
          (...)
          ;;
      "iptables"* | "ip6tables"*)  ## including extensions
          if ! "${tool}" -V &> /dev/null; then
          (...)
      *)
          mptcp_lib_print_warn "Unsupported tool: ${tool}"
          exit ${KSFT_FAIL}
          ;;
      esac
  done


So we can use this helper with parameters in any order, e.g.

  mptcp_lib_check_tools ss iptables-nft


> +		if ! ip -Version &> /dev/null; then
> +			mptcp_lib_print_warn "SKIP: Could not run test without ip tool"
> +			exit ${KSFT_SKIP}
> +		fi
> +	fi
> +
> +	if [ "${2:-""}" == "ss" ]; then
> +		if ! ss -h | grep -q MPTCP; then
> +			mptcp_lib_print_warn "SKIP: ss tool does not support MPTCP"
> +			exit ${KSFT_SKIP}
> +		fi
> +	fi
> +
> +	if [ "${3:-""}" == "iptables" ]; then
> +		if ! iptables -V &> /dev/null; then
> +			mptcp_lib_print_warn "SKIP: Could not run all tests without iptables tool"
> +			exit ${KSFT_SKIP}
> +		elif ! ip6tables -V &> /dev/null; then
> +			mptcp_lib_print_warn "SKIP: Could not run all tests without ip6tables tool"
> +			exit ${KSFT_SKIP}
> +		fi

I would split "iptables" and "ip6tables" cases, please see above: just
not to repeat the same err message, and maybe a selftest will only need one.

> +	fi
> +}

(...)

> diff --git a/tools/testing/selftests/net/mptcp/pm_netlink.sh b/tools/testing/selftests/net/mptcp/pm_netlink.sh
> index ebfefae71e13..e7ab5eca3e75 100755
> --- a/tools/testing/selftests/net/mptcp/pm_netlink.sh
> +++ b/tools/testing/selftests/net/mptcp/pm_netlink.sh
> @@ -35,13 +35,7 @@ cleanup()
>  	ip netns del $ns1
>  }
>  
> -mptcp_lib_check_mptcp

(see above) Here, we don't need to check for mptcp_lib_check_kallsyms.

> -ip -Version > /dev/null 2>&1
> -if [ $? -ne 0 ];then
> -	echo "SKIP: Could not run test without ip tool"
> -	exit $ksft_skip
> -fi
> +mptcp_lib_check_tools "ip"
>  
>  trap cleanup EXIT
>  
> diff --git a/tools/testing/selftests/net/mptcp/simult_flows.sh b/tools/testing/selftests/net/mptcp/simult_flows.sh
> index e6e5b933a1b9..053f40bf25c1 100755
> --- a/tools/testing/selftests/net/mptcp/simult_flows.sh
> +++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
> @@ -42,13 +42,7 @@ cleanup()
>  	done
>  }
>  
> -mptcp_lib_check_mptcp

(see above) Here, we don't need to check for mptcp_lib_check_kallsyms.

(...)

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.
