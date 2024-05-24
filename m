Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F15B686251
	for <mptcp@lists.linux.dev>; Fri, 24 May 2024 11:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716548951; cv=none; b=NqP+gvNkCrTAsZGaUlB9h1r+hIPczL2a0xQvZZ3R2Pw/LtbqVSndJkhw2ByAYxnxEBI12g9v/Uu6GmMG8KuwJAuOoxXrc7doRfP6JNslD5VaYVDw9HvXaschiSa2UdovxT+jXwtlONChjyJqWqrudAKbMsC/RIxW0Aaau5rhHz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716548951; c=relaxed/simple;
	bh=LbZVy+sOtxUlDHxJSKv3CYZZKEfUMXw97Oum31rvD1k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PfN2U+3a9x2oxc6cGKhf0ZdiuQi1rr2VsdYVk4UM/gYWi0y9NZcqsC4rnAXuRpsvZMhntBDZb3cjXyI/WajzgGBZ4FDKbsb8DiEE7FeAw+URuDG2YK6bDCXWOgd0+XAEGjHAODqiFh/BMqIxZgpzj8d6lb1tF1WNLTslVTHSqEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b2yQ509B; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b2yQ509B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6928BC2BBFC;
	Fri, 24 May 2024 11:09:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716548950;
	bh=LbZVy+sOtxUlDHxJSKv3CYZZKEfUMXw97Oum31rvD1k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=b2yQ509BQYTylkwm5p6wv6iLAqdFU5DzP5RO6lXJsSsvlEE13ezOmtohghEgXuZTW
	 4LmkZKMFhKZSktfafTgDhxoMjiCMC1K20Z2XPIVAA/9q3Ri6FdbZEYllJBsdlEd8aq
	 VNj6cbaSZfWxpXaDJhFuNh8+HFNbadg0I15gzmPcXKdb8TzIU2Jy5cNzxJL4nz9VyV
	 tIpI+gUmZuCbaesR1TjjpNoJ2u4ifd7tAqa27pjWrPFnzHkF0SAU8Hr+Nah17M3Gpm
	 YLSnwFvcjGMs8/B607MNUjgycSvGPyMdPNh9VhzhLVMD2dHljOhi3gGnq19dSgtZo7
	 KW38HLxId5jcw==
Message-ID: <83d554c8-efef-43dd-a514-bfc0a51ca562@kernel.org>
Date: Fri, 24 May 2024 13:09:06 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v4 1/6] selftests: net: rename ns in
 setup/cleanup_ns
Content-Language: en-GB
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1716533107.git.tanggeliang@kylinos.cn>
 <7a877165562901175b913285b3bb844f2cbc49c9.1716533107.git.tanggeliang@kylinos.cn>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <7a877165562901175b913285b3bb844f2cbc49c9.1716533107.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 24/05/2024 08:48, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> The helpers setup_ns and cleanup_ns don't work when a namespace named
> "ns" is passed to them.
> 
> For example, in net/mptcp/diag.sh, the name of the namespace is "ns".
> If "setup_ns ns" is used in it, diag.sh fails with errors:
> 
>  Invalid netns name "./mptcp_connect"
>  Cannot open network namespace "10000": No such file or directory
>  Cannot open network namespace "10000": No such file or directory
> 
> That is because "ns" is also a local variable in both setup_ns and
> cleanup_ns. To solve this, this patch renames the local variable "ns"
> as "_ns".

Do you mind justifying why the new name helps? Something like:

  (...)
  as "_ns", which is more unlikely to conflict with existing variables.
  "_ns" name appears to be unused in the selftests.

> Also a ns_name valid check has been added to setup_ns. If "_ns" is
> passed in as a ns_name, setup_ns helper exits.
> 
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>  tools/testing/selftests/net/lib.sh | 33 ++++++++++++++++++------------
>  1 file changed, 20 insertions(+), 13 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/lib.sh b/tools/testing/selftests/net/lib.sh
> index edc030e81a46..ce611bc73098 100644
> --- a/tools/testing/selftests/net/lib.sh
> +++ b/tools/testing/selftests/net/lib.sh
> @@ -128,7 +128,7 @@ slowwait_for_counter()
>  
>  cleanup_ns()
>  {
> -	local ns=""
> +	local _ns=""

Are you sure this modification in cleanup_ns is needed as well? The
variable is local, and it is not unset / modified using the name passed
in argument.

>  	local errexit=0
>  	local ret=0
>  
> @@ -138,10 +138,11 @@ cleanup_ns()
>  		set +e
>  	fi
>  
> -	for ns in "$@"; do
> -		ip netns delete "${ns}" &> /dev/null
> -		if ! busywait $BUSYWAIT_TIMEOUT ip netns list \| grep -vq "^$ns$" &> /dev/null; then
> -			echo "Warn: Failed to remove namespace $ns"
> +	for _ns in "$@"; do
> +		ip netns delete "${_ns}" &> /dev/null
> +		if ! busywait $BUSYWAIT_TIMEOUT ip netns list \
> +		   \| grep -vq "^$_ns$" &> /dev/null; then
> +			echo "Warn: Failed to remove namespace $_ns"
>  			ret=1
>  		fi
>  	done
> @@ -159,29 +160,35 @@ cleanup_all_ns()
>  # setup_ns local remote
>  setup_ns()
>  {
> -	local ns=""
> +	local _ns=""
>  	local ns_name=""
>  	local ns_list=""
>  	local ns_exist=
>  	for ns_name in "$@"; do
> +		if [ "${ns_name}" == "_ns" ]; then
> +			echo "Failed to setup namespace '${ns_name}': invalid name"
> +			cleanup_ns "$ns_list"

If the list is empty, it will call cleanup_ns with "", and it will try
to do 'ip netns delete ""', etc.

If ns_list is an array, then 'cleanup_ns "${ns_list[@]}"' is OK. Mmh, I
see there is the same issue below. I can send a fix for that, that would
be for -net, not next. I will look at that this afternoon.

> +			set -e

Why do you need this? (see below)

> +			return $ksft_fail

Why not 'exit ${ksft_fail}' instead? That's an internal error, you can
do that.

> +		fi
>  		# Some test may setup/remove same netns multi times
>  		if unset ${ns_name} 2> /dev/null; then
> -			ns="${ns_name,,}-$(mktemp -u XXXXXX)"
> -			eval readonly ${ns_name}="$ns"
> +			_ns="${ns_name,,}-$(mktemp -u XXXXXX)"
> +			eval readonly ${ns_name}="$_ns"
>  			ns_exist=false
>  		else
> -			eval ns='$'${ns_name}
> -			cleanup_ns "$ns"
> +			eval _ns='$'${ns_name}
> +			cleanup_ns "$_ns"
>  			ns_exist=true
>  		fi
>  
> -		if ! ip netns add "$ns"; then
> +		if ! ip netns add "$_ns"; then
>  			echo "Failed to create namespace $ns_name"
>  			cleanup_ns "$ns_list"
>  			return $ksft_skip
>  		fi
> -		ip -n "$ns" link set lo up
> -		! $ns_exist && ns_list="$ns_list $ns"
> +		ip -n "$_ns" link set lo up
> +		! $ns_exist && ns_list="$ns_list $_ns"
>  	done
>  	NS_LIST="$NS_LIST $ns_list"
>  }

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

