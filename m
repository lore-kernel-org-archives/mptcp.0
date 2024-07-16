Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66FCA12B72
	for <mptcp@lists.linux.dev>; Tue, 16 Jul 2024 03:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721100053; cv=none; b=J232DTWMF1hh7HkE8ArJHHjSyJPXDTspDf8JAjJN27EJ5Q5N/bNW/l9s/ML0Z4nJrVNpCKDwb7jbd6or+HfXVTyhxTpmrchm6dN609Q3eJ0GsDvSngYlpNk4AVFX6wfcMDQS5229C6gOdyV3O7pumsagQY6u8+P7Hw5mEF0PgPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721100053; c=relaxed/simple;
	bh=Zh1grBOGbO8bIlQlNpI4k64WbAmlwW19D/ppnG+si5A=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sqTIf1R5LKpCjH7kqV8dtu+JrrReIzE9t/+BBGLDXoxXKdVHHWhST9vSHMvk3saJ6czcLzogH8gqPBCiWY+h2NuQ07RJCR5yRkdVfM0ykWmvWgciKtdAmcTUSxq6yYWf8S96uxfe5SXg1ibfAFbZLmyaQbC9wy4ZliqhZrdPWJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sxfRWfLp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sxfRWfLp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF793C116B1;
	Tue, 16 Jul 2024 03:20:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721100052;
	bh=Zh1grBOGbO8bIlQlNpI4k64WbAmlwW19D/ppnG+si5A=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=sxfRWfLp9ttEkrOOxBr/F3uMJZjk6KB2r4icoescj7pB3D9KkkpOxH5a99+w0hljF
	 HomroKxMW9f7kXcCwOOLlj+kv0yLjVoGCCUSDXE8Yw0fR9jDwECjOmSPVTWN3Y6iVz
	 oIw2dTNLEmqddFjH/rT/GhxoTm21VYFQlNo3La/H4fucnwE49n6n3H1GmMDwDPP+P5
	 XeWgtH7o/LpPxeUQn+L74IqMer1TGhvxc0PZA/WsDqi6V0quof5OclkXV85chIdJEi
	 9yYICw9ZJeBkp4e9Jko5Zpwn7aIS/T3XxA+PltrwcoR8dTAwCWnGS59nwZ0EdEQQ8L
	 gleRvCVrn6Iow==
Message-ID: <f62e151f743c4e6358f8745f2ba9bfbc746f6bab.camel@kernel.org>
Subject: Re: [PATCH mptcp-net v2 06/17] selftests: mptcp: join: ability to
 invert ADD_ADDR check
From: Geliang Tang <geliang@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>
Date: Tue, 16 Jul 2024 11:20:44 +0800
In-Reply-To: <20240715-mptcp-pm-avail-v2-6-fc5153bd1f6e@kernel.org>
References: <20240715-mptcp-pm-avail-v2-0-fc5153bd1f6e@kernel.org>
	 <20240715-mptcp-pm-avail-v2-6-fc5153bd1f6e@kernel.org>
Autocrypt: addr=geliang@kernel.org; prefer-encrypt=mutual;
 keydata=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
 TO0tfEdfAX7IENcV87h2yAFBZkaA==
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.52.0-1build2 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Matt,

