Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B847352B
	for <mptcp@lists.linux.dev>; Wed, 28 Feb 2024 12:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709121700; cv=none; b=W4QTkUEznCVBdkqEyOfvaxZ/yRnSvejYIy20nC0agAmHCHsjfT+HHxtMUHlk5R0KWfkayMQLbVB9mFt3FkeatB1/FJiOszJkJPplgl5jhovnU9T+c/rhi4ut1dcWUSpifz98qlFil16o0D6cEp5x5Zh4qPrQhFxlKeaHRSfUybI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709121700; c=relaxed/simple;
	bh=oZKNBaKuEHTjF6D0b08dDHXuIQMITE8UT1M/QYOR56w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m9YtJy3BcLvUDU7n3QJkePwkgd0bru2d9wlWG1Ix8kUVHYAP7u6j4mHGAYEIL/b4aRrK1Jx4QRTfMbeWKsEtu7y6eya6fL/C9hgBLoX9p+CC7ufRKX23lKKtGAAC5lwAYN7LHgUiWZwFcJicrrZfNuOG3E6qtnZqFFPreeZktHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iDhv12wz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iDhv12wz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06B9EC433C7;
	Wed, 28 Feb 2024 12:01:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709121699;
	bh=oZKNBaKuEHTjF6D0b08dDHXuIQMITE8UT1M/QYOR56w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=iDhv12wzMXb0ze8tdHrkxGXuossWRlwWhw6c5Z/AWKaebbqylh7UeDcTrREFi2z1G
	 7i610Jt2GoWnIWxDfJIu2NYeSSqRC+iTaDForJNz/IObf/Qro4ddOe8csi67J0HbZ2
	 jq6fWusrygNUn/p5GWSl/f7MSHXGoeaxxcQJry1O/J9cEAWQQVQsXbaXnOLQQ0bvhk
	 iKygAcUuZZUeo1hx8DlfHUBvB3Mp+5iM2fg51+TF8gMearBu2uzj0ybVaC7Rr66czp
	 hZNA5onsa0FDmL+SNUira834YlpMpGlHnousH6185XvnefPYrrMABwxfC7XGGpbwzD
	 jC4o+UZpS+ZXA==
Message-ID: <c4ccc059-03e1-4636-a994-cd9f8049d66d@kernel.org>
Date: Wed, 28 Feb 2024 13:01:37 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-next v6 3/9] selftests: mptcp: connect: fix
 misaligned output
Content-Language: en-GB, fr-BE
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1709105922.git.tanggeliang@kylinos.cn>
 <ff577139939e084179364bc5f963d6c98942e8ae.1709105922.git.tanggeliang@kylinos.cn>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <ff577139939e084179364bc5f963d6c98942e8ae.1709105922.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Geliang,

On 28/02/2024 08:43, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> The first [ OK ] and [FAIL] in the output of mptcp_connect.sh misalign
> with the others:
> 
> New MPTCP socket can be blocked via sysctl		[ OK ]
> INFO: validating network environment with pings
> INFO: Using loss of 0.85% delay 16 ms reorder 95% 70% with delay 4ms on
> ns1 MPTCP -> ns1 (10.0.1.1:10000      ) MPTCP	(duration   184ms) [ OK ]
> ns1 MPTCP -> ns1 (10.0.1.1:10001      ) TCP  	(duration    50ms) [ OK ]
> ns1 TCP   -> ns1 (10.0.1.1:10002      ) MPTCP	(duration    55ms) [ OK ]
> 
> This patch aligns them by using the newly added print_title() helper.
> 
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
> 
> Notes:
>     add print_title helper
> 
>  tools/testing/selftests/net/mptcp/mptcp_connect.sh | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
> index ffc063a58149..7a53c8fb1783 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
> @@ -247,11 +247,20 @@ else
>  	set_ethtool_flags "$ns4" ns4eth3 "$ethtool_args"
>  fi
>  
> +print_title()
> +{
> +	local msg="${1}"
> +	local nr_blank="${2-50}"

(detail: probably better to add ':': "${2:-50}" → it will use '50' is
${2} is unset or empty, not just unset).

> +
> +	printf "%-${nr_blank}s" "${msg}"
> +}
> +
>  check_mptcp_disabled()
>  {
>  	local disabled_ns
>  	mptcp_lib_ns_init disabled_ns
>  
> +	print_title "New MPTCP socket can be blocked via sysctl" 69

Why do you need to set 69 here? All titles should be using the same
length. 50 seems too small in fact:

> $ python3
> len("ns1 MPTCP -> ns1 (10.0.1.1:10000      ) MPTCP	(duration   184ms)")
> 63

If you need different alignments, please use a dedicated helper, but
don't pass a "raw" value directly, not to have to change that everywhere
if the alignment needs to be revisited later.

>  	# net.mptcp.enabled should be enabled by default
>  	if [ "$(ip netns exec ${disabled_ns} sysctl net.mptcp.enabled | awk '{ print $3 }')" -ne 1 ]; then
>  		mptcp_lib_pr_fail "net.mptcp.enabled sysctl is not 1 by default"
> @@ -273,7 +282,6 @@ check_mptcp_disabled()
>  		return 1
>  	fi
>  
> -	echo -n -e "New MPTCP socket can be blocked via sysctl\t\t"
>  	mptcp_lib_pr_ok
>  	mptcp_lib_result_pass "New MPTCP socket can be blocked via sysctl"
>  	return 0
> @@ -343,7 +351,7 @@ do_transfer()
>  	addr_port=$(printf "%s:%d" ${connect_addr} ${port})
>  	local result_msg
>  	result_msg="$(printf "%.3s %-5s -> %.3s (%-20s) %-5s" ${connector_ns} ${cl_proto} ${listener_ns} ${addr_port} ${srv_proto})"
> -	printf "%s\t" "${result_msg}"
> +	print_title "${result_msg}"
>  
>  	if $capture; then
>  		local capuser

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.
