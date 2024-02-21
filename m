Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A6653A1A2
	for <mptcp@lists.linux.dev>; Wed, 21 Feb 2024 16:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708532463; cv=none; b=PvIEBQ/K9HByJ+f+BkCnD2xYPFiD11+/o1LR2vg5NXzTUe6gEVmoRJkyKGk8EOkUfasH6dMvnpk+AtHb+2f/Rv8bpQhuYbYcOmY5V11OozB/T9gmZ+E2ULJneVUOarucqgFaldqKuM77chbsnh2BQ+Tumr6wOzUqc6AKT5+nwW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708532463; c=relaxed/simple;
	bh=YS+Mst/NOd/yZI2mZEW2nMbCP4xvuaoHbmA9O1cpVaM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t/lCyX1bX7/wwrWbaFvig99rb/sQrL1yFpCBDFzmKtBpSHgvY54Yf1HtAfBu2scSXu06mOya1Em+UYr3IzqkAy15xt6TDdXhgZjEJTdTX76QyD+KnpQoCz9LKYS+6zttCjldN59Yi54uY1VArq+JehwZpw6O/9imAZUj+d8er3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IgWXDqIV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IgWXDqIV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B010C43390;
	Wed, 21 Feb 2024 16:21:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708532463;
	bh=YS+Mst/NOd/yZI2mZEW2nMbCP4xvuaoHbmA9O1cpVaM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=IgWXDqIVVi7Rn6d9symlM/7+g3oNf0tHel9kmfzJSbsW4xyDcvXlx1Kv13KGvrIey
	 SViqh8akw3nxkSlbyZ9CjFLvfi0apYcYpaMg+aPzz0yT+jMPiUhxRJOU43YewjS55j
	 rrVAK1sD+kEFKuAtpcvc4HO/VVTIDYIW7YSB6f0+ybalDmSeBr5oY5Y0aEjN14pbIG
	 CpdPY30dJRmvfbida4Xmlg4I1AZQseV15Vy5w4JA03y/VUkGPOg73jVl4143KbqIx0
	 wXKh9inm3M3rdDLORloJ78QvAf+RuAAyPtzXPwNGISHiwcg3hGTJQ0jN4x5G6mU7OF
	 K4n5SSHCSzT4A==
Message-ID: <360c8ee5-99c4-44b2-91f1-ebe634b19a2a@kernel.org>
Date: Wed, 21 Feb 2024 17:21:01 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-next 8/8] selftests: mptcp: flush userspace addrs
 list
Content-Language: en-GB, fr-BE
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1708497039.git.tanggeliang@kylinos.cn>
 <bb5e3f97c4a225f616d82112570514114fce00c5.1708497039.git.tanggeliang@kylinos.cn>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <bb5e3f97c4a225f616d82112570514114fce00c5.1708497039.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 21/02/2024 7:31 am, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> This patch adds a new helper userspace_pm_flush() to flush all addresses
> for the userspace PM. Invoke it in userspace pm dump address and subflow
> tests. And use dump commands to check if the userspace pm local address
> list is empty after addresses flushing.
> 
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>  .../testing/selftests/net/mptcp/mptcp_join.sh | 46 ++++++++++++++++---
>  1 file changed, 39 insertions(+), 7 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index aedc5698f26a..9f1476f0e2ae 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -3374,6 +3374,34 @@ userspace_pm_get_addr()
>  	ip netns exec $1 ./pm_nl_ctl get $2 token $tk
>  }
>  
> +# $1: ns ; $2: addr
> +userspace_pm_flush()
> +{
> +	if mptcp_lib_kallsyms_has "mptcp_userspace_pm_dump_addr$"; then
> +		local ns=$1
> +		local line
> +
> +		userspace_pm_dump $ns | while read -r line; do

This will create a subshell: it means that variables that are changed
here below will only be valid in this restricted scope. In other words,
if there is a failure below, the 'failure' message will be printed, but
'ret=1' will only be set here in this scope, so the test will not be
marked as failed: the check will be ignored. You cannot do it like that.

What you can do is something like that to avoid a subshell:

  while read -r line; do (...); done <<< $(cmd)

but...

> +			local arr=($line)
> +			local nr=0
> +			local id
> +			local addr
> +			local i
> +			for i in "${arr[@]}"; do
> +				if [ $i = "id" ]; then
> +					id=${arr[$nr+1]}
> +				fi
> +				nr=$((nr + 1))
> +			done
> +			addr=${arr[$nr-1]}

Can you not use read to do the parsing if it is always the same output:

  read -r _ id _ _ addr

> +			userspace_pm_rm_addr $ns $id
> +			userspace_pm_rm_sf $ns "$addr" $SUB_ESTABLISHED
> +		done
> +	else
> +		print_skip

The skip doesn't make sense here: there is no 'check' in progress.

But that's not it, the behaviour is wrong too: if the feature is not
supported, it means that the subflows and addresses will not be removed,
then the rest of the test will be wrong on kernels not supporting the
features because the counters will be different.

Maybe we could do that in a new dedicated test where everything is
skipped if "dump addresses" is not supported. But, does this test
increase the code coverage? I understand that doing the flush is a good
"summary", but it looks like this has already been validated, no? So
maybe easier to drop this?

> +	fi
> +}
> +
>  userspace_pm_chk_dump_addr()
>  {
>  	local ns="${1}"

(...)

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.