On Mon, 2024-07-15 at 12:09 +0200, Matthieu Baerts (NGI0) wrote:
> In the following commit, the client will initiate the ADD_ADDR,
> instead
> of the server. We need to way to verify the ADD_ADDR have been
> correctly
> sent.
> 
> Note: the default expected counters for when the port number is given
> are never changed by the caller, no need to accept them as parameter
> then.
> 
> The 'Fixes' tag here below is the same as the one from the previous
> commit: this patch here is not fixing anything wrong in the
> selftests,
> but it validates the previous fix for an issue introduced by this
> commit
> ID.
> 
> Fixes: 86e39e04482b ("mptcp: keep track of local endpoint still
> available for each msk")
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
>  tools/testing/selftests/net/mptcp/mptcp_join.sh | 40
> ++++++++++++++++---------
>  1 file changed, 26 insertions(+), 14 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index 55d84a1bde15..55ccc4fdf18a 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -1415,18 +1415,28 @@ chk_add_nr()
>  	local add_nr=$1
>  	local echo_nr=$2
>  	local port_nr=${3:-0}
> -	local syn_nr=${4:-$port_nr}
> -	local syn_ack_nr=${5:-$port_nr}
> -	local ack_nr=${6:-$port_nr}
> -	local mis_syn_nr=${7:-0}
> -	local mis_ack_nr=${8:-0}

nit: How about moving the code that reduces arguments into a separate
patch?

> +	local ns_invert=${4:-""}
> +	local syn_nr=$port_nr
> +	local syn_ack_nr=$port_nr
> +	local ack_nr=$port_nr
> +	local mis_syn_nr=0
> +	local mis_ack_nr=0
> +	local ns_tx=$ns1
> +	local ns_rx=$ns2

And move the code for renaming ns into another separate patch too?

WDYT?

Thanks,
-Geliang

> +	local extra_msg=""
>  	local count
>  	local timeout
>  
> -	timeout=$(ip netns exec $ns1 sysctl -n
> net.mptcp.add_addr_timeout)
> +	if [[ $ns_invert = "invert" ]]; then
> +		ns_tx=$ns2
> +		ns_rx=$ns1
> +		extra_msg="invert"
> +	fi
> +
> +	timeout=$(ip netns exec ${ns_tx} sysctl -n
> net.mptcp.add_addr_timeout)
>  
>  	print_check "add"
> -	count=$(mptcp_lib_get_counter ${ns2} "MPTcpExtAddAddr")
> +	count=$(mptcp_lib_get_counter ${ns_rx} "MPTcpExtAddAddr")
>  	if [ -z "$count" ]; then
>  		print_skip
>  	# if the test configured a short timeout tolerate greater
> then expected
> @@ -1438,7 +1448,7 @@ chk_add_nr()
>  	fi
>  
>  	print_check "echo"
> -	count=$(mptcp_lib_get_counter ${ns1} "MPTcpExtEchoAdd")
> +	count=$(mptcp_lib_get_counter ${ns_tx} "MPTcpExtEchoAdd")
>  	if [ -z "$count" ]; then
>  		print_skip
>  	elif [ "$count" != "$echo_nr" ]; then
> @@ -1449,7 +1459,7 @@ chk_add_nr()
>  
>  	if [ $port_nr -gt 0 ]; then
>  		print_check "pt"
> -		count=$(mptcp_lib_get_counter ${ns2}
> "MPTcpExtPortAdd")
> +		count=$(mptcp_lib_get_counter ${ns_rx}
> "MPTcpExtPortAdd")
>  		if [ -z "$count" ]; then
>  			print_skip
>  		elif [ "$count" != "$port_nr" ]; then
> @@ -1459,7 +1469,7 @@ chk_add_nr()
>  		fi
>  
>  		print_check "syn"
> -		count=$(mptcp_lib_get_counter ${ns1}
> "MPTcpExtMPJoinPortSynRx")
> +		count=$(mptcp_lib_get_counter ${ns_tx}
> "MPTcpExtMPJoinPortSynRx")
>  		if [ -z "$count" ]; then
>  			print_skip
>  		elif [ "$count" != "$syn_nr" ]; then
> @@ -1470,7 +1480,7 @@ chk_add_nr()
>  		fi
>  
>  		print_check "synack"
> -		count=$(mptcp_lib_get_counter ${ns2}
> "MPTcpExtMPJoinPortSynAckRx")
> +		count=$(mptcp_lib_get_counter ${ns_rx}
> "MPTcpExtMPJoinPortSynAckRx")
>  		if [ -z "$count" ]; then
>  			print_skip
>  		elif [ "$count" != "$syn_ack_nr" ]; then
> @@ -1481,7 +1491,7 @@ chk_add_nr()
>  		fi
>  
>  		print_check "ack"
> -		count=$(mptcp_lib_get_counter ${ns1}
> "MPTcpExtMPJoinPortAckRx")
> +		count=$(mptcp_lib_get_counter ${ns_tx}
> "MPTcpExtMPJoinPortAckRx")
>  		if [ -z "$count" ]; then
>  			print_skip
>  		elif [ "$count" != "$ack_nr" ]; then
> @@ -1492,7 +1502,7 @@ chk_add_nr()
>  		fi
>  
>  		print_check "syn"
> -		count=$(mptcp_lib_get_counter ${ns1}
> "MPTcpExtMismatchPortSynRx")
> +		count=$(mptcp_lib_get_counter ${ns_tx}
> "MPTcpExtMismatchPortSynRx")
>  		if [ -z "$count" ]; then
>  			print_skip
>  		elif [ "$count" != "$mis_syn_nr" ]; then
> @@ -1503,7 +1513,7 @@ chk_add_nr()
>  		fi
>  
>  		print_check "ack"
> -		count=$(mptcp_lib_get_counter ${ns1}
> "MPTcpExtMismatchPortAckRx")
> +		count=$(mptcp_lib_get_counter ${ns_tx}
> "MPTcpExtMismatchPortAckRx")
>  		if [ -z "$count" ]; then
>  			print_skip
>  		elif [ "$count" != "$mis_ack_nr" ]; then
> @@ -1513,6 +1523,8 @@ chk_add_nr()
>  			print_ok
>  		fi
>  	fi
> +
> +	print_info "$extra_msg"
>  }
>  
>  chk_add_tx_nr()
> 

