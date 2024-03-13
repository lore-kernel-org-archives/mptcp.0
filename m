Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC38555C0A
	for <mptcp@lists.linux.dev>; Wed, 13 Mar 2024 18:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710355681; cv=none; b=FHbleFgtTxapPfQE6jW+9p/j9oHjT0R+2azXtbV7kigLmxWDSMVhtj0RifADK+9dAulDUW4W6JR1yx9Fo6y+P0fBdMreOMwwWSMKxSQgf7k44E2LcewCwSOpz6jKUEdLbBrDq8xMtHuZLQDpZQCvdtz7E1zmuMOmNBQSu3e/oo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710355681; c=relaxed/simple;
	bh=dcVWb4N9NdsJ7tiR/OkRHC9HMr2vN7pZKD+UVC6JBgY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XRPFx5HDvTjuktdFmZqOzQsqdyC7qID/zp1O0SolIxTxK0/VGGKK3HAZ3nqx2Lu6h/aeU8cJfsTk/NWm8foIiYMdl6i6NM6lOY9PeZW2f5fzTHx1L9j49LfVI4GaHnx4LdHeBeIkkMSKtT7nf2OkAO9F63Atb1dO8w0w3SCWTcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KBgTVMh3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KBgTVMh3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1194CC433F1;
	Wed, 13 Mar 2024 18:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710355681;
	bh=dcVWb4N9NdsJ7tiR/OkRHC9HMr2vN7pZKD+UVC6JBgY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=KBgTVMh3RZC7VA9B14tdVyNQUVkw0enTcJyg/lcCvdFie4foJfx/aes+0qCZ6lqxE
	 9p9oiDBtdpm7c+LV/qZcjesK61SmjV+1v3OTqOpPYz24XF3WZ1M/LQ7ji2mDtgOJ3V
	 xBiGHfBSvzcKVgTkyGyvHy0TzqJP7nO83NWSf38fpam/TyMZX5sL4S8rYg4eYxYbsH
	 xcjDuWCBbglvtdIm1xUt0B4sFh9xRP8jZkEaB4PwKg+3K0SOhHfHfr0KzqEfEZPHgP
	 YhBe1UbjovXuwNiVai/tw5WJB5MM+hS86eX9VDD/GP5VL3wttes6ZvU2CoV0ltUIci
	 kb8izaIhC24iQ==
Message-ID: <d3129248-0191-4a02-b0c0-9e0959791cad@kernel.org>
Date: Wed, 13 Mar 2024 19:47:57 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next 03/10] selftests: mptcp: id support for
 show_endpoints
Content-Language: en-US
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1710121590.git.tanggeliang@kylinos.cn>
 <3e52c3dda1c27337c482e4752c376fad1c4d4e67.1710121590.git.tanggeliang@kylinos.cn>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <3e52c3dda1c27337c482e4752c376fad1c4d4e67.1710121590.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 11/03/2024 02:48, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> All endpoints are showed in pm_nl_show_endpoints(). This patch adds support
> for showing a specofic endpoint identified by the given address ID.
> 
> Usage:
>         All endpoints - pm_nl_show_endpoints $ns
>         One endpoint - pm_nl_show_endpoints $ns $id
> 
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>  tools/testing/selftests/net/mptcp/mptcp_join.sh | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index 8eb5cf54ea42..e33a136aef8e 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -699,11 +699,18 @@ pm_nl_flush_endpoint()
>  pm_nl_show_endpoints()
>  {
>  	local ns=$1
> +	local id=$2
>  
>  	if mptcp_lib_is_ip_mptcp; then
> -		ip -n $ns mptcp endpoint show
> +		local show="show"
> +
> +		[ -n "$id" ] && show+=" id $id"
> +		ip -n $ns mptcp endpoint $show
>  	else
> -		ip netns exec $ns ./pm_nl_ctl dump
> +		local dump="dump"
> +
> +		[ -n "$id" ] && dump="get $id"
> +		ip netns exec $ns ./pm_nl_ctl $dump
>  	fi
>  }
>  
> @@ -3598,6 +3605,10 @@ endpoint_tests()
>  		mptcp_lib_is_ip_mptcp && output="add_addr_accepted 2 subflows 2 "
>  		check_output "pm_nl_get_limits ${ns1}" "${output}"
>  		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
> +		print_check "show id 1 addr"
> +		output="id 1 flags signal 10.0.2.1"
> +		mptcp_lib_is_ip_mptcp && output="10.0.2.1 id 1 signal "
> +		check_output "pm_nl_show_endpoints ${ns1} 1" "${output}"

Same here, that's already validated in pm_netlink.sh, no need to
duplicate the test validating the same kernel code path. WDYT?

>  		speed=slow \
>  			run_tests $ns1 $ns2 10.0.1.1 &
>  		local tests_pid=$!

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

