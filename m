Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 782DA12D74E
	for <mptcp@lists.linux.dev>; Thu,  7 Mar 2024 14:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709823355; cv=none; b=smfT3YXWaEiDUNc9u/sOrv/TApMVjsaPlapR9ppaXIGTk1gH40f6hguznEKsRE6x0cfy5QZhDEWM7LKnagqsLfiSRamoq/MjzLFOznfB45mwyE2suWlc2rdIJAG/oj/IwmK8EBlBQL59haZyo2d8fwHeN56bVks4noWQBwrrF6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709823355; c=relaxed/simple;
	bh=xTE4zkEfuGvd0RBGaIRd9GcwtFYR806bv7ZnxSeliAY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o13z1cuqpnSrQAw4fNEv/EVuoDoIxxM0Y8TJ4/zSt2jyPXqDquo2gUJao7P7O2/N5migl1T1BRho/jZ3fuvhv4HSmAB1XoECTgTQDn6fASDWLWF7ikd0cghdhoDJ5Rz2rUMLs+RTnwlfEBf2xVTjHRqu6qjuD+SxE9FK99K1opE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nU4Cgms3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nU4Cgms3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4291C433F1;
	Thu,  7 Mar 2024 14:55:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709823355;
	bh=xTE4zkEfuGvd0RBGaIRd9GcwtFYR806bv7ZnxSeliAY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=nU4Cgms3jdukXG90pJUoY5N2GBs/x8kM3IJGphxAxl2PU01dzOTDhCJsP9tOx69+l
	 vJe6KEa59zJaMseRZSsCiAXsSQdGCIF4vCm+5iwxGGFU/3cjcSlCqjpIl8kDMT06gF
	 rzy9NF+CvmAwcHZuM9fdvcpqorOhnS8DrRw10+2ar4OOcOxRWsjkzWOLQMtLVi8Z2U
	 AmP7LZrgJKZ3pe+RB2y7YPry26fRktg6hh8BeFwFMlhL92ha9l0NIv5MG1cvaVgaeP
	 aY4Rrm+s0dvMvOqLok7eeMeH4szLDshubcBpJAEBPGx7QuSk5P9kEjhASfvWwmCo+W
	 5qMfaTwDL8hXQ==
Message-ID: <ee6b2dfc-ab55-4275-b14d-96db118ca9e1@kernel.org>
Date: Thu, 7 Mar 2024 15:55:50 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-next 5/5] selftests: mptcp: join: use += operator to
 append strings
Content-Language: en-GB, fr-BE
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1709815545.git.tanggeliang@kylinos.cn>
 <c8bd786e0c09f4f19d518ec998a36f9fbd64e0b5.1709815545.git.tanggeliang@kylinos.cn>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <c8bd786e0c09f4f19d518ec998a36f9fbd64e0b5.1709815545.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 07/03/2024 13:48, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> This patch uses addition assignment operator (+=) to append strings instead
> of open-coding in mptcp_join.sh. This can make the statements shorter.
> 
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>  .../testing/selftests/net/mptcp/mptcp_join.sh | 34 +++++++++----------
>  1 file changed, 17 insertions(+), 17 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index 6d725419b7d4..b70bd8e0088a 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -753,18 +753,18 @@ pm_nl_check_endpoint()
>  		line="${line% }"
>  		# the dump order is: address id flags port dev
>  		[ -n "$addr" ] && expected_line="$addr"
> -		expected_line="$expected_line $id"
> -		[ -n "$_flags" ] && expected_line="$expected_line ${_flags//","/" "}"
> -		[ -n "$dev" ] && expected_line="$expected_line $dev"
> -		[ -n "$port" ] && expected_line="$expected_line $port"
> +		expected_line+=" $id"
> +		[ -n "$_flags" ] && expected_line+=" ${_flags//","/" "}"
> +		[ -n "$dev" ] && expected_line+=" $dev"
> +		[ -n "$port" ] && expected_line+=" $port"
>  	else
>  		line=$(ip netns exec $ns ./pm_nl_ctl get $_id)
>  		# the dump order is: id flags dev address port
>  		expected_line="$id"
> -		[ -n "$flags" ] && expected_line="$expected_line $flags"
> -		[ -n "$dev" ] && expected_line="$expected_line $dev"
> -		[ -n "$addr" ] && expected_line="$expected_line $addr"
> -		[ -n "$_port" ] && expected_line="$expected_line $_port"
> +		[ -n "$flags" ] && expected_line+=" $flags"
> +		[ -n "$dev" ] && expected_line+=" $dev"
> +		[ -n "$addr" ] && expected_line+=" $addr"
> +		[ -n "$_port" ] && expected_line+=" $_port"
>  	fi
>  	if [ "$line" = "$expected_line" ]; then
>  		print_ok
> @@ -1032,7 +1032,7 @@ do_transfer()
>  		fi
>  	fi
>  
> -	extra_srv_args="$extra_args $extra_srv_args"
> +	extra_srv_args+=" $extra_args"

Here, you are changing the order. Just to be sure, is it still OK with
the new order?

If yes, please add a comment in the commit message to explain why this
change of behaviour is OK (any behaviour changes in such refactoring
should be mentioned, otherwise it might look like an accident, reviewers
will ask questions or lose time trying to understand why it would be OK,
etc.)

>  	if [ "$test_linkfail" -gt 1 ];then
>  		timeout ${timeout_test} \
>  			ip netns exec ${listener_ns} \
> @@ -1048,7 +1048,7 @@ do_transfer()
>  
>  	mptcp_lib_wait_local_port_listen "${listener_ns}" "${port}"
>  
> -	extra_cl_args="$extra_args $extra_cl_args"
> +	extra_cl_args+=" $extra_args"

Same here for the order.

>  	if [ "$test_linkfail" -eq 0 ];then
>  		timeout ${timeout_test} \
>  			ip netns exec ${connector_ns} \

(...)

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.
